FROM weseek/crowi-plus:2.0.1

MAINTAINER Shoma Nishitateno <shoma416@gmail.com>

# install dockerize
ENV DOCKERIZE_VERSION v0.3.0

RUN set -xe \
    && apk add --no-cache --virtual .dl-deps \
        curl \
    && curl -SL https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
        | tar -xz -C /usr/local/bin \
    && apk del .dl-deps

# corresponds to `FILE_UPLOAD=local`
RUN set -xe \
    && mkdir -p /data/uploads \
    && ln -s /data/uploads $APP_DIR/public/uploads

# install plugins
RUN set -xe \
    && npm install --save \
        crowi-plugin-lsx \
        crowi-plugin-pukiwiki-like-linker

RUN npm run build:prod

COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD [""]