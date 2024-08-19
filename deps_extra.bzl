load("@base_pip3//:requirements.bzl", pip_dependencies = "install_deps")
load("@bazel_gazelle//:deps.bzl", "gazelle_dependencies")
load("@envoy_apt_pip3//:requirements.bzl", "install_deps")

def dependencies_extra():
    pip_dependencies()
    gazelle_dependencies(go_repository_default_config = "//:WORKSPACE")
    install_deps()
