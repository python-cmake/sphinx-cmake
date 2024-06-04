.. _tutorial:

********
Tutorial
********

Once :ref:`integrated in your project <integration>`, the ``Sphinx::Build``
target and the :func:`sphinx_add_docs` function are available for using.

.. _tutorial/target:

Using the target
================

Let's consider a project that includes a :file:`doc` folder containing
:term:`Sphinx` documentation. We need to add a :file:`CMakeLists.txt`
configuration file to add Python tests within the same directory. The
"sphinx-build" command can be easily implemented using a custom target:

.. code-block:: cmake

    add_custom_target(doc ALL
        COMMAND Sphinx::Build -T -b html
        ${CMAKE_CURRENT_SOURCE_DIR}
        ${CMAKE_CURRENT_BINARY_DIR}/doc
    )

Building the project will generate an HTML version of the documentation within
the build folder, making it ready for installation.

.. _tutorial/function:

Using the function
==================

A :func:`sphinx_add_docs` function is provided to create a target which will
generate the documentation. Therefore, the custom target added in the previous
section could be replaced by the following:

.. code-block:: cmake

    sphinx_add_docs(doc ALL)

By default, the :term:`builder` used is "html". Another builder can be defined
as follows:

.. code-block:: cmake

    sphinx_add_docs(doc ALL BUILDER latex)

You can define different source and output directories as follows:

.. code-block:: cmake

    sphinx_add_docs(doc ALL
        SOURCE_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/sphinx-doc
        OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/sphinx-doc
    )

You can also define a separate directory to fetch the :file:`conf.py` file:

.. code-block:: cmake

    sphinx_add_docs(doc ALL
        CONFIG_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/config
    )

Defining configuration setting directly within the :term:`CMake` configuration
file to override the :file:`conf.py` file can be done as follows:

.. code-block:: cmake

    sphinx_add_docs(doc ALL
        DEFINE
            version=${MAKE_PROJECT_VERSION}
    )

If necessary, you can also ignore the :file:`conf.py` file:

.. code-block:: cmake

    sphinx_add_docs(doc ALL ISOLATED)
