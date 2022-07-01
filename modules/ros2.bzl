"""
File with all dependencies needed for the ROS2

They are loaded but without loading the transitive dependencies, this is done in
a separated file extra_dependencies.bzl
"""

load("//modules/rcutils:direct.bzl", "load_rcutils")
load("//modules/rcpputils:direct.bzl", "load_rcpputils")

def load_ros2_libraries():
    """Load all third party dependencies"""
    load_rcutils()
    load_rcpputils()
