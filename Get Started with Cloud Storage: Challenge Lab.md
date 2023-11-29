```bash
export REGION=
```
```bash
 export BUCKET="$(gcloud config get-value project)"		

gsutil mb -l $REGION "gs://$BUCKET"

gsutil retention set 30s "gs://$BUCKET"

gsutil retention get "gs://$BUCKET"

curl https://upload.wikimedia.org/wikipedia/commons/thumb/a/a4/Ada_Lovelace_portrait.jpg/800px-Ada_Lovelace_portrait.jpg --output ada.jpg

gsutil cp ada.jpg gs://$DEVSHELL_PROJECT_ID

rm ada.jpg

gsutil cp -r gs://$DEVSHELL_PROJECT_ID/ada.jpg .

gsutil cp gs://$DEVSHELL_PROJECT_ID/ada.jpg gs://$DEVSHELL_PROJECT_ID/image-folder/

gsutil acl ch -u AllUsers:R gs://$DEVSHELL_PROJECT_ID/ada.jpg

```
