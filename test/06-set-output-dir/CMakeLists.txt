sphinx_add_docs(doc6 ALL
    OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/newDoc)

add_test(NAME SetOutputDir
    COMMAND ${CMAKE_COMMAND} -E compare_files
    ${CMAKE_CURRENT_SOURCE_DIR}/index.html
    ${CMAKE_CURRENT_BINARY_DIR}/newDoc/index.html)
