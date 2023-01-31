ARG BASE_IMAGE
FROM alpine:latest

ENV S6_KEEP_ENV=1

ARG TARGETPLATFORM
RUN case ${TARGETPLATFORM} in \	
 "linux/amd64") S6_ARCH="amd64" ;; \
 "linux/arm64") S6_ARCH="aarch64" ;; \
 "linux/arm/v7") S6_ARCH="armhf" ;; \
 *) echo "${TARGETPLATFORM}"; echo "unsupported architecture"; exit 1 ;; \
esac \
&& set -x && apk add curl coreutils tzdata shadow xz \
&& curl -L -s https://github.com/just-containers/s6-overlay/releases/download/v3.1.3.0/s6-overlay-noarch.tar.xz | tar -xvJf - -C / \
&& curl -L -s https://github.com/just-containers/s6-overlay/releases/download/v3.1.3.0/s6-overlay-${S6_ARCH}.tar.xz | tar -xvJf - -C / \
&& groupmod -g 911 users && \
  useradd -u 911 -U -d /config -s /bin/false abc && \
  usermod -G users abc && \
  mkdir -p /app /config /defaults && \
  apk del --no-cache curl \
  apk del --purge \
  rm -rf /tmp/*

ENTRYPOINT [ "/init" ]
