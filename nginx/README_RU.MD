Для передачи номера порта и других необходимых параметров через переменные разработчики nginx предлагают использовать команду envsubst
(переменные обрабатывается скриптами в контейнере разработчиков). Чтобы скрипты экспорта переменных через envsubst заработали, необходимо примонтировать
ваши файлы template (конфигурационные файлы nginx с названиями переменных типа ${VARIABLE} на месте заменяемых параметров) в папку /etc/nginx/templates.
После отработки файлы наподобие my_conf_80.conf.template будут размещены в /etc/nginx/conf.d/my_conf_80.conf и передаваемые docker переменные будут подставлены.

Монтирование:
1. Первая папка с templates примонтирована как bind, т.к. в реальном контейнере папки /etc/nginx/templates не существует и создавать ради нее
отдельный volume не имеет особого смысла
2. Вторая папка logs примонтирована как volume, чтобы не затирая своей папкой директорию контейнера просматривать его логи. Также в template создан файл
/var/log/nginx/nginx.log, потому что по-умолчанию логи nginx разработчиками выведены в stdout/err, чтобы просматривать логи через докер

Пример написания template в папке templates. Пример запуска nginx с двумя прослушиваемыми портами одной командой в скрипте run.sh 

#docker run --env SERVER_NAME1=foo.bar --env SERVER_NAME2=bar.foo --env PORT1=80 --env PORT2=8080 \
#-p 9090:80 -p 9999:8080 \
#--mount type=bind,source="$(pwd)"/templates,target=/etc/nginx/templates \
#--mount src=local_nginx_log,dst=/var/log/nginx,volume-opt=device=$(pwd)/logs,volume-opt=type=volume,volume-opt=o=bind \
#-it -d --name nginx1 nginx:1.22.1


