#ifndef ROSIDL_TYPESUPPORT_COREDDS_CPP__VISIBILITY_CONTROL_H_
#define ROSIDL_TYPESUPPORT_COREDDS_CPP__VISIBILITY_CONTROL_H_

#if __cplusplus
extern "C"
{
#endif

// This logic was borrowed (then namespaced) from the examples on the gcc wiki:
//     https://gcc.gnu.org/wiki/Visibility

#if defined _WIN32 || defined __CYGWIN__
  #ifdef __GNUC__
    #define ROSIDL_TYPESUPPORT_COREDDS_CPP_EXPORT __attribute__ ((dllexport))
    #define ROSIDL_TYPESUPPORT_COREDDS_CPP_IMPORT __attribute__ ((dllimport))
  #else
    #define ROSIDL_TYPESUPPORT_COREDDS_CPP_EXPORT __declspec(dllexport)
    #define ROSIDL_TYPESUPPORT_COREDDS_CPP_IMPORT __declspec(dllimport)
  #endif
  #ifdef ROSIDL_TYPESUPPORT_COREDDS_CPP_BUILDING_DLL
    #define ROSIDL_TYPESUPPORT_COREDDS_CPP_PUBLIC ROSIDL_TYPESUPPORT_COREDDS_CPP_EXPORT
  #else
    #define ROSIDL_TYPESUPPORT_COREDDS_CPP_PUBLIC ROSIDL_TYPESUPPORT_COREDDS_CPP_IMPORT
  #endif
  #define ROSIDL_TYPESUPPORT_COREDDS_CPP_LOCAL
#else
  #define ROSIDL_TYPESUPPORT_COREDDS_CPP_EXPORT __attribute__ ((visibility("default")))
  #define ROSIDL_TYPESUPPORT_COREDDS_CPP_IMPORT
  #if __GNUC__ >= 4
    #define ROSIDL_TYPESUPPORT_COREDDS_CPP_PUBLIC __attribute__ ((visibility("default")))
    #define ROSIDL_TYPESUPPORT_COREDDS_CPP_LOCAL  __attribute__ ((visibility("hidden")))
  #else
    #define ROSIDL_TYPESUPPORT_COREDDS_CPP_PUBLIC
    #define ROSIDL_TYPESUPPORT_COREDDS_CPP_LOCAL
  #endif
#endif
    
#if __cplusplus
}   
#endif
    
#endif  // ROSIDL_TYPESUPPORT_COREDDS_CPP__VISIBILITY_CONTROL_H_
