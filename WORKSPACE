workspace(name = "envoy_apt")

load("//:versions.bzl", "VERSIONS")
load(":archives.bzl", "archives")
archives(VERSIONS)

load("//:deps.bzl", "dependencies")
dependencies()

load("//:setup.bzl", "setup")
setup()

load("//:toolchains.bzl", "toolchains")
toolchains()

load("@bazel_gazelle//:deps.bzl", "gazelle_dependencies")
# gazelle:repo bazel_gazelle
# gazelle:repository_macro deps-go.bzl%go_dependencies
gazelle_dependencies(go_repository_default_config = "//:WORKSPACE")
