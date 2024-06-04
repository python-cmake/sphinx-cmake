sphinx_add_docs(doc4 ALL
    CONFIG_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/config)

add_test(NAME SetConfDir
    COMMAND ${CMAKE_COMMAND} -E compare_files
    ${CMAKE_CURRENT_SOURCE_DIR}/index.html
    ${CMAKE_CURRENT_BINARY_DIR}/doc/index.html)
