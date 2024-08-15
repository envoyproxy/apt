workspace(name = "envoy_apt")

load("//:versions.bzl", "VERSIONS")
load(":archives.bzl", "archives")
archives(VERSIONS)

load("//:deps.bzl", "dependencies")
dependencies()

load("//:setup.bzl", "setup")
setup()

load("//:toolchains.bzl", "toolchains")
toolchains(VERSIONS)

load("//:setup_extra.bzl", "setup_extra")
setup_extra()

load("//:deps_extra.bzl", "dependencies_extra")
dependencies_extra()

# gazelle:repo bazel_gazelle
# gazelle:repository_macro deps-go.bzl%go_dependencies
