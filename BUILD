load("@bazel_gazelle//:def.bzl", "gazelle")
load("@io_bazel_rules_go//go:def.bzl", "go_binary", "go_library")
load("@aspect_bazel_lib//lib:jq.bzl", "jq")

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
