FROM alpine:latest as builder

LABEL maintainer Steve Richards <srichards@mirantis.com> \
      version=0.1

RUN apk add --update -t build-deps go git make

COPY . /src

RUN cd /src && go build -o /bin/prometheus-exporter

FROM alpine:latest as rethinkdb-exporter

LABEL maintainer Steve Richards <srichards@mirantis.com> \
      version=0.1

WORKDIR /bin

COPY --from=builder /bin/prometheus-exporter .

EXPOSE     9055

ENTRYPOINT [ "/bin/prometheus-exporter" ]