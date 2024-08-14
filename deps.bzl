load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def dependencies():
    http_archive(
        name = "io_bazel_rules_go",
        integrity = "sha256-M6zErg9wUC20uJPJ/B3Xqb+ZjCPn/yxFF3QdQEmpdvg=",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/rules_go/releases/download/v0.48.0/rules_go-v0.48.0.zip",
            "https://github.com/bazelbuild/rules_go/releases/download/v0.48.0/rules_go-v0.48.0.zip",
        ],
    )
    http_archive(
        name = "bazel_gazelle",
        sha256 = "d76bf7a60fd8b050444090dfa2837a4eaf9829e1165618ee35dceca5cbdf58d5",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/bazel-gazelle/releases/download/v0.37.0/bazel-gazelle-v0.37.0.tar.gz",
            "https://github.com/bazelbuild/bazel-gazelle/releases/download/v0.37.0/bazel-gazelle-v0.37.0.tar.gz",
        ],
    )
    http_archive(
        name = "rules_proto",
        sha256 = "6fb6767d1bef535310547e03247f7518b03487740c11b6c6adb7952033fe1295",
        urls = ["https://github.com/bazelbuild/rules_proto/archive/refs/tags/6.0.2.tar.gz"],
        strip_prefix = "rules_proto-6.0.2",
    )
    http_archive(
        name = "rules_pkg",
        sha256 = "23005750a27aabfd5975a3d5aeac9542371cbfa24d3ad74e47f80b84547754da",
        urls = ["https://github.com/bazelbuild/rules_pkg/archive/refs/tags/1.0.1.tar.gz"],
        strip_prefix = "rules_pkg-1.0.1",
    )
    http_archive(
        name = "rules_python",
        sha256 = "778aaeab3e6cfd56d681c89f5c10d7ad6bf8d2f1a72de9de55b23081b2d31618",
        urls = ["https://github.com/bazelbuild/rules_python/archive/refs/tags/0.34.0.tar.gz"],
        strip_prefix = "rules_python-0.34.0",
    )
    http_archive(
        name = "com_google_absl",
        sha256 = "987ce98f02eefbaf930d6e38ab16aa05737234d7afbab2d5c4ea7adbe50c28ed",
        strip_prefix = "abseil-cpp-20230802.1",
        urls = ["https://github.com/abseil/abseil-cpp/archive/20230802.1.tar.gz"],
    )
    http_archive(
        name = "com_google_protobuf",
        sha256 = "4fc5ff1b2c339fb86cd3a25f0b5311478ab081e65ad258c6789359cd84d421f8",
        strip_prefix = "protobuf-26.1",
        urls = ["https://github.com/protocolbuffers/protobuf/releases/download/v26.1/protobuf-26.1.tar.gz"],
    )
