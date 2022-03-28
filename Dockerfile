FROM debian:11-slim

RUN apt update && apt install -q -y python3-pip openssh-client nvi \
    && python3 -m pip install jinja2==3.0.3 salt-ssh

RUN useradd -m -d /salt-ssh -s /bin/bash -u 1010 salt

WORKDIR /salt-ssh

COPY --chown=1010 conf ./
COPY dir1 dir1
COPY dir2 dir2

RUN chown salt dir1 dir2
RUN chmod 400 dir?/file5

USER salt

CMD ["sleep","inf"]
