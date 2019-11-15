@# Included from rosidl_typesupport_gurumdds_c/resource/idl__type_support_c.cpp.em
@{
TEMPLATE(
    'msg__type_support_c.cpp.em',
    package_name=package_name, interface_path=interface_path, message=service.request_message,
    include_directives=include_directives)
}@

@{
TEMPLATE(
    'msg__type_support_c.cpp.em',
    package_name=package_name, interface_path=interface_path, message=service.response_message,
    include_directives=include_directives)
}@

@{
from rosidl_cmake import convert_camel_case_to_lower_case_underscore

include_parts = [package_name] + list(interface_path.parents[0].parts) + \
    [convert_camel_case_to_lower_case_underscore(interface_path.stem)]
include_base = '/'.join(include_parts)

header_files = [
    # Provides the definition of the service_type_support_callbacks_t struct.
    'rosidl_typesupport_gurumdds_cpp/service_type_support.h',
    'rosidl_typesupport_cpp/service_type_support.hpp',
    'rosidl_typesupport_gurumdds_c/identifier.h',
    package_name + '/msg/rosidl_typesupport_gurumdds_c__visibility_control.h',
    include_base + '.h',
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

#if defined(__cplusplus)
extern "C"
{
#endif

static void
_@(service.request_message.structure.namespaced_type.name)__set_sequence_number(void * untyped_dds_message, int64_t seq_number)
{
  @(__request_msg_type) * dds_message =
    reinterpret_cast<@(__request_msg_type) *>(untyped_dds_message);

  dds_message->gurumdds__sequence_number_ = seq_number;
}

static int64_t
_@(service.request_message.structure.namespaced_type.name)__get_sequence_number(const void * untyped_dds_message)
{
  const @(__request_msg_type) * dds_message =
    reinterpret_cast<const @(__request_msg_type) *>(untyped_dds_message);

  return dds_message->gurumdds__sequence_number_;
}

static void
_@(service.request_message.structure.namespaced_type.name)__set_guid(void * untyped_dds_message, const int8_t * guid)
{
  @(__request_msg_type) * dds_message =
    reinterpret_cast<@(__request_msg_type) *>(untyped_dds_message);

  memcpy(&(dds_message->gurumdds__client_guid_0_), guid, sizeof(dds_message->gurumdds__client_guid_0_));
  memcpy(&(dds_message->gurumdds__client_guid_1_), guid + sizeof(dds_message->gurumdds__client_guid_0_), sizeof(dds_message->gurumdds__client_guid_1_));
}

static void
_@(service.request_message.structure.namespaced_type.name)__get_guid(const void * untyped_dds_message, int8_t * guid)
{
  const @(__request_msg_type) * dds_message =
    reinterpret_cast<const @(__request_msg_type) *>(untyped_dds_message);

  memcpy(guid, &(dds_message->gurumdds__client_guid_0_), sizeof(dds_message->gurumdds__client_guid_0_));
  memcpy(guid + sizeof(dds_message->gurumdds__client_guid_0_), &(dds_message->gurumdds__client_guid_1_), sizeof(dds_message->gurumdds__client_guid_1_));
}

static void
_@(service.response_message.structure.namespaced_type.name)__set_sequence_number(void * untyped_dds_message, int64_t seq_number)
{
  @(__response_msg_type) * dds_message =
    reinterpret_cast<@(__response_msg_type) *>(untyped_dds_message);

  dds_message->gurumdds__sequence_number_ = seq_number;
}

static int64_t
_@(service.response_message.structure.namespaced_type.name)__get_sequence_number(const void * untyped_dds_message)
{
  const @(__response_msg_type) * dds_message =
    reinterpret_cast<const @(__response_msg_type) *>(untyped_dds_message);

  return dds_message->gurumdds__sequence_number_;
}

static void
_@(service.response_message.structure.namespaced_type.name)__set_guid(void * untyped_dds_message, const int8_t * guid)
{
  @(__response_msg_type) * dds_message =
    reinterpret_cast<@(__response_msg_type) *>(untyped_dds_message);

  memcpy(&(dds_message->gurumdds__client_guid_0_), guid, sizeof(dds_message->gurumdds__client_guid_0_));
  memcpy(&(dds_message->gurumdds__client_guid_1_), guid + sizeof(dds_message->gurumdds__client_guid_0_), sizeof(dds_message->gurumdds__client_guid_1_));
}

static void
_@(service.response_message.structure.namespaced_type.name)__get_guid(const void * untyped_dds_message, int8_t * guid)
{
  const @(__response_msg_type) * dds_message =
    reinterpret_cast<const @(__response_msg_type) *>(untyped_dds_message);

  memcpy(guid, &(dds_message->gurumdds__client_guid_0_), sizeof(dds_message->gurumdds__client_guid_0_));
  memcpy(guid + sizeof(dds_message->gurumdds__client_guid_0_), &(dds_message->gurumdds__client_guid_1_), sizeof(dds_message->gurumdds__client_guid_1_));
}

static service_type_support_callbacks_t @(service.namespaced_type.name)__callbacks = {
  "@('::'.join([package_name] + list(interface_path.parents[0].parts)))",  // service_namespace
  "@(service.namespaced_type.name)",
  ROSIDL_TYPESUPPORT_INTERFACE__MESSAGE_SYMBOL_NAME(rosidl_typesupport_gurumdds_c, @(', '.join([package_name] + list(interface_path.parents[0].parts) + [service.namespaced_type.name]))_Request)(),
  ROSIDL_TYPESUPPORT_INTERFACE__MESSAGE_SYMBOL_NAME(rosidl_typesupport_gurumdds_c, @(', '.join([package_name] + list(interface_path.parents[0].parts) + [service.namespaced_type.name]))_Response)(),
  &_@(service.request_message.structure.namespaced_type.name)__set_sequence_number,  // request_set_sequence_number
  &_@(service.request_message.structure.namespaced_type.name)__get_sequence_number,  // request_get_sequence_number
  &_@(service.request_message.structure.namespaced_type.name)__set_guid,  // request_set_guid
  &_@(service.request_message.structure.namespaced_type.name)__get_guid,  // request_get_guid
  &_@(service.response_message.structure.namespaced_type.name)__set_sequence_number,  // response_set_sequence_number
  &_@(service.response_message.structure.namespaced_type.name)__get_sequence_number,  // response_get_sequence_number
  &_@(service.response_message.structure.namespaced_type.name)__set_guid,  // response_set_guid
  &_@(service.response_message.structure.namespaced_type.name)__get_guid,  // response_get_guid
};

static rosidl_service_type_support_t @(service.namespaced_type.name)__handle = {
  rosidl_typesupport_gurumdds_c__identifier,
  &@(service.namespaced_type.name)__callbacks,
  get_service_typesupport_handle_function,
};

const rosidl_service_type_support_t *
ROSIDL_TYPESUPPORT_INTERFACE__SERVICE_SYMBOL_NAME(rosidl_typesupport_gurumdds_c, @(', '.join([package_name] + list(interface_path.parents[0].parts) + [service.namespaced_type.name])))() {
  return &@(service.namespaced_type.name)__handle;
}

#if defined(__cplusplus)
}
#endif
