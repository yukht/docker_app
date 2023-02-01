docker rm web_py -f
docker image prune -a -f
docker volume rm -f srv_app_vol
rm -fr app_vol/*

