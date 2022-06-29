"""Configures pip dependencies.
"""

load("@rules_python//python:pip.bzl", "pip_parse")

def pip_deps(name, python_interpreter, python_requirements_lock):
    if not native.existing_rule(name):
        pip_parse(
            name = name,
            python_interpreter = python_interpreter,
            requirements_lock = python_requirements_lock,
        )
