FROM cloudron/base:4.2.0@sha256:46da2fffb36353ef714f97ae8e962bd2c212ca091108d768ba473078319a47f4

RUN mkdir -p /app/code
WORKDIR /app/code

ARG VERSION=0.2.11

RUN wget -P /app/code/ https://gitea.com/gitea/act_runner/releases/download/v${VERSION}/act_runner-${VERSION}-linux-amd64

RUN mv /app/code/act_runner-${VERSION}-linux-amd64 /app/code/act_runner && \
    chmod +x /app/code/act_runner

COPY config.yaml start.sh /app/pkg/

CMD [ "/app/pkg/start.sh" ]

