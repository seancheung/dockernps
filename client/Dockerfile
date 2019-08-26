FROM alpine:3.9
LABEL maintainer="Sean Cheung <theoxuanx@gmail.com>"

ARG CN_MIRROR=false
RUN if [ "$CN_MIRROR" = true ]; then sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories; fi

RUN set -ex && \
    apk add --no-cache bash && \
    apk add --no-cache --virtual TMP curl && \
    file_url=$(curl -s 'https://api.github.com/repos/cnlh/nps/releases/latest' | grep "browser_download_url.*linux_amd64_client.tar.gz" | cut -d '"' -f 4) && \
    curl -sL "$file_url" | tar -xzv -C /tmp && \
    mkdir -p /etc/nps && \
    cp -r /tmp/nps/conf /etc/nps/ && \
    cp /tmp/nps/npc /usr/bin/ && \
    apk del TMP && \
    rm -rf /var/cache/apk/* && \
    rm -rf /tmp/*

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/bin/npc", "-config=/etc/nps/conf/npc.conf"]