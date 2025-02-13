FROM ubuntu:24.04

COPY sasl-xoauth2-ubuntu-stable-noble.sources /etc/apt/sources.list.d/

RUN apt update \
    && DEBIAN_FRONTEND=noninteractive apt install -y \
        postfix curl ca-certificates gettext-base python3 \
    && apt update \
    && DEBIAN_FRONTEND=noninteractive apt install -y \
    sasl-xoauth2 \
    && apt-get clean \
    && ln -sf /var/spool/postfix/etc/sasl-xoauth2.conf /etc/sasl-xoauth2.conf

COPY smtp-relay.sh /

COPY master.cf /etc/postfix/

EXPOSE 2525

ENTRYPOINT [ "/smtp-relay.sh" ]
