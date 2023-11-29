
gcloud services enable datacatalog.googleapis.com
bq mk ecommerce
gcloud services enable bigqueryconnection.googleapis.com
bq mk --connection --location=$LOCATION --project_id=$DEVSHELL_PROJECT_ID \
    --connection_type=CLOUD_RESOURCE customer_data_connection
CLOUD=$(bq show --connection $DEVSHELL_PROJECT_ID.$LOCATION.customer_data_connection | grep "serviceAccountId" | awk '{gsub(/"/, "", $8); print $8}')
NEWs="${CLOUD%?}"
gcloud projects add-iam-policy-binding $DEVSHELL_PROJECT_ID \
    --member="serviceAccount:$NEWs" \
    --role="roles/storage.objectViewer"
bq mk --external_table_definition=gs://$DEVSHELL_PROJECT_ID-bucket/customer-online-sessions.csv \
ecommerce.customer_online_sessions
gcloud data-catalog tag-templates create sensitive_data_template \
    --location=$LOCATION \
    --display-name="Sensitive Data Template" \
    --field=id=has_sensitive_data,display-name="Has Sensitive Data",type=bool \
    --field=id=sensitive_data_type,display-name="Sensitive Data Type",type='enum(Location Info|Contact Info|None)'
cat > tag_file.json << EOF
  {
    "has_sensitive_data": TRUE,
    "sensitive_data_type": "Location Info"
  }
EOF
ENTRY_NAME=$(gcloud data-catalog entries lookup '//bigquery.googleapis.com/projects/'$DEVSHELL_PROJECT_ID'/datasets/ecommerce/tables/customer_online_sessions' --format="value(name)")
gcloud data-catalog tags create --entry=${ENTRY_NAME} \
    --tag-template=sensitive_data_template --tag-template-location=$LOCATION --tag-file=tag_file.json
