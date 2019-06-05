// Copyright 2019 GurumNetworks, Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#ifndef ROSIDL_TYPESUPPORT_COREDDS_CPP__MESSAGE_TYPE_SUPPORT_H_
#define ROSIDL_TYPESUPPORT_COREDDS_CPP__MESSAGE_TYPE_SUPPORT_H_

#include "rosidl_generator_c/message_type_support_struct.h"
#include <dds/dcps.h>
#include "rcutils/types/uint8_array.h"

typedef struct message_type_support_callbacks_t
{
  const char * message_namespace;
  const char * message_name;

  uint32_t (* get_type_size)(void);
  dds_ReturnCode_t (* register_type)(dds_DomainParticipant * participant, const char * type_name);

  bool (* convert_ros_to_dds)(const void * untyped_ros_message, void * untyped_dds_message);
  bool (* convert_dds_to_ros)(const void * untyped_dds_message, void * untyped_ros_message);

  void * (*alloc)(void);
  void (* free)(void * data);

  bool (* serialize)(const void * untyped_dds_message, rcutils_uint8_array_t * serialized_message);
  bool (* deserialize)(
    const rcutils_uint8_array_t * serialized_message,
    void * untyped_dds_message);
} message_type_support_callbacks_t;

#endif  // ROSIDL_TYPESUPPORT_COREDDS_CPP__MESSAGE_TYPE_SUPPORT_H_
