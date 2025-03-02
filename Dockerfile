FROM debian:latest
WORKDIR /render

ARG TAILSCALE_VERSION
ENV TAILSCALE_VERSION=$TAILSCALE_VERSION

RUN apt-get update
RUN apt-get install --upgrade -y --no-install-recommends apt-transport-https \
    ca-certificates \
    netcat-openbsd \
    wget \
    dnsutils
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN echo "+search +short" > /root/.digrc
COPY run-tailscale.sh /render/

COPY install-tailscale.sh /tmp
RUN /tmp/install-tailscale.sh && rm -r /tmp/*

CMD ./run-tailscale.sh
