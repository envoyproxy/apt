load("@envoy_apt_pip3//:requirements.bzl", "requirement", base_entry_point = "entry_point")
load("@envoy_toolshed//py:macros.bzl", "entry_point")

entry_point(
    name = "fetch",
    pkg = "envoy.base.utils",
    script = "envoy.fetch",
    entry_point_alias = base_entry_point,
    visibility = ["//visibility:public"],
)
