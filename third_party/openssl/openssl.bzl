load("@rules_foreign_cc//foreign_cc:configure.bzl", "configure_make")


def openssl_component(name):
    configure_make(
        name = name,
        lib_source = "@openssl_src//:all_srcs",

        #configure
        # configure_command = select({
        #     "@platforms//os:windows": "perl Configure VC-WIN64A",
        #     "//conditions:default": "./Configure"
        # }),
        configure_command = "perl Configure VC-WIN64A",
        configure_options = [ "shared", "no-tests", ],

        # actual build stuff
        # make_commands = select({
        #     "@platforms//os:windows": ["nmake"],
        #     "//conditions:default": ["make"],
        # }),

        # install_commands = (),
        

        # gather the things
        out_lib_dir = "lib", 
        out_include_dir = "include",


        visibility = ["//visibility:public"]
    )
