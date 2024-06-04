.. _integration:

**********************
Integrating with CMake
**********************

.. highlight:: bash

Once :ref:`installed <installing>`, the package integration within a
:term:`CMake` project can be done using the :term:`find_package` function:

.. code-block:: cmake

    find_package(Sphinx)

A specific range of versions can be targeted:

.. code-block:: cmake

    # Request Sphinx version 7.3.7.
    find_package(Sphinx 7.3.7 EXACT REQUIRED)

    # Request Sphinx between version 6.0.0 and 7.3.0 included.
    find_package(Sphinx 6.0.0...7.3.0 REQUIRED)

    # Request any version of Sphinx over 6.0.0.
    find_package(Sphinx 6.0.0 REQUIRED)

.. _integration/config:

Finding Configuration
=====================

When Python is used from its standard system location, :term:`CMake` should be
able to discover the newly installed configuration automatically using its
`Config Mode Search Procedure
<https://cmake.org/cmake/help/latest/command/find_package.html#search-procedure>`_.

.. warning::

    The `CMAKE_FIND_USE_SYSTEM_ENVIRONMENT_PATH
    <https://cmake.org/cmake/help/latest/variable/CMAKE_FIND_USE_SYSTEM_ENVIRONMENT_PATH.html>`_
    option should not be set to False.

When using a Python virtual environment, or if Python is installed in a
non-standard location, the :envvar:`CMAKE_PREFIX_PATH` environment variable
(or :term:`CMake` option) can be used to guide the discovery process::

    cmake -S . -B ./build -D "CMAKE_PREFIX_PATH=/path/to/python/prefix"

This is also necessary when installing the configuration in the
`Python user directory
<https://pip.pypa.io/en/stable/cli/pip_install/#install-user>`_::

    pip install sphinx-cmake --user

.. _integration/module:

Finding Module
==============

The package integration within a :term:`CMake` project can also be done using
the :file:`FindSphinx.cmake` module. The CMake files can be copied into a
new project, or the following code can be added before invoking the
:term:`find_package` function:

.. code-block:: cmake

    set(sphinx_url https://github.com/python-cmake/sphinx-cmake/archive/main.zip)

    # Fetch CMake files from the main branch of the Github repository
    file(DOWNLOAD ${sphinx_url} ${CMAKE_BINARY_DIR}/sphinx.zip)
    file(
        ARCHIVE_EXTRACT INPUT ${CMAKE_BINARY_DIR}/sphinx.zip
        DESTINATION ${CMAKE_BINARY_DIR}
        PATTERNS "*.cmake"
    )

    # Expand the module path variable to discover the `FindSphinx.cmake` module.
    set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CMAKE_BINARY_DIR}/sphinx-cmake-main/cmake)

.. warning::

    It is strongly recommended to use the :term:`Pip` installation over
    this method.

