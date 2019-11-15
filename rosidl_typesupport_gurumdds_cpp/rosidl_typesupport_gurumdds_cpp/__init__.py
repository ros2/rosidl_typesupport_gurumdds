# Copyright 2019 GurumNetworks, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

import os
import subprocess
import sys

from rosidl_cmake import generate_files


def generate_dds_gurumdds_cpp(
        pkg_name, dds_interface_files, dds_interface_base_path, deps,
        output_basepath, idl_pp):

    include_dirs = [dds_interface_base_path]
    for dep in deps:
        # Only take the first : for separation, as Windows follows with a C:\
        dep_parts = dep.split(':', 1)
        assert len(dep_parts) == 2, "The dependency '%s' must contain a double colon" % dep
        idl_path = dep_parts[1]
        idl_base_path = os.path.dirname(
            os.path.dirname(os.path.dirname(os.path.normpath(idl_path))))
        if idl_base_path not in include_dirs:
            include_dirs.append(idl_base_path)

    for idl_file in dds_interface_files:
        assert os.path.exists(idl_file), 'Could not find IDL file: ' + idl_file

        # get two level of parent folders for idl file
        folder = os.path.dirname(idl_file)
        parent_folder = os.path.dirname(folder)
        output_path = os.path.join(
            output_basepath,
            os.path.basename(parent_folder),
            os.path.basename(folder))
        try:
            os.makedirs(output_path)
        except FileExistsError:
            pass

        _modify(
            idl_file, pkg_name, os.path.splitext(os.path.basename(idl_file))[0],
            (str(os.path.basename(parent_folder)) == 'srv' or
                str(os.path.basename(parent_folder)) == 'action'))

        cmd = [idl_pp]
        for include_dir in include_dirs:
            cmd += ['-I', include_dir]
        cmd += [
            'c',
            '--case-sensitive',
            idl_file,
            output_path
        ]

        msg_name = os.path.splitext(os.path.basename(idl_file))[0]
        count = 1
        max_count = 5
        parent = os.path.basename(parent_folder)

        while True:
            subprocess.check_call(cmd)

            # fail safe if the generator does not work as expected
            any_missing = False
            for suffix in ['TypeSupport.h', '.h', 'TypeSupport.c']:
                add_path = ''
                temp_output_path = ''
                if suffix[-1] == 'h':
                    add_path = '/include/' + pkg_name + '/' + parent + '/' + 'dds_/'
                else:
                    add_path = '/src/' + pkg_name + '_' + parent + '_' + 'dds__'

                temp_output_path = output_path + add_path
                if parent == 'action':
                    for action_suffix in ['Goal_',  'SendGoal_Request_', 'SendGoal_Response_',
                                          'Result_', 'GetResult_Request_', 'GetResult_Response_',
                                          'Feedback_', 'FeedbackMessage_']:
                        filename = temp_output_path + msg_name + action_suffix + suffix
                        if not os.path.exists(filename):
                            any_missing = True
                            break
                    if any_missing:
                        break
                elif parent == 'srv':
                    for srv_suffix in ['Request_', 'Response_']:
                        filename = temp_output_path + msg_name + srv_suffix + suffix
                        if not os.path.exists(filename):
                            any_missing = True
                            break
                    if any_missing:
                        break
                else:
                    filename = temp_output_path + msg_name + suffix
                    if not os.path.exists(filename):
                        any_missing = True
                        break
            if not any_missing:
                break
            print("'%s' failed to generate the expected files for '%s/%s'" %
                  (idl_pp, pkg_name, msg_name), file=sys.stderr)
            if count < max_count:
                count += 1
                print('Running code generator again (retry %d of %d)...' %
                      (count, max_count), file=sys.stderr)
                continue
            raise RuntimeError('failed to generate the expected files')

    return 0


def _modify(filename, pkg_name, msg_name, is_srv):
    modified = False
    with open(filename, 'r') as h:
        lines = h.read().split('\n')
    if is_srv is True:
        modified = add_seq_number(lines)
    if modified:
        with open(filename, 'w') as h:
            h.write('\n'.join(lines))


def add_seq_number(lines):
    changed = True
    while changed:
        changed = False
        flag = False
        for i, line in enumerate(lines):
            if (line.startswith('struct') and
                    (line.endswith('_Request_ {') or line.endswith('_Response_ {'))):
                if flag:
                    assert False, 'unexpected struct declaration'
                flag = True
            elif flag:
                if line.startswith('long long gurumdds__sequence_number_;'):
                    flag = False
                elif line.startswith('};'):
                    lines.insert(i - 1, 'long long gurumdds__sequence_number_;')
                    lines.insert(i, 'unsigned long long gurumdds__client_guid_0_;')
                    lines.insert(i + 1, 'unsigned long long gurumdds__client_guid_1_;')
                    flag = False
                    changed = True
                    break

    return lines


def generate_cpp(arguments_file):
    mapping = {
        'idl__rosidl_typesupport_gurumdds_cpp.hpp.em':
        '%s__rosidl_typesupport_gurumdds_cpp.hpp',
        'idl__dds_gurumdds__type_support.cpp.em':
        'dds_gurumdds/%s__type_support.cpp'
    }
    generate_files(arguments_file, mapping)
    return 0
