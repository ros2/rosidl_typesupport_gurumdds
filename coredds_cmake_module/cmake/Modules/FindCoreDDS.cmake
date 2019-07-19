# Copyright 2019 GurumNetworks, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

###############################################################################
#
# CMake module for finding GurumNetworks CoreDDS.
#
# Input variables:
#
# - COREDDS_HOME: Header files and libraries will be searched for in
#   `${COREDDS_HOME}/include` and ${COREDDS_HOME}/lib` respectively.
#
# Output variables:
#
# - CoreDDS_FOUND: flag indicating if the package was found
# - CoreDDS_INCLUDE_DIR: Paths to the header files
# - CoreDDS_LIBRARIES: Name to the C++ library including the path
# - CoreDDS_LIBRARY_DIRS: Path to the library
# - CoreDDS_COREIDL: Path to the idl2code generator
#
# Example usage:
#
#   find_package(coredds_cmake_module REQUIRED)
#   find_package(CoreDDS MODULE)
#   # use CoreDDS_* variables
#
###############################################################################

# lint_cmake: -convention/filename, -package/stdargs

if(DEFINED CoreDDS_FOUND)
  return()
endif()
set(CoreDDS_FOUND FALSE)

file(TO_CMAKE_PATH "$ENV{COREDDS_HOME}" _COREDDS_HOME)

if(NOT _COREDDS_HOME STREQUAL "")
  message(STATUS "Found CoreDDS:" ${_COREDDS_HOME})
  set(CoreDDS_HOME "${_COREDDS_HOME}")
  set(CoreDDS_INCLUDE_DIR "${_COREDDS_HOME}/include/")
  set(CoreDDS_LIBRARY_DIRS "${_COREDDS_HOME}/lib/")
  set(CoreDDS_LIBRARIES "${CoreDDS_LIBRARY_DIRS}libdds.so")

  file(GLOB library "${CoreDDS_LIBRARIES}")
  if(library)
    set(CoreDDS_FOUND TRUE)
  else()
    set(os_dir "")
    if(WIN32)
      # TODO(clemjh): Support for Windows
      message(FATAL_ERROR "This operating system is not supported yet.")
      return()
    else()
      if(APPLE)
        message(FATAL_ERROR "This operating system is not supported yet.")
        return()
      else() # Linux
        execute_process(COMMAND lsb_release -is OUTPUT_VARIABLE LSB_RELEASE_DIST OUTPUT_STRIP_TRAILING_WHITESPACE)
        if(LSB_RELEASE_DIST STREQUAL "Ubuntu")
          execute_process(COMMAND lsb_release -cs OUTPUT_VARIABLE LSB_RELEASE_VER OUTPUT_STRIP_TRAILING_WHITESPACE)
          if(LSB_RELEASE_VER STREQUAL "bionic")
            set(os_dir "ubuntu-18.04/")
          elseif(LSB_RELEASE_VER STREQUAL "xenial")
            set(os_dir "ubuntu-16.04/")
          else()
            message(FATAL_ERROR "This operating system is not supported.")
            return()
          endif()
        else()
          message(FATAL_ERROR "This operating system is not supported yet.")
          return()
        endif()
      endif()
    endif()
    set(CoreDDS_LIBRARY_DIRS "${CoreDDS_LIBRARY_DIRS}${os_dir}")
    set(CoreDDS_LIBRARIES "${CoreDDS_LIBRARY_DIRS}libdds.so")

    file(GLOB library "${CoreDDS_LIBRARIES}")
    if(library)
      set(CoreDDS_FOUND TRUE)
    else()
      set(CoreDDS_FOUND FALSE)
      return()
    endif()
  endif()

  if(WIN32)
    # TODO(clemjh): CoreIDL support for Windows
  else()
    set(CoreDDS_COREIDL "${_COREDDS_HOME}/tools/coreidl")
    if(NOT EXISTS "${CoreDDS_COREIDL}")
      set(CoreDDS_COREIDL "${_COREDDS_HOME}/tool/coreidl")
      if(NOT EXISTS "${CoreDDS_COREIDL}")
        message(FATAL_ERROR "Could not find executable 'CoreIDL'")
      endif()
    endif()
  endif()
else()
  set(CoreDDS_FOUND FALSE)
endif()

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(CoreDDS
  FOUND_VAR CoreDDS_FOUND
  REQUIRED_VARS
  CoreDDS_INCLUDE_DIR
  CoreDDS_LIBRARY_DIRS
  CoreDDS_LIBRARIES
)
