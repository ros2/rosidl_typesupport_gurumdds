// generated from 
// rosidl_typesupport_coredds_cpp/resource/msg__rosidl_typesupport_coredds_cpp.hpp.em
// generated code does not contain a copyright notice

@#######################################################################
@# EmPy template for generating
@# <msg>__rosidl_typesupport_coredds_cpp.hpp files
@#
@# Context:
@#  - spec (rosidl_parser.MessageSpecification)
@#    Parsed specification of the .msg file
@#  - subfolder (string)
@#    The subfolder / subnamespace of the message
@#    Either 'msg' or 'srv'
@#  - get_header_filename_from_msg_name (function) 
@#######################################################################
@
@{
header_guard_parts = [     
    spec.base_type.pkg_name, subfolder,
    get_header_filename_from_msg_name(spec.base_type.type) + '__rosidl_typesupport_coredds_cpp_hpp']
header_guard_variable = '__'.join([x.upper() for x in header_guard_parts]) + '_'
}@
#ifndef @(header_guard_variable)
#define @(header_guard_variable)

#include "rosidl_generator_c/message_type_support_struct.h"
#include "rosidl_typesupport_interface/macros.h"

#include "@(spec.base_type.pkg_name)/msg/rosidl_typesupport_coredds_cpp__visibility_control.h"

#include "@(spec.base_type.pkg_name)/@(subfolder)/@(get_header_filename_from_msg_name(spec.base_type.type))__struct.hpp"

#ifndef _WIN32
# pragma GCC diagnostic push
# pragma GCC diagnostic ignored "-Wunused-parameter"
# ifdef __clang__
#  pragma clang diagnostic ignored "-Wdeprecated-register"
#  pragma clang diagnostic ignored "-Wreturn-type-c-linkage"
# endif
#endif

@[for field in spec.fields]@
@[  if not field.type.is_primitive_type()]@
#include "@(field.type.pkg_name)/msg/dds_coredds/include/@(field.type.pkg_name)/msg/dds_/@(field.type.type)_TypeSupport.h"
#include "@(field.type.pkg_name)/msg/dds_coredds/include/@(field.type.pkg_name)/msg/dds_/@(field.type.type)_.h"
@[  end if]@
@[end for]@

#include "@(spec.base_type.pkg_name)/@(subfolder)/dds_coredds/include/@(spec.base_type.pkg_name)/@(subfolder)/dds_/@(spec.base_type.type)_TypeSupport.h"
#include "@(spec.base_type.pkg_name)/@(subfolder)/dds_coredds/include/@(spec.base_type.pkg_name)/@(subfolder)/dds_/@(spec.base_type.type)_.h"
#include <dds/dcps.h>

#ifndef _WIN32
# pragma GCC diagnostic pop
#endif

namespace @(spec.base_type.pkg_name)
{

namespace @(subfolder)
{

namespace typesupport_coredds_cpp
{

bool
ROSIDL_TYPESUPPORT_COREDDS_CPP_PUBLIC_@(spec.base_type.pkg_name)
ros_to_dds(
  const @(spec.base_type.pkg_name)::@(subfolder)::@(spec.base_type.type) & ros_message,
  @(spec.base_type.pkg_name)_@(subfolder)_dds__@(spec.base_type.type)_ & dds_message);

bool
ROSIDL_TYPESUPPORT_COREDDS_CPP_PUBLIC_@(spec.base_type.pkg_name)
dds_to_ros(
  const @(spec.base_type.pkg_name)_@(subfolder)_dds__@(spec.base_type.type)_ & dds_message,
  @(spec.base_type.pkg_name)::@(subfolder)::@(spec.base_type.type) & ros_message);

void
ROSIDL_TYPESUPPORT_COREDDS_CPP_PUBLIC_@(spec.base_type.pkg_name)
alloc(@(spec.base_type.pkg_name)_@(subfolder)_dds__@(spec.base_type.type)_ * & dds_message);

} // namespace typesupport_coredds_cpp

} // namespace @(subfolder)

} // namespace @(spec.base_type.pkg_name)

#ifdef __cplusplus
extern "C"
{
#endif

ROSIDL_TYPESUPPORT_COREDDS_CPP_PUBLIC_@(spec.base_type.pkg_name)
const rosidl_message_type_support_t*
  ROSIDL_TYPESUPPORT_INTERFACE__MESSAGE_SYMBOL_NAME(rosidl_typesupport_coredds_cpp, @(spec.base_type.pkg_name), @(subfolder), @(spec.base_type.type))();

#ifdef __cplusplus
}
#endif

#endif // @(header_guard_variable)
