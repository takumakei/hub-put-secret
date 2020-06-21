FROM node:lts-alpine3.11

WORKDIR /opt/
COPY ./opt /opt/

RUN apk add --no-cache git jq \
 && wget -O - https://github.com/github/hub/releases/download/v2.14.2/hub-linux-arm64-2.14.2.tgz | tar x -z -f - -C /opt \
 && ln -s /opt/hub-linux-arm64-2.14.2/bin/hub /usr/local/bin/hub \
 && chmod +x /opt/hub-put-secret.sh \
 && npm install tweetsodium

ENTRYPOINT ["/opt/hub-put-secret.sh"]
