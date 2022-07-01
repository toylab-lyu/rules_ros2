""" Builds unique_identifier_msgs.
"""

load("@com_github_lyu_rules_ros2//modules:interfaces.bzl", "ros2_interface_library",)

ros2_interface_library(
    name = "unique_identifier_msgs",
    srcs = glob([
        "msg/*.msg"
    ]),
    visibility = ["//visibility:public"],
)
