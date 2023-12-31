
```bash
gcloud services enable dataplex.googleapis.com

gcloud services enable datacatalog.googleapis.com
```
```bash 
export LOCATION=
```
```bash
export ID=
```

```bash

gcloud dataplex lakes create orders-lake \
   --location=$LOCATION \
   --display-name="Orders Lake"

gcloud dataplex zones create customer-curated-zone \
    --location=$LOCATION \
    --lake=orders-lake \
    --display-name="Customer Curated Zone" \
    --type=CURATED \
    --resource-location-type=SINGLE_REGION


gcloud dataplex assets create customer-details-dataset \
--location=$LOCATION \
--lake=orders-lake \
--zone=customer-curated-zone \
--display-name="Customer Details Dataset" \
--resource-type=BIGQUERY_DATASET \
--resource-name=projects/$ID/datasets/customers


gcloud services enable datacatalog.googleapis.com

```
