cmake_minimum_required(VERSION 3.20)

project(Test)

find_package(Sphinx 1.8.0 REQUIRED)

enable_testing()

# tests
add_subdirectory(01-simple-html)
add_subdirectory(02-simple-html-with-target)
add_subdirectory(03-simple-text-isolated)
add_subdirectory(04-set-conf-dir)
add_subdirectory(05-set-source-dir)
add_subdirectory(06-set-output-dir)
add_subdirectory(07-use-define)
