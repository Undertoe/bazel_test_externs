

def _impl(module_ctx):
    src_to_expose = []
    for mod in module_ctx.modules:
        for repo in mod.tags.append:
            src_to_expose.append(repo)

    for r in src_to_expose:
        use_repo(module_ctx, r)
    

add_thirdparty_src = module_extension(
    implementation = _impl,
    tag_classes = {
        "append": tag_class(attrs = {"name": attr.string(mandatory = True)})
    },
)