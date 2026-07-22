# Changelog

## 1.0.1

- Fix: `/usr/bin/signal-api-receiver` was a dangling symlink at runtime
  ("cannot execute: required file not found"), because the upstream image's
  binary is itself a symlink into a Nix store path that didn't exist in the
  add-on's base image. The Dockerfile now dereferences it into a plain file
  during the build.

## 1.0.0

- Initial release, wrapping `kalbasit/signal-api-receiver:v0.4.0`.
