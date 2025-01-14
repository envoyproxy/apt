
def _fetch_impl(ctx):
    output_dir = ctx.actions.declare_directory("debs")
    inputs = depset(
        [ctx.executable.fetch,
         ctx.file.downloads,
         ctx.file.excludes,
         ctx.file.token],
        transitive = [ctx.attr.fetch[DefaultInfo].files],
    )
    ctx.actions.run(
        executable = ctx.executable.fetch,
        inputs = inputs,
        outputs = [output_dir],
        arguments = [
            ctx.file.downloads.path,
            "--concurrency 4",
            "--excludes=%s" % ctx.file.excludes.path,
            "--token-path=%s" % ctx.file.token.path,
            "--extract-downloads",
            "--output-path=%s" % output_dir.path,
            "--output=dir",
            # "-ldebug",
            # "-vdebug",
        ],
        mnemonic = "FetchDebs",
    )
    return [DefaultInfo(files = depset([output_dir]))]

fetch_debs = rule(
    implementation = _fetch_impl,
    attrs = {
        "downloads": attr.label(
            mandatory = True,
            allow_single_file = True,
        ),
        "fetch": attr.label(
            default = "//tools/fetch",
            executable = True,
            cfg = "host",
        ),
        "token": attr.label(
            mandatory = True,
            allow_single_file = True,
        ),
        "excludes": attr.label(allow_single_file = True),
    },
)
