FROM bandsintown/alpine:3.5
MAINTAINER Bandsintown Devops Team "devops@bandsintown.com"

ENV FLUENTD_VERSION="0.12.41" FLUENTD_OPT="" FLUENTD_CONF="fluent.conf" LD_PRELOAD=""

ADD rootfs /

# Do not split this into multiple RUN!
# Docker creates a layer for every RUN-Statement
# therefore an 'apk delete' has no effect
RUN apk update \
 && apk upgrade \
 && apk add --no-cache \
        ca-certificates \
        ruby ruby-irb \
 && apk add --no-cache --virtual .build-deps \
        build-base \
        ruby-dev \
 && update-ca-certificates \
 && echo 'gem: --no-document' >> /etc/gemrc \
 && gem install oj \
 && gem install json \
 && gem install fluentd -v $FLUENTD_VERSION \
 && apk del .build-deps \
 && rm -rf /var/cache/apk/* \
 && rm -rf /tmp/* /var/tmp/* /usr/lib/ruby/gems/*/cache/*.gem

# volume for log storage (maybe shared with host)
VOLUME /var/log/fluentd

# volume for plugins
VOLUME /var/lib/fluentd


EXPOSE 24224 5140

CMD exec fluentd -c /etc/fluentd/$FLUENTD_CONF $FLUENTD_OPT