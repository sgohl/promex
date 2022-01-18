FROM msoap/shell2http

RUN apk add -U --no-cache bash curl docker jq coreutils openssl ts

COPY promex /bin/
RUN chmod -R +x /bin

COPY checks /checks

ENV OPTS="-cgi -include-stderr -show-errors -export-all-vars"

#ENV TS_ONFINISH="/bin/onfinish"
ENV TS_SLOTS="100"
ENV TS_MAXFINISHED="1000"
ENV BASE="/checks"
ENV OUT="/tmp/out"
ENV GROUPS="foo"

ENTRYPOINT []
CMD ["/bin/promex", "web"]
