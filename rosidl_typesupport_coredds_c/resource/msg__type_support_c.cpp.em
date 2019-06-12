// generated from rosidl_typesupport_coredds_c/resource/msg__type_support_c.cpp.em
// generated code does not contain a copyright notice

@##########################################################################
@# EmPy template for generating <msg>__type_support_c.cpp files for Coredds
@#
@# Context:
@#  - spec (rosidl_parser.MessageSpecification)
@#    Parsed specification of the .msg file
@#  - pkg (string)
@#    name of the containing package; equivalent to spec.base_type.pkg_name
@#  - msg (string)
@#    name of the message; equivalent to spec.msg_name
@#  - type (string)
@#    full type of the message; equivalent to spec.base_type.type
@#  - subfolder (string)
@#    The subfolder / subnamespace of the message
@#    Could be 'msg', 'srv' or 'action'
@#  - get_header_filename_from_msg_name (function)
@##########################################################################
@
#include "@(spec.base_type.pkg_name)/@(subfolder)/@(get_header_filename_from_msg_name(spec.base_type.type))__rosidl_typesupport_coredds_c.h"

#include <limits>
#include <stdexcept>
#include <cstring>

#include "rcutils/types/uint8_array.h"

#include "rosidl_typesupport_coredds_c/identifier.h"
#include "rosidl_typesupport_coredds_cpp/message_type_support.h"

#include "@(pkg)/msg/rosidl_typesupport_coredds_c__visibility_control.h"
@{header_file_name = get_header_filename_from_msg_name(type)}@
#include "@(pkg)/@(subfolder)/@(header_file_name)__struct.h"
#include "@(pkg)/@(subfolder)/@(header_file_name)__functions.h"

#ifndef _WIN32
# pragma GCC diagnostic push
# pragma GCC diagnostic ignored "-Wunused-parameter"
# ifdef __clang__
#  pragma clang diagnostic ignored "-Wdeprecated-register"
#  pragma clang diagnostic ignored "-Wreturn-type-c-linkage"
# endif
#endif
#include "@(spec.base_type.pkg_name)/@(subfolder)/dds_coredds/include/@(spec.base_type.pkg_name)/@(subfolder)/dds_/@(spec.base_type.type)_TypeSupport.h"
#include "@(spec.base_type.pkg_name)/@(subfolder)/dds_coredds/include/@(spec.base_type.pkg_name)/@(subfolder)/dds_/@(spec.base_type.type)_.h"
#ifndef _WIN32
# pragma GCC diagnostic pop
#endif

// includes and forward declarations of message dependencies and their conversion functions

@# // Include the message header for each non-primitive field.
#if defined(__cplusplus)
extern "C"
{
#endif

@{
includes = {}
for field in spec.fields:
    keys = set([])
    if field.type.is_primitive_type():
        if field.type.is_array:
            keys.add('rosidl_generator_c/primitives_sequence.h')
            keys.add('rosidl_generator_c/primitives_sequence_functions.h')
        if field.type.type == 'string':
            keys.add('rosidl_generator_c/string.h')
            keys.add('rosidl_generator_c/string_functions.h')
    else:
        header_file_name = get_header_filename_from_msg_name(field.type.type)
        keys.add('%s/msg/%s__functions.h' % (field.type.pkg_name, header_file_name))
    for key in keys:
        if key not in includes:
            includes[key] = set([])
        includes[key].add(field.name)
}@
@[for key in sorted(includes.keys())]@
#include "@(key)"  // @(', '.join(includes[key]))
@[end for]@

// forward declare type support functions
@{
forward_declares = {}
for field in spec.fields:
    if not field.type.is_primitive_type():
        key = (field.type.pkg_name, field.type.type)
        if key not in includes:
            forward_declares[key] = set([])
        forward_declares[key].add(field.name)
}@
@[for key in sorted(forward_declares.keys())]@
@[  if key[0] != pkg]@
ROSIDL_TYPESUPPORT_COREDDS_C_IMPORT_@(pkg)
@[  end if]@
const rosidl_message_type_support_t *
  ROSIDL_TYPESUPPORT_INTERFACE__MESSAGE_SYMBOL_NAME(rosidl_typesupport_coredds_c, @(key[0]), msg, @(key[1]))();
@[end for]@

@# // Make callback functions specific to this message type.

@{
__dds_msg_type_prefix = "{0}_{1}_dds__{2}_".format(
  spec.base_type.pkg_name, subfolder, spec.base_type.type)
}@

using __dds_msg_type = @(__dds_msg_type_prefix);
using __ros_msg_type = @(pkg)__@(subfolder)__@(type);

static uint32_t
__get_type_size()
{
  return sizeof(__ros_msg_type);
}

static dds_ReturnCode_t
__register_type(dds_DomainParticipant* participant, const char* type_name)
{
    return @(pkg)_@(subfolder)_dds__@(type)_TypeSupport_register_type(participant, type_name);
}

static bool
__convert_ros_to_dds(const void* untyped_ros_message, void* untyped_dds_message) {
  if(untyped_ros_message == NULL) {
    fprintf(stderr, "ros message handle is null\n");
    return false;
  }
  if(untyped_dds_message == NULL) {
    fprintf(stderr, "dds message handle is null\n");
    return false;
  }

  const __ros_msg_type* ros_message = static_cast<const __ros_msg_type*>(untyped_ros_message);
  __dds_msg_type* dds_message = static_cast<__dds_msg_type*>(untyped_dds_message);

@[if not spec.fields]@
  // No fields
  (void)dds_message;
  (void)ros_message;
@[end if]@

@[for field in spec.fields]@
  // Field name: @(field.name)
  {
@[  if not field.type.is_primitive_type()]@
    const message_type_support_callbacks_t* @(field.type.pkg_name)__msg__@(field.type.type)__callbacks = 
      static_cast<const message_type_support_callbacks_t*>(
        ROSIDL_TYPESUPPORT_INTERFACE__MESSAGE_SYMBOL_NAME(rosidl_typesupport_coredds_c, @(field.type.pkg_name), msg, @(field.type.type))()->data);
@[  end if]@
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
    size_t len = ros_message->@(field.name).size;
    if(len > (std::numeric_limits<uint32_t>::max)()) {
      fprintf(stderr, "array size exceeds maximum DDS sequence size\n");
      return false;
    }
@[      if field.type.is_upper_bound]@
    if(len > @(field.type.array_size)) {
      fprintf(stderr, "array size exceeds upper bound\n");
      return false;
    }
@[      end if]@
@[    end if]@

@[    if field.type.array_size and not field.type.is_upper_bound]@
    for(uint32_t i = 0; i < static_cast<uint32_t>(len); ++i) {
      auto & ros_i = ros_message->@(field.name)[i];
@[      if field.type.type == 'string']@
      const rosidl_generator_c__String* str = &ros_i;
      if(str->capacity == 0 || str->capacity <= str->size) {
        fprintf(stderr, "string capacity not greater than size\n");
        return false;
      }
      if(str->data[str->size] != '\0') {
        fprintf(stderr, "string not null-terminated\n");
        return false;
      }

      dds_message->@(field.name)_[i] = strdup(str->data);
@[      elif field.type.is_primitive_type()]@
      dds_message->@(field.name)_[i] = ros_i;
@[      else]@
      //dds_message->@(field.name)_[i] = (@(field.type.pkg_name)_msg_dds__@(field.type.type)_ *)calloc(1, sizeof(@(field.type.pkg_name)_msg_dds__@(field.type.type)_));
      dds_message->@(field.name)_[i] = static_cast<@(field.type.pkg_name)_msg_dds__@(field.type.type)_ *>(@(field.type.pkg_name)__msg__@(field.type.type)__callbacks->alloc());
      if(!@(field.type.pkg_name)__msg__@(field.type.type)__callbacks->convert_ros_to_dds(&ros_i, dds_message->@(field.name)_[i]))
        return false;
@[      end if]@
    }
@[    else]@
@[      if field.type.is_primitive_type() and field.type.type != 'string']@
    if(!dds_@(seq_name)Seq_add_array(dds_message->@(field.name)_, (dds_@(seq_name)*)ros_message->@(field.name).data, len))
      return false;
@[      else]@
    for(uint32_t i = 0; i < static_cast<uint32_t>(len); ++i) {
      auto & ros_i = ros_message->@(field.name).data[i];
@[        if field.type.type == 'string']@
      const rosidl_generator_c__String* str = &ros_i;
      if(str->capacity == 0 || str->capacity <= str->size) {
        fprintf(stderr, "string capacity not greater than size\n");
        return false;
      }
      if(str->data[str->size] != '\0') {
        fprintf(stderr, "string not null-terminated\n");
        return false;
      }
      dds_StringSeq_add((dds_StringSeq*)dds_message->@(field.name)_, strdup(str->data));
@[        else]@
      //__dds_msg_type* dds_i = (__dds_msg_type*)calloc(1, sizeof(__dds_msg_type));
      __dds_msg_type * dds_i = static_cast<__dds_msg_type *>(@(field.type.pkg_name)__msg__@(field.type.type)__callbacks->alloc());
      if(!@(field.type.pkg_name)__msg__@(field.type.type)__callbacks->convert_ros_to_dds(&ros_i, dds_i))
        return false;
      dds_DataSeq_add((dds_DataSeq*)dds_message->@(field.name)_, dds_i);
@[        end if]@
    }
@[      end if]@
@[    end if]@
@[  elif field.type.type == 'string']@
    const rosidl_generator_c__String* str = &ros_message->@(field.name);
    if(str->capacity == 0 || str->capacity <= str->size) {
      fprintf(stderr, "string capacity not greater than size\n");
      return false;
    }
    if(str->data[str->size] != '\0') {
      fprintf(stderr, "string not null-terminated\n");
      return false;
    }
    dds_message->@(field.name)_ = strdup(str->data);
@[  elif field.type.is_primitive_type()]@
    dds_message->@(field.name)_ = ros_message->@(field.name);
@[  else]@
    if(!@(field.type.pkg_name)__msg__@(field.type.type)__callbacks->convert_ros_to_dds(
        &ros_message->@(field.name), &dds_message->@(field.name)_))
      return false;
@[  end if]@
  }
@[end for]@

  return true;
}

static bool 
__convert_dds_to_ros(const void* untyped_dds_message, void* untyped_ros_message) {
  if(!untyped_ros_message) {
    fprintf(stderr, "ros message handle is null\n");
    return false;
  }
  if(!untyped_dds_message) {
    fprintf(stderr, "dds message handle is null\n");
    return false;
  }

  const __dds_msg_type* dds_message = static_cast<const __dds_msg_type*>(untyped_dds_message);
  __ros_msg_type* ros_message = static_cast<__ros_msg_type*>(untyped_ros_message);

@[if not spec.fields]@
  // No fields
  (void)dds_message;
  (void)ros_message;
@[end if]@
@[for field in spec.fields]@
  // Field name: @(field.name)
  {
@[  if field.type.is_array]@
@{
if field.type.type == 'string':
  array_init = 'rosidl_generator_c__String__Sequence__init'
  array_fini = 'rosidl_generator_c__String__Sequence__fini'
elif field.type.is_primitive_type():
  array_init = 'rosidl_generator_c__{field.type.type}__Sequence__init'.format(**locals())
  array_fini = 'rosidl_generator_c__{field.type.type}__Sequence__fini'.format(**locals())
else:
  array_init = '{field.type.pkg_name}__msg__{field.type.type}__Sequence__init'.format(**locals())
  array_fini = '{field.type.pkg_name}__msg__{field.type.type}__Sequence__fini'.format(**locals())

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
    uint32_t len = @(field.type.array_size);
@[    else]@
    uint32_t len = dds_@(seq_name)Seq_length((dds_@(seq_name)Seq*)dds_message->@(field.name)_);
    if(ros_message->@(field.name).data)
      @(array_fini)(&ros_message->@(field.name));
    if(!@(array_init)(&ros_message->@(field.name), len)) {
      fprintf(stderr, "failed to create array for field '@(field.name)'\n");
      return false;
    }
@[    end if]@

@[    if (not field.type.array_size or field.type.is_upper_bound) and (field.type.is_primitive_type() and field.type.type != 'string')]@
    dds_@(seq_name)Seq_get_array(dds_message->@(field.name)_, (dds_@(seq_name)*)ros_message->@(field.name).data, 0, len);
@[    else]@
    for(uint32_t i = 0; i < len; i++) {
@[      if field.type.array_size and not field.type.is_upper_bound]@
      auto & ros_i = ros_message->@(field.name)[i];
      auto dds_i = dds_message->@(field.name)_[i];
@[      else]@
      auto & ros_i = ros_message->@(field.name).data[i];
      auto dds_i = dds_@(seq_name)Seq_get((dds_@(seq_name)Seq*)dds_message->@(field.name)_, i);
@[      end if]@
@[      if field.type.type == 'bool']@
      ros_i = (dds_i != 0);
@[      elif field.type.type == 'string']@
      if(!ros_i.data)
        rosidl_generator_c__String__init(&ros_i);
      bool succeeded = rosidl_generator_c__String__assign(&ros_i, dds_i);
      if(!succeeded) {
        fprintf(stderr, "failed to assign string into field '@(field.name)'\n");
        return false;
      }
@[      elif field.type.is_primitive_type()]@
      ros_i = dds_i;
@[      else]@
      const rosidl_message_type_support_t* ts =
        ROSIDL_TYPESUPPORT_INTERFACE__MESSAGE_SYMBOL_NAME(rosidl_typesupport_coredds_c, @(field.type.pkg_name), msg, @(field.type.type))();
      const message_type_support_callbacks_t* callbacks = static_cast<const message_type_support_callbacks_t*>(ts->data);
      callbacks->convert_dds_to_ros(dds_i, &ros_i);
@[      end if]@
    }
@[    end if]@
@[  elif field.type.type == 'string']@
    if(!ros_message->@(field.name).data)
      rosidl_generator_c__String__init(&ros_message->@(field.name));
    bool succeeded = rosidl_generator_c__String__assign(
        &ros_message->@(field.name),
        dds_message->@(field.name)_);
    if(!succeeded) {
      fprintf(stderr, "failed to assign string into field '@(field.name)'\n");
      return false;
    }
@[  elif field.type.type == 'bool']@
    ros_message->@(field.name) = (dds_message->@(field.name)_ != 0);
@[  elif field.type.is_primitive_type()]@
    ros_message->@(field.name) = dds_message->@(field.name)_;
@[  else]@
    const rosidl_message_type_support_t* ts =
      ROSIDL_TYPESUPPORT_INTERFACE__MESSAGE_SYMBOL_NAME(rosidl_typesupport_coredds_c, @(field.type.pkg_name), msg, @(field.type.type))();
    const message_type_support_callbacks_t* callbacks = static_cast<const message_type_support_callbacks_t*>(ts->data);
    callbacks->convert_dds_to_ros(&dds_message->@(field.name)_, &ros_message->@(field.name));
@[  end if]@
  }
@[end for]@

  return true;
}

static void*
__alloc() {
  @(spec.base_type.pkg_name)_@(subfolder)_dds__@(spec.base_type.type)_* dds_message = 
    @(spec.base_type.pkg_name)_@(subfolder)_dds__@(spec.base_type.type)_TypeSupport_alloc();

@[for field in spec.fields]@
  // field.name @(field.name)
@[  if field.type.is_array and (not field.type.array_size or field.type.is_upper_bound)]@
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
  dds_message->@(field.name)_ = dds_@(seq_name)Seq_create(8);
@[  end if]@
@[end for]@

  return (void*)dds_message;
}

static void
__free(void* data) {
  @(spec.base_type.pkg_name)_@(subfolder)_dds__@(spec.base_type.type)_* dds_message = 
    (@(spec.base_type.pkg_name)_@(subfolder)_dds__@(spec.base_type.type)_*) data;

  @(spec.base_type.pkg_name)_@(subfolder)_dds__@(spec.base_type.type)_TypeSupport_free(dds_message);
}

static void
__set_sequence_number(void* untyped_dds_message, int64_t seq_number) {
@[if subfolder == 'srv' or (subfolder == 'action' and (spec.base_type.type.endswith('Request') or spec.base_type.type.endswith('Response')))]@
  @(spec.base_type.pkg_name)_@(subfolder)_dds__@(spec.base_type.type)_* dds_message = 
    (@(spec.base_type.pkg_name)_@(subfolder)_dds__@(spec.base_type.type)_*) untyped_dds_message;

  dds_message->coredds__sequence_number_ = seq_number;
@[else]@
  (void)untyped_dds_message;
  (void)seq_number;
  return;
@[end if]@
}

static int64_t
__get_sequence_number(const void* untyped_dds_message) {
@[if subfolder == 'srv' or (subfolder == 'action' and (spec.base_type.type.endswith('Request') or spec.base_type.type.endswith('Response')))]@
  const @(spec.base_type.pkg_name)_@(subfolder)_dds__@(spec.base_type.type)_* dds_message = 
    (const @(spec.base_type.pkg_name)_@(subfolder)_dds__@(spec.base_type.type)_*) untyped_dds_message;

  return dds_message->coredds__sequence_number_;
@[else]@
  (void)untyped_dds_message;
  return 0;
@[end if]@
}

static void
__set_guid(void* untyped_dds_message, const int8_t* guid) {
@[if subfolder == 'srv' or (subfolder == 'action' and (spec.base_type.type.endswith('Request') or spec.base_type.type.endswith('Response')))]@
  @(spec.base_type.pkg_name)_@(subfolder)_dds__@(spec.base_type.type)_* dds_message = 
    (@(spec.base_type.pkg_name)_@(subfolder)_dds__@(spec.base_type.type)_*) untyped_dds_message;

  memcpy(&(dds_message->coredds__client_guid_0_), guid, sizeof(dds_message->coredds__client_guid_0_));
  memcpy(&(dds_message->coredds__client_guid_1_), guid + sizeof(dds_message->coredds__client_guid_0_), sizeof(dds_message->coredds__client_guid_1_));
@[else]@
  (void)untyped_dds_message;
  (void)guid;
  return;
@[end if]@
}

static void
__get_guid(const void* untyped_dds_message, int8_t* guid) {
@[if subfolder == 'srv' or (subfolder == 'action' and (spec.base_type.type.endswith('Request') or spec.base_type.type.endswith('Response')))]@
  @(spec.base_type.pkg_name)_@(subfolder)_dds__@(spec.base_type.type)_* dds_message = 
    (@(spec.base_type.pkg_name)_@(subfolder)_dds__@(spec.base_type.type)_*) untyped_dds_message;

  memcpy(guid, &(dds_message->coredds__client_guid_0_), sizeof(dds_message->coredds__client_guid_0_));
  memcpy(guid + sizeof(dds_message->coredds__client_guid_0_), &(dds_message->coredds__client_guid_1_), sizeof(dds_message->coredds__client_guid_1_));
@[else]@
  (void)untyped_dds_message;
  (void)guid;
  return;
@[end if]@
}

static bool
__serialize(const void* untyped_dds_message, rcutils_uint8_array_t* serialized_message) {
  @(spec.base_type.pkg_name)_@(subfolder)_dds__@(spec.base_type.type)_* dds_message = 
    (@(spec.base_type.pkg_name)_@(subfolder)_dds__@(spec.base_type.type)_*) untyped_dds_message;

  void* temp_message = nullptr;
  size_t message_size = 0;

  temp_message = @(spec.base_type.pkg_name)_@(subfolder)_dds__@(spec.base_type.type)_TypeSupport_serialize(dds_message, &message_size);
  if(temp_message == nullptr || message_size == 0) 
    return false;

  serialized_message->buffer_length = message_size;
  if(serialized_message->buffer_capacity < message_size) {
    serialized_message->allocator.deallocate(serialized_message->buffer, serialized_message->allocator.state);
    serialized_message->buffer = static_cast<uint8_t*>(serialized_message->allocator.allocate(serialized_message->buffer_length, 
                    serialized_message->allocator.state));
  }

  memcpy(serialized_message->buffer, temp_message, message_size);

  free(temp_message);

  return true;
}

static bool
__deserialize(const rcutils_uint8_array_t* serialized_message, void* untyped_dds_message) {
  void* temp_message = nullptr;
  size_t message_size = serialized_message->buffer_length;

  temp_message = @(spec.base_type.pkg_name)_@(subfolder)_dds__@(spec.base_type.type)_TypeSupport_deserialize(serialized_message->buffer, message_size);
  if(temp_message == nullptr)
    return false;

  memcpy(untyped_dds_message, temp_message, sizeof(__dds_msg_type));

  free(temp_message);
  
  return true;
}

@
@# // Collect the callback functions and provide a function to get the type support struct.

static message_type_support_callbacks_t __callbacks = {
  "@(pkg)",  // package_name
  "@(msg)",  // message_name
  &__get_type_size,  // get_type_size_
  &__register_type,  // register_type 
  &__convert_ros_to_dds,
  &__convert_dds_to_ros,
  &__alloc,
  &__free,
  &__set_sequence_number,
  &__get_sequence_number,
  &__set_guid,
  &__get_guid,
  &__serialize,
  &__deserialize
};

static rosidl_message_type_support_t __type_support = {
  rosidl_typesupport_coredds_c__identifier,
  &__callbacks,
  get_message_typesupport_handle_function,
};

const rosidl_message_type_support_t *
ROSIDL_TYPESUPPORT_INTERFACE__MESSAGE_SYMBOL_NAME(rosidl_typesupport_coredds_c, @(pkg), @(subfolder), @(msg))() {
  return &__type_support;
}

#if defined(__cplusplus)
}
#endif
