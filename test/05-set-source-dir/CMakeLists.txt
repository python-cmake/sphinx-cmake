sphinx_add_docs(doc5 ALL
    SOURCE_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/doc)

add_test(NAME SetSourceDir
    COMMAND ${CMAKE_COMMAND} -E compare_files
    ${CMAKE_CURRENT_SOURCE_DIR}/index.html
    ${CMAKE_CURRENT_BINARY_DIR}/doc/index.html)
