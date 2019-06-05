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

#ifndef ROSIDL_TYPESUPPORT_COREDDS_CPP__SERVICE_TYPE_SUPPORT_DECL_HPP_
#define ROSIDL_TYPESUPPORT_COREDDS_CPP__SERVICE_TYPE_SUPPORT_DECL_HPP_

#include <rosidl_generator_c/service_type_support_struct.h>
#include <rosidl_typesupport_coredds_cpp/visibility_control.h>

namespace rosidl_typesupport_coredds_cpp
{

template<typename T>
ROSIDL_TYPESUPPORT_COREDDS_CPP_PUBLIC
const rosidl_service_type_support_t * get_service_type_support_handle();

}

#endif  // ROSIDL_TYPESUPPORT_COREDDS_CPP__SERVICE_TYPE_SUPPORT_DECL_HPP_
