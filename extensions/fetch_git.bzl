
load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")


_MIN_BUILD = """
package(default_visibility = ["//visibility:public"])

filegroup(
    name = "all_srcs",
    srcs = glob(
        ["**"],
        exclude = [
            ".git/**",
            "**/.git/**",
        ],
    ),
)
"""

def _get_impl(module_ctx):

    for mod in module_ctx.modules:
        for t in mod.tags.git:
            git_repository(
                name = t.name,          # the repo name you will pass to use_repo(...)
                remote = t.remote,      # e.g. "https://github.com/org/project.git"
                tag = t.tag,      # e.g. "main" or "release/v1"

                
                build_file_content = _MIN_BUILD,
            )

git = tag_class(
    attrs = {
        "name": attr.string(mandatory = True, doc = "External repo name to create (used by use_repo)."),
        "remote": attr.string(mandatory = True, doc = "Git remote URL."),
        "tag": attr.string(mandatory = True, doc = "Git branch to fetch."),
    },
    doc = "Declares a git checkout repo.",
)

fetch_git = module_extension(
    implementation = _get_impl,
    tag_classes = {"git": git},
    doc = "checkouts"
)

# def _impl(ctx):
#     for mod in ctx.modules:
#         for repo in mod.tags.fetch:
#             out = ctx.path(repo.name)
#             ctx.file(repo.name + "/.placeholder", "")

#             ctx.execute(
#                 [
#                     "git", 
#                     "clone", 
#                     "--depth=1",
#                     "--branch", 
#                     repo.tag,
#                     repo.remote,
#                     out
#                 ],
#                 # working_directory = ctx.path("."),
#             )

# fetch_git = module_extension(
#     implementation = _impl,
#     tag_classes = {
#         "fetch": tag_class( attrs = {
#             "name": attr.string(mandatory = True),
#             "remote": attr.string(mandatory = True),
#             "tag": attr.string(),
#             "commit": attr.string(),
#             "strip_prefix": attr.string(),
#             # "patches": attr.string(),
#             # "patch_args": attr.string(),
#         }),
#     },
#     # creates = ["*"]
# )