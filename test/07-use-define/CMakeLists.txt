sphinx_add_docs(doc7 ALL
    DEFINE
        master_doc=foo
        source_suffix..ext=restructuredtext)

add_test(NAME UseDefine
    COMMAND ${CMAKE_COMMAND} -E compare_files
    ${CMAKE_CURRENT_SOURCE_DIR}/index.html
    ${CMAKE_CURRENT_BINARY_DIR}/doc/foo.html)
