if(DEFINED CoreDDS_FOUND)
  return()
endif()
set(CoreDDS_FOUND FALSE)

# TODO: Implement support for other OS

file(TO_CMAKE_PATH "$ENV{COREDDS_HOME}" _COREDDS_HOME)

if(NOT _COREDDS_HOME STREQUAL "")
  message(STATUS "Found CoreDDS:" ${_COREDDS_HOME})
  set(CoreDDS_HOME "${_COREDDS_HOME}")
  set(CoreDDS_INCLUDE_DIR "${_COREDDS_HOME}/include/")
  set(CoreDDS_LIBRARY_DIRS "${_COREDDS_HOME}/lib/")
  set(CoreDDS_LIBRARIES "${CoreDDS_LIBRARY_DIRS}libdds.so")

  file(GLOB_RECURSE library RELATIVE "${CoreDDS_HOME}" "${CoreDDS_LIBRARIES}")
  if(library)
    set(CoreDDS_FOUND TRUE)
  else()
    set(CoreDDS_FOUND FALSE)
    return()
  endif()

  if(WIN32)
    # TODO
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
