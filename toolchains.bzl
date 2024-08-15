load("@aspect_bazel_lib//lib:repositories.bzl", "register_jq_toolchains", "register_yq_toolchains")
load("@io_bazel_rules_go//go:deps.bzl", "go_register_toolchains")
load("@rules_proto//proto:toolchains.bzl", "rules_proto_toolchains")
load("@rules_python//python:repositories.bzl", "python_register_toolchains")

def _python_minor_version(python_version):
    return "_".join(python_version.split(".")[:2])

def toolchains(versions):
    python_register_toolchains(
        name = "python%s" % _python_minor_version(versions["python"]),
        python_version = versions["python"],
    )
    rules_proto_toolchains()
    go_register_toolchains(version = "1.22.4")
    register_jq_toolchains(version = versions["jq"])
    register_yq_toolchains(version = versions["yq"])
