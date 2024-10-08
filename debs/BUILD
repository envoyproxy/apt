load("@aspect_bazel_lib//lib:jq.bzl", "jq")

MAINTAINER = "Envoy maintainers <envoy-maintainers@googlegroups.com>"

exports_files([
    "excludes.txt",
    "token.txt",
    "signing-token.txt",
])

genrule(
    name = "empty",
    outs = ["empty.txt"],
    cmd = """
    touch $@
    """,
)

label_flag(
    name = "excludes",
    build_setting_default = ":empty",
    visibility = ["//visibility:public"],
)

label_flag(
    name = "token",
    build_setting_default = ":empty",
    visibility = ["//visibility:public"],
)

label_flag(
    name = "signing-token",
    build_setting_default = ":empty",
    visibility = ["//visibility:public"],
)

jq(
    name = "envoy_versions",
    srcs = ["@envoy_repo//:project"],
    out = "envoy_versions.json",
    filter = """
    .releases as $releases
    | {
      latest_releases: [
        .stable_versions[]
        | . as $minor
        | {
            version: $minor,
            releases: (
              $releases
              | map(select(startswith("v" + $minor + ".")))
            )
          }
      ]
    }
    """,
    visibility = ["//visibility:public"],
)

jq(
    name = "minor_versions",
    srcs = [":envoy_versions"],
    out = "minor_versions.txt",
    filter = """
    .latest_releases[] | .version
    """,
    args = ["-r"],
    visibility = ["//visibility:public"],
)

jq(
    name = "patch_versions",
    srcs = [":envoy_versions"],
    out = "patch_versions.txt",
    filter = """
    .latest_releases[] | .releases[]
    """,
    args = ["-r"],
    visibility = ["//visibility:public"],
)

jq(
    name = "deb_checksum_downloads",
    srcs = [":envoy_versions"],
    out = "deb_checksum_downloads.txt",
    filter = """
    reduce .latest_releases[].releases[] as $item ({};
      .[$item] = {"signature": "%s"})
    | with_entries(
        {"key": "https://github.com/envoyproxy/envoy/releases/download/\\(.key)/checksums.txt.asc",
         "value": .value})
    """ % MAINTAINER,
    args = ["-r"],
    visibility = ["//visibility:public"],
)

genrule(
    name = "published_checksums",
    outs = ["published_checksums.txt"],
    cmd = """
    $(location //tools/fetch) $(location :deb_checksum_downloads) --output=json > $@
    """,
    tools = [
        "//tools/fetch",
        ":deb_checksum_downloads",
    ],
)

jq(
    name = "debs_downloads",
    srcs = [":published_checksums"],
    out = "debs_downloads.json",
    filter = """
    with_entries(
      .key as $key
        | .value as $value
        | ($key | capture("v(?<version>[0-9.]+)") | .version) as $version
        | {key: ("https://github.com/envoyproxy/envoy/releases/download/v\\($version)/debs.tar.gz"),
           value: {
             "path": "v\\($version)",
             "checksum": (
               $value
               | split("\n")
               | map(select(endswith("debs.tar.gz")))
               | first
               | split(" ")
               | .[0]
             )}})
    """,
    visibility = ["//visibility:public"],
)

genrule(
    name = "debs",
    outs = ["debs.tar.gz"],
    cmd = """
    $(location //tools/fetch) $(location :debs_downloads) \
        --concurrency 4 \
        --excludes=$(location :excludes) \
        --token-path=$(location :token) \
        --extract-downloads \
        --output-path=$@
    if [[ ! -e $@ ]]; then
        touch $@
    fi
    """,
    tools = [
        "//tools/fetch",
        ":debs_downloads",
        ":excludes",
        ":token",
    ],
    visibility = ["//visibility:public"],
)

PUBLISH_ENV = {
    "APTLY_BIN": "$(location @aptly)",
    "MAINTAINER_KEY": "$(location //:envoy-maintainers-public.key)",
    "APTLY_CONF": "$(location //:aptly-config)",
    "DEBS": "$(location :debs)",
    "DEBS_ROOT": "$${APT_ROOT}/repository",
    "SIGNING_TOKEN": "$(location :signing-token)",
}

sh_binary(
    name = "publish",
    srcs = ["publish.sh"],
    env = PUBLISH_ENV | select({
        "//:production_build": {"SIGNING_KEY": "Envoy maintainers <envoy-maintainers@googlegroups.com>"},
        "//conditions:default": {"SIGNING_KEY": "Envoy CI <envoy-ci@for.testing.only>"},
    }),
    data = [
        "@aptly",
        "//:aptly-config",
        "//:envoy-maintainers-public.key",
        ":debs",
        ":signing-token",
    ],
    visibility = ["//visibility:public"],
)

HTML_BUILD_CMD = """
export APTLY_BIN="$(location @aptly)"
export MAINTAINER_KEY="$(location //:envoy-maintainers-public.key)"
export APTLY_CONF="$(location //:aptly-config)"
export DEBS="$(location :debs)"
export DEBS_ROOT="$${APT_ROOT}/repository"
export SIGNING_TOKEN="$(location :signing-token)"
$(location :publish)
tar hcf $@ -C $${APT_ROOT}/html .
"""

genrule(
    name = "html",
    outs = ["html.tar.gz"],
    cmd = select({
        "//:production_build": "export SIGNING_KEY=\"Envoy maintainers <envoy-maintainers@googlegroups.com>\"",
        "//conditions:default": "export SIGNING_KEY=\"envoy-ci@for.testing.only\"",
    }) + HTML_BUILD_CMD,
    tools = [
        "@aptly",
        "//:aptly-config",
        "//:envoy-maintainers-public.key",
        ":debs",
        ":publish",
        ":signing-token",
    ],
    visibility = ["//visibility:public"],
)

genrule(
    name = "file_list",
    srcs = [":html.tar.gz"],
    outs = ["file_list.txt"],
    cmd = "tar -tf $(location :html.tar.gz) | grep -v '/$$' > $@",
    visibility = ["//visibility:public"],
)
