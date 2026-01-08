# Discover required Sphinx target.
#
# This module defines the following imported targets:
#     Sphinx::Build
#
# It also exposes the 'sphinx_add_docs' function which adds a target
# for generating documentation with Sphinx.
#
# Usage:
#     find_package(Sphinx)
#     find_package(Sphinx REQUIRED)
#     find_package(Sphinx 1.8.6 REQUIRED)
#
# Note:
#     The Sphinx_ROOT environment variable or CMake variable can be used to
#     prepend a custom search path.
#     (https://cmake.org/cmake/help/latest/policy/CMP0074.html)

cmake_minimum_required(VERSION 3.20...4.2)

include(FindPackageHandleStandardArgs)

find_program(SPHINX_EXECUTABLE NAMES sphinx-build)
mark_as_advanced(SPHINX_EXECUTABLE)

if(SPHINX_EXECUTABLE)
    execute_process(
        COMMAND "${SPHINX_EXECUTABLE}" --version
        OUTPUT_VARIABLE _version
        ERROR_VARIABLE _version
        OUTPUT_STRIP_TRAILING_WHITESPACE)

    if (_version MATCHES " ([0-9]+\\.[0-9]+\\.[0-9]+)$")
        set(SPHINX_VERSION "${CMAKE_MATCH_1}")
    endif()
endif()

find_package_handle_standard_args(
    Sphinx
    REQUIRED_VARS
        SPHINX_EXECUTABLE
    VERSION_VAR
        SPHINX_VERSION
    HANDLE_COMPONENTS
    HANDLE_VERSION_RANGE)

if (Sphinx_FOUND AND NOT TARGET Sphinx::Build)
    add_executable(Sphinx::Build IMPORTED)
    set_target_properties(Sphinx::Build
        PROPERTIES
            IMPORTED_LOCATION "${SPHINX_EXECUTABLE}")

    # Helper function to register a Sphinx documentation target.
    function(sphinx_add_docs NAME)
        set(_BOOL_ARGS
            ALL
            SHOW_TRACEBACK
            WRITE_ALL
            FRESH_ENV
            ISOLATED
        )

        set(_SINGLE_VALUE_ARGS
            COMMENT
            BUILDER
            CONFIG_DIRECTORY
            SOURCE_DIRECTORY
            OUTPUT_DIRECTORY
            WORKING_DIRECTORY
        )

        set(_MULTI_VALUE_ARGS
            DEFINE
            DEPENDS
            LIBRARY_PATH_PREPEND
            PYTHON_PATH_PREPEND
            ENVIRONMENT
        )

        cmake_parse_arguments(
            PARSE_ARGV 1 ""
            "${_BOOL_ARGS}"
            "${_SINGLE_VALUE_ARGS}"
            "${_MULTI_VALUE_ARGS}"
        )

        # Ensure that target should be added to the default build target,
        # if required.
        if(_ALL)
            set(_ALL "ALL")
        else()
            set(_ALL "")
        endif()

        # Set platform-specific library path environment variable.
        if (CMAKE_SYSTEM_NAME STREQUAL Windows)
            set(LIBRARY_ENV_NAME PATH)
        elseif (CMAKE_SYSTEM_NAME STREQUAL Darwin)
            set(LIBRARY_ENV_NAME DYLD_LIBRARY_PATH)
        else()
            set(LIBRARY_ENV_NAME LD_LIBRARY_PATH)
        endif()

        # Convert paths to CMake-friendly format.
        if(DEFINED ENV{${LIBRARY_ENV_NAME}})
            cmake_path(CONVERT "$ENV{${LIBRARY_ENV_NAME}}" TO_CMAKE_PATH_LIST LIBRARY_PATH)
        else()
            set(LIBRARY_PATH "")
        endif()
        if(DEFINED ENV{PYTHONPATH})
            cmake_path(CONVERT "$ENV{PYTHONPATH}" TO_CMAKE_PATH_LIST PYTHON_PATH)
        else()
            set(PYTHON_PATH "")
        endif()

        # Prepend specified paths to the library and Python paths.
        if (_LIBRARY_PATH_PREPEND)
            list(PREPEND LIBRARY_PATH ${_LIBRARY_PATH_PREPEND})
        endif()

        if (_PYTHON_PATH_PREPEND)
            list(PREPEND PYTHON_PATH ${_PYTHON_PATH_PREPEND})
        endif()

        # Build environment arguments for cmake -E env.
        set(_env_args "")

        if (LIBRARY_PATH)
            if (CMAKE_SYSTEM_NAME STREQUAL Windows)
                list(JOIN LIBRARY_PATH "\\;" _LIBRARY_PATH_STRING)
            else()
                list(JOIN LIBRARY_PATH ":" _LIBRARY_PATH_STRING)
            endif()
            list(APPEND _env_args "${LIBRARY_ENV_NAME}=${_LIBRARY_PATH_STRING}")
        endif()

        if (PYTHON_PATH)
            if (CMAKE_SYSTEM_NAME STREQUAL Windows)
                list(JOIN PYTHON_PATH "\\;" _PYTHON_PATH_STRING)
            else()
                list(JOIN PYTHON_PATH ":" _PYTHON_PATH_STRING)
            endif()
            list(APPEND _env_args "PYTHONPATH=${_PYTHON_PATH_STRING}")
        endif()

        foreach(_env ${_ENVIRONMENT})
            list(APPEND _env_args "${_env}")
        endforeach()

        # Default working directory to current source path if none is provided.
        if (NOT _WORKING_DIRECTORY)
            set(_WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})
        endif()

        # Default comment if none is provided.
        if (NOT _COMMENT)
            set(_COMMENT "Generate documentation for ${NAME}")
        endif()

        # Default builder to "html" if none is provided.
        if (NOT _BUILDER)
            set(_BUILDER "html")
        endif()

        # Default source directory to current source path if none is provided.
        if (NOT _SOURCE_DIRECTORY)
            set(_SOURCE_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})
        endif()

        # Default output directory to current build path if none is provided.
        if (NOT _OUTPUT_DIRECTORY)
            set(_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/doc)
        endif()

        # Ensure that output directory exists.
        file(MAKE_DIRECTORY "${_OUTPUT_DIRECTORY}")

        # Build command arguments.
        set(_args -b ${_BUILDER})

        if (_CONFIG_DIRECTORY)
            list(APPEND _args -c ${_CONFIG_DIRECTORY})
        endif()

        foreach (setting ${_DEFINE})
            list(APPEND _args -D ${setting})
        endforeach()

        if (_SHOW_TRACEBACK)
            list(APPEND _args -T)
        endif()

        if (_WRITE_ALL)
            list(APPEND _args -a)
        endif()

        if (_FRESH_ENV)
            list(APPEND _args -E)
        endif()

        if (_ISOLATED)
            list(APPEND _args -C)
        endif()

        list(APPEND _args ${_SOURCE_DIRECTORY} ${_OUTPUT_DIRECTORY})

        # Create target.
        add_custom_target(${NAME} ${_ALL} VERBATIM
            WORKING_DIRECTORY ${_WORKING_DIRECTORY}
            COMMENT ${_COMMENT}
            DEPENDS ${_DEPENDS}
            COMMAND ${CMAKE_COMMAND} -E make_directory ${_OUTPUT_DIRECTORY}
            COMMAND ${CMAKE_COMMAND} -E env ${_env_args} "${SPHINX_EXECUTABLE}" ${_args})
    endfunction()
endif()
