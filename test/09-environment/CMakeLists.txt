sphinx_add_docs(doc9 ALL
    ENVIRONMENT
        "KEY1=VALUE1"
        "KEY2=VALUE2"
        "KEY3=PATH1:PATH2:PATH3"
        "KEY4=PATH1\;PATH2\;PATH3"
        "KEY5=C:\\Path\\To\\Dir1\;C:\\Path\\To\\Dir2"
        "K3Y4=SPECIAL$VALUE!@#%^&*")

add_test(NAME Environment
    COMMAND ${CMAKE_COMMAND} -E compare_files
    ${CMAKE_CURRENT_SOURCE_DIR}/index.html
    ${CMAKE_CURRENT_BINARY_DIR}/doc/index.html)
