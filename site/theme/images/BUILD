load("@rules_pkg//pkg:mappings.bzl", "pkg_filegroup", "pkg_files")

pkg_files(
    name = "extra_images",
    srcs = glob([
        "**/*.svg",
    ]),
    prefix = "theme/images",
    strip_prefix = "",
    visibility = ["//visibility:public"],
)

pkg_filegroup(
    name = "images",
    srcs = [
        "@envoy-website//site/theme/images:image_files",
        ":extra_images",
    ],
    visibility = ["//visibility:public"],
)
