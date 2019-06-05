@# Included from rosidl_typesupport_coredds_cpp/resource/idl__rosidl_typesupport_coredds_cpp.hpp.em
@{
from rosidl_cmake import convert_camel_case_to_lower_case_underscore
from rosidl_generator_c import idl_structure_type_to_c_include_prefix
from rosidl_generator_c import idl_structure_type_to_c_typename
from rosidl_generator_c import idl_type_to_c
from rosidl_parser.definition import AbstractNestedType
from rosidl_parser.definition import NamespacedType
include_parts = [package_name] + list(interface_path.parents[0].parts)
include_base = '/'.join(include_parts)
header_filename = convert_camel_case_to_lower_case_underscore(interface_path.stem)
header_files = [
    'rosidl_generator_c/message_type_support_struct.h',
    'rosidl_typesupport_interface/macros.h',
    package_name + '/msg/rosidl_typesupport_coredds_cpp__visibility_control.h',
    include_base + '/' + header_filename + '__struct.hpp'
]

dds_specific_header_files = []
if message.structure.namespaced_type.namespaces[1] == 'msg':
    dds_specific_header_files = [
        include_base + '/dds_coredds/include/' + '/'.join(message.structure.namespaced_type.namespaces) + '/dds_/' + interface_path.stem + '_TypeSupport.h',
        include_base + '/dds_coredds/include/' + '/'.join(message.structure.namespaced_type.namespaces) + '/dds_/' + interface_path.stem + '_.h',
        'dds/dcps.h'
    ]
elif message.structure.namespaced_type.namespaces[1] == 'srv':
    dds_specific_header_files = [
        include_base + '/dds_coredds/include/' + '/'.join(message.structure.namespaced_type.namespaces) + '/dds_/' + interface_path.stem + '_Request_TypeSupport.h',
        include_base + '/dds_coredds/include/' + '/'.join(message.structure.namespaced_type.namespaces) + '/dds_/' + interface_path.stem + '_Request_.h',
        include_base + '/dds_coredds/include/' + '/'.join(message.structure.namespaced_type.namespaces) + '/dds_/' + interface_path.stem + '_Response_TypeSupport.h',
        include_base + '/dds_coredds/include/' + '/'.join(message.structure.namespaced_type.namespaces) + '/dds_/' + interface_path.stem + '_Response_.h',
        'dds/dcps.h'
    ]
elif message.structure.namespaced_type.namespaces[1] == 'action':
    for __suffix in ['_Goal',  '_SendGoal_Request', '_SendGoal_Response', '_Result', '_GetResult_Request', '_GetResult_Response', '_Feedback', '_FeedbackMessage']:
        dds_specific_header_files.append(include_base + '/dds_coredds/include/' + '/'.join(message.structure.namespaced_type.namespaces) + '/dds_/' + interface_path.stem + __suffix + '_TypeSupport.h')
        dds_specific_header_files.append(include_base + '/dds_coredds/include/' + '/'.join(message.structure.namespaced_type.namespaces) + '/dds_/' + interface_path.stem + __suffix + '_.h')
    dds_specific_header_files.append('dds/dcps.h')
}@
@[for header_file in header_files]@
@[    if header_file in include_directives]@
// already included above
// @
@[    else]@
@{include_directives.add(header_file)}@
@[    end if]@
#include "@(header_file)"
@[end for]@

#ifndef _WIN32
# pragma GCC diagnostic push
# pragma GCC diagnostic ignored "-Wunused-parameter"
# ifdef __clang__
#  pragma clang diagnostic ignored "-Wdeprecated-register"
#  pragma clang diagnostic ignored "-Wreturn-type-c-linkage"
# endif
#endif

@[for member in message.structure.members]@
@[  if isinstance(member.type, NamespacedType)]@
@{
type_ = member.type
if isinstance(type_, AbstractNestedType):
  type_ = type_.basetype
dds_specific_header_files.append(type_.namespaces[0] + '/' + type_.namespaces[1] + '/dds_coredds/include/' + type_.namespaces[0] + '/' + type_.namespaces[1] + '/dds_/' + type_.name + '_TypeSupport.h')
dds_specific_header_files.append(type_.namespaces[0] + '/' + type_.namespaces[1] + '/dds_coredds/include/' + type_.namespaces[0] + '/' + type_.namespaces[1] + '/dds_/' + type_.name + '_.h')
}@
@[  end if]@
@[end for]@

@[for header_file in dds_specific_header_files]@
@[    if header_file in include_directives]@
// already included above
// @
@[    else]@
@{include_directives.add(header_file)}@
@[    end if]@
#include "@(header_file)"
@[end for]@

#ifndef _WIN32
# pragma GCC diagnostic pop
#endif

@[for ns in message.structure.namespaced_type.namespaces]@

namespace @(ns)
{
@[end for]@
@{
__ros_msg_pkg_prefix = '::'.join(message.structure.namespaced_type.namespaces)
__ros_msg_type = __ros_msg_pkg_prefix + '::' + message.structure.namespaced_type.name
__dds_msg_type_prefix = __ros_msg_pkg_prefix.replace('::', '_') + '_dds__' + message.structure.namespaced_type.name
__dds_msg_type = __dds_msg_type_prefix + '_'
}@
namespace typesupport_coredds_cpp
{

bool
ROSIDL_TYPESUPPORT_COREDDS_CPP_PUBLIC_@(package_name)
ros_to_dds(
  const @(__ros_msg_type) & ros_message,
  @(__dds_msg_type) & dds_message);

bool
ROSIDL_TYPESUPPORT_COREDDS_CPP_PUBLIC_@(package_name)
dds_to_ros(
  const @(__dds_msg_type) & dds_message,
  @(__ros_msg_type) & ros_message);

void
ROSIDL_TYPESUPPORT_COREDDS_CPP_PUBLIC_@(package_name)
alloc(
  @(__dds_msg_type) * & dds_message);

}  // namespace typesupport_coredds_cpp

@[for ns in reversed(message.structure.namespaced_type.namespaces)]@
}  // namespace @(ns)

@[end for]@

#ifdef __cplusplus
extern "C"
{
#endif

ROSIDL_TYPESUPPORT_COREDDS_CPP_PUBLIC_@(package_name)
const rosidl_message_type_support_t *
  ROSIDL_TYPESUPPORT_INTERFACE__MESSAGE_SYMBOL_NAME(
  rosidl_typesupport_coredds_cpp,
  @(', '.join([package_name] + list(interface_path.parents[0].parts))),
  @(message.structure.namespaced_type.name))();

#ifdef __cplusplus
}
#endif

