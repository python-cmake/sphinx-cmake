"""Setuptools config only used for Python 2.7 compatibility.
"""

from setuptools import setup
from setuptools.command.install import install

import os
import subprocess


ROOT = os.path.dirname(os.path.realpath(__file__))
DEPENDENCIES = ["sphinx >= 1, < 8"]


class CreateCmakeConfig(install):
    """Custom command to create and share sphinx config."""

    def run(self):
        """Execute builder."""
        import sphinx

        build_path = os.path.join(ROOT, "build")
        if not os.path.exists(build_path):
            os.makedirs(build_path)

        # CMake search procedure is limited to CMake package configuration files
        # and does not work with modules. Hence, we are generating a
        # configuration file based on the CMake modules created.
        # https://cmake.org/cmake/help/latest/command/find_package.html
        config_path = os.path.join(build_path, "SphinxConfig.cmake")
        with open(config_path, "w") as stream:
            stream.write(
                "include(${CMAKE_CURRENT_LIST_DIR}/FindSphinx.cmake)\n"
            )

        # Generate CMake config version file for client to target a specific
        # version of Sphinx within CMake projects.
        version_config_path = os.path.join(
            build_path, "SphinxConfigVersion.cmake"
        )
        script_path = os.path.join(
            build_path, "SphinxConfigVersionScript.cmake"
        )
        with open(script_path, "w") as stream:
            stream.write(
                "include(CMakePackageConfigHelpers)\n"
                "write_basic_package_version_file(\n"
                "    \"{path}\"\n"
                "    VERSION {version}\n"
                "    COMPATIBILITY AnyNewerVersion\n"
                ")".format(
                    path=str(version_config_path),
                    version=sphinx.__version__,
                )
            )

        subprocess.call(["cmake", "-P", str(script_path), "-VV"])
        return install.run(self)


setup(
    name="sphinx-cmake",
    version="0.1.0",
    data_files=[
        (
            "share/Sphinx/cmake",
            [
                "build/SphinxConfig.cmake",
                "build/SphinxConfigVersion.cmake",
                "cmake/FindSphinx.cmake",
            ]
        )
    ],
    cmdclass={"install": CreateCmakeConfig},
    install_requires=DEPENDENCIES,
    setup_requires=DEPENDENCIES,
)
