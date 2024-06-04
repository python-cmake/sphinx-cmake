sphinx_add_docs(doc1 ALL)

add_test(NAME SimpleHtml
    COMMAND ${CMAKE_COMMAND} -E compare_files
    ${CMAKE_CURRENT_SOURCE_DIR}/index.html
    ${CMAKE_CURRENT_BINARY_DIR}/doc/index.html)
