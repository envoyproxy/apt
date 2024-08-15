load("@envoy//bazel:python_dependencies.bzl", "envoy_python_dependencies")
load("@envoy//bazel:repo.bzl", "envoy_repo")

def setup_extra():
    envoy_python_dependencies()
    envoy_repo()
