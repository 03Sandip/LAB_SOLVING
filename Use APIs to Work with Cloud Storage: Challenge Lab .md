

```
gcloud services enable fitness.googleapis.com

export OAUTH2_TOKEN=$(gcloud auth print-access-token)
```

## Task 1. Create two Cloud Storage buckets

* This will create and call the Bucket-1.

```
# Create bucket1.json
cat > bucket1.json <<EOF
{  
   "name": "$DEVSHELL_PROJECT_ID-bucket-1",
   "location": "us",
   "storageClass": "multi_regional"
}
EOF
```


```

# Create bucket1
curl -X POST -H "Authorization: Bearer $(gcloud auth print-access-token)" -H "Content-Type: application/json" --data-binary @bucket1.json "https://storage.googleapis.com/storage/v1/b?project=$DEVSHELL_PROJECT_ID"
```
* This will create and call the Bucket-2.
```

# Create bucket2.json
cat > bucket2.json <<EOF
{  
   "name": "$DEVSHELL_PROJECT_ID-bucket-2",
   "location": "us",
   "storageClass": "multi_regional"
}
EOF
```

```

# Create bucket2
curl -X POST -H "Authorization: Bearer $(gcloud auth print-access-token)" -H "Content-Type: application/json" --data-binary @bucket2.json "https://storage.googleapis.com/storage/v1/b?project=$DEVSHELL_PROJECT_ID"
```

## Task 2. Upload an image file to a Cloud Storage Bucket

```
curl -X POST --data-binary @/home/gcpstaging25084_student/demo-image.png \
    -H "Authorization: Bearer $OAUTH2_TOKEN" \
    -H "Content-Type: image/png" \
    "https://www.googleapis.com/upload/storage/v1/b/$DEVSHELL_PROJECT_ID-bucket-1/o?uploadType=media&name=demo-image"
```

## Task 3. Copy a file to another bucket

```
curl -X POST \
  -H "Authorization: Bearer $OAUTH2_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "destination": "gs://$DEVSHELL_PROJECT_ID-bucket-2/demo-image"
   }' \
   "https://storage.googleapis.com/storage/v1/b/$DEVSHELL_PROJECT_ID-bucket-1/o/demo-image/copyTo/b/$DEVSHELL_PROJECT_ID-bucket-2/o/demo-image"
```

## Task 4. Make an object (file) publicly accessible

```
echo '{
  "entity": "allUsers",
  "role": "READER"
}
' > values.json

curl -X POST --data-binary @values.json \
  -H "Authorization: Bearer $OAUTH2_TOKEN" \
  -H "Content-Type: application/json" \
  "https://storage.googleapis.com/storage/v1/b/$DEVSHELL_PROJECT_ID-bucket-1/o/demo-image/acl"
```

## Task 5. Delete the object file and a Cloud Storage bucket (Bucket 1)

```
curl -X DELETE \
  -H "Authorization: Bearer $OAUTH2_TOKEN" \
  "https://storage.googleapis.com/storage/v1/b/gs://$DEVSHELL_PROJECT_ID-bucket-1/o/demo-image"
  
curl -X DELETE \
  -H "Authorization: Bearer $OAUTH2_TOKEN" \
  "https://storage.googleapis.com/storage/v1/b/$DEVSHELL_PROJECT_ID-bucket-1/o/demo-image"

curl -X DELETE \
  -H "Authorization: Bearer $OAUTH2_TOKEN" \
  "https://storage.googleapis.com/storage/v1/b/$DEVSHELL_PROJECT_ID-bucket-1"
```

# Congratulations 🎉! You're all done with this Challenge Lab.
# Subscribe our channel 
