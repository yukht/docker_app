docker run --env SERVER_NAME1=foo.bar --env SERVER_NAME2=bar.foo --env PORT1=80 --env PORT2=8080 \
-p 9090:80 -p 9999:8080 \
--mount type=bind,source="$(pwd)"/templates,target=/etc/nginx/templates \
--mount src=local_nginx_log,dst=/var/log/nginx,volume-opt=device=$(pwd)/logs,volume-opt=type=volume,volume-opt=o=bind \
-it -d --name nginx1 nginx:1.22.1
