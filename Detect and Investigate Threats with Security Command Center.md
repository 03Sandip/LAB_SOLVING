


```bash
export ZONE=
```
###

```bash
gcloud services enable securitycenter.googleapis.com --project=$DEVSHELL_PROJECT_ID

sleep 15

gcloud projects add-iam-policy-binding $DEVSHELL_PROJECT_ID \
--member=user:demouser1@gmail.com --role=roles/bigquery.admin


gcloud projects remove-iam-policy-binding $DEVSHELL_PROJECT_ID \
--member=user:demouser1@gmail.com --role=roles/bigquery.admin

export PROJECT_NUMBER=$(gcloud projects describe $DEVSHELL_PROJECT_ID --format="value(projectNumber)")

gcloud projects add-iam-policy-binding $DEVSHELL_PROJECT_ID \
  --member=user:$USER_EMAIL \
  --role=roles/cloudresourcemanager.projectIamAdmin



gcloud compute instances create instance-1 --project=$DEVSHELL_PROJECT_ID --zone=$ZONE --machine-type=e2-medium --network-interface=network-tier=PREMIUM,stack-type=IPV4_ONLY,subnet=default --metadata=enable-oslogin=true --maintenance-policy=MIGRATE --provisioning-model=STANDARD --scopes=https://www.googleapis.com/auth/cloud-platform --create-disk=auto-delete=yes,boot=yes,device-name=instance-1,image=projects/debian-cloud/global/images/debian-11-bullseye-v20230912,mode=rw,size=10,type=projects/$DEVSHELL_PROJECT_ID/zones/$ZONE/diskTypes/pd-balanced --no-shielded-secure-boot --shielded-vtpm --shielded-integrity-monitoring --labels=goog-ec-src=vm_add-gcloud --reservation-affinity=any

gcloud dns --project=$DEVSHELL_PROJECT_ID policies create dns-test-policy --description="Please like share & subscirbe to quicklab" --networks="default" --alternative-name-servers="" --private-alternative-name-servers="" --no-enable-inbound-forwarding --enable-logging
```
###
###
```bash
gcloud compute ssh --zone "$ZONE" "instance-1" --tunnel-through-iap --project "$DEVSHELL_PROJECT_ID" --quiet --command "gcloud projects get-iam-policy \$(gcloud config get project) && curl etd-malware-trigger.goog"
```
###
## check the score for task 2 after getting score then do next task
###
```bash
gcloud compute instances delete instance-1 --zone=$ZONE --quiet

gcloud compute instances create attacker-instance \
--scopes=cloud-platform  \
--zone=$ZONE \
--machine-type=e2-medium  \
--image-family=ubuntu-2004-lts \
--image-project=ubuntu-os-cloud \
--no-address


gcloud compute networks subnets update default \
--region="${ZONE%-*}" \
--enable-private-ip-google-access
```

```bash
export ZONE=
```
###

```bash
sudo snap remove google-cloud-cli

curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-438.0.0-linux-x86_64.tar.gz

tar -xf google-cloud-cli-438.0.0-linux-x86_64.tar.gz

./google-cloud-sdk/install.sh
```


###
```bash
. ~/.bashrc

gcloud components install kubectl gke-gcloud-auth-plugin --quiet

gcloud container clusters create test-cluster \
--zone "$ZONE" \
--enable-private-nodes \
--enable-private-endpoint \
--enable-ip-alias \
--num-nodes=1 \
--master-ipv4-cidr "172.16.0.0/28" \
--enable-master-authorized-networks \
--master-authorized-networks "10.128.0.0/20"

sleep 20

kubectl describe daemonsets container-watcher -n kube-system
```

##

```bash
kubectl create deployment apache-deployment \
--replicas=1 \
--image=us-central1-docker.pkg.dev/cloud-training-prod-bucket/scc-labs/ktd-test-httpd:2.4.49-vulnerable

kubectl expose deployment apache-deployment \
--name apache-test-service  \
--type NodePort \
--protocol TCP \
--port 80


NODE_IP=$(kubectl get nodes -o jsonpath={.items[0].status.addresses[0].address})
NODE_PORT=$(kubectl get service apache-test-service \
-o jsonpath={.spec.ports[0].nodePort})


gcloud compute firewall-rules create apache-test-service-fw \
--allow tcp:${NODE_PORT}

gcloud compute firewall-rules create apache-test-rvrs-cnnct-fw --allow tcp:8888
```
