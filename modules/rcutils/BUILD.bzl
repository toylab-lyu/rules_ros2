""" Builds rcutils.
"""

load("@com_github_lyu_rules_ros2//modules/rcutils:logging_macros.bzl", "logging_macros",)
load("@rules_ros2_pip_deps//:requirements.bzl", "requirement",)

_GENERATE_LOGGING_MACROS_PY = "@com_github_lyu_rules_ros2//modules/rcutils:generate_rcutils_logging_macros.py"

py_library(
    name = "logging_generator",
    srcs = [
        "rcutils/logging.py"
    ],
    deps = [
        requirement("empy"),
    ],
    visibility = ["//visibility:__subpackages__"],
)

py_binary(
    name = "generate_logging_macros",
    srcs = [
        _GENERATE_LOGGING_MACROS_PY,
    ],
    main = _GENERATE_LOGGING_MACROS_PY,
    deps = [
        ":logging_generator",
        requirement("empy"),
    ],
)

logging_macros(
    name = "logging_macros",
    output = "include/rcutils/logging_macros.h",
    template = "resource/logging_macros.h.em",
    generator = ":generate_logging_macros",
)

cc_library(
    name = "rcutils",
    srcs = glob([
        "src/*.c",
        "src/*.h",
    ], exclude = [
        "src/time_win32.c",
    ]),
    hdrs = glob([
        "include/**/*.h",
    ]) + [
        ":logging_macros",
    ],
    includes = [
        "include",
    ],
    local_defines = [
        "_GNU_SOURCE",
    ],
    linkopts = [
        "-ldl",
    ],
    visibility = [
        "//visibility:public"
    ],
)
