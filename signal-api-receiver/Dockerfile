ARG BUILD_FROM

# Pinned upstream release; bump this tag deliberately when updating the add-on.
# https://hub.docker.com/r/kalbasit/signal-api-receiver/tags
FROM kalbasit/signal-api-receiver:v0.4.0 AS upstream

FROM ${BUILD_FROM}

# The upstream image is built with `pkgs.dockerTools.buildLayeredImage` (Nix)
# and only contains the statically-linked binary at /bin/signal-api-receiver.
COPY --from=upstream /bin/signal-api-receiver /usr/bin/signal-api-receiver

COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
