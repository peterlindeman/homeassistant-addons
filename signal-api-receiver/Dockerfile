ARG BUILD_FROM

# Pinned upstream release; bump this tag deliberately when updating the add-on.
# https://hub.docker.com/r/kalbasit/signal-api-receiver/tags
FROM kalbasit/signal-api-receiver:v0.4.0 AS upstream

# The upstream image is built with `pkgs.dockerTools.buildLayeredImage` (Nix):
# /bin/signal-api-receiver is a symlink into /nix/store/*, which doesn't exist
# outside that image. Copy the whole /nix store alongside it so the symlink
# resolves, then dereference it into a plain file before leaving this stage.
FROM ${BUILD_FROM} AS extract
COPY --from=upstream /nix /nix
COPY --from=upstream /bin/signal-api-receiver /bin/signal-api-receiver
RUN cat /bin/signal-api-receiver > /signal-api-receiver && chmod +x /signal-api-receiver

FROM ${BUILD_FROM}

COPY --from=extract /signal-api-receiver /usr/bin/signal-api-receiver

COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
