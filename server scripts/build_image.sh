git_password=XXX
TAG=1.0.0

cd ../
yes|sudo docker builder prune --all

app1='{"url": "https://Sagar-ks-1996:'"$git_password"'@github.com/Sagar-ks-1996/expense_manager_frappe.git","branch": "frappe-15"}'
# app2='{"url": "https://Sagar-ks-1996:'"$git_password"'@github.com/Sagar-ks-1996/firebase_app.git","branch": "main"}'
export APPS_JSON='['"$app1"']'
# export APPS_JSON='['"$app1"','"$app2"']'
export APPS_JSON_BASE64=$(echo ${APPS_JSON} | base64 -w 0)

sudo docker build \
  --build-arg=FRAPPE_PATH=https://github.com/frappe/frappe \
  --build-arg=FRAPPE_BRANCH=v15.28.0 \
  --build-arg=PYTHON_VERSION=3.11.9 \
  --build-arg=NODE_VERSION=18.20.2 \
  --build-arg=APPS_JSON_BASE64=$APPS_JSON_BASE64 \
  --tag=ghcr.io/ideenkreisetech/expense_manager_frappe/expense_manager_frappe:$TAG \
  --file=images/custom/Containerfile . \
  --no-cache

sudo docker login ghcr.io -u Sagar-ks-1996 -p $git_password

sudo docker push ghcr.io/sagar-ks-1996/expense_manager_frappe/expense_manager_frappe:$TAG