FROM debian:stretch-slim AS base

FROM base AS user

RUN apt-get update && apt-get install -y apache2-utils
WORKDIR /etc/squid
RUN htpasswd -bc passwords user password

FROM base

RUN apt-get update && apt-get install -y squid

COPY --from=user /etc/squid/passwords /etc/squid/passwords
ADD squid.conf /etc/squid/
EXPOSE 3128/tcp

ENTRYPOINT exec $(which squid) -NYCd 1