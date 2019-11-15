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

#include <rosidl_typesupport_gurumdds_cpp/wstring_conversion.hpp>

#define GURUMDDS_WSTRING_MAX_LEN 65535

namespace rosidl_typesupport_gurumdds_cpp
{

dds_Wstring create_wstring_from_u16string(const std::u16string & u16str)
{
  dds_Wstring wstr = (dds_Wstring)calloc(u16str.size() + 1, sizeof(dds_Wchar));
  if (wstr == NULL) {
    return NULL;
  }

  for (size_t i = 0; i < u16str.size(); ++i) {
    wstr[i] = static_cast<dds_Wchar>(u16str[i]);
  }
  wstr[u16str.size()] = static_cast<dds_Wchar>(u'\0');

  return wstr;
}

bool convert_wstring_to_u16string(const dds_Wstring wstr, std::u16string & u16str)
{
  size_t size = 0;
  if (wstr != NULL) {
    for (; size < GURUMDDS_WSTRING_MAX_LEN; size++) {
      if (wstr[size] == u'\0') {
        break;
      }
    }
  }

  try {
    u16str.resize(size);
  } catch (...) {
    return false;
  }

  for (size_t i = 0; i < size; ++i) {
    u16str[i] = static_cast<char16_t>(wstr[i]);
  }
  u16str[size] = u'\0';

  return true;
}

}  // namespace rosidl_typesupport_gurumdds_cpp
