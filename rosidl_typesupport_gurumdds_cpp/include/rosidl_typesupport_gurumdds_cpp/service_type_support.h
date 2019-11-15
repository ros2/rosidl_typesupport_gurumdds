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

#ifndef ROSIDL_TYPESUPPORT_GURUMDDS_CPP__SERVICE_TYPE_SUPPORT_H_
#define ROSIDL_TYPESUPPORT_GURUMDDS_CPP__SERVICE_TYPE_SUPPORT_H_

#include <stdint.h>
#include <rmw/types.h>
#include "rosidl_generator_c/service_type_support_struct.h"

#include "rosidl_typesupport_gurumdds_cpp/message_type_support.h"

typedef struct service_type_support_callbacks_t
{
  const char * service_namespace;
  const char * service_name;

  const rosidl_message_type_support_t * request_callbacks;
  const rosidl_message_type_support_t * response_callbacks;

  void (* request_set_sequence_number)(void * untyped_dds_message, int64_t seq_number);
  int64_t (* request_get_sequence_number)(const void * untyped_dds_message);
  void (* request_set_guid)(void * untyped_dds_message, const int8_t * guid);
  void (* request_get_guid)(const void * untyped_dds_message, int8_t * guid);

  void (* response_set_sequence_number)(void * untyped_dds_message, int64_t seq_number);
  int64_t (* response_get_sequence_number)(const void * untyped_dds_message);
  void (* response_set_guid)(void * untyped_dds_message, const int8_t * guid);
  void (* response_get_guid)(const void * untyped_dds_message, int8_t * guid);
} service_type_support_callbacks_t;

#endif  // ROSIDL_TYPESUPPORT_GURUMDDS_CPP__SERVICE_TYPE_SUPPORT_H_
