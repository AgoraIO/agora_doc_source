from __future__ import print_function
import argparse
import os
import re
import sys
import glob
import shutil
import datetime

TARGET_TEST_BASE_FOLDER = "test_base"
TARGET_TEST_FOLDER = "test"
ORIGIN_SDK_INTERFACE_FILE_NAME = "AgoraRteSdkInterface.hpp"
MERGED_HEADER_FILE_NAME = "AgoraRteSdkImpl.hpp"
TARGET_LOW_LEVEL_FOLDER = "low_level_api"

g_rte_dir = ""
g_low_level_api_dir = ""
g_out_dir = ""

g_api_folder = ""
g_impl_folder = ""
g_test_folder = ""
g_test_base_folder = ""
g_utils_folder = ""

g_api_files = set()
g_impl_header_files = set()
g_impl_cpp_files = set()
g_test_files = set()
g_test_base_files = set()
g_utils_files = set()

g_low_level_api_files = set()


def get_file_name_from_line(line):
  m = re.search('"(.+?)"', line)
  if m:
    return m.group(1)


def include_contains_merged_file(line, impl_header_names):
  if "#include" in line:
    m = re.search('"(.+?)"', line)
    if m:
      referenced = m.group(1)
      if referenced in impl_header_names:
        return True
  return False


def replace_then_write_to_file(file_path, impl_header_names, target_file, replaced_header, mark_inline=False):
  target_file.write("// ======================= " + os.path.basename(file_path) + " ======================= \n")
  with open(file_path) as f:
    lines = f.readlines()
    # we only want to include the merged head file once
    already_replaced = False
    for line in lines:
      if include_contains_merged_file(line, impl_header_names):
        if not already_replaced:
          target_file.write('#include "' + replaced_header + '" \n')
          already_replaced = True
      else:
        if mark_inline and line.startswith("RTE_INLINE"):
          changed_line = line.replace("RTE_INLINE", "inline")
          target_file.write(changed_line)
        else:
          # nothing changed, just copy and past
          check_and_replace_include_files(target_file, line)
  target_file.write("\n")


def do_replace_impl_cpp_include(file, file_handle):
  file_handle.write("// ======================= " + os.path.basename(file) + " ======================= \n")
  with open(file) as f:
    lines = f.readlines()

    for line in lines:
      if line.startswith("RTE_INLINE"):
        changed_line = line.replace("RTE_INLINE", "inline")

        file_handle.write(changed_line)
        continue

      if "#include" not in line:
        file_handle.write(line)
        continue

      rte, ret_line = replace_low_level_api_include_files_if_needed(line)
      if rte:
        file_handle.write(ret_line)
        continue

      replace_api_file_names = map(os.path.basename, g_api_files)
      replace_impl_file_names = map(os.path.basename, g_impl_header_files)
      referenced = get_file_name_from_line(line)
      if referenced in replace_api_file_names or referenced in replace_impl_file_names:
        continue

      file_handle.write(ret_line)


def do_merge_head_file(head_reference_map, file_handle):
  while bool(head_reference_map):
    for key, values in list(head_reference_map.items()):
      if not values:
        print("Merging .h: " + key)
        do_replace_impl_head_include(g_impl_folder + "/" + key, file_handle)
        for key2, values2 in head_reference_map.items():
          values2.discard(key)
        head_reference_map.pop(key)


def do_merge_cpp_file(file_handle):
  for cpp_file in g_impl_cpp_files:
    print("Merging .cpp: " + os.path.basename(cpp_file))
    do_replace_impl_cpp_include(cpp_file, file_handle)
    # replace_then_write_to_file(cpp_file, impl_header_names, file_handle, MERGED_HEADER_FILE_NAME, True)


def parser_in_and_out_argument():
  parser = argparse.ArgumentParser(
    description='Merge agora head files into single one')

  parser.add_argument(
    '--input_rte_dir',
    help='The directory contains source files, input_dir should be different with output_dir',
    required=True)

  parser.add_argument(
    '--input_rte_ut_dir',
    help='The directory contains ut source files, input_dir should be different with output_dir',
    required=True)

  parser.add_argument(
    '--input_low_level_api_dir',
    help='The directory contains low level api',
    required=True)

  parser.add_argument(
    '--output_dir',
    help='The directory to store target files',
    required=True)

  args = parser.parse_args()

  global g_rte_dir, g_low_level_api_dir, g_out_dir,g_rte_ut_dir
  g_rte_dir = args.input_rte_dir
  g_rte_ut_dir = args.input_rte_ut_dir
  g_low_level_api_dir = args.input_low_level_api_dir
  g_out_dir = args.output_dir

  print("\n---------- folder info ----------")
  print("rte_dir:", g_rte_dir)
  print("rte_ut_dir:", g_rte_ut_dir)
  print("low_level_api_dir:", g_low_level_api_dir)
  print("out_dir:", g_out_dir)
  print("-------------------------------- \n")

  if g_rte_dir == g_out_dir:
    print("error: input_dir should be different with output_dir\n")
    exit(1)

  global g_api_folder, g_impl_folder, g_test_folder, g_test_base_folder, g_utils_folder
  g_api_folder = os.path.join(g_rte_dir, "api")
  g_impl_folder = os.path.join(g_rte_dir, "impl")
  g_test_folder = g_rte_ut_dir
  g_test_base_folder = os.path.join(g_rte_ut_dir, "test_base")
  g_utils_folder = os.path.join(g_rte_dir, "utils")

  print("api_folder:", g_api_folder)
  print("impl_folder:", g_impl_folder)
  print("test_folder:", g_test_folder)
  print("test_base_folder:", g_test_base_folder)
  print("utils_folder:", g_utils_folder)

  global g_api_files, g_impl_header_files, g_impl_cpp_files, g_test_files, g_test_base_files, g_utils_files
  g_api_files = glob.glob(g_api_folder + "/*.h")
  g_impl_header_files = glob.glob(g_impl_folder + "/*.h")
  g_impl_cpp_files = glob.glob(g_impl_folder + "/*.cpp")
  g_test_files = glob.glob(g_test_folder + "/*.*")
  g_test_base_files = glob.glob(g_test_base_folder + "/*")
  g_utils_files = glob.glob(g_utils_folder + "/*")

  print("\n---------- api_files size:%d----------" % len(g_api_files))
  print("api_files:", g_api_files)
  print("-------------------------------- \n")

  print("\n---------- impl_header_files size:%d----------" % len(g_impl_header_files))
  print("impl_header_files:", g_impl_header_files)
  print("-------------------------------- \n")

  print("\n---------- impl_cpp_files size:%d----------" % len(g_impl_cpp_files))
  print("impl_cpp_files:", g_impl_cpp_files)
  print("-------------------------------- \n")

  print("\n---------- test_files size:%d----------" % len(g_test_files))
  print("test_files:", g_test_files)
  print("-------------------------------- \n")

  print("\n---------- test_base_files size:%d----------" % len(g_test_base_files))
  print("test_base_files:", g_test_base_files)
  print("-------------------------------- \n")

  print("\n---------- utils_files size:%d----------" % len(g_utils_files))
  print("utils_files:", g_utils_files)
  print("-------------------------------- \n")


def parser_low_level_api_files():
  global g_low_level_api_files
  g_low_level_api_files |= do_low_level_api_folder_files()
  g_low_level_api_files |= do_special_internal_low_level_api_files()

  print("\n---------- low_level_api_files ----------")
  print("low_level_header_files size:%d", len(g_low_level_api_files))
  print(g_low_level_api_files)
  print("-------------------------------- \n")


def do_move_utils_files():
  target_utils_folder = os.path.join(g_out_dir, "utils")
  if os.path.exists(target_utils_folder):
    shutil.rmtree(target_utils_folder)

  if not os.path.exists(g_utils_folder):
    return

  shutil.copytree(g_utils_folder, target_utils_folder)


def replace_low_level_api_include_files_if_needed(line):
  replace_file_names = map(os.path.basename, g_low_level_api_files)

  if "#include" not in line:
    return False, line

  referenced = get_file_name_from_line(line)
  if referenced in replace_file_names:
    replaced = '#include "' + TARGET_LOW_LEVEL_FOLDER + "/" + referenced + '"\n'
    return True, replaced
  return False, line


def replace_interface_include_files_if_needed(line):
  replace_file_names = map(os.path.basename, g_api_files)

  if "#include" not in line:
    return False, line

  referenced = get_file_name_from_line(line)
  if referenced in replace_file_names:
    replaced = '#include "' + MERGED_HEADER_FILE_NAME + '"\n'
    return True, replaced
  return False, line


def replace_impl_include_files_if_needed(line):
  replace_file_names = map(os.path.basename, g_impl_header_files)

  if "#include" not in line:
    return False, line

  referenced = get_file_name_from_line(line)
  if referenced in replace_file_names:
    replaced = '#include "' + MERGED_HEADER_FILE_NAME + '"\n'
    return True, replaced
  return False, line


def do_replace_interface_api_include(file, target_file):
  target_file_handle = open(target_file, "w+")
  with open(file) as f:
    lines = f.readlines()

    for line in lines:
      ret, ret_line = replace_low_level_api_include_files_if_needed(line)
      target_file_handle.write(ret_line)
  target_file_handle.close()


def do_replace_test_include(file, target_file):
  target_file_handle = open(target_file, "w+")
  with open(file) as f:
    lines = f.readlines()

    for line in lines:
      rte, ret_line = replace_low_level_api_include_files_if_needed(line)
      if not rte:
        rte, ret_line = replace_interface_include_files_if_needed(ret_line)
      if not rte:
        rte, ret_line = replace_impl_include_files_if_needed(ret_line)
      target_file_handle.write(ret_line)
  target_file_handle.close()


def do_replace_impl_head_include(file, file_handle):
  file_handle.write("// ======================= " + os.path.basename(file) + " ======================= \n")
  with open(file) as f:
    lines = f.readlines()

    for line in lines:
      if "#include" not in line:
        file_handle.write(line)
        continue

      rte, ret_line = replace_low_level_api_include_files_if_needed(line)
      if rte:
        file_handle.write(ret_line)
        continue

      replace_api_file_names = map(os.path.basename, g_api_files)
      replace_impl_file_names = map(os.path.basename, g_impl_header_files)
      referenced = get_file_name_from_line(line)
      if referenced in replace_api_file_names or referenced in replace_impl_file_names:
        continue

      file_handle.write(ret_line)


def do_move_and_replace_include_api_files():
  print("\n---------- do_move_and_replace_include_api_files ----------")
  for file in g_api_files:
    name = os.path.basename(file)
    target_file = os.path.join(g_out_dir, name)
    print("Processing : " + name)
    do_replace_interface_api_include(file, target_file)
  print("-------------------------------- \n")


def remove_duplicate_include(file, include_file):
  temporary_file_name = file + "_"
  print("temporary_file_name:", temporary_file_name)
  target_file_handle = open(temporary_file_name, "w+")

  has = False
  for line in open(file):
    if include_file in line:
      if not has:
        has = True
        target_file_handle.write(line)
    else:
      target_file_handle.write(line)

  target_file_handle.close()
  os.remove(file)
  if os.path.exists(temporary_file_name):
    print("exists:", temporary_file_name)
  else:
    print("not exists:", temporary_file_name)
  os.rename(temporary_file_name, file)


def do_move_and_replace_include_test_base_files():
  print("\n---------- do_move_and_replace_include_test_base_files ----------")

  target_test_path = os.path.join(g_out_dir, TARGET_TEST_FOLDER)
  if os.path.exists(target_test_path):
    shutil.rmtree(target_test_path)

  os.makedirs(target_test_path)

  for file in g_test_files:
    name = os.path.basename(file)
    target_file = os.path.join(target_test_path, name)
    print("Processing : " + name)
    do_replace_test_include(file, target_file)
    remove_duplicate_include(target_file, ORIGIN_SDK_INTERFACE_FILE_NAME)
    remove_duplicate_include(target_file, MERGED_HEADER_FILE_NAME)

  target_test_base_path = os.path.join(target_test_path, TARGET_TEST_BASE_FOLDER)
  if os.path.exists(target_test_base_path):
    shutil.rmtree(target_test_base_path)

  os.makedirs(target_test_base_path)

  for file in g_test_base_files:
    name = os.path.basename(file)
    target_file = os.path.join(target_test_base_path, name)
    print("Processing : " + name)
    do_replace_test_include(file, target_file)
    remove_duplicate_include(target_file, ORIGIN_SDK_INTERFACE_FILE_NAME)
    remove_duplicate_include(target_file, MERGED_HEADER_FILE_NAME)

  print("-------------------------------- \n")


def do_merge_impl_files():
  output_header_file_path = os.path.join(g_out_dir, MERGED_HEADER_FILE_NAME)
  print("output_header_file_path merge_files:", output_header_file_path)
  target_header_file_handle = open(output_header_file_path, "w+")
  write_copyright(target_header_file_handle)
  include = '#include "' + ORIGIN_SDK_INTERFACE_FILE_NAME + '"\n'
  target_header_file_handle.write(include)

  impl_header_names = map(os.path.basename, g_impl_header_files)
  print("impl_header_names", impl_header_names)

  head_reference_map = reference_relationship(g_impl_header_files, impl_header_names)
  do_merge_head_file(head_reference_map, target_header_file_handle)
  do_merge_cpp_file(target_header_file_handle)
  target_header_file_handle.close()
  #remove_duplicate_include(output_header_file_path, "#pragma once")


def do_low_level_api_folder_files():
  if not os.path.isdir(g_low_level_api_dir):
    print("low_level_api_dir:%s is not dir" % g_low_level_api_dir)

  api_files = set()
  for root, dirs, files in os.walk(g_low_level_api_dir):
    for filename in files:
      if filename.endswith('.h') and not "rte" in filename:
        api_files.add(filename)
  return api_files


def do_special_internal_low_level_api_files():
  special_low_level_api = set()
  # media_component/internal/media_player_i.h
  file_media_player_name = "media_player_i.h"
  file_media_player_path_name = os.path.join(g_rte_dir + "/../media_component/internal/", file_media_player_name)
  output_file_media_player_path_name = os.path.join(g_low_level_api_dir, file_media_player_name)
  shutil.copy(file_media_player_path_name, output_file_media_player_path_name)

  special_low_level_api.add(file_media_player_name)
  return special_low_level_api


def write_copyright(file_handle):
  # generate the head file to reference all previous required head files
  year = datetime.datetime.now().year
  head_copy_right = "//\n"
  head_copy_right += "//  Agora Real-time Engagement \n"
  head_copy_right += "//\n"
  head_copy_right += "//  Copyright (c) " + str(year) + " Agora.io. All rights reserved.\n"
  head_copy_right += "//\n\n\n"
  head_copy_right += "#pragma once\n"
  head_copy_right += "\n"
  file_handle.write(head_copy_right)


def reference_relationship(impl_header_files, impl_header_names):
  head_reference_map = dict()

  for head_file in impl_header_files:
    name = os.path.basename(head_file)
    head_reference_map[name] = set()
    lines = []
    with open(head_file) as f:
      lines += f.readlines()

    for line in lines:
      if "#include" in line:
        referenced = get_file_name_from_line(line)
        if referenced in impl_header_names:
          head_reference_map[name].add(referenced)

  # sort the map with file name for easy print
  for key, values in sorted(head_reference_map.items()):
    print(key, values)
  return head_reference_map


def do_merge_test_file(impl_header_names, test_base_files, output_test_base_path):
  print("impl_header_names", impl_header_names)
  print("test_base_files", test_base_files)
  print("output_test_base_path", output_test_base_path)
  if len(test_base_files) <= 0:
    print("test_base_folder %s not exists" % test_base_folder)
    return

  if os.path.exists(output_test_base_path):
    shutil.rmtree(output_test_base_path)

  os.makedirs(output_test_base_path)

  for test_file in test_base_files:
    name = os.path.basename(test_file)
    print("Processing : " + name + '\n')
    test_header_file = open(os.path.join(output_test_base_path, name), "w+")
    replace_then_write_to_file(test_file, impl_header_names, test_header_file, MERGED_HEADER_FILE_NAME)


def do_generate_sdk_header():
  target_all_in_one_file_handle = open(os.path.join(g_out_dir, ORIGIN_SDK_INTERFACE_FILE_NAME), "w+")
  write_copyright(target_all_in_one_file_handle)

  for interface_file in g_api_files:
    name = os.path.basename(interface_file)
    include_file = '#include "' + name + '"\n'
    target_all_in_one_file_handle.write(include_file)
  target_all_in_one_file_handle.close()


def main():
  parser_in_and_out_argument()

  parser_low_level_api_files()

  #do_move_utils_files()

  do_move_and_replace_include_api_files()

  #do_move_and_replace_include_test_base_files()

  do_merge_impl_files()

  do_generate_sdk_header()

  print("\n")
  print("**************************")
  print("All files are successfully processed\n")


if __name__ == '__main__':
  sys.exit(main())
