""" Builds rmw.
"""

cc_library(
    name = "rmw",
    srcs = glob([
        "rmw/src/*.c",
    ]),
    hdrs = glob([
        "rmw/include/**/*.h",
    ]),
    includes = [
        "rmw/include",
    ],
    deps = [
        "@ros2_rcutils//:rcutils",
        "@ros2_rosidl//:rosidl_runtime_c",
    ],
    visibility = ["//visibility:public"],
)

cc_library(
    name = "rmw_cpp",
    hdrs = glob([
        "rmw/include/**/*.hpp",
    ]),
    includes = [
        "rmw/include",
    ],
    deps = [
        ":rmw"
    ],
    visibility = ["//visibility:public"],
)
