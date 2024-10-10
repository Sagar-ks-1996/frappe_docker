git_password=XXX
site_name=XXX
TAG=1.0.0
cd ../
sudo docker login ghcr.io -u Sagar-ks-1996 -p $git_password
sudo docker pull ghcr.io/sagar-ks-1996/expense_manager_frappe/expense_manager_frappe:$TAG
sudo docker compose -f compose.yaml -f overrides/compose.noproxy.yaml -f overrides/compose.mariadb.yaml -f overrides/compose.redis.yaml down
sudo docker compose -f compose.yaml -f overrides/compose.noproxy.yaml -f overrides/compose.mariadb.yaml -f overrides/compose.redis.yaml up -d
#sudo docker compose exec backend bench --site $site_name install-app firebase_app
sudo docker compose exec backend bench --site $site_name migrate
sudo docker compose restart backend