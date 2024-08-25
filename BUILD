load("@bazel_gazelle//:def.bzl", "gazelle")
load("@io_bazel_rules_go//go:def.bzl", "go_binary", "go_library")
load("@aspect_bazel_lib//lib:jq.bzl", "jq")
load("@aspect_bazel_lib//lib:yq.bzl", "yq")
load("@rules_pkg//pkg:pkg.bzl", "pkg_tar")

exports_files([
    "envoy-maintainers-public.key",
])

filegroup(
    name = "true",
    srcs = [],
)

filegroup(
    name = "false",
    srcs = [],
)

label_flag(
    name = "production",
    build_setting_default = ":false",
    visibility = ["//visibility:public"],
)

config_setting(
    name = "production_build",
    flag_values = {":production": ":true"},
)

# gazelle:prefix github.com/aptly-dev/aptly
gazelle(name = "gazelle")

genrule(
    name = "go.mod",
    srcs = ["@aptly//:go.mod"],
    outs = ["go.mod.txt"],
    cmd = "cat $(location @aptly//:go.mod) > $@",
)

gazelle(
    name = "gazelle-update-repos",
    args = [
        "-from_file=$(location :go.mod)",
        "-to_macro=deps-go.bzl%go_dependencies",
        "-prune",
    ],
    command = "update-repos",
    data = [":go.mod"],
)

jq(
    name = "envoy_versions",
    srcs = ["@envoy_repo//:project"],
    out = "envoy_versions.json",
    filter = """
    .releases as $releases
    | {
      latest_releases: [
        .stable_versions[]
        | . as $minor
        | {
            version: $minor,
            releases: (
              $releases
              | map(select(startswith("v" + $minor + ".")))
            )
          }
      ]
    }
    """,
    visibility = ["//visibility:public"],
)

yq(
    name = ".aptly-base",
    args = ["-P"],
    outs = [".aptly-base.json"],
    srcs = [".aptly.yaml"],
    visibility = ["//visibility:public"],
)

yq(
    name = ".aptly-ci-override",
    args = ["-P"],
    outs = [".aptly-ci-override.json"],
    srcs = [".aptly-ci.yaml"],
    visibility = ["//visibility:public"],
)

genrule(
    name = "aptly-empty",
    outs = ["aptly-empty.json"],
    cmd = "echo {} > $@",
)

label_flag(
    name = "aptly-custom",
    build_setting_default = ":aptly-empty",
)

jq(
    name = "aptly-config",
    args = ["-s"],
    out = ".aptly",
    srcs = [
        ".aptly-base.json",
        ":aptly-custom",
    ],
    visibility = ["//visibility:public"],
    filter = """
    .[0] * .[1]
    """,
)

pkg_tar(
    name = "html",
    extension = "tar.gz",
    deps = [
        "//debs:html",
        "//site:html",
    ],
    srcs = ["//site:signing_key"],
)
