""" Builds rcutils.
"""

cc_library(
    name = "rcpputils",
    srcs = glob([
        "src/*.cpp",
    ]),
    hdrs = glob([
        "include/**/*.hpp",
    ]),
    includes = [
        "include",
    ],
    deps = [
        "@ros2_rcutils//:rcutils",
    ],
    visibility = ["//visibility:public"],
)
