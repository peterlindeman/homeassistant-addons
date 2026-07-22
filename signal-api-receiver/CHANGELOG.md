# Changelog

## 1.0.3

- Add `icon.png` (128x128) and `logo.png` (256x256), based on the Signal logo.

## 1.0.2

- Fix: 1.0.1 dereferenced the upstream binary's symlink but dropped the rest
  of its Nix closure, so the binary (dynamically linked against glibc, not
  static as assumed) still couldn't run: `exec ...: no such file or
  directory` — the dynamic linker itself was missing. Now the full `/nix`
  store from the upstream image is copied alongside the binary/symlink so
  glibc, tzdata and nss data are all present at runtime.

## 1.0.1

- Fix: `/usr/bin/signal-api-receiver` was a dangling symlink at runtime
  ("cannot execute: required file not found"), because the upstream image's
  binary is itself a symlink into a Nix store path that didn't exist in the
  add-on's base image. The Dockerfile now dereferences it into a plain file
  during the build.

## 1.0.0

- Initial release, wrapping `kalbasit/signal-api-receiver:v0.4.0`.
