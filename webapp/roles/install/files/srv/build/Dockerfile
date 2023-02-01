FROM alpine:3.16.3
RUN apk add python3=3.10.9-r0 py3-pip=22.1.1-r0 && \
apk add --virtual .tmpdep --no-cache postgresql-dev && \
pip install psycopg2-binary Flask ConfigParser && \
apk del --no-cache .tmpdep && \
mkdir -p /srv/app/conf
COPY app/web.py /srv/app/web.py
COPY app/conf/web.conf /srv/app/conf/web.conf

ENTRYPOINT ["python3", "/srv/app/web.py"]




