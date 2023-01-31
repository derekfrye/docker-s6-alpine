# s6-alpine

This is an updated version of a [previously archived repository](https://github.com/oznu/docker-s6-alpine) base Alpine image with the [S6 Overlay](https://github.com/just-containers/s6-overlay).

## Usage

You probably don't want to run this directly, you probably want to build it so you can then build and run [ddns](https://github.com/derekfrye/docker-cloudflare-ddns).

Build:

```shell
docker buildx build --tag djf/alpine-s6 -f Dockerfile --platform linux/arm64 .
```

If you really want to run it (testing?), do:
```shell
docker run djf/alpine-s6
```
See the [S6 Overlay Documentation](https://github.com/just-containers/s6-overlay) for details on how to manage services.
