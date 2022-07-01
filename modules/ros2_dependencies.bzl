"""
Transitive dependencies for ros2
"""
load("//modules/rcutils:transitive.bzl", "load_rcutils_transitive_dependencies")
load("//modules/rcpputils:transitive.bzl", "load_rcpputils_transitive_dependencies")

def load_ros2_transitive_dependencies():
    # Leaving it empty allows that if at some point some transitive dependencies are needed
    # they can be added without modifying transitive_dependencies.bzl
    load_rcutils_transitive_dependencies()
    load_rcpputils_transitive_dependencies()
