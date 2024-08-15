load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@com_google_protobuf//:protobuf_deps.bzl", "protobuf_deps")
load("@rules_proto//proto:repositories.bzl", "rules_proto_dependencies")
load("@io_bazel_rules_go//go:deps.bzl", "go_register_toolchains", "go_rules_dependencies")
load("//:deps-go.bzl", "aptly_dependencies", "go_dependencies")

def dependencies():
    protobuf_deps()
    rules_proto_dependencies()
    aptly_dependencies()
    go_dependencies()
    go_rules_dependencies()
