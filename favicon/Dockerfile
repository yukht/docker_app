FROM alpine:3.10
RUN apk add --no-cache python3 py3-pip && \
mkdir /app && pip3 install requests
COPY ./app/my_app.py /app/

ENTRYPOINT ["python3", "/app/my_app.py"]

