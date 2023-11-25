
```bash
export LOCATION=
export ID=
```

```bash
gcloud dataplex lakes create sensors \
    --location=$LOCATION \
    --display-name="sensors" \
    --description="Ecommerce Domain"


gcloud dataplex zones create temperature-raw-data \
    --location=$LOCATION \
    --lake=sensors \
    --display-name="temperature raw data" \
    --type=RAW \
    --resource-location-type=SINGLE_REGION \
    --discovery-enabled

gsutil mb -p $ID -c REGIONAL -l $LOCATION gs://$ID


gcloud dataplex assets create measurements \
--location=$LOCATION \
--lake=sensors \
--zone=temperature-raw-data \
--display-name="measurements" \
--resource-type=STORAGE_BUCKET \
--resource-name=projects/my-project/buckets/${ID} \
--discovery-enabled
```

```bash
gcloud dataplex assets delete measurements --location=$LOCATION --zone=temperature-raw-data --lake=sensors 

gcloud dataplex zones delete temperature-raw-data --location=$LOCATION --lake=sensors

gcloud dataplex lakes delete sensors --location=$LOCATION
```



