""" Builds rosidl.
"""

load("@bazel_skylib//rules:copy_file.bzl", "copy_file")
load("@rules_ros2_pip_deps//:requirements.bzl", "requirement")

cc_library(
    name = "rosidl_typesupport_interface",
    hdrs = glob([
        "rosidl_typesupport_interface/include/**/*.h",
    ]),
    includes = [
        "rosidl_typesupport_interface/include",
    ],
    visibility = ["//visibility:public"],
)

cc_library(
    name = "rosidl_runtime_c",
    srcs = glob([
        "rosidl_runtime_c/src/*.c",
    ]),
    hdrs = glob([
        "rosidl_runtime_c/include/**/*.h",
    ]),
    includes = [
        "rosidl_runtime_c/include",
    ],
    deps = [
        ":rosidl_typesupport_interface",
        "@ros2_rcutils//:rcutils",
    ],
    visibility = ["//visibility:public"],
)

cc_library(
    name = "rosidl_runtime_cpp",
    hdrs = glob([
        "rosidl_runtime_cpp/include/**/*.hpp",
    ]),
    includes = [
        "rosidl_runtime_cpp/include"
    ],
    deps = [
        ":rosidl_runtime_c",
    ],
    visibility = ["//visibility:public"],
)

py_library(
    name = "rosidl_adapter_lib",
    srcs = [
        "rosidl_adapter/rosidl_adapter/action/__init__.py",
        "rosidl_adapter/rosidl_adapter/msg/__init__.py",
        "rosidl_adapter/rosidl_adapter/resource/__init__.py",
        "rosidl_adapter/rosidl_adapter/srv/__init__.py",
        "rosidl_adapter/rosidl_adapter/__init__.py",
        "rosidl_adapter/rosidl_adapter/main.py",
        "rosidl_adapter/rosidl_adapter/parser.py",
    ],
    imports = [
        "rosidl_adapter",
    ],
    deps = [
        requirement("empy")
    ],
    data = glob([
        "rosidl_adapter/rosidl_adapter/resource/*.em",
    ]),
    visibility = ["//visibility:public"],
)
_ROSIDL_ADAPTER_APP_PY = "rosidl_adapter_app.py"
copy_file(
    name = "rosidl_adapter_copy",
    src = "rosidl_adapter/rosidl_adapter/__main__.py",
    out = _ROSIDL_ADAPTER_APP_PY,
)
py_binary(
    name = "rosidl_adapter_app",
    srcs = [
        _ROSIDL_ADAPTER_APP_PY,
    ],
    main = _ROSIDL_ADAPTER_APP_PY,
    deps = [
        ":rosidl_adapter_lib",
    ],
    visibility = ["//visibility:public"],
)

py_library(
    name = "rosidl_parser",
    srcs = glob([
        "rosidl_parser/rosidl_parser/*.py"
    ]),
    imports = [
        "rosidl_parser"
    ],
    data = [
        "rosidl_parser/rosidl_parser/grammar.lark"
    ],
    deps = [
        requirement("lark_parser")
    ],
    visibility = ["//visibility:public"],
)

py_library(
    name = "rosidl_cmake",
    srcs = [
        "rosidl_cmake/rosidl_cmake/__init__.py"
    ],
    imports = [
        "rosidl_cmake",
    ],
    deps = [
        ":rosidl_parser",
        requirement("empy"),
    ],
    visibility = ["//visibility:public"],
)

py_library(
    name = "rosidl_generator_c_lib",
    srcs = [
        "rosidl_generator_c/rosidl_generator_c/__init__.py",
    ],
    imports = [
        "rosidl_generator_c",
    ],
    deps = [
        ":rosidl_cmake",
        ":rosidl_parser",
    ],
    visibility = ["//visibility:public"],
)
_ROSIDL_GENERATOR_C_APP_PY = "rosidl_generator_c_app.py"
copy_file(
    name = "rosidl_generator_c_copy",
    src = "rosidl_generator_c/bin/rosidl_generator_c",
    out = _ROSIDL_GENERATOR_C_APP_PY,
)
py_binary(
    name = "rosidl_generator_c_app",
    srcs = [
        _ROSIDL_GENERATOR_C_APP_PY,
    ],
    main = _ROSIDL_GENERATOR_C_APP_PY,
    deps = [
        ":rosidl_generator_c_lib",
    ],
    visibility = ["//visibility:public"],
)
filegroup(
    name = "rosidl_generator_c_templates",
    srcs = glob([
        "rosidl_generator_c/resource/*.em",
    ]),
    visibility = ["//visibility:public"],
)
exports_files(
    srcs = [
        "rosidl_generator_c/resource/rosidl_generator_c__visibility_control.h.in",
    ],
)

py_library(
    name = "rosidl_generator_cpp_lib",
    srcs = [
        "rosidl_generator_cpp/rosidl_generator_cpp/__init__.py"
    ],
    imports = [
        "rosidl_generator_cpp",
    ],
    deps = [
        ":rosidl_cmake",
        ":rosidl_parser",
    ],
    visibility = ["//visibility:public"],
)
_ROSIDL_GENERATOR_CPP_APP_PY = "rosidl_generator_cpp_app.py"
copy_file(
    name = "rosidl_generator_cpp_copy",
    src = "rosidl_generator_cpp/bin/rosidl_generator_cpp",
    out = _ROSIDL_GENERATOR_CPP_APP_PY,
)
py_binary(
    name = "rosidl_generator_cpp_app",
    srcs = [
        _ROSIDL_GENERATOR_CPP_APP_PY,
    ],
    main = _ROSIDL_GENERATOR_CPP_APP_PY,
    deps = [
        ":rosidl_generator_cpp_lib"
    ],
    visibility = ["//visibility:public"],
)
filegroup(
    name = "rosidl_generator_cpp_templates",
    srcs = glob([
        "rosidl_generator_cpp/resource/**",
    ]),
    visibility = ["//visibility:public"],
)

cc_library(
    name = "rosidl_typesupport_introspection_c",
    srcs = glob([
        "rosidl_typesupport_introspection_c/src/*.c",
    ]),
    hdrs = glob([
        "rosidl_typesupport_introspection_c/include/**/*.h",
    ]),
    includes = [
        "rosidl_typesupport_introspection_c/include",
    ],
    visibility = ["//visibility:public"],
)

cc_library(
    name = "rosidl_typesupport_introspection_cpp",
    srcs = glob([
        "rosidl_typesupport_introspection_cpp/src/*.cpp",
    ]),
    hdrs = glob([
        "rosidl_typesupport_introspection_cpp/include/**/*.hpp",
        "rosidl_typesupport_introspection_cpp/include/**/*.h",
    ]),
    includes = [
        "rosidl_typesupport_introspection_cpp/include"
    ],
    deps = [
        ":rosidl_runtime_c",
        ":rosidl_runtime_cpp",
    ],
    visibility = ["//visibility:public"],
)

py_library(
    name = "rosidl_typesupport_introspection_generator_c_lib",
    srcs = [
        "rosidl_typesupport_introspection_c/rosidl_typesupport_introspection_c/__init__.py",
    ],
    imports = [
        "rosidl_typesupport_introspection_c",
    ],
    deps = [
        ":rosidl_cmake",
        ":rosidl_generator_c_lib",
        ":rosidl_parser",
    ],
    visibility = ["//visibility:public"],
)
_ROSIDL_TYPESUPPORT_INTROSPECTION_GENERATOR_C_PY = "rosidl_typesupport_introspection_generator_c.py"
copy_file(
    name = "rosidl_typesupport_introspection_generator_c_copy",
    src = "rosidl_typesupport_introspection_c/bin/rosidl_typesupport_introspection_c",
    out = _ROSIDL_TYPESUPPORT_INTROSPECTION_GENERATOR_C_PY,
)
py_binary(
    name = "rosidl_typesupport_introspection_generator_c",
    srcs = [
        _ROSIDL_TYPESUPPORT_INTROSPECTION_GENERATOR_C_PY,
    ],
    deps = [
        ":rosidl_typesupport_introspection_generator_c_lib"
    ],
    visibility = ["//visibility:public"],
)
filegroup(
    name = "rosidl_typesupport_introspection_generator_c_templates",
    srcs = glob([
        "rosidl_typesupport_introspection_c/resource/*.em",
    ]),
    visibility = ["//visibility:public"],
)
exports_files([
    "rosidl_typesupport_introspection_c/resource/rosidl_typesupport_introspection_c__visibility_control.h.in",
])

py_library(
    name = "rosidl_typesupport_introspection_generator_cpp_lib",
    srcs = [
        "rosidl_typesupport_introspection_cpp/rosidl_typesupport_introspection_cpp/__init__.py"
    ,],
    imports = [
        "rosidl_typesupport_introspection_cpp",
    ],
    deps = [
        ":rosidl_cmake",
        ":rosidl_generator_cpp_lib",
        ":rosidl_parser",
    ],
    visibility = ["//visibility:public"],
)
_ROSIDL_TYPESUPPORT_INTROSPECTION_GENERATOR_CPP_PY = "rosidl_typesupport_introspection_generator_cpp.py"
copy_file(
    name = "rosidl_typesupport_introspection_generator_cpp_copy",
    src = "rosidl_typesupport_introspection_cpp/bin/rosidl_typesupport_introspection_cpp",
    out = _ROSIDL_TYPESUPPORT_INTROSPECTION_GENERATOR_CPP_PY,
)
py_binary(
    name = "rosidl_typesupport_introspection_generator_cpp",
    srcs = [
        _ROSIDL_TYPESUPPORT_INTROSPECTION_GENERATOR_CPP_PY,
    ],
    deps = [
        ":rosidl_typesupport_introspection_generator_cpp_lib",
    ],
    visibility = ["//visibility:public"],
)
filegroup(
    name = "rosidl_typesupport_introspection_generator_cpp_templates",
    srcs = glob([
        "rosidl_typesupport_introspection_cpp/resource/*.em",
    ]),
    visibility = ["//visibility:public"],
)
