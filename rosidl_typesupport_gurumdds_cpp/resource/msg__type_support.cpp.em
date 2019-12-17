// generated from rosidl_typesupport_gurumdds_cpp/resource/msg__type_support.cpp.em
// generated code does not contain a copyright notice

@#######################################################################
@# EmPy template for generating <msg>__type_support.cpp files
@#
@# Context:
@#  - spec (rosidl_parser.MessageSpecification)
@#    Parsed specification of the .msg file
@#  - subfolder (string)
@#    The subfolder / subnamespace of the message
@#    Could be 'msg', 'srv' or 'action'
@#  - get_header_filename_from_msg_name (function)
@#######################################################################
@
#include "@(spec.base_type.pkg_name)/@(subfolder)/@(get_header_filename_from_msg_name(spec.base_type.type))__rosidl_typesupport_gurumdds_cpp.hpp"

#include <limits>
#include <stdexcept>

#include <cstring>
#include <string>
#include <fstream>

#include "rcutils/types/uint8_array.h"

#include "rosidl_typesupport_cpp/message_type_support.hpp"

#include "rosidl_typesupport_gurumdds_cpp/identifier.hpp"
#include "rosidl_typesupport_gurumdds_cpp/message_type_support.h"
#include "rosidl_typesupport_gurumdds_cpp/message_type_support_decl.hpp"

// forward declaration of message dependencies and their conversion functions
@[for field in spec.fields]@
@[  if not field.type.is_primitive_type()]@
//struct @(field.type.pkg_name)_msg_dds__@(field.type.type)_;

namespace @(field.type.pkg_name)
{
namespace msg
{
namespace typesupport_gurumdds_cpp
{
bool ros_to_dds(const @(field.type.pkg_name)::msg::@(field.type.type) &,
              @(field.type.pkg_name)_msg_dds__@(field.type.type)_ &);
bool dds_to_ros(const @(field.type.pkg_name)_msg_dds__@(field.type.type)_ &,
              @(field.type.pkg_name)::msg::@(field.type.type) &);
void alloc(@(field.type.pkg_name)_msg_dds__@(field.type.type)_ * &);
}  // namespace typesupport_gurumdds_cpp
}  // namespace msg
}  // namespace @(field.type.pkg_name)
@[  end if]@
@[end for]@

namespace @(spec.base_type.pkg_name)
{

namespace @(subfolder)
{

namespace typesupport_gurumdds_cpp
{

uint32_t
get_type_size__@(spec.base_type.type)()
{
  return sizeof(@(spec.base_type.pkg_name)::@(subfolder)::@(spec.base_type.type));
}

dds_ReturnCode_t
register_type__@(spec.base_type.type)(dds_DomainParticipant* participant, const char* type_name)
{
  return @(spec.base_type.pkg_name)_@(subfolder)_dds__@(spec.base_type.type)_TypeSupport_register_type(participant, type_name);
}

bool
ROSIDL_TYPESUPPORT_GURUMDDS_CPP_PUBLIC_@(spec.base_type.pkg_name)
ros_to_dds(
  const @(spec.base_type.pkg_name)::@(subfolder)::@(spec.base_type.type) & ros_message,
  @(spec.base_type.pkg_name)_@(subfolder)_dds__@(spec.base_type.type)_ & dds_message)
{

@[if not spec.fields]@
  (void)ros_message;
  (void)dds_message;
@[end if]@
@[for field in spec.fields]@
  {
    // field.name @(field.name)
@[  if field.type.is_array]@
@{
if field.type.type == 'bool':
  seq_name = 'Boolean'
elif field.type.type == 'byte':
  seq_name = 'Octet'
elif field.type.type == 'char':
  seq_name = 'Char'
elif field.type.type == 'float32':
  seq_name = 'Float'
elif field.type.type == 'float64':
  seq_name = 'Double'
elif field.type.type == 'int8':
  seq_name = 'Octet'
elif field.type.type == 'uint8':
  seq_name = 'Octet'
elif field.type.type == 'int16':
  seq_name = 'Short'
elif field.type.type == 'uint16':
  seq_name = 'UnsignedShort'
elif field.type.type == 'int32':
  seq_name = 'Long'
elif field.type.type == 'uint32':
  seq_name = 'UnsignedLong'
elif field.type.type == 'int64':
  seq_name = 'LongLong'
elif field.type.type == 'uint64':
  seq_name = 'UnsignedLongLong'
elif field.type.type == 'string':
  seq_name = 'String'
else:
  seq_name = 'Data'
}@

@[    if field.type.array_size and not field.type.is_upper_bound]@
    size_t len = @(field.type.array_size);
@[    else]@
    size_t len = ros_message.@(field.name).size();
    if (len > (std::numeric_limits<dds_Long>::max)())
      throw std::runtime_error("array size exceeds maximum DDS sequence size");
@[      if field.type.is_upper_bound]@
    if (len > @(field.type.array_size))
      throw std::runtime_error("array size exceeds upper bound");
@[      end if]@
@[    end if]@

@[    if field.type.array_size and not field.type.is_upper_bound]@
@[      if field.type.type != 'string' and field.type.is_primitive_type()]@
    (void)len;
    memcpy(dds_message.@(field.name)_, ros_message.@(field.name).data(), sizeof(dds_message.@(field.name)_));
@[      else]@
    for (size_t i = 0; i < len; i++) {
@[        if field.type.type == 'string']@
      dds_message.@(field.name)_[i] = strdup(ros_message.@(field.name)[i].c_str());
@[        elif field.type.is_primitive_type()]@
      dds_message.@(field.name)_[i] = ros_message.@(field.name)[i];
@[        else]@
      @(field.type.pkg_name)::msg::typesupport_gurumdds_cpp::alloc(dds_message.@(field.name)_[i]);
      if (!@(field.type.pkg_name)::msg::typesupport_gurumdds_cpp::ros_to_dds(ros_message.@(field.name)[i], *dds_message.@(field.name)_[i])) {
        return false;
      }
@[        end if]@
    }
@[      end if]@
@[    elif field.type.type == 'string']@
    if (dds_message.@(field.name)_ == NULL) {
      dds_message.@(field.name)_ = dds_StringSeq_create(8);
      if (dds_message.@(field.name)_ == NULL) {
        return false;
      }
    }
    for (size_t i = 0; i < len; i++) {
      dds_StringSeq_add(dds_message.@(field.name)_, strdup(ros_message.@(field.name)[i].c_str()));
    }
@[    elif field.type.is_primitive_type()]@
@[      if field.type.type == 'bool']@
    if (dds_message.@(field.name)_ == NULL) {
      dds_message.@(field.name)_ = dds_BooleanSeq_create(8);
      if (dds_message.@(field.name)_ == NULL) {
        return false;
      }
    }
    for (size_t i = 0; i < len; i++) {
      dds_BooleanSeq_add(dds_message.@(field.name)_, (dds_Boolean)ros_message.@(field.name)[i]);
    }
@[      else]@
    if (dds_message.@(field.name)_ == NULL) {
      dds_message.@(field.name)_ = dds_@(seq_name)Seq_create(8);
      if (dds_message.@(field.name)_ == NULL) {
        return false;
      }
    }
    dds_@(seq_name)Seq_add_array(dds_message.@(field.name)_, (dds_@(seq_name)*)(&(ros_message.@(field.name)[0])), len);
@[      end if]@
@[    else]@
    if (dds_message.@(field.name)_ == NULL) {
      dds_message.@(field.name)_ = dds_DataSeq_create(8);
      if (dds_message.@(field.name)_ == NULL) {
        return false;
      }
    }
    for (size_t i = 0; i < len; i++) {
      @(field.type.pkg_name)_msg_dds__@(field.type.type)_ * tmp = nullptr;
      @(field.type.pkg_name)::msg::typesupport_gurumdds_cpp::alloc(tmp);
      if (!@(field.type.pkg_name)::msg::typesupport_gurumdds_cpp::ros_to_dds(ros_message.@(field.name)[i], *tmp))
        return false;
      dds_DataSeq_add((dds_DataSeq*)dds_message.@(field.name)_, tmp);
    }
@[    end if]@
@[  else]@
@[    if field.type.type == 'string']@
    dds_message.@(field.name)_ = strdup(ros_message.@(field.name).c_str());
@[    elif field.type.is_primitive_type()]@
    dds_message.@(field.name)_ = ros_message.@(field.name);
@[    else]@
    if (!@(field.type.pkg_name)::msg::typesupport_gurumdds_cpp::ros_to_dds(ros_message.@(field.name), dds_message.@(field.name)_))
      return false;
@[    end if]@
@[  end if]@
  }
@[end for]@

  return true;
}

bool convert_ros_to_dds__@(spec.base_type.type)(const void* untyped_ros_message, void* untyped_dds_message) {
  const @(spec.base_type.pkg_name)::@(subfolder)::@(spec.base_type.type)* ros_message =
    (const @(spec.base_type.pkg_name)::@(subfolder)::@(spec.base_type.type)*) untyped_ros_message;

  @(spec.base_type.pkg_name)_@(subfolder)_dds__@(spec.base_type.type)_* dds_message =
    (@(spec.base_type.pkg_name)_@(subfolder)_dds__@(spec.base_type.type)_*) untyped_dds_message;

  return ros_to_dds(*ros_message, *dds_message);

}

bool
ROSIDL_TYPESUPPORT_GURUMDDS_CPP_PUBLIC_@(spec.base_type.pkg_name)
dds_to_ros(
  const @(spec.base_type.pkg_name)_@(subfolder)_dds__@(spec.base_type.type)_ & dds_message,
  @(spec.base_type.pkg_name)::@(subfolder)::@(spec.base_type.type) & ros_message)
{

@[if not spec.fields]@
  (void)dds_message;
  (void)ros_message;
@[end if]@
@[for field in spec.fields]@
  {
    // field.name @(field.name)
@[  if field.type.is_array]@
@{
if field.type.type == 'bool':
  seq_name = 'Boolean'
elif field.type.type == 'byte':
  seq_name = 'Octet'
elif field.type.type == 'char':
  seq_name = 'Char'
elif field.type.type == 'float32':
  seq_name = 'Float'
elif field.type.type == 'float64':
  seq_name = 'Double'
elif field.type.type == 'int8':
  seq_name = 'Octet'
elif field.type.type == 'uint8':
  seq_name = 'Octet'
elif field.type.type == 'int16':
  seq_name = 'Short'
elif field.type.type == 'uint16':
  seq_name = 'UnsignedShort'
elif field.type.type == 'int32':
  seq_name = 'Long'
elif field.type.type == 'uint32':
  seq_name = 'UnsignedLong'
elif field.type.type == 'int64':
  seq_name = 'LongLong'
elif field.type.type == 'uint64':
  seq_name = 'UnsignedLongLong'
elif field.type.type == 'string':
  seq_name = 'String'
else:
  seq_name = 'Data'
}@
@[    if field.type.array_size and not field.type.is_upper_bound]@
    size_t len = @(field.type.array_size);
@[    else]@
    size_t len = dds_DataSeq_length((dds_DataSeq*)dds_message.@(field.name)_);
    ros_message.@(field.name).resize(len);
@[    end if]@

@[    if field.type.array_size and not field.type.is_upper_bound]@
@[      if field.type.type != 'string' and field.type.is_primitive_type()]@
    (void)len;
    memcpy(ros_message.@(field.name).data(), dds_message.@(field.name)_, sizeof(dds_message.@(field.name)_));
@[      else]@
    for (uint32_t i = 0; i < len; i++) {
@[        if field.type.type == 'string']@
      ros_message.@(field.name)[i] = std::string(dds_message.@(field.name)_[i]);
@[        elif field.type.is_primitive_type()]@
      ros_message.@(field.name)[i] = dds_message.@(field.name)_[i];
@[        else]@
      if (!@(field.type.pkg_name)::msg::typesupport_gurumdds_cpp::dds_to_ros(*dds_message.@(field.name)_[i], ros_message.@(field.name)[i]))
        return false;
@[        end if]@
    }
@[      end if]@
@[    elif field.type.type == 'string']@
    for (uint32_t i = 0; i < len; i++) {
      ros_message.@(field.name)[i] = std::string(dds_StringSeq_get((dds_StringSeq*)dds_message.@(field.name)_, i));
    }
@[    elif field.type.is_primitive_type()]@
@[      if field.type.type == 'bool']@
    for (uint32_t i = 0; i < len; i++) {
      ros_message.@(field.name)[i] = dds_BooleanSeq_get(dds_message.@(field.name)_, i);
    }
@[      else]@
    dds_@(seq_name)Seq_get_array(dds_message.@(field.name)_, (dds_@(seq_name)*)(&(ros_message.@(field.name)[0])), 0, len);
@[      end if]@
@[    else]@
    for (uint32_t i = 0; i < len; i++) {
      if (!@(field.type.pkg_name)::msg::typesupport_gurumdds_cpp::dds_to_ros(
        *(@(field.type.pkg_name)_msg_dds__@(field.type.type)_*)(dds_DataSeq_get((dds_DataSeq*)dds_message.@(field.name)_, i)),
        ros_message.@(field.name)[i]))
      {
        return false;
      }
    }
@[    end if]@
@[  else]@
@[    if field.type.type == 'string']@
    ros_message.@(field.name) = std::string(dds_message.@(field.name)_);
@[    elif field.type.is_primitive_type()]@
    ros_message.@(field.name) = dds_message.@(field.name)_;
@[    else]@
    if (!@(field.type.pkg_name)::msg::typesupport_gurumdds_cpp::dds_to_ros(dds_message.@(field.name)_, ros_message.@(field.name))) {
      return false;
    }
@[    end if]@
@[  end if]@
  }
@[end for]@
  return true;
}

bool convert_dds_to_ros__@(spec.base_type.type)(const void* untyped_dds_message, void* untyped_ros_message) {
  const @(spec.base_type.pkg_name)_@(subfolder)_dds__@(spec.base_type.type)_* dds_message =
    (const @(spec.base_type.pkg_name)_@(subfolder)_dds__@(spec.base_type.type)_*) untyped_dds_message;

  @(spec.base_type.pkg_name)::@(subfolder)::@(spec.base_type.type)* ros_message =
    (@(spec.base_type.pkg_name)::@(subfolder)::@(spec.base_type.type)*) untyped_ros_message;

  return dds_to_ros(*dds_message, *ros_message);
}

void
alloc(@(spec.base_type.pkg_name)_@(subfolder)_dds__@(spec.base_type.type)_ * & dds_message)
{
   dds_message =
    @(spec.base_type.pkg_name)_@(subfolder)_dds__@(spec.base_type.type)_TypeSupport_alloc();
}

void*
alloc__@(spec.base_type.type)() {
  @(spec.base_type.pkg_name)_@(subfolder)_dds__@(spec.base_type.type)_* dds_message = nullptr;
  alloc(dds_message);

  return reinterpret_cast<void*>(dds_message);
}

void
free__@(spec.base_type.type)(void* data) {
  @(spec.base_type.pkg_name)_@(subfolder)_dds__@(spec.base_type.type)_* dds_message =
    (@(spec.base_type.pkg_name)_@(subfolder)_dds__@(spec.base_type.type)_*) data;

  @(spec.base_type.pkg_name)_@(subfolder)_dds__@(spec.base_type.type)_TypeSupport_free(dds_message);
}

void
set_sequence_number__@(spec.base_type.type)(void* untyped_dds_message, int64_t seq_number) {
@[if subfolder == 'srv' or (subfolder == 'action' and (spec.base_type.type.endswith('Request') or spec.base_type.type.endswith('Response')))]@
  @(spec.base_type.pkg_name)_@(subfolder)_dds__@(spec.base_type.type)_* dds_message =
    (@(spec.base_type.pkg_name)_@(subfolder)_dds__@(spec.base_type.type)_*) untyped_dds_message;

  dds_message->gurumdds__sequence_number_ = seq_number;
@[else]@
  (void)untyped_dds_message;
  (void)seq_number;
  return;
@[end if]@
}

int64_t
get_sequence_number__@(spec.base_type.type)(const void* untyped_dds_message) {
@[if subfolder == 'srv' or (subfolder == 'action' and (spec.base_type.type.endswith('Request') or spec.base_type.type.endswith('Response')))]@
  const @(spec.base_type.pkg_name)_@(subfolder)_dds__@(spec.base_type.type)_* dds_message =
    (const @(spec.base_type.pkg_name)_@(subfolder)_dds__@(spec.base_type.type)_*) untyped_dds_message;

  return dds_message->gurumdds__sequence_number_;
@[else]@
  (void)untyped_dds_message;
  return 0;
@[end if]@
}

void
set_guid__@(spec.base_type.type)(void* untyped_dds_message, const int8_t* guid) {
@[if subfolder == 'srv' or (subfolder == 'action' and (spec.base_type.type.endswith('Request') or spec.base_type.type.endswith('Response')))]@
  @(spec.base_type.pkg_name)_@(subfolder)_dds__@(spec.base_type.type)_* dds_message =
    (@(spec.base_type.pkg_name)_@(subfolder)_dds__@(spec.base_type.type)_*) untyped_dds_message;

  memcpy(&(dds_message->gurumdds__client_guid_0_), guid, sizeof(dds_message->gurumdds__client_guid_0_));
  memcpy(&(dds_message->gurumdds__client_guid_1_), guid + sizeof(dds_message->gurumdds__client_guid_0_), sizeof(dds_message->gurumdds__client_guid_1_));
@[else]@
  (void)untyped_dds_message;
  (void)guid;
  return;
@[end if]@
}

void
get_guid__@(spec.base_type.type)(const void* untyped_dds_message, int8_t* guid) {
@[if subfolder == 'srv' or (subfolder == 'action' and (spec.base_type.type.endswith('Request') or spec.base_type.type.endswith('Response')))]@
  @(spec.base_type.pkg_name)_@(subfolder)_dds__@(spec.base_type.type)_* dds_message =
    (@(spec.base_type.pkg_name)_@(subfolder)_dds__@(spec.base_type.type)_*) untyped_dds_message;

  memcpy(guid, &(dds_message->gurumdds__client_guid_0_), sizeof(dds_message->gurumdds__client_guid_0_));
  memcpy(guid + sizeof(dds_message->gurumdds__client_guid_0_), &(dds_message->gurumdds__client_guid_1_), sizeof(dds_message->gurumdds__client_guid_1_));
@[else]@
  (void)untyped_dds_message;
  (void)guid;
  return;
@[end if]@
}

bool
serialize__@(spec.base_type.type)(const void* untyped_dds_message, rcutils_uint8_array_t* serialized_message) {
  @(spec.base_type.pkg_name)_@(subfolder)_dds__@(spec.base_type.type)_* dds_message =
    (@(spec.base_type.pkg_name)_@(subfolder)_dds__@(spec.base_type.type)_*) untyped_dds_message;

  void* temp_message = nullptr;
  size_t message_size = 0;

  temp_message = @(spec.base_type.pkg_name)_@(subfolder)_dds__@(spec.base_type.type)_TypeSupport_serialize(dds_message, &message_size);
  if (temp_message == nullptr || message_size == 0)
    return false;

  serialized_message->buffer_length = message_size;
  if (serialized_message->buffer_capacity < message_size) {
    serialized_message->allocator.deallocate(serialized_message->buffer, serialized_message->allocator.state);
    serialized_message->buffer = static_cast<uint8_t*>(serialized_message->allocator.allocate(serialized_message->buffer_length,
                    serialized_message->allocator.state));
  }

  memcpy(serialized_message->buffer, temp_message, message_size);

  free(temp_message);

  return true;
}

bool
deserialize__@(spec.base_type.type)(const rcutils_uint8_array_t* serialized_message, void* untyped_dds_message) {
  void* temp_message = nullptr;
  size_t message_size = serialized_message->buffer_length;

  temp_message = @(spec.base_type.pkg_name)_@(subfolder)_dds__@(spec.base_type.type)_TypeSupport_deserialize(serialized_message->buffer, message_size);
  if (temp_message == nullptr)
    return false;

  memcpy(untyped_dds_message, temp_message, sizeof(@(spec.base_type.pkg_name)_@(subfolder)_dds__@(spec.base_type.type)_));

  free(temp_message);

  return true;
}

static message_type_support_callbacks_t callbacks = {
  "@(spec.base_type.pkg_name)",
  "@(spec.base_type.type)",
  &get_type_size__@(spec.base_type.type),
  &register_type__@(spec.base_type.type),
  &convert_ros_to_dds__@(spec.base_type.type),
  &convert_dds_to_ros__@(spec.base_type.type),
  &alloc__@(spec.base_type.type),
  &free__@(spec.base_type.type),
  &set_sequence_number__@(spec.base_type.type),
  &get_sequence_number__@(spec.base_type.type),
  &set_guid__@(spec.base_type.type),
  &get_guid__@(spec.base_type.type),
  &serialize__@(spec.base_type.type),
  &deserialize__@(spec.base_type.type)
};

static rosidl_message_type_support_t handle = {
  rosidl_typesupport_gurumdds_cpp::typesupport_identifier,
  &callbacks,
  get_message_typesupport_handle_function,
};

} // namespace typesupport_gurumdds_cpp

} // namespace @(subfolder)

} // namespace @(spec.base_type.pkg_name)

namespace rosidl_typesupport_gurumdds_cpp
{

template<>
ROSIDL_TYPESUPPORT_GURUMDDS_CPP_EXPORT_@(spec.base_type.pkg_name)
const rosidl_message_type_support_t*
get_message_type_support_handle<@(spec.base_type.pkg_name)::@(subfolder)::@(spec.base_type.type)>()
{
  return &@(spec.base_type.pkg_name)::@(subfolder)::typesupport_gurumdds_cpp::handle;
}

} // namespace rosidl_typesupport_gurumdds_cpp

#ifdef __cplusplus
extern "C"
{
#endif

const rosidl_message_type_support_t*
ROSIDL_TYPESUPPORT_INTERFACE__MESSAGE_SYMBOL_NAME(rosidl_typesupport_gurumdds_cpp, @(spec.base_type.pkg_name), @(subfolder), @(spec.base_type.type))() {
  return &@(spec.base_type.pkg_name)::@(subfolder)::typesupport_gurumdds_cpp::handle;
}

#ifdef __cplusplus
}
#endif
