@# Included from rosidl_typesupport_coredds_cpp/resource/idl__dds_coredds__type_support.cpp.em
@{
from rosidl_cmake import convert_camel_case_to_lower_case_underscore
from rosidl_parser.definition import AbstractGenericString
from rosidl_parser.definition import AbstractNestedType
from rosidl_parser.definition import AbstractString
from rosidl_parser.definition import AbstractWString
from rosidl_parser.definition import Array
from rosidl_parser.definition import BasicType
from rosidl_parser.definition import BoundedSequence
from rosidl_parser.definition import NamespacedType
include_parts = [package_name] + list(interface_path.parents[0].parts)
include_base = '/'.join(include_parts)

include_prefix = convert_camel_case_to_lower_case_underscore(interface_path.stem)

header_files = [
    include_base + '/' + include_prefix + '__rosidl_typesupport_coredds_cpp.hpp',
    'rcutils/types/uint8_array.h',
    'rosidl_typesupport_cpp/message_type_support.hpp',
    'rosidl_typesupport_coredds_cpp/identifier.hpp',
    'rosidl_typesupport_coredds_cpp/message_type_support.h',
    'rosidl_typesupport_coredds_cpp/message_type_support_decl.hpp',
    'rosidl_typesupport_coredds_cpp/wstring_conversion.hpp',
]
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

// forward declaration of message dependencies and their conversion functions
@[for member in message.structure.members]@
@{
type_ = member.type
if isinstance(type_, AbstractNestedType):
  type_ = type_.value_type
}@
@[  if isinstance(type_, NamespacedType)]@
@[    for ns in type_.namespaces]@
namespace @(ns)
{
@[    end for]@

namespace typesupport_coredds_cpp
{
@{
member_ros_msg_pkg_prefix = '::'.join(type_.namespaces)
member_ros_msg_type = member_ros_msg_pkg_prefix + '::' + type_.name
member_dds_msg_type = member_ros_msg_pkg_prefix.replace('::', '_') + '_dds__' + type_.name + '_'
}@
bool ros_to_dds(
  const @(member_ros_msg_type) &,
  @(member_dds_msg_type) &);
bool dds_to_ros(
  const @(member_dds_msg_type) &,
  @(member_ros_msg_type) &);
void alloc(
  @(member_dds_msg_type) * &);
}  // namespace typesupport_coredds_cpp

@[    for ns in reversed(type_.namespaces)]@
}  // namespace @(ns)
@[    end for]@
@[  end if]@
@[end for]@

@[for ns in message.structure.namespaced_type.namespaces]@

namespace @(ns)
{
@[end for]@

namespace typesupport_coredds_cpp
{

@{
__ros_msg_pkg_prefix = '::'.join(message.structure.namespaced_type.namespaces)
__ros_msg_type = __ros_msg_pkg_prefix + '::' + message.structure.namespaced_type.name
__dds_msg_type_prefix = __ros_msg_pkg_prefix.replace('::', '_') + '_dds__' + message.structure.namespaced_type.name
__dds_msg_type = __dds_msg_type_prefix + '_'
}@

uint32_t
get_type_size__@(message.structure.namespaced_type.name)()
{
  return sizeof(@(__ros_msg_type));
}

dds_ReturnCode_t
register_type__@(message.structure.namespaced_type.name)(dds_DomainParticipant * participant, const char * type_name)
{
  return @(__dds_msg_type_prefix)_TypeSupport_register_type(participant, type_name);
}

bool
ROSIDL_TYPESUPPORT_COREDDS_CPP_PUBLIC_@(package_name)
ros_to_dds(
  const @(__ros_msg_type) & ros_message,
  @(__dds_msg_type) & dds_message)
{
@[if not message.structure.members]@
  (void)ros_message;
  (void)dds_message;
@[end if]@
@[for member in message.structure.members]@
@{
type_ = member.type
if isinstance(type_, AbstractNestedType):
    type_ = type_.value_type
}@
  {
    // Member name: @(member.name)
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
  elif type_.typename == 'wchar':
    seq_name = 'Wchar'
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
    size_t size = @(member.type.size);
@[    else]@
    size_t size = ros_message.@(member.name).size();
    if (size > (std::numeric_limits<dds_Long>::max)()) {
      throw std::runtime_error("array size exceeds maximum DDS sequence size");
    }
@[      if isinstance(member.type, BoundedSequence)]@
    if (size > @(member.type.maximum_size)) {
      throw std::runtime_error("array size exceeds upper bound");
    }
@[      end if]@
@[    end if]@

@[    if isinstance(member.type, Array)]@
    for (size_t i = 0; i < size; i++) {
@[      if isinstance(member.type.value_type, AbstractString)]@
      free(dds_message.@(member.name)_[i]);
      dds_message.@(member.name)_[i] = strdup(ros_message.@(member.name)[i].c_str());
@[      elif isinstance(member.type.value_type, AbstractWString)]@
      dds_message.@(member.name)_[i] = rosidl_typesupport_coredds_cpp::create_wstring_from_u16string(ros_message.@(member.name)[i]);
      if (dds_message.@(member.name)_[i] == NULL) {
        fprintf(stderr, "failed to convert u16string to dds_Wstring\n");
        return false;
      }
@[      elif isinstance(member.type.value_type, BasicType)]@
      dds_message.@(member.name)_[i] = ros_message.@(member.name)[i];
@[      elif isinstance(member.type.value_type, NamespacedType)]@
      @('::'.join(member.type.value_type.namespaces))::typesupport_coredds_cpp::alloc(dds_message.@(member.name)_[i]);
      if (!@('::'.join(member.type.value_type.namespaces))::typesupport_coredds_cpp::ros_to_dds(ros_message.@(member.name)[i], *dds_message.@(member.name)_[i])) {
        return false;
      }
@[      else]@
@{        assert False, "unknown type %s" % type_}@
@[      end if]@
    }
@[    elif isinstance(member.type.value_type, AbstractString)]@
    if (dds_message.@(member.name)_ == NULL) {
      dds_message.@(member.name)_ = dds_StringSeq_create(8);
      if (dds_message.@(member.name)_ == NULL) {
        return false;
      }
    }
    for (size_t i = 0; i < size; i++) {
      dds_StringSeq_add(dds_message.@(member.name)_, strdup(ros_message.@(member.name)[i].c_str()));
    }
@[    elif isinstance(member.type.value_type, AbstractWString)]@
    if (dds_message.@(member.name)_ == NULL) {
      dds_message.@(member.name)_ = dds_WstringSeq_create(8);
      if (dds_message.@(member.name)_ == NULL) {
        return false;
      }
    }

    for (size_t i = 0; i < size; i++) {
      dds_Wstring temp_wstring = rosidl_typesupport_coredds_cpp::create_wstring_from_u16string(ros_message.@(member.name)[i]);
      if (temp_wstring == NULL) {
        fprintf(stderr, "failed to convert u16string to dds_Wstring\n");
        return false;
      }
      dds_WstringSeq_add(dds_message.@(member.name)_, temp_wstring);
    }
@[    elif isinstance(member.type.value_type, BasicType)]@
@[      if member.type.value_type.typename == 'boolean']@
    if (dds_message.@(member.name)_ == NULL) {
      dds_message.@(member.name)_ = dds_BooleanSeq_create(8);
      if (dds_message.@(member.name)_ == NULL) {
        return false;
      }
    }
    for (size_t i = 0; i < size; i++) {
      dds_BooleanSeq_add(dds_message.@(member.name)_, (dds_Boolean)ros_message.@(member.name)[i]);
    }
@[      else]@
    if (dds_message.@(member.name)_ == NULL) {
      dds_message.@(member.name)_ = dds_@(seq_name)Seq_create(8);
      if (dds_message.@(member.name)_ == NULL) {
        return false;
      }
    }
    dds_@(seq_name)Seq_add_array(dds_message.@(member.name)_, const_cast<dds_@(seq_name) *>(reinterpret_cast<const dds_@(seq_name) *>(&(ros_message.@(member.name)[0]))), size);
@[      end if]@
@[    elif isinstance(member.type.value_type, NamespacedType)]@
    if (dds_message.@(member.name)_ == NULL) {
      dds_message.@(member.name)_ = dds_DataSeq_create(8);
      if (dds_message.@(member.name)_ == NULL) {
        return false;
      }
    }
    for (size_t i = 0; i < size; i++) {
      @('_'.join(member.type.value_type.namespaces) + '_dds__' + member.type.value_type.name + '_') * tmp = nullptr;
      @('::'.join(member.type.value_type.namespaces))::typesupport_coredds_cpp::alloc(tmp);
      if (!@('::'.join(member.type.value_type.namespaces))::typesupport_coredds_cpp::ros_to_dds(ros_message.@(member.name)[i], *tmp)) {
        return false;
      }
      dds_DataSeq_add(dds_message.@(member.name)_, tmp);
    }
@[    else]@
@{      assert False, "unknown type %s" % type_}@
@[    end if]@
@[  else]@
@[    if isinstance(member.type, AbstractString)]@
    free(dds_message.@(member.name)_);
    dds_message.@(member.name)_ = strdup(ros_message.@(member.name).c_str());
@[    elif isinstance(member.type, AbstractWString)]@
    dds_message.@(member.name)_ = rosidl_typesupport_coredds_cpp::create_wstring_from_u16string(ros_message.@(member.name));
    if (dds_message.@(member.name)_ == NULL) {
      fprintf(stderr, "failed to convert u16string to dds_Wstring\n");
      return false;
    }
@[    elif isinstance(member.type, BasicType)]@
    dds_message.@(member.name)_ = ros_message.@(member.name);
@[    elif isinstance(member.type, NamespacedType)]@
    if (!@('::'.join(member.type.namespaces))::typesupport_coredds_cpp::ros_to_dds(ros_message.@(member.name), dds_message.@(member.name)_)) {
      return false;
    }
@[    else]@
@{      assert False, "unknown type %s" % type_}@
@[    end if]@
@[  end if]@
  }
@[end for]@

  return true;
}

bool convert_ros_to_dds__@(message.structure.namespaced_type.name)(const void * untyped_ros_message, void * untyped_dds_message)
{
  if (untyped_dds_message == NULL || untyped_ros_message == NULL) {
    return false;
  }
  const @(__ros_msg_type) * ros_message =
    reinterpret_cast<const @(__ros_msg_type) *>(untyped_ros_message);

  @(__dds_msg_type) * dds_message =
    reinterpret_cast<@(__dds_msg_type) *>(untyped_dds_message);

  return ros_to_dds(*ros_message, *dds_message);
}

bool
ROSIDL_TYPESUPPORT_COREDDS_CPP_PUBLIC_@(package_name)
dds_to_ros(
  const @(__dds_msg_type) & dds_message,
  @(__ros_msg_type) & ros_message)
{
@[if not message.structure.members]@
  (void)dds_message;
  (void)ros_message;
@[end if]@
@[for member in message.structure.members]@
@{
type_ = member.type
if isinstance(type_, AbstractNestedType):
    type_ = type_.value_type
}@
  {
    // Member name: @(member.name)
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
  elif type_.typename == 'wchar':
    seq_name = 'Wchar'
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
    size_t size = @(member.type.size);
@[    else]@
    size_t size = dds_@(seq_name)Seq_length(dds_message.@(member.name)_);
    ros_message.@(member.name).resize(size);
@[    end if]@

@[    if isinstance(member.type, Array)]@
    for (uint32_t i = 0; i < size; i++) {
@[      if isinstance(member.type.value_type, AbstractString)]@
      ros_message.@(member.name)[i] = std::string(dds_message.@(member.name)_[i]);
@[      elif isinstance(member.type.value_type, AbstractWString)]@
      if (!rosidl_typesupport_coredds_cpp::convert_wstring_to_u16string(dds_message.@(member.name)_[i], ros_message.@(member.name)[i])) {
        fprintf(stderr, "failed to convert dds_Wstring to u16string\n");
        return false;
      }
@[      elif isinstance(member.type.value_type, BasicType)]@
      ros_message.@(member.name)[i] = dds_message.@(member.name)_[i];
@[      elif isinstance(member.type.value_type, NamespacedType)]@
      if (!@('::'.join(member.type.value_type.namespaces))::typesupport_coredds_cpp::dds_to_ros(*dds_message.@(member.name)_[i], ros_message.@(member.name)[i])) {
        return false;
      }
@[      else]@
@{        assert False, "unknown type %s" % type_}@
@[      end if]@
    }
@[    elif isinstance(member.type.value_type, AbstractString)]@
    for (uint32_t i = 0; i < size; i++) {
      ros_message.@(member.name)[i] = std::string(dds_StringSeq_get(dds_message.@(member.name)_, i));
    }
@[    elif isinstance(member.type.value_type, AbstractWString)]@
    for (uint32_t i = 0; i < size; i++) {
      dds_Wstring temp_wstring = dds_WstringSeq_get(dds_message.@(member.name)_, i);
      if (!rosidl_typesupport_coredds_cpp::convert_wstring_to_u16string(temp_wstring, ros_message.@(member.name)[i])) {
        fprintf(stderr, "failed to convert dds_Wstring to u16string\n");
        return false;
      }
    }
@[    elif isinstance(member.type.value_type, BasicType)]@
@[      if member.type.value_type.typename == 'boolean']@
    for (uint32_t i = 0; i < size; i++) {
      ros_message.@(member.name)[i] = dds_BooleanSeq_get(dds_message.@(member.name)_, i);
    }
@[      else]@
    dds_@(seq_name)Seq_get_array(dds_message.@(member.name)_, const_cast<dds_@(seq_name) *>(reinterpret_cast<const dds_@(seq_name) *>(&(ros_message.@(member.name)[0]))), 0, size);
@[      end if]@
@[    elif isinstance(member.type.value_type, NamespacedType)]@
    for (uint32_t i = 0; i < size; i++) {
      if (!@('::'.join(member.type.value_type.namespaces))::typesupport_coredds_cpp::dds_to_ros(
          *reinterpret_cast<@('_'.join(member.type.value_type.namespaces) + '_dds__' + member.type.value_type.name + '_') *>(dds_DataSeq_get(dds_message.@(member.name)_, i)),
          ros_message.@(member.name)[i]))
      {
        return false;
      }
    }
@[    else]@
@{      assert False, "unknown type %s" % type_}@
@[    end if]@
@[  else]@
@[    if isinstance(member.type, AbstractString)]@
    ros_message.@(member.name) = std::string(dds_message.@(member.name)_);
@[    elif isinstance(member.type, AbstractWString)]@
    if (!rosidl_typesupport_coredds_cpp::convert_wstring_to_u16string(dds_message.@(member.name)_, ros_message.@(member.name))) {
      fprintf(stderr, "failed to convert dds_Wstring to u16string\n");
      return false;
    }
@[    elif isinstance(member.type, BasicType)]@
    ros_message.@(member.name) = dds_message.@(member.name)_;
@[    else]@
    if (!@('::'.join(member.type.namespaces))::typesupport_coredds_cpp::dds_to_ros(dds_message.@(member.name)_, ros_message.@(member.name))) {
      return false;
    }
@[    end if]@
@[  end if]@
  }
@[end for]@
  return true;
}

bool convert_dds_to_ros__@(message.structure.namespaced_type.name)(const void * untyped_dds_message, void * untyped_ros_message)
{
  if (untyped_dds_message == NULL || untyped_ros_message == NULL) {
    return false;
  }
  const @(__dds_msg_type) * dds_message =
    reinterpret_cast<const @(__dds_msg_type) *>(untyped_dds_message);

  @(__ros_msg_type) * ros_message =
    reinterpret_cast<@(__ros_msg_type) *>(untyped_ros_message);

  return dds_to_ros(*dds_message, *ros_message);
}

void
ROSIDL_TYPESUPPORT_COREDDS_CPP_PUBLIC_@(package_name)
alloc(@(__dds_msg_type) * & dds_message)
{
  dds_message =
    @(__dds_msg_type_prefix)_TypeSupport_alloc();
}

void *
alloc__@(message.structure.namespaced_type.name)()
{
  @(__dds_msg_type) * dds_message = nullptr;
  alloc(dds_message);

  return reinterpret_cast<void *>(dds_message);
}

void
free__@(message.structure.namespaced_type.name)(void * data)
{
  @(__dds_msg_type) * dds_message =
    reinterpret_cast<@(__dds_msg_type) *>(data);

  @(__dds_msg_type_prefix)_TypeSupport_free(dds_message);
}

bool
serialize__@(message.structure.namespaced_type.name)(const void * untyped_dds_message, rcutils_uint8_array_t * serialized_message)
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
    serialized_message->buffer = static_cast<uint8_t *>(
      serialized_message->allocator.allocate(
        serialized_message->buffer_length,
        serialized_message->allocator.state));
  }

  memcpy(serialized_message->buffer, temp_message, message_size);

  free(temp_message);

  return true;
}

bool
deserialize__@(message.structure.namespaced_type.name)(const rcutils_uint8_array_t * serialized_message, void * untyped_dds_message)
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

static message_type_support_callbacks_t _@(message.structure.namespaced_type.name)__callbacks = {
  "@('::'.join([package_name] + list(interface_path.parents[0].parts)))",
  "@(message.structure.namespaced_type.name)",
  &get_type_size__@(message.structure.namespaced_type.name),
  &register_type__@(message.structure.namespaced_type.name),
  &convert_ros_to_dds__@(message.structure.namespaced_type.name),
  &convert_dds_to_ros__@(message.structure.namespaced_type.name),
  &alloc__@(message.structure.namespaced_type.name),
  &free__@(message.structure.namespaced_type.name),
  &serialize__@(message.structure.namespaced_type.name),
  &deserialize__@(message.structure.namespaced_type.name)
};

static rosidl_message_type_support_t _@(message.structure.namespaced_type.name)__handle = {
  rosidl_typesupport_coredds_cpp::typesupport_identifier,
  &_@(message.structure.namespaced_type.name)__callbacks,
  get_message_typesupport_handle_function,
};

}  // namespace typesupport_coredds_cpp

@[for ns in reversed(message.structure.namespaced_type.namespaces)]@
}  // namespace @(ns)

@[end for]@

namespace rosidl_typesupport_coredds_cpp
{

template<>
ROSIDL_TYPESUPPORT_COREDDS_CPP_EXPORT_@(package_name)
const rosidl_message_type_support_t *
get_message_type_support_handle<@(__ros_msg_type)>()
{
  return &@(__ros_msg_pkg_prefix)::typesupport_coredds_cpp::_@(message.structure.namespaced_type.name)__handle;
}

}  // namespace rosidl_typesupport_coredds_cpp

#ifdef __cplusplus
extern "C"
{
#endif

const rosidl_message_type_support_t *
ROSIDL_TYPESUPPORT_INTERFACE__MESSAGE_SYMBOL_NAME(
  rosidl_typesupport_coredds_cpp,
  @(', '.join([package_name] + list(interface_path.parents[0].parts))),
  @(message.structure.namespaced_type.name))()
{
  return &@(__ros_msg_pkg_prefix)::typesupport_coredds_cpp::_@(message.structure.namespaced_type.name)__handle;
}

#ifdef __cplusplus
}
#endif
