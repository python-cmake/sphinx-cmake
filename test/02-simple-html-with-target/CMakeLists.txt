add_custom_target(doc2 ALL
    COMMAND Sphinx::Build -T -b html
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_CURRENT_BINARY_DIR}/doc
)

add_test(NAME SimpleHtmlWithTarget
    COMMAND ${CMAKE_COMMAND} -E compare_files
    ${CMAKE_CURRENT_SOURCE_DIR}/index.html
    ${CMAKE_CURRENT_BINARY_DIR}/doc/index.html)
