load("@io_bazel_rules_go//go:deps.bzl", "go_register_toolchains")
load("@rules_proto//proto:toolchains.bzl", "rules_proto_toolchains")
load("@rules_python//python:repositories.bzl", "python_register_toolchains")

def toolchains():
    python_register_toolchains(
        name = "python3_12",
        # Available versions are listed in @rules_python//python:versions.bzl.
        # We recommend using the same version your team is already standardized on.
        python_version = "3.12",
    )
    rules_proto_toolchains()
    go_register_toolchains(version = "1.22.4")
