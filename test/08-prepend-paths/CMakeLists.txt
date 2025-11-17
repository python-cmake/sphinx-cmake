if(WIN32)
    set(EXPECTED "/path1;/path2;/path3")
else()
    set(EXPECTED "/path1:/path2:/path3")
endif()
configure_file(index.html index.html @ONLY)

# NOTE: configure_file() adds a trailing newline; Sphinx doesn’t.
# Strip it so compare_files remains stable.
file(READ ${CMAKE_CURRENT_BINARY_DIR}/index.html _content)
string(REGEX REPLACE "\n$" "" _content "${_content}")
file(WRITE ${CMAKE_CURRENT_BINARY_DIR}/index.html "${_content}")

sphinx_add_docs(doc8 ALL
    WORKING_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}"
    LIBRARY_PATH_PREPEND "/path1" "/path2" "/path3"
    PYTHON_PATH_PREPEND "/path1" "/path2" "/path3")

add_test(NAME PrependPaths
    COMMAND ${CMAKE_COMMAND} -E compare_files
    ${CMAKE_CURRENT_BINARY_DIR}/index.html
    ${CMAKE_CURRENT_BINARY_DIR}/doc/index.html)
