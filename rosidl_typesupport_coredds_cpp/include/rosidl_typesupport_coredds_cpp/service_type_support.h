#ifndef ROSIDL_TYPESUPPORT_COREDDS_CPP__SERVICE_TYPE_SUPPORT_H_
#define ROSIDL_TYPESUPPORT_COREDDS_CPP__SERVICE_TYPE_SUPPORT_H_

#include <stdint.h>
#include <rmw/types.h>
#include "rosidl_generator_c/service_type_support_struct.h"

#include "rosidl_typesupport_coredds_cpp/message_type_support.h"

typedef struct service_type_support_callbacks_t
{
  const char* package_name;
  const char* service_name;

  const rosidl_message_type_support_t* request_callbacks;
  const rosidl_message_type_support_t* response_callbacks;
} service_type_support_callbacks_t;

#endif // ROSIDL_TYPESUPPORT_COREDDS_CPP__SERVICE_TYPE_SUPPORT_H_
