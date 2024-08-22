load("@aspect_bazel_lib//lib:yq.bzl", "yq")
load("@rules_pkg//pkg:mappings.bzl", "pkg_filegroup", "pkg_files")
load("@rules_pkg//pkg:pkg.bzl", "pkg_tar")

exports_files(["file_list.txt"])

label_flag(
    name = "file-list",
    build_setting_default = "//debs:file_list",
    visibility = ["//visibility:public"],
)

yq(
    name = "nav",
    srcs = ["@envoy-website//site/data:nav.yaml"],
    outs = ["nav.yaml"],
    expression = """
    .[] | select(.url | test("^http") | not).url |= "https://envoyproxy.io" + . | [.]
    """,
    visibility = ["//visibility:public"],
)

pkg_files(
    name = "yaml_files",
    srcs = [
        ":nav.yaml",
        "home.yaml",
        "site.yaml",
        ":file-list",
    ],
    prefix = "data",
    strip_prefix = "",
)

pkg_filegroup(
    name = "data",
    srcs = [":yaml_files"],
    visibility = ["//visibility:public"],
)
