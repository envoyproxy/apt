load("@bazel_gazelle//:def.bzl", "gazelle")
load("@io_bazel_rules_go//go:def.bzl", "go_binary", "go_library")

# gazelle:prefix github.com/aptly-dev/aptly
gazelle(name = "gazelle")

genrule(
    name = "go.mod",
    srcs = ["@com_github_aptly_dev_aptly//:go.mod"],
    outs = ["go.mod.txt"],
    cmd = "cat $(location @com_github_aptly_dev_aptly//:go.mod) > $@",
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

go_library(
    name = "aptly_lib",
    srcs = ["@com_github_aptly_dev_aptly//:main.go"],
    importpath = "github.com/aptly-dev/aptly",
    visibility = ["//visibility:private"],
    deps = [
        "@com_github_aptly_dev_aptly//aptly",
        "@com_github_aptly_dev_aptly//cmd",
    ],
)
