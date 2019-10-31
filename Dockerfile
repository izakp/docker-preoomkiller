FROM python:2

RUN apt-get update && apt-get install -y curl dumb-init

ADD preoomkiller /usr/local/bin/preoomkiller

ENV ENABLE_PREOOMKILLER 1

ENTRYPOINT ["/usr/bin/dumb-init", "--"]

CMD ["preoomkiller"]

