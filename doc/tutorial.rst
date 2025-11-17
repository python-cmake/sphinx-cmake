.. _tutorial:

********
Tutorial
********

Once :ref:`integrated into your project <integration>`, the ``Sphinx::Build``
target and the :func:`sphinx_add_docs` function are available for use.

.. _tutorial/target:

Using the target
================

Let's consider a project that includes a :file:`doc` folder containing
:term:`Sphinx` documentation. We need to add a :file:`CMakeLists.txt`
configuration file to build the documentation as part of the project.

The ``sphinx-build`` command can be implemented directly using a custom target:

.. code-block:: cmake

    add_custom_target(doc ALL
        COMMAND Sphinx::Build -T -b html
        ${CMAKE_CURRENT_SOURCE_DIR}
        ${CMAKE_CURRENT_BINARY_DIR}/doc
    )

Building the project will generate an HTML version of the documentation within
the build directory, making it ready for installation or deployment.

In some cases, the documentation build may depend on Python modules or shared
libraries produced by the project itself. These must be made available through
the build environment.

This can be achieved by explicitly defining environment variables on the target,
for example:

.. code-block:: cmake

    set_target_properties(doc PROPERTIES
        ENVIRONMENT
            PYTHONPATH=$<TARGET_FILE_DIR:MyLibrary>:$ENV{PYTHONPATH}
    )

Similarly, shared libraries required at runtime must be discoverable through the
platform-specific library search path.

.. code-block:: cmake

    set_target_properties(doc PROPERTIES
        APPEND ENVIRONMENT
            LD_LIBRARY_PATH=$<TARGET_FILE_DIR:MyLibrary>:$ENV{LD_LIBRARY_PATH}
    )

.. warning::

    The environment variable used to locate shared libraries depends on the
    platform. :envvar:`LD_LIBRARY_PATH` is used on Linux,
    :envvar:`DYLD_LIBRARY_PATH` on macOS, and :envvar:`PATH` on Windows.

.. _tutorial/function:

Using the function
==================

A :func:`sphinx_add_docs` function is provided to simplify the creation of a
documentation target. The configuration above can therefore be replaced by the
following:

.. code-block:: cmake

    sphinx_add_docs(doc ALL)

By default, the :term:`builder` used is ``html``. Another builder can be selected
as follows:

.. code-block:: cmake

    sphinx_add_docs(doc ALL
        BUILDER latex
    )

Different source and output directories can be specified:

.. code-block:: cmake

    sphinx_add_docs(doc ALL
        SOURCE_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/sphinx-doc
        OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/sphinx-doc
    )

A separate directory can also be used to locate the :file:`conf.py` file:

.. code-block:: cmake

    sphinx_add_docs(doc ALL
        CONFIG_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/config
    )

Configuration values can be overridden directly from the :term:`CMake`
configuration using the ``DEFINE`` option:

.. code-block:: cmake

    sphinx_add_docs(doc ALL
        DEFINE
            version=${PROJECT_VERSION}
    )

The :file:`conf.py` file can be ignored entirely if required:

.. code-block:: cmake

    sphinx_add_docs(doc ALL ISOLATED)

When the documentation depends on project-built libraries or Python modules,
the build environment can be configured declaratively using dedicated options.

The ``LIBRARY_PATH_PREPEND`` option prepends directories to the platform-specific
library search path, selecting the appropriate environment variable
automatically:

.. code-block:: cmake

    sphinx_add_docs(doc ALL
        LIBRARY_PATH_PREPEND
            $<TARGET_FILE_DIR:MyLibrary>
    )

Python modules can similarly be made available by prepending directories to the
Python module search path:

.. code-block:: cmake

    sphinx_add_docs(doc ALL
        PYTHON_PATH_PREPEND
            ${CMAKE_CURRENT_SOURCE_DIR}/python
    )

Custom environment variables can also be defined explicitly:

.. code-block:: cmake

    sphinx_add_docs(doc ALL
        ENVIRONMENT
            "MY_PROJECT_DOCS_MODE=1"
            "CUSTOM_FLAG=enabled"
    )

These options allow the documentation build environment to be described
declaratively and consistently across platforms, without manually handling
platform-specific environment variables.
