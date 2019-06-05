@# Included from rosidl_typesupport_coredds_cpp/resource/idl__dds_coredds__type_support.cpp.em
@{
from rosidl_cmake import convert_camel_case_to_lower_case_underscore

include_parts = [package_name] + list(interface_path.parents[0].parts) + \
    [convert_camel_case_to_lower_case_underscore(interface_path.stem)]
include_base = '/'.join(include_parts)
}@
@{
TEMPLATE(
    'msg__type_support.cpp.em',
    package_name=package_name, interface_path=interface_path, message=service.request_message,
    include_directives=include_directives)
}@

@{
TEMPLATE(
    'msg__type_support.cpp.em',
    package_name=package_name, interface_path=interface_path, message=service.response_message,
    include_directives=include_directives)
}@

@{
header_files = [
    'rmw/error_handling.h',
    'rosidl_typesupport_coredds_cpp/identifier.hpp',
    'rosidl_typesupport_coredds_cpp/service_type_support.h',
    'rosidl_typesupport_coredds_cpp/service_type_support_decl.hpp',
]
}@

@{
__request_msg_type = '_'.join(service.request_message.structure.namespaced_type.namespaces) + '_dds__' + service.request_message.structure.namespaced_type.name + '_'
__response_msg_type = '_'.join(service.response_message.structure.namespaced_type.namespaces) + '_dds__' + service.response_message.structure.namespaced_type.name + '_'
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

@[for ns in service.namespaced_type.namespaces]@

namespace @(ns)
{
@[end for]@

namespace typesupport_coredds_cpp
{

void
set_sequence_number__@(service.request_message.structure.namespaced_type.name)(void * untyped_dds_message, int64_t seq_number)
{
  @(__request_msg_type) * dds_message =
    reinterpret_cast<@(__request_msg_type) *>(untyped_dds_message);

  dds_message->coredds__sequence_number_ = seq_number;
}

int64_t
get_sequence_number__@(service.request_message.structure.namespaced_type.name)(const void * untyped_dds_message)
{
  const @(__request_msg_type) * dds_message =
    reinterpret_cast<const @(__request_msg_type) *>(untyped_dds_message);

  return dds_message->coredds__sequence_number_;
}

void
set_guid__@(service.request_message.structure.namespaced_type.name)(void * untyped_dds_message, const int8_t * guid)
{
  @(__request_msg_type) * dds_message =
    reinterpret_cast<@(__request_msg_type) *>(untyped_dds_message);

  memcpy(&(dds_message->coredds__client_guid_0_), guid, sizeof(dds_message->coredds__client_guid_0_));
  memcpy(&(dds_message->coredds__client_guid_1_), guid + sizeof(dds_message->coredds__client_guid_0_), sizeof(dds_message->coredds__client_guid_1_));
}

void
get_guid__@(service.request_message.structure.namespaced_type.name)(const void * untyped_dds_message, int8_t * guid)
{
  const @(__request_msg_type) * dds_message =
    reinterpret_cast<const @(__request_msg_type) *>(untyped_dds_message);

  memcpy(guid, &(dds_message->coredds__client_guid_0_), sizeof(dds_message->coredds__client_guid_0_));
  memcpy(guid + sizeof(dds_message->coredds__client_guid_0_), &(dds_message->coredds__client_guid_1_), sizeof(dds_message->coredds__client_guid_1_));
}

void
set_sequence_number__@(service.response_message.structure.namespaced_type.name)(void * untyped_dds_message, int64_t seq_number)
{
  @(__response_msg_type) * dds_message =
    reinterpret_cast<@(__response_msg_type) *>(untyped_dds_message);

  dds_message->coredds__sequence_number_ = seq_number;
}

int64_t
get_sequence_number__@(service.response_message.structure.namespaced_type.name)(const void * untyped_dds_message)
{
  const @(__response_msg_type) * dds_message =
    reinterpret_cast<const @(__response_msg_type) *>(untyped_dds_message);

  return dds_message->coredds__sequence_number_;
}

void
set_guid__@(service.response_message.structure.namespaced_type.name)(void * untyped_dds_message, const int8_t * guid)
{
  @(__response_msg_type) * dds_message =
    reinterpret_cast<@(__response_msg_type) *>(untyped_dds_message);

  memcpy(&(dds_message->coredds__client_guid_0_), guid, sizeof(dds_message->coredds__client_guid_0_));
  memcpy(&(dds_message->coredds__client_guid_1_), guid + sizeof(dds_message->coredds__client_guid_0_), sizeof(dds_message->coredds__client_guid_1_));
}

void
get_guid__@(service.response_message.structure.namespaced_type.name)(const void * untyped_dds_message, int8_t * guid)
{
  const @(__response_msg_type) * dds_message =
    reinterpret_cast<const @(__response_msg_type) *>(untyped_dds_message);

  memcpy(guid, &(dds_message->coredds__client_guid_0_), sizeof(dds_message->coredds__client_guid_0_));
  memcpy(guid + sizeof(dds_message->coredds__client_guid_0_), &(dds_message->coredds__client_guid_1_), sizeof(dds_message->coredds__client_guid_1_));
}

static service_type_support_callbacks_t _@(service.namespaced_type.name)__callbacks = {
  "@('::'.join([package_name] + list(interface_path.parents[0].parts)))",
  "@(service.namespaced_type.name)",
  ROSIDL_TYPESUPPORT_INTERFACE__MESSAGE_SYMBOL_NAME(rosidl_typesupport_coredds_cpp, @(', '.join([package_name] + list(interface_path.parents[0].parts))), @(service.namespaced_type.name)_Request)(),
  ROSIDL_TYPESUPPORT_INTERFACE__MESSAGE_SYMBOL_NAME(rosidl_typesupport_coredds_cpp, @(', '.join([package_name] + list(interface_path.parents[0].parts))), @(service.namespaced_type.name)_Response)(),
  &set_sequence_number__@(service.request_message.structure.namespaced_type.name),
  &get_sequence_number__@(service.request_message.structure.namespaced_type.name),
  &set_guid__@(service.request_message.structure.namespaced_type.name),
  &get_guid__@(service.request_message.structure.namespaced_type.name),
  &set_sequence_number__@(service.response_message.structure.namespaced_type.name),
  &get_sequence_number__@(service.response_message.structure.namespaced_type.name),
  &set_guid__@(service.response_message.structure.namespaced_type.name),
  &get_guid__@(service.response_message.structure.namespaced_type.name),
};

static rosidl_service_type_support_t _@(service.namespaced_type.name)__handle = {
  rosidl_typesupport_coredds_cpp::typesupport_identifier,
  &_@(service.namespaced_type.name)__callbacks,
  get_service_typesupport_handle_function,
};

}  // namespace typesupport_coredds_cpp
@[for ns in reversed(service.namespaced_type.namespaces)]@

}  // namespace @(ns)
@[end for]@

namespace rosidl_typesupport_coredds_cpp
{

template<>
ROSIDL_TYPESUPPORT_COREDDS_CPP_EXPORT_@(package_name)
const rosidl_service_type_support_t *
get_service_type_support_handle<@('::'.join([package_name] + list(interface_path.parents[0].parts) + [service.namespaced_type.name]))>()
{
  return &@('::'.join([package_name] + list(interface_path.parents[0].parts)))::typesupport_coredds_cpp::_@(service.namespaced_type.name)__handle;
}

}  // namespace rosidl_typesupport_coredds_cpp

#ifdef __cplusplus
extern "C"
{
#endif

const rosidl_service_type_support_t *
ROSIDL_TYPESUPPORT_INTERFACE__SERVICE_SYMBOL_NAME(
  rosidl_typesupport_coredds_cpp,
  @(', '.join([package_name] + list(interface_path.parents[0].parts))),
  @(service.namespaced_type.name))()
{
  return &@('::'.join([package_name] + list(interface_path.parents[0].parts)))::typesupport_coredds_cpp::_@(service.namespaced_type.name)__handle;
}

#ifdef __cplusplus
}
#endif
