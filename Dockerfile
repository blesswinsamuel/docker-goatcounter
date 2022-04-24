# https://github.com/BretFisher/multi-platform-docker-build
FROM --platform=${BUILDPLATFORM} alpine:3.15.4

RUN apk add --no-cache postgresql-client

# Without this goatcounter won't start.
RUN apk --update --no-cache add tzdata
ENV TZ UTC

ENV VERSION=2.2.3
ARG TARGETPLATFORM

RUN case ${TARGETPLATFORM} in \
         "linux/amd64")  ARCH=amd64  ;; \
         "linux/arm64")  ARCH=arm64  ;; \
         "linux/arm/v7") ARCH=armhf  ;; \
         "linux/arm/v6") ARCH=armel  ;; \
         "linux/386")    ARCH=i386   ;; \
    esac \
    && FILENAME=goatcounter-v${VERSION}-linux-${ARCH}
    && wget https://github.com/zgoat/goatcounter/releases/download/v${VERSION}/${FILENAME}.gz \
    && gunzip ${FILENAME}.gz \
    && mv ${FILENAME} goatcounter \
    && chmod a+x goatcounter

ENTRYPOINT ["./goatcounter"]
