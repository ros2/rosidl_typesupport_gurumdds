#ifndef ROSIDL_TYPESUPPORT_COREDDS_CPP__MESSAGE_TYPE_SUPPORT_H_
#define ROSIDL_TYPESUPPORT_COREDDS_CPP__MESSAGE_TYPE_SUPPORT_H_

#include "rosidl_generator_c/message_type_support_struct.h"

#include "rcutils/types/uint8_array.h"
#include <dds/dcps.h>

typedef struct message_type_support_callbacks_t
{
  const char* package_name;
  const char* message_name;

  uint32_t (*get_type_size)(void);
  dds_ReturnCode_t (*register_type)(dds_DomainParticipant* participant, const char* type_name);

  bool (*convert_ros_to_dds)(const void* untyped_ros_message, void* untyped_dds_message);
  bool (*convert_dds_to_ros)(const void* untyped_dds_message, void* untyped_ros_message);

  void* (*alloc)(void);
  void (*free)(void* data);

  void (*set_sequence_number)(void* untyped_dds_message, int64_t seq_number);
  int64_t (*get_sequence_number)(const void* untyped_dds_message);

  void (*set_guid)(void* untyped_dds_message, const int8_t* guid);
  void (*get_guid)(const void* untyped_dds_message, int8_t* guid);

  bool (*serialize)(const void* untyped_dds_message, rcutils_uint8_array_t* serialized_message);
  bool (*deserialize)(const rcutils_uint8_array_t* serialized_message, void* untyped_dds_message);
} message_type_support_callbacks_t;

#endif // ROSIDL_TYPESUPPORT_COREDDS_CPP__MESSAGE_TYPE_SUPPORT_H_
