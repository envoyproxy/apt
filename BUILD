load("@bazel_gazelle//:def.bzl", "gazelle")
load("@io_bazel_rules_go//go:def.bzl", "go_binary", "go_library")

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
