FROM msoap/shell2http

ENV TS_ONFINISH="/bin/onfinish"
ENV TS_SLOTS="100"
ENV TS_MAXFINISHED="1000"

ENV BASE="/checks"
ENV OUT="/tmp/out"

RUN apk add -U --no-cache bash curl docker jq coreutils openssl ts
RUN mkdir -p $OUT

COPY dist /
COPY checks /
RUN chmod -R +x /bin

ENTRYPOINT []
CMD ["/bin/promex", "web"]
