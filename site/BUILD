load("@envoy_toolshed//website:macros.bzl", "static_website")

ENVOY_APT_URL = "https://apt.envoyproxy.io"

exports_files([
    "signing.key",
    "url.txt",
])

genrule(
    name = "default_url",
    outs = ["default_url.txt"],
    cmd = """
    echo %s > $@
    """ % ENVOY_APT_URL,
)

label_flag(
    name = "url",
    build_setting_default = ":default_url",
    visibility = ["//visibility:public"],
)

label_flag(
    name = "signing-key",
    build_setting_default = "//:envoy-maintainers-public.key",
    visibility = ["//visibility:public"],
)

filegroup(
    name = "config",
    srcs = ["pelicanconf.py"],
    visibility = ["//visibility:public"],
)

static_website(
    name = "html",
    content = "//site/content",
    data = "//site/data",
    theme = "//site/theme",
    url = ":url",
    visibility = ["//visibility:public"],
)
