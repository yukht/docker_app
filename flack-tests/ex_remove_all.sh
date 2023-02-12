docker rm web_py redis -f
# docker image prune -a -f
docker image rm -f python-3.7-alpine-custom-flack:0.1 redis:6.2.10
# unlink logs/access.log && unlink logs/error.log && rm -f logs/*
