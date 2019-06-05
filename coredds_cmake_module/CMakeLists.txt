cmake_minimum_required(VERSION 3.5)
project(coredds_cmake_module)

if(CMAKE_COMPILER_IS_GNUCXX OR CMAKE_CXX_COMPILER_ID MATCHES "Clang")
  add_compile_options(-Wall -Wextra -Wpedantic)
endif()

find_package(ament_cmake REQUIRED)

set(${PROJECT_NAME}_DIR "${CMAKE_CURRENT_SOURCE_DIR}/cmake")
list(INSERT CMAKE_MODULE_PATH 0 "${CMAKE_CURRENT_SOURCE_DIR}/cmake/Modules")
find_package(CoreDDS QUIET MODULE)
if(CoreDDS_FOUND)
  find_package(CoreDDS MODULE)
endif()
if(CoreDDS_HOME)
  file(TO_NATIVE_PATH "${CoreDDS_HOME}" CoreDDS_HOME)
  if(NOT WIN32)
    ament_environment_hooks(env_hook/coredds.sh.in)
  endif()
endif()

if(BUILD_TESTING)
  find_package(ament_lint_auto REQUIRED)
  ament_lint_auto_find_test_dependencies()
endif()

ament_package(
  CONFIG_EXTRAS "coredds_cmake_module-extras.cmake"
)

install(DIRECTORY cmake
  DESTINATION share/${PROJECT_NAME})
