FROM frolvlad/alpine-bash as base

LABEL "repository"="https://github.com/Gerkiz/ControlComment"
LABEL "homepage"="https://nvfs.se"
LABEL "maintainer"="Gerkiz <gerkiz@nvfs.se>"

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
