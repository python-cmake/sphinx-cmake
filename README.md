# Sphinx CMake

[![PyPi version](https://img.shields.io/pypi/v/sphinx-cmake.svg?logo=pypi&label=PyPI&logoColor=gold)](https://pypi.python.org/pypi/sphinx-cmake)
[![CMake](https://img.shields.io/badge/CMake-3.20...4.2-blue.svg?logo=CMake&logoColor=blue)](https://cmake.org)
[![Test](https://github.com/python-cmake/sphinx-cmake/actions/workflows/test.yml/badge.svg?branch=main)](https://github.com/python-cmake/sphinx-cmake/actions/workflows/test.yml)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

This project provides convenient ways to use [Sphinx](https://www.sphinx-doc.org/)
within a [CMake](https://cmake.org/) project. The package can be discovered from a specific range of
versions on Linux, macOS or Windows using the
[find_package](https://cmake.org/cmake/help/latest/command/find_package.html)
function:

```cmake
find_package(Sphinx 7.3.7 REQUIRED)
```

A ``sphinx_add_docs`` function is provided as a convenience for adding a target
for generating documentation with Sphinx.

```cmake
sphinx_add_docs(docs ALL)
```

## Documentation

Full documentation, including installation and setup guides, can be found at
https://python-cmake.github.io/sphinx-cmake/
