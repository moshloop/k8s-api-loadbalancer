FROM ubuntu:bionic

ENV CONSUL_TEMPLATE_VERSION=0.19.5

RUN apt-get update && apt-get install -y haproxy psutils unzip bash
ADD https://releases.hashicorp.com/consul-template/${CONSUL_TEMPLATE_VERSION}/consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip /
RUN unzip /consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip  && \
    mv /consul-template /usr/local/bin/consul-template && \
    rm -rf /consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip

EXPOSE 6443
EXPOSE 1936
ADD entrypoint.sh /
ADD haproxy.cfg.tpl /consul-template/
ADD haproxy.hcl /consul-template/
RUN mkdir -p /haproxy

ENTRYPOINT ["/entrypoint.sh"]