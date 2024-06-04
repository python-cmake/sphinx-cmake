sphinx_add_docs(doc3 ALL BUILDER text ISOLATED)

add_test(NAME SimpleTextIsolated
    COMMAND ${CMAKE_COMMAND} -E compare_files
    ${CMAKE_CURRENT_SOURCE_DIR}/index.txt
    ${CMAKE_CURRENT_BINARY_DIR}/doc/index.txt)
