FROM ubuntu:bionic

ENV CONSUL_TEMPLATE_VERSION=0.19.5
ENV PORT=8443

RUN apt-get update && \
   apt-get install  --no-install-recommends --no-install-suggests -y psutils unzip bash curl openssl nginx net-tools \
   apt-get remove --purge --auto-remove -y apt-transport-https ca-certificates && \
   rm -rf /var/lib/apt/lists/* /etc/apt/sources.list.d/nginx.list

ADD https://releases.hashicorp.com/consul-template/${CONSUL_TEMPLATE_VERSION}/consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip /

RUN unzip /consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip  && \
    mv /consul-template /usr/local/bin/consul-template && \
    rm -rf /consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip

EXPOSE $PORT
ADD entrypoint.sh /
RUN ln -sf /dev/stdout /var/log/nginx/access.log && ln -sf /dev/stderr /var/log/nginx/error.log
ADD nginx.conf.tpl /
ADD base.conf /nginx.conf
ADD nginx.hcl /consul.hcl
ENTRYPOINT ["/entrypoint.sh"]