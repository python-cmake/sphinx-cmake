.. _introduction:

************
Introduction
************

This project provides convenient ways to use :term:`Sphinx` within a
:term:`CMake` project. The package can be discovered from a specific range of
versions on Linux, macOS or Windows using the `find_package
<https://cmake.org/cmake/help/latest/command/find_package.html>`_ function:

.. code-block:: cmake

    find_package(Sphinx 7.3.7 REQUIRED)

A :func:`sphinx_add_docs` function is provided as a convenience for adding a
target for generating documentation with Sphinx.

.. code-block:: cmake

    sphinx_add_docs(docs ALL)

.. seealso:: :ref:`tutorial`