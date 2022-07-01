"""
File with all dependencies needed for the ROS2

They are loaded but without loading the transitive dependencies, this is done in
a separated file extra_dependencies.bzl
"""

load("//modules/rcutils:direct.bzl", "load_rcutils")
load("//modules/rcpputils:direct.bzl", "load_rcpputils")
load("//modules/rosidl:direct.bzl", "load_rosidl")
load("//modules/rosidl_typesupport:direct.bzl", "load_rosidl_typesupport")
load("//modules/unique_identifier_msgs:direct.bzl", "load_unique_identifier_msgs")
load("//modules/rmw:direct.bzl", "load_rmw")

def load_ros2_libraries():
    """Load all third party dependencies"""
    load_rcutils()
    load_rcpputils()
    load_rosidl()
    load_rosidl_typesupport()
    load_unique_identifier_msgs()
    load_rmw()
