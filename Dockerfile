FROM msoap/shell2http

ENV OPTS="-no-index"
ENV TS_ONFINISH="/bin/onfinish"
ENV TS_SLOTS="100"
ENV TS_MAXFINISHED="1000"

ENV BASE="/opt"
ENV OUT="/tmp/out"

RUN apk add -U --no-cache bash curl docker jq coreutils openssl ts
RUN mkdir -p $OUT

COPY dist /
RUN chmod -R +x /bin

ENTRYPOINT []
CMD ["/bin/promex", "web"]
