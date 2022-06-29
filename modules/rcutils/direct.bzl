"""
Dependency to rcutils, rcutils is a C API consisting of macros, functions, and data structures used through out the ROS 2 code base.
"""

load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def load_rcutils():
    # It is not clear in Bazel what is the best practice for using http_archive.
    # If you call http_archive without any kind of check, you could call it two times
    # with the same name and different parameters and you would not get any warning/error.
    #
    # One option is to check if it is already available in the existing_rules and only
    # call http_archive if it is not present. In the else you could display a message in
    # case that was already present but in reality you would only want a warning/error if was
    # already called with different parameters (different library version for example).
    #
    # Another option is to wrap the http_archive in a maybe call but this will also not display
    # a warning. It behaves like the if check with the advantage that the name has not to be
    # repeated
    maybe(
        http_archive,
        name = "ros2_rcutils", # Must different with rcutils,
        url = "https://github.com/ros2/rcutils/archive/refs/tags/5.1.1.tar.gz",
        sha256 = "e69ed32f189ed2078b22b49408f6a12b7f78d83ce5d56bdd1b6cea357ccd7e6e",
        strip_prefix = "rcutils-5.1.1",
        build_file = "//modules/rcutils:BUILD.bzl",
    )
