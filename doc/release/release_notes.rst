.. _release/release_notes:

*************
Release Notes
*************

.. release:: 1.1.0
    :date: 2026-01-08

    .. change:: new

        Added support for prepending library and Python paths, and for passing
        arbitrary environment variables to Sphinx builds.

    .. change:: new

        Added compatibility with Sphinx v9 and CMake 4.2.

    .. change:: changed

        Updated :term:`CMake` packaging by simplifying
        `SphinxConfigVersion.cmake` so that version compatibility is no longer
        fixed at build time. Version discovery and validation are handled
        dynamically by `FindSphinx.cmake`, with `SphinxConfig.cmake` serving
        only as a thin entry point for :term:`CMake` package discovery.
        Wheel distribution is fully supported and recommended.

.. release:: 1.0.1
    :date: 2025-08-14

    .. change:: fixed

        Added manual docs deployment trigger and updated GitHub Pages actions.

.. release:: 1.0.0
    :date: 2025-08-14

    .. change:: new

        Added compatibility with CMake 4.1.

    .. change:: changed

        Dropped support for Python 2.x. The minimum supported version is now
        Python 3.7.

.. release:: 0.2.2
    :date: 2024-10-06

    .. change:: fixed

        Corrected the CMake version upper bound from 3.30 to 3.31.

    .. change:: changed

        Added documentation for :ref:`installing/deployment`.

    .. change:: changed

        Added link to Github Project in documentation.

.. release:: 0.2.1
    :date: 2024-08-17

    .. change:: fixed

        Fixed the :func:`sphinx_add_docs` to prevent setting incorrect
        attribute when the "ALL" option is not set.

    .. change:: fixed

        Fixed the :func:`sphinx_add_docs` to add missing "COMMENT" option.

.. release:: 0.2.0
    :date: 2024-08-09

    .. change:: new

        Added compatibility with Sphinx v8 and CMake 3.30.

.. release:: 0.1.1
    :date: 2024-06-04

    .. change:: fixed

        Fixed release script.

.. release:: 0.1.0
    :date: 2024-06-04

    .. change:: new

        Initial release.
