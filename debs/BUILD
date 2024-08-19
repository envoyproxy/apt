load("@aspect_bazel_lib//lib:jq.bzl", "jq")

sh_binary(
    name = "publish",
    srcs = ["publish.sh"],
    env = {
        "APTLY_BIN": "$(location @aptly)",
        "MAINTAINER_KEY": "$(location //:envoy-maintainers-public.key)",
        "APTLY_CONF": "$(location //:aptly-config)",
    },
    data = [
        "@aptly",
        "//:aptly-config",
        "//:envoy-maintainers-public.key",
    ],
)
