load("@envoy//bazel:python_dependencies.bzl", "envoy_python_dependencies")
load("@envoy//bazel:repo.bzl", "envoy_repo")
load("@python3_12//:defs.bzl", "interpreter")
load("@rules_python//python:pip.bzl", "pip_parse")

def setup_extra():
    envoy_repo()
    envoy_python_dependencies()
    pip_parse(
        name = "envoy_apt_pip3",
        python_interpreter_target = interpreter,
        requirements_lock = "//tools:requirements.txt",
        extra_pip_args = ["--require-hashes"],
    )
