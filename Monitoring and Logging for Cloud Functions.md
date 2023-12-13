```
export REGION=
```
```
cat <<EOF> function.js
exports.helloWorld = (req, res) => {
  res.status(200).send('Hello, Hustlers!');
};
EOF
gcloud functions deploy helloWorld \
  --runtime nodejs16 \
  --trigger-http \
  --allow-unauthenticated \
  --region $REGION \
  --max-instances 5
gcloud logging metrics create CloudFunctionLatency-Logs \
    --project=$DEVSHELL_PROJECT_ID \
    --description="Metric for Cloud Function latency" \
    --log-filter='resource.type="cloud_function"
resource.labels.function_name="helloWorld"'
```
