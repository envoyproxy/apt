load("@rules_proto//proto:setup.bzl", "rules_proto_setup")
load("@rules_python//python:repositories.bzl", "py_repositories")

def setup():
    py_repositories()
    rules_proto_setup()
