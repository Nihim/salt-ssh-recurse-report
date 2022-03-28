FROM debian:11-slim

RUN apt update && apt install -q -y python3-pip openssh-client nvi \
    && python3 -m pip install jinja2==3.0.3 salt-ssh

RUN useradd -m -d /salt-ssh -s /bin/bash -u 1010 salt

WORKDIR /salt-ssh

ADD --chown=1010 conf ./
ADD dir1 ./dir1/
ADD dir2 ./dir2/

RUN chown salt dir1 dir2

USER salt

CMD ["sleep","900"]
