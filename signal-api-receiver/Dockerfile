ARG BUILD_FROM

# Pinned upstream release; bump this tag deliberately when updating the add-on.
# https://hub.docker.com/r/kalbasit/signal-api-receiver/tags
FROM kalbasit/signal-api-receiver:v0.4.0 AS upstream

FROM ${BUILD_FROM}

# The upstream image is built with `pkgs.dockerTools.buildLayeredImage` (Nix):
# /bin/signal-api-receiver is a symlink into /nix/store/*, and the binary is
# dynamically linked against glibc (also in /nix/store/*, along with tzdata /
# nss data it pulls in). Both the symlink and its full runtime closure need to
# come along, so copy /nix wholesale rather than trying to extract a single
# static binary.
COPY --from=upstream /nix /nix
COPY --from=upstream /bin/signal-api-receiver /usr/bin/signal-api-receiver

COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
