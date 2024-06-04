.. _api_reference:

*************
API Reference
*************

.. highlight:: cmake

.. function:: sphinx_add_docs(NAME ARGV)

    Convenient function for adding a target for generating documentation with
    :term:`Sphinx`::

        sphinx_add_docs(NAME
            [ALL]
            [COMMENT comment]
            [WORKING_DIRECTORY dir]
            [BUILDER name]
            [CONFIG_DIRECTORY path]
            [SOURCE_DIRECTORY dir]
            [OUTPUT_DIRECTORY dir]
            [DEFINE setting1=value1 setting2=value2...]
            [DEPENDS target1 target2...]
            [SHOW_TRACEBACK]
            [WRITE_ALL]
            [FRESH_ENV]
            [ISOLATED]
        )

    The options are:

    * ``NAME``

        Indicate the name of the target that will be created.

    * ``ALL``

        Indicate that this target should be added to the default build target
        so that it will be run every time.

    * ``COMMENT``

        Display the given message before the commands are executed at build
        time. By default the following value will be used::

            sphinx_add_docs(
                ...
                COMMENT "Generate documentation for ${NAME}"
            )

    * ``WORKING_DIRECTORY``

        Specify the directory in which to run the :term:`Sphinx` command. If
        this option is not provided, the current source directory is used.

    * ``BUILDER``

        Specify a :term:`Builder` to use for generating the documentation. If
        this option is not provided, the "html" builder is used::

            sphinx_add_docs(
                ...
                BUILDER html
            )

    * ``CONFIG_DIRECTORY``

        Specify the directory in which to look for the :file:`conf.py` file. If
        this option is not provided, the :file:`conf.py` is expected to be found
        in the source directory::

            sphinx_add_docs(
                ...
                CONFIG_DIRECTORY /path/to/config/
            )

    * ``SOURCE_DIRECTORY``

        Specify the directory in which documentation source files are located.
        If this option is not provided, the current source directory is used::

            sphinx_add_docs(
                ...
                SOURCE_DIRECTORY /path/to/source/
            )

    * ``OUTPUT_DIRECTORY``

        Specify the directory in which documentation will be generated. If this
        option is not provided, a "doc" directory within the current binary
        directory is used::

            sphinx_add_docs(
                ...
                OUTPUT_DIRECTORY /path/to/output/doc
            )

    * ``DEFINE``

        Override a configuration value set in the :file:`conf.py` file. The
        value must be a number, string, list or dictionary value. For lists, use
        commas to separate values; for dictionaries, use dots to represent
        hierarchical keys; and for boolean values, use 0 or 1::

            sphinx_add_docs(
                ...
                DEFINE
                    "html_theme_path=path1,path2"
                    "latex_elements.docclass=scrartcl"
                    "show_authors=1"
            )

    * ``DEPENDS``

        List of dependent targets that need to be executed before generating
        the documentation::

            sphinx_add_docs(
                ...
                DEPENDS lib1 lib2
            )

    * ``SHOW_TRACEBACK``

        Display the full traceback when an unhandled exception occurs.
        Otherwise, only a summary is displayed and the traceback information
        is saved to a file for further analysis::

            sphinx_add_docs(
                ...
                SHOW_TRACEBACK
            )

    * ``WRITE_ALL``

        Indicate whether all output files should always be written, instead of
        only writing output for changed source files::

            sphinx_add_docs(
                ...
                WRITE_ALL
            )

        .. note::

            This option does not re-read source files. To read and re-process
            every file, use ``FRESH_ENV`` instead.

    * ``FRESH_ENV``

        Rebuild environment for every source files instead of only
        generating output for changed source files::

            sphinx_add_docs(
                ...
                FRESH_ENV
            )


    * ``ISOLATED``

        Ignore any discovered :file:`conf.py` file::

            sphinx_add_docs(
                ...
                ISOLATED
            )

    .. note::

       This function works similarly to the `doxygen_add_docs
       <https://cmake.org/cmake/help/latest/module/FindDoxygen.html#command:doxygen_add_docs>`_
       function, which generating documentation for :term:`Doxygen`.

