"""
Transitive dependencies for ros2
"""
load("//modules/rcutils:transitive.bzl", "load_rcutils_transitive_dependencies")
load("//modules/rcpputils:transitive.bzl", "load_rcpputils_transitive_dependencies")
load("//modules/rosidl:transitive.bzl", "load_rosidl_transitive_dependencies")
load("//modules/rosidl_typesupport:transitive.bzl", "load_rosidl_typesupport_transitive_dependencies")
load("//modules/unique_identifier_msgs:transitive.bzl", "load_unique_identifier_msgs_transitive_dependencies")
load("//modules/rmw:transitive.bzl", "load_rmw_transitive_dependencies")

def load_ros2_transitive_dependencies():
    # Leaving it empty allows that if at some point some transitive dependencies are needed
    # they can be added without modifying transitive_dependencies.bzl
    load_rcutils_transitive_dependencies()
    load_rcpputils_transitive_dependencies()
    load_rosidl_transitive_dependencies()
    load_rosidl_typesupport_transitive_dependencies()
    load_unique_identifier_msgs_transitive_dependencies()
    load_rmw_transitive_dependencies()
