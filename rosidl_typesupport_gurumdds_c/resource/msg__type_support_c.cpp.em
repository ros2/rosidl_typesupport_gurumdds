@# Included from rosidl_typesupport_gurumdds_c/resource/idl__dds_gurumdds__typesupport_c.cpp.em
@{
from rosidl_cmake import convert_camel_case_to_lower_case_underscore
from rosidl_generator_c import idl_structure_type_to_c_include_prefix
from rosidl_generator_c import idl_structure_type_to_c_typename
from rosidl_generator_c import idl_type_to_c
from rosidl_parser.definition import AbstractNestedType
from rosidl_parser.definition import AbstractSequence
from rosidl_parser.definition import AbstractString
from rosidl_parser.definition import AbstractWString
from rosidl_parser.definition import Array
from rosidl_parser.definition import BasicType
from rosidl_parser.definition import BoundedSequence
from rosidl_parser.definition import NamespacedType
include_parts = [package_name] + list(interface_path.parents[0].parts)
include_base = '/'.join(include_parts)

cpp_include_prefix = interface_path.stem
c_include_prefix = convert_camel_case_to_lower_case_underscore(cpp_include_prefix)

header_files = [
    include_base + '/' + c_include_prefix + '__rosidl_typesupport_gurumdds_c.h',
    'rcutils/types/uint8_array.h',
    'rosidl_typesupport_gurumdds_c/identifier.h',
    'rosidl_typesupport_gurumdds_c/wstring_conversion.hpp',
    'rosidl_typesupport_gurumdds_cpp/message_type_support.h',
    package_name + '/msg/rosidl_typesupport_gurumdds_c__visibility_control.h',
    include_base + '/' + c_include_prefix + '__struct.h',
    include_base + '/' + c_include_prefix + '__functions.h',
]

dds_specific_header_files = []
if message.structure.namespaced_type.namespaces[1] == 'msg':
    dds_specific_header_files = [
        include_base + '/dds_gurumdds/include/' + '/'.join(message.structure.namespaced_type.namespaces) + '/dds_/' + interface_path.stem + '_TypeSupport.h',
        include_base + '/dds_gurumdds/include/' + '/'.join(message.structure.namespaced_type.namespaces) + '/dds_/' + interface_path.stem + '_.h',
        'dds/dcps.h'
    ]
elif message.structure.namespaced_type.namespaces[1] == 'srv':
    dds_specific_header_files = [
        include_base + '/dds_gurumdds/include/' + '/'.join(message.structure.namespaced_type.namespaces) + '/dds_/' + interface_path.stem + '_Request_TypeSupport.h',
        include_base + '/dds_gurumdds/include/' + '/'.join(message.structure.namespaced_type.namespaces) + '/dds_/' + interface_path.stem + '_Request_.h',
        include_base + '/dds_gurumdds/include/' + '/'.join(message.structure.namespaced_type.namespaces) + '/dds_/' + interface_path.stem + '_Response_TypeSupport.h',
        include_base + '/dds_gurumdds/include/' + '/'.join(message.structure.namespaced_type.namespaces) + '/dds_/' + interface_path.stem + '_Response_.h',
        'dds/dcps.h'
    ]
elif message.structure.namespaced_type.namespaces[1] == 'action':
    for __suffix in ['_Goal',  '_SendGoal_Request', '_SendGoal_Response', '_Result', '_GetResult_Request', '_GetResult_Response', '_Feedback', '_FeedbackMessage']:
        dds_specific_header_files.append(include_base + '/dds_gurumdds/include/' + '/'.join(message.structure.namespaced_type.namespaces) + '/dds_/' + interface_path.stem + __suffix + '_TypeSupport.h')
        dds_specific_header_files.append(include_base + '/dds_gurumdds/include/' + '/'.join(message.structure.namespaced_type.namespaces) + '/dds_/' + interface_path.stem + __suffix + '_.h')
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

// includes and forward declarations of message dependencies and their conversion functions
@# // Include the message header for each non-primitive field.
#if defined(__cplusplus)
extern "C"
{
#endif

@{
from collections import OrderedDict
includes = OrderedDict()
for member in message.structure.members:
    if isinstance(member.type, AbstractSequence) and isinstance(member.type.value_type, BasicType):
       includes.setdefault('rosidl_generator_c/primitives_sequence.h', []).append(member.name)
       includes.setdefault('rosidl_generator_c/primitives_sequence_functions.h', []).append(member.name)
       continue
    type_ = member.type
    if isinstance(type_, AbstractNestedType):
       type_ = type_.value_type
    if isinstance(type_, AbstractString):
        includes.setdefault('rosidl_generator_c/string.h', []).append(member.name)
        includes.setdefault('rosidl_generator_c/string_functions.h', []).append(member.name)
    if isinstance(type_, AbstractWString):
        includes.setdefault('rosidl_generator_c/u16string.h', []).append(member.name)
        includes.setdefault('rosidl_generator_c/u16string_functions.h', []).append(member.name)
    if isinstance(type_, NamespacedType):
        include_prefix = idl_structure_type_to_c_include_prefix(type_)
        if include_prefix.endswith('__request'):
            include_prefix = include_prefix[:-9]
        elif include_prefix.endswith('__response'):
            include_prefix = include_prefix[:-10]
        if include_prefix.endswith('__goal'):
            include_prefix = include_prefix[:-6]
        elif include_prefix.endswith('__result'):
            include_prefix = include_prefix[:-8]
        elif include_prefix.endswith('__feedback'):
            include_prefix = include_prefix[:-10]
        includes.setdefault(include_prefix + '__struct.h', []).append(member.name)
        includes.setdefault(include_prefix + '__functions.h', []).append(member.name)
}@
@[if includes]@
// Include directives for member types
@[    for header_file, member_names in includes.items()]@
@[        for member_name in member_names]@
// Member '@(member_name)'
@[        end for]@
@[        if header_file in include_directives]@
// already included above
// @
@[        else]@
@{include_directives.add(header_file)}@
@[        end if]@
#include "@(header_file)"
@[    end for]@
@[end if]@

// forward declare type support functions
@{
from collections import OrderedDict
forward_declares = OrderedDict()
for member in message.structure.members:
    type_ = member.type
    if isinstance(type_, AbstractNestedType):
       type_ = type_.value_type
    if isinstance(type_, NamespacedType):
        _, member_names = forward_declares.setdefault(type_.name, (type_, []))
        member_names.append(member.name)
}@
@[for member_type, member_names in forward_declares.values()]@
@[  for name in member_names]@
// Member '@(name)'
@[  end for]@
@[  if member_type.namespaces[0] != package_name]@
ROSIDL_TYPESUPPORT_GURUMDDS_C_IMPORT_@(package_name)
@[  end if]@
const rosidl_message_type_support_t *
  ROSIDL_TYPESUPPORT_INTERFACE__MESSAGE_SYMBOL_NAME(
  rosidl_typesupport_gurumdds_c,
  @(', '.join(member_type.namespaces)),
  @(member_type.name))();
@[end for]@
@# // Make callback functions specific to this message type.
@{
__ros_msg_type = '__'.join(message.structure.namespaced_type.namespaces + [message.structure.namespaced_type.name])
__dds_msg_type_prefix = '_'.join(message.structure.namespaced_type.namespaces + ['dds_', message.structure.namespaced_type.name])
__dds_msg_type = __dds_msg_type_prefix + '_'
}@

static uint32_t
_@(message.structure.namespaced_type.name)__get_type_size()
{
  return sizeof(@(__ros_msg_type));
}

static dds_ReturnCode_t
_@(message.structure.namespaced_type.name)__register_type(dds_DomainParticipant * participant, const char * type_name)
{
  return @(__dds_msg_type_prefix)_TypeSupport_register_type(participant, type_name);
}

static bool
_@(message.structure.namespaced_type.name)__convert_ros_to_dds(const void * untyped_ros_message, void * untyped_dds_message)
{
  if (untyped_ros_message == NULL) {
    fprintf(stderr, "ros message handle is null\n");
    return false;
  }
  if (untyped_dds_message == NULL) {
    fprintf(stderr, "dds message handle is null\n");
    return false;
  }

  const @(__ros_msg_type) * ros_message = static_cast<const @(__ros_msg_type) *>(untyped_ros_message);
  @(__dds_msg_type) * dds_message = static_cast<@(__dds_msg_type) *>(untyped_dds_message);

@[if not message.structure.members]@
  // No fields
  (void)dds_message;
  (void)ros_message;
@[end if]@

@[for member in message.structure.members]@
  // Member name: @(member.name)
  {
@{
type_ = member.type
if isinstance(type_, AbstractNestedType):
    type_ = type_.value_type
}@
@{
if isinstance(type_, AbstractString):
  seq_name = 'String'
elif isinstance(type_, AbstractWString):
  seq_name = 'Wstring'
elif isinstance(type_, BasicType):
  if type_.typename == 'boolean':
    seq_name = 'Boolean'
  elif type_.typename == 'byte' or type_.typename == 'octet':
    seq_name = 'Octet'
  elif type_.typename == 'char':
    seq_name = 'Char'
  elif type_.typename == 'float32' or type_.typename == 'float':
    seq_name = 'Float'
  elif type_.typename == 'float64' or type_.typename == 'double':
    seq_name = 'Double'
  elif type_.typename == 'int8':
    seq_name = 'Octet'
  elif type_.typename == 'uint8':
    seq_name = 'Octet'
  elif type_.typename == 'int16':
    seq_name = 'Short'
  elif type_.typename == 'uint16':
    seq_name = 'UnsignedShort'
  elif type_.typename == 'int32':
    seq_name = 'Long'
  elif type_.typename == 'uint32':
    seq_name = 'UnsignedLong'
  elif type_.typename == 'int64':
    seq_name = 'LongLong'
  elif type_.typename == 'uint64':
    seq_name = 'UnsignedLongLong'
  else:
    assert False, "unknown type %s" % type_.typename
else:
  seq_name = 'Data'
}@
@[  if isinstance(type_, NamespacedType)]@
    const message_type_support_callbacks_t * @('__'.join(type_.namespaces + [type_.name]))__callbacks =
      static_cast<const message_type_support_callbacks_t *>(
      ROSIDL_TYPESUPPORT_INTERFACE__MESSAGE_SYMBOL_NAME(rosidl_typesupport_gurumdds_c, @(', '.join(type_.namespaces)), @(type_.name))()->data);
@[  end if]@
@[  if isinstance(member.type, AbstractNestedType)]@
@[    if isinstance(member.type, Array)]@
    size_t size = @(member.type.size);
@[    else]@
    size_t size = ros_message->@(member.name).size;
    if (size > (std::numeric_limits<uint32_t>::max)()) {
      fprintf(stderr, "array size exceeds maximum DDS sequence size\n");
      return false;
    }
@[      if isinstance(member.type, BoundedSequence)]@
    if (size > @(member.type.maximum_size)) {
      fprintf(stderr, "array size exceeds upper bound\n");
      return false;
    }
@[      end if]@
@[    end if]@
@[    if isinstance(member.type, Array)]@
@[      if isinstance(type_, BasicType)]@
    (void)size;
    memcpy(dds_message->@(member.name)_, ros_message->@(member.name), sizeof(dds_message->@(member.name)_));
@[      else]@
    for (uint32_t i = 0; i < static_cast<uint32_t>(size); ++i) {
@[        if isinstance(type_, AbstractString)]@
      const rosidl_generator_c__String * str = &ros_message->@(member.name)[i];
      if (str->capacity == 0 || str->capacity <= str->size) {
        fprintf(stderr, "string capacity not greater than size\n");
        return false;
      }
      if (str->data[str->size] != '\0') {
        fprintf(stderr, "string not null-terminated\n");
        return false;
      }

      dds_message->@(member.name)_[i] = strdup(str->data);
@[        elif isinstance(type_, AbstractWString)]@
      const rosidl_generator_c__U16String * str = &ros_message->@(member.name)[i];
      if (str->capacity == 0 || str->capacity <= str->size) {
        fprintf(stderr, "string capacity not greater than size\n");
        return false;
      }
      if (str->data[str->size] != u'\0') {
        fprintf(stderr, "string not null-terminated\n");
        return false;
      }
      dds_message->@(member.name)_[i] = rosidl_typesupport_gurumdds_c::create_wstring_from_u16string(*str);
      if (dds_message->@(member.name)_[i] == NULL) {
        fprintf(stderr, "failed to convert u16string to dds_Wstring\n");
        return false;
      }
@[        else]@
      dds_message->@(member.name)_[i] = reinterpret_cast<@('_'.join(type_.namespaces + ['dds_', type_.name]))_ *>(@(idl_structure_type_to_c_typename(type_))__callbacks->alloc());
      if (!@(idl_structure_type_to_c_typename(type_))__callbacks->convert_ros_to_dds(&(ros_message->@(member.name)[i]), dds_message->@(member.name)_[i])) {
        return false;
      }
@[        end if]@
    }
@[      end if]@
@[    else]@
@[      if isinstance(type_, BasicType)]@
    if (dds_message->@(member.name)_ == NULL) {
      dds_message->@(member.name)_ = dds_@(seq_name)Seq_create(8);
      if (dds_message->@(member.name)_ == NULL) {
        return false;
      }
    }
    if (!dds_@(seq_name)Seq_add_array(dds_message->@(member.name)_, reinterpret_cast<dds_@(seq_name) *>(ros_message->@(member.name).data), size)) {
      return false;
    }
@[      else]@
    dds_message->@(member.name)_ = dds_@(seq_name)Seq_create(8);
    for (uint32_t i = 0; i < static_cast<uint32_t>(size); ++i) {
@[        if isinstance(type_, AbstractString)]@
      const rosidl_generator_c__String * str = &ros_message->@(member.name).data[i];
      if (str->capacity == 0 || str->capacity <= str->size) {
        fprintf(stderr, "string capacity not greater than size\n");
        return false;
      }
      if (str->data[str->size] != '\0') {
        fprintf(stderr, "string not null-terminated\n");
        return false;
      }
      dds_StringSeq_add(dds_message->@(member.name)_, strdup(str->data));
@[        elif isinstance(type_, AbstractWString)]@
      const rosidl_generator_c__U16String * str = &ros_message->@(member.name).data[i];
      if (str->capacity == 0 || str->capacity <= str->size) {
        fprintf(stderr, "string capacity not greater than size\n");
        return false;
      }
      if (str->data[str->size] != '\0') {
        fprintf(stderr, "string not null-terminated\n");
        return false;
      }

      dds_Wstring temp_wstring = rosidl_typesupport_gurumdds_c::create_wstring_from_u16string(*str);
      if (temp_wstring == NULL) {
        fprintf(stderr, "failed to convert u16string to dds_Wstring\n");
        return false;
      }
      dds_WstringSeq_add(dds_message->@(member.name)_, temp_wstring);
@[        else]@
      @(__dds_msg_type) * dds_i = reinterpret_cast<@(__dds_msg_type) *>(@(idl_structure_type_to_c_typename(type_))__callbacks->alloc());
      if (!@(idl_structure_type_to_c_typename(type_))__callbacks->convert_ros_to_dds(&ros_message->@(member.name).data[i], dds_i)) {
        return false;
      }
      dds_DataSeq_add(dds_message->@(member.name)_, dds_i);
@[        end if]@
    }
@[      end if]@
@[    end if]@
@[  elif isinstance(member.type, AbstractString)]@
    const rosidl_generator_c__String * str = &ros_message->@(member.name);
    if (str->capacity == 0 || str->capacity <= str->size) {
      fprintf(stderr, "string capacity not greater than size\n");
      return false;
    }
    if (str->data[str->size] != '\0') {
      fprintf(stderr, "string not null-terminated\n");
      return false;
    }
    if (dds_message->@(member.name)_ != NULL) {
      free(dds_message->@(member.name)_);
    }
    dds_message->@(member.name)_ = strdup(str->data);
@[  elif isinstance(member.type, AbstractWString)]@
    const rosidl_generator_c__U16String * str = &ros_message->@(member.name);
    if (str->capacity == 0 || str->capacity <= str->size) {
      fprintf(stderr, "string capacity not greater than size\n");
      return false;
    }
    if (str->data[str->size] != '\0') {
      fprintf(stderr, "string not null-terminated\n");
      return false;
    }

    dds_message->@(member.name)_ = rosidl_typesupport_gurumdds_c::create_wstring_from_u16string(*str);
    if (dds_message->@(member.name)_ == NULL) {
      fprintf(stderr, "failed to convert u16string to dds_Wstring\n");
      return false;
    }
@[  elif isinstance(member.type, BasicType)]@
@[    if type_.typename == 'boolean']@
    dds_message->@(member.name)_ = static_cast<dds_@(seq_name)>(ros_message->@(member.name) ? 1 : 0);
@[    else]@
    dds_message->@(member.name)_ = static_cast<dds_@(seq_name)>(ros_message->@(member.name));
@[    end if]@
@[  else]@
    if (!@(idl_structure_type_to_c_typename(member.type))__callbacks->convert_ros_to_dds(
        &ros_message->@(member.name), &dds_message->@(member.name)_))
    {
      return false;
    }
@[  end if]@
  }
@[end for]@

  return true;
}

static bool
_@(message.structure.namespaced_type.name)__convert_dds_to_ros(const void * untyped_dds_message, void * untyped_ros_message)
{
  if (!untyped_ros_message) {
    fprintf(stderr, "ros message handle is null\n");
    return false;
  }
  if (!untyped_dds_message) {
    fprintf(stderr, "dds message handle is null\n");
    return false;
  }

  const @(__dds_msg_type) * dds_message = static_cast<const @(__dds_msg_type) *>(untyped_dds_message);
  @(__ros_msg_type) * ros_message = static_cast<@(__ros_msg_type) *>(untyped_ros_message);

@[if not message.structure.members]@
  // No fields
  (void)dds_message;
  (void)ros_message;
@[end if]@
@[for member in message.structure.members]@
  // Member name: @(member.name)
  {
@{
type_ = member.type
if isinstance(type_, AbstractNestedType):
  type_ = type_.value_type
}@
@[  if isinstance(member.type, AbstractNestedType)]@
@{
if isinstance(type_, AbstractString):
  seq_name = 'String'
elif isinstance(type_, AbstractWString):
  seq_name = 'Wstring'
elif isinstance(type_, BasicType):
  if type_.typename == 'boolean':
    seq_name = 'Boolean'
  elif type_.typename == 'byte' or type_.typename == 'octet':
    seq_name = 'Octet'
  elif type_.typename == 'char':
    seq_name = 'Char'
  elif type_.typename == 'float32' or type_.typename == 'float':
    seq_name = 'Float'
  elif type_.typename == 'float64' or type_.typename == 'double':
    seq_name = 'Double'
  elif type_.typename == 'int8':
    seq_name = 'Octet'
  elif type_.typename == 'uint8':
    seq_name = 'Octet'
  elif type_.typename == 'int16':
    seq_name = 'Short'
  elif type_.typename == 'uint16':
    seq_name = 'UnsignedShort'
  elif type_.typename == 'int32':
    seq_name = 'Long'
  elif type_.typename == 'uint32':
    seq_name = 'UnsignedLong'
  elif type_.typename == 'int64':
    seq_name = 'LongLong'
  elif type_.typename == 'uint64':
    seq_name = 'UnsignedLongLong'
  else:
    assert False, "unknown type %s" % type_.typename
else:
  seq_name = 'Data'
}@
@[    if isinstance(member.type, Array)]@
    uint32_t size = @(member.type.size);
@[    else]@
    uint32_t size = dds_@(seq_name)Seq_length(dds_message->@(member.name)_);
    if (ros_message->@(member.name).data) {
      @(idl_type_to_c(member.type) + '__fini')(&ros_message->@(member.name));
    }
    if (!@(idl_type_to_c(member.type) + '__init')(&ros_message->@(member.name), size)) {
      fprintf(stderr, "failed to create array for field '@(member.name)'\n");
      return false;
    }
@[    end if]@

@[    if not isinstance(member.type, Array) and isinstance(type_, BasicType)]@
    dds_@(seq_name)Seq_get_array(dds_message->@(member.name)_, reinterpret_cast<dds_@(seq_name) *>(ros_message->@(member.name).data), 0, size);
@[    elif isinstance(member.type, Array) and isinstance(type_, BasicType)]@
    (void)size;
    memcpy(ros_message->@(member.name), dds_message->@(member.name)_, sizeof(dds_message->@(member.name)_));
@[    else]@
    for (uint32_t i = 0; i < size; i++) {
@[      if isinstance(member.type, Array)]@
      auto & ros_i = ros_message->@(member.name)[i];
      auto dds_i = dds_message->@(member.name)_[i];
@[      else]@
      auto & ros_i = ros_message->@(member.name).data[i];
      auto dds_i = dds_@(seq_name)Seq_get(dds_message->@(member.name)_, i);
@[      end if]@
@[      if isinstance(type_, BasicType)]@
@[        if type_.typename == 'boolean']@
      ros_i = (dds_i != 0);
@[        else]@
      ros_i = dds_i;
@[        end if]@
@[      elif isinstance(type_, AbstractString)]@
      if (!ros_i.data) {
        rosidl_generator_c__String__init(&ros_i);
      }
      bool succeeded = rosidl_generator_c__String__assign(&ros_i, dds_i);
      if (!succeeded) {
        fprintf(stderr, "failed to assign string into field '@(member.name)'\n");
        return false;
      }
@[      elif isinstance(type_, AbstractWString)]@
      if (!ros_i.data) {
        rosidl_generator_c__U16String__init(&ros_i);
      }
      if (!rosidl_typesupport_gurumdds_c::convert_wstring_to_u16string(dds_i, ros_i)) {
        fprintf(stderr, "failed to convert dds_Wstring to u16string\n");
        return false;
      }
@[      elif isinstance(type_, NamespacedType)]@
      const rosidl_message_type_support_t * ts =
        ROSIDL_TYPESUPPORT_INTERFACE__MESSAGE_SYMBOL_NAME(
        rosidl_typesupport_gurumdds_c, @(', '.join(type_.namespaces)), @(type_.name))();
      const message_type_support_callbacks_t * callbacks = static_cast<const message_type_support_callbacks_t *>(ts->data);
      callbacks->convert_dds_to_ros(dds_i, &ros_i);
@[      end if]@
    }
@[    end if]@
@[  elif isinstance(member.type, AbstractString)]@
    if (!ros_message->@(member.name).data) {
      rosidl_generator_c__String__init(&ros_message->@(member.name));
    }
    bool succeeded = rosidl_generator_c__String__assign(&ros_message->@(member.name), dds_message->@(member.name)_);
    if (!succeeded) {
      fprintf(stderr, "failed to assign string into field '@(member.name)'\n");
      return false;
    }
@[  elif isinstance(member.type, AbstractWString)]@
    if (!ros_message->@(member.name).data) {
      rosidl_generator_c__U16String__init(&ros_message->@(member.name));
    }
    if (!rosidl_typesupport_gurumdds_c::convert_wstring_to_u16string(dds_message->@(member.name)_, ros_message->@(member.name))) {
      fprintf(stderr, "failed to convert dds_Wstring to u16string\n");
      return false;
    }
@[  elif isinstance(member.type, BasicType)]@
@[    if member.type.typename == 'bool']@
    ros_message->@(member.name) = (dds_message->@(member.name)_ != 0);
@[    else]@
    ros_message->@(member.name) = dds_message->@(member.name)_;
@[    end if]@
@[  elif isinstance(member.type, NamespacedType)]@
    const rosidl_message_type_support_t * ts =
      ROSIDL_TYPESUPPORT_INTERFACE__MESSAGE_SYMBOL_NAME(
      rosidl_typesupport_gurumdds_c, @(', '.join(member.type.namespaces)), @(member.type.name))();
    const message_type_support_callbacks_t * callbacks = static_cast<const message_type_support_callbacks_t *>(ts->data);
    callbacks->convert_dds_to_ros(&dds_message->@(member.name)_, &ros_message->@(member.name));
@[  else]@
@{    assert False, 'Unknown member type'}@
@[  end if]@
  }
@[end for]@

  return true;
}

static void *
_@(message.structure.namespaced_type.name)__alloc()
{
  @(__dds_msg_type) * dds_message =
    @(__dds_msg_type_prefix)_TypeSupport_alloc();

  return reinterpret_cast<void *>(dds_message);
}

static void
_@(message.structure.namespaced_type.name)__free(void * data)
{
  @(__dds_msg_type) * dds_message =
    reinterpret_cast<@(__dds_msg_type) *>(data);

  @(__dds_msg_type_prefix)_TypeSupport_free(dds_message);
}

static bool
_@(message.structure.namespaced_type.name)__serialize(const void * untyped_dds_message, rcutils_uint8_array_t * serialized_message)
{
  @(__dds_msg_type) * dds_message =
    reinterpret_cast<@(__dds_msg_type) *>(const_cast<void *>(untyped_dds_message));

  void * temp_message = nullptr;
  size_t message_size = 0;

  temp_message = @(__dds_msg_type_prefix)_TypeSupport_serialize(dds_message, &message_size);
  if (temp_message == nullptr || message_size == 0) {
    return false;
  }

  serialized_message->buffer_length = message_size;
  if (serialized_message->buffer_capacity < message_size) {
    serialized_message->allocator.deallocate(serialized_message->buffer, serialized_message->allocator.state);
    serialized_message->buffer = static_cast<uint8_t *>(serialized_message->allocator.allocate(serialized_message->buffer_length, serialized_message->allocator.state));
  }

  memcpy(serialized_message->buffer, temp_message, message_size);

  free(temp_message);

  return true;
}

static bool
_@(message.structure.namespaced_type.name)__deserialize(const rcutils_uint8_array_t * serialized_message, void * untyped_dds_message)
{
  void * temp_message = nullptr;
  size_t message_size = serialized_message->buffer_length;

  temp_message = @(__dds_msg_type_prefix)_TypeSupport_deserialize(serialized_message->buffer, message_size);
  if (temp_message == nullptr) {
    return false;
  }

  memcpy(untyped_dds_message, temp_message, sizeof(@(__dds_msg_type)));

  free(temp_message);

  return true;
}

@
@# // Collect the callback functions and provide a function to get the type support struct.

static message_type_support_callbacks_t _@(message.structure.namespaced_type.name)__callbacks = {
  "@('::'.join([package_name] + list(interface_path.parents[0].parts)))",  // message_namespace
  "@(message.structure.namespaced_type.name)",  // message_name
  &_@(message.structure.namespaced_type.name)__get_type_size,  // get_type_size
  &_@(message.structure.namespaced_type.name)__register_type,  // register_type
  &_@(message.structure.namespaced_type.name)__convert_ros_to_dds,  // convert_ros_to_dds
  &_@(message.structure.namespaced_type.name)__convert_dds_to_ros,  // convert_dds_to_ros
  &_@(message.structure.namespaced_type.name)__alloc,  // alloc
  &_@(message.structure.namespaced_type.name)__free,  // free
  &_@(message.structure.namespaced_type.name)__serialize,  // serialize
  &_@(message.structure.namespaced_type.name)__deserialize  // deserialize
};

static rosidl_message_type_support_t _@(message.structure.namespaced_type.name)__type_support = {
  rosidl_typesupport_gurumdds_c__identifier,
  &_@(message.structure.namespaced_type.name)__callbacks,
  get_message_typesupport_handle_function,
};

const rosidl_message_type_support_t *
ROSIDL_TYPESUPPORT_INTERFACE__MESSAGE_SYMBOL_NAME(
  rosidl_typesupport_gurumdds_c,
  @(', '.join([package_name] + list(interface_path.parents[0].parts))),
  @(message.structure.namespaced_type.name))()
{
  return &_@(message.structure.namespaced_type.name)__type_support;
}

#if defined(__cplusplus)
}
#endif
