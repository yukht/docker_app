docker rm nginx1 -f
docker image prune -a -f
docker volume rm -f local_nginx_log
unlink logs/access.log && unlink logs/error.log && rm -f logs/*
