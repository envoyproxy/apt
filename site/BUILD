
ENVOY_APT_URL = "https://apt.envoyproxy.io"

exports_files([
    "signing.key",
    "url.txt",
])

genrule(
    name = "default_url",
    outs = ["default_url.txt"],
    cmd = """
    echo %s > $@
    """ % ENVOY_APT_URL,
)

label_flag(
    name = "url",
    build_setting_default = ":default_url",
    visibility = ["//visibility:public"],
)

label_flag(
    name = "signing-key",
    build_setting_default = "//:envoy-maintainers-public.key",
    visibility = ["//visibility:public"],
)

genrule(
    name = "html",
    outs = ["site.tar.gz"],
    cmd = """
    TMPDIR=$$(mktemp -d)
    URL_HOST="$$(cat $(location :url))"
    KEY_URL="$${URL_HOST}/signing.key"
    cat $(location :signing-key) > "$${TMPDIR}/signing.key"
    echo "<h1>COMING SOON: $${URL_HOST}</h1>" > "$${TMPDIR}/index.html"
    echo "<div>Signing key: <a href=\"$${KEY_URL}\">$${KEY_URL}</div>" >> "$${TMPDIR}/index.html"
    tar cf $@ -C "$${TMPDIR}" .
    """,
    tools = [
        ":signing-key",
        ":url",
    ],
    visibility = ["//visibility:public"],
)
