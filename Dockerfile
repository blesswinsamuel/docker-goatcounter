FROM amd64/alpine:3.14

RUN apk add --no-cache postgresql-client

# Without this goatcounter won't start.
RUN apk --update --no-cache add tzdata
ENV TZ UTC

ENV VERSION=2.0.4

RUN wget https://github.com/zgoat/goatcounter/releases/download/v$VERSION/goatcounter-v$VERSION-linux-amd64.gz \
    && gunzip goatcounter-v$VERSION-linux-amd64.gz \
    && mv goatcounter-v$VERSION-linux-amd64 goatcounter \
    && chmod a+x goatcounter

ENTRYPOINT ["./goatcounter"]
