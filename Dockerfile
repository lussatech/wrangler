FROM alpine:3.11

ENV WRANGLER_LATEST_VERSION="v1.10.3"

# setup dependencies
RUN apk add --update ca-certificates \
  && apk add --update -t deps curl \
  && mkdir /lib64 \
  && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2

# download binaries
RUN curl -L https://github.com/cloudflare/wrangler/releases/download/${WRANGLER_LATEST_VERSION}/wrangler-${WRANGLER_LATEST_VERSION}-x86_64-unknown-linux-musl.tar.gz | tar xz \
  && cp dist/wrangler /usr/local/bin/wrangler

# clean ups
RUN apk del --purge deps \
  && rm /var/cache/apk/*

ENTRYPOINT ["/bin/sh", "-c"]
CMD ["wrangler", "help"]
