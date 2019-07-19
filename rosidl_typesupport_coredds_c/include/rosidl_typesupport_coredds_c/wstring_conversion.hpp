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

#ifndef ROSIDL_TYPESUPPORT_COREDDS_C__WSTRING_CONVERSION_HPP_
#define ROSIDL_TYPESUPPORT_COREDDS_C__WSTRING_CONVERSION_HPP_

#include "dds/dcps.h"
#include "rosidl_generator_c/u16string.h"
#include "rosidl_generator_c/u16string_functions.h"
#include "rosidl_typesupport_coredds_cpp/visibility_control.h"

namespace rosidl_typesupport_coredds_c
{

ROSIDL_TYPESUPPORT_COREDDS_CPP_PUBLIC
dds_Wstring create_wstring_from_u16string(
  const rosidl_generator_c__U16String & u16str);

ROSIDL_TYPESUPPORT_COREDDS_CPP_PUBLIC
bool convert_wstring_to_u16string(
  const dds_Wstring wstr, rosidl_generator_c__U16String & u16str);

}  // namespace rosidl_typesupport_coredds_c

#endif  // ROSIDL_TYPESUPPORT_COREDDS_C__WSTRING_CONVERSION_HPP_
