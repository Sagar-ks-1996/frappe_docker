# export HTTP_PUBLISH_PORT=8083
db_password=XXX
admin_password=XXX
encryption_key=XXX
git_password=XXX
site_name=XXX
TAG=1.0.0
cd ../
sudo docker login ghcr.io -u Sagar-ks-1996 -p $git_password
sudo docker pull ghcr.io/sagar-ks-1996/expense_manager_frappe/expense_manager_frappe:$TAG
sudo docker compose -f compose.yaml -f overrides/compose.noproxy.yaml -f overrides/compose.mariadb.yaml -f overrides/compose.redis.yaml up -d
sudo docker compose exec backend bench new-site $site_name  --no-mariadb-socket --mariadb-root-password $db_password --admin-password $admin_password
sudo docker compose exec backend bench --site $site_name install-app expense_manager_app
# sudo docker compose exec backend bench --site $site_name set-config encryption_key $encryption_key
sudo docker compose exec backend bench --site $site_name enable-scheduler