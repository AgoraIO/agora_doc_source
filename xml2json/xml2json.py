# coding utf-8
# using Python 3.x
# Created by Lu Wang 2020-12-16

# ---------------------------------------------------------------------
# TODO: Need to process all dita files and provide a combined JSON file
# ---------------------------------------------------------------------

import xml.etree.ElementTree as ET
import json
from os import path

import sys


# -------------------------------------------------------------
# TODO: Need to resolve conrefs and keyrefs in dita files
# TODO: conrefs and keyrefs may exist in parameter descriptions,
# TODO: and return values
# -------------------------------------------------------------

# ------------------------------------------------------
# Parse the dita file to get information. Child's play.
# ------------------------------------------------------

working_dir = 'C:\\Users\\WL\\Documents\\lwdita_latest'
file_dir = 'C:\\Users\\WL\\Documents\\lwdita_latest\\API\\api_mutelocalvideostream.dita'
tree = ET.parse(file_dir)
root = tree.getroot()

# Iterate over all dita files

# -----------------------------------------
# Replace xref -> keyrefs with actual names
# For example:
# <xref keyref="setClientRole"/>
# -----------------------------------------
# for xref in root.iter("xref"):
#     # print(xref.get("keyref"))
#     if xref.get("keyref") is not None:
#         xref.text = str(xref.get("keyref"))
#         # ET.SubElement(xref, "text")

# ----------------------------------------------------------------------------
# Implement all conrefs with the actual content
# For example:
# <p conref="../conref/conref_rtc_api.dita#apidef/onClientRoleChanged"> </p>
# Depends on the relative location of conref
# ----------------------------------------------------------------------------
for child in root.iter('*'):
    if child.get("conref") is not None:
        conref = str(child.get("conref"))
        conref = conref.split("#")
        if "../" in str(conref[0]):
            new_working_dir = path.normpath(working_dir)
            # print(new_working_dir[0])
            # print(conref[0].replace("../", ""))
        if sys.platform == 'darwin':
            print("macOS")
            conref_path = path.join(new_working_dir, str(conref[0]).replace("../", ""))
        elif sys.platform == 'win32':
            print("Windows")
            conref_path = path.join(new_working_dir, str(conref[0]).replace("../", "").replace("/", "\\"))
        print(" ---------------------- Get the conref path ----------------------------")
        print(conref_path)
        print(" ---------------------- Get the conref path ----------------------------")
        # ---------------------------------------------------------------------------------------------------
        # Read the referenced dita file and get the content
        # ---------------------------------------------------------------------------------------------------
        dita_file_tree = ET.parse(conref_path)
        dita_file_root = dita_file_tree.getroot()
        print(str(conref[1]))

        xpath_list = str(conref[1]).split("/")
        last_id = xpath_list[-1]
        # Get the last ID
        print(" ---------------------- Last ID ----------------------------")
        print(last_id)
        print(" ---------------------- Last ID ----------------------------")

        # Find tag by id
        dita_ref_text = ""
        for dita_tag in dita_file_root.iter('*'):
            # print(str(dita_tag.get("id")))
            # print(last_id)
            if dita_tag is not None:
                if str(dita_tag.get("id")) == str(last_id):
                    print(dita_tag)
                    for tag in dita_tag.iter():
                        print(tag)
                        dita_ref_text = dita_ref_text + dita_tag.text

        print("------------------- Dita ref text -----------------------")
        print(dita_ref_text)
        print("------------------- Dita ref text -----------------------")

        # Inject text to the original conref
        child.text = dita_ref_text
        print("------------------- Final change -----------------------")
        print(child.text)
        print("------------------- Final change -----------------------")


# TODO: Implement API name keyrefs
# Tags can be like <apiname keyref="addInjectStreamUrl"/> and <xref keyref="setChannelProfile"/>
# The keys are defined in ditamap files such as:
# Android: ../config/keys-rtc-android-api.ditamap
# CPP: ../config/keys-rtc-cpp-api.ditamap
# Rust: ../config/keys-rtc-rust-api.ditamap
# ---------------------------------------------------------------------------
# TODO: Use args to determine the platform
# -- android
# -- cpp
# -- rust
# ...
# ---------------------------------------------------------------------------

# Get path of ditamap files that contain refs
android_path = "config/keys-rtc-android-api.ditamap"
cpp_path = "config/keys-rtc-cpp-api.ditamap"
rust_path = "config/keys-rtc-rust-api.ditamap"
if sys.platform == 'darwin':
    print("macOS")
    android_full_path = path.join(working_dir, android_path)
    cpp_full_path = path.join(working_dir, cpp_path)
    rust_full_path = path.join(working_dir, rust_path)
elif sys.platform == 'win32':
    print("Windows")
    android_full_path = path.join(working_dir, android_path.replace("/", "\\"))
    cpp_full_path = path.join(working_dir, cpp_path.replace("/", "\\"))
    rust_full_path = path.join(working_dir, rust_path.replace("/", "\\"))

print(android_full_path)
print(cpp_full_path)
print(rust_full_path)

# Get keyword from keydef in ditamap files
#     <keydef keys="onClientRoleChanged" href="../API/onClientRoleChanged.dita">
#         <topicmeta>
#             <keywords>
#                 <keyword>onClientRoleChanged</keyword>
#             </keywords>
#         </topicmeta>
#     </keydef>
#
#
#
# <apiname keyref="addInjectStreamUrl"/> for each API category
#
# CPP
for apiname in root.iter("apiname"):
    # print(xref.get("keyref"))
    # For each xref, perform the following operations:
    # 1. Get the ditamap file per platform
    # 2. Extract href text from ditamap
    # 3. Set href text in current dita
    href_text = ""
    if apiname.get("keyref") is not None:
        # xref.text = str(xref.get("keyref"))
        # ET.SubElement(xref, "text")
        dita_file_tree = ET.parse(cpp_full_path)
        dita_file_root = dita_file_tree.getroot()
        for keydef in dita_file_root.iter("keydef"):
            if keydef.get("keys").strip() == apiname.get("keyref").strip():
                href_text = "".join(keydef.itertext()).strip()
        print("----------------------apiname text--------------------")
        print(href_text.strip())
        print("----------------------apiname text--------------------")
        apiname.text = href_text.strip()
        print(apiname.text)

# Android

# Rust

# Get href from keydef in ditamap files
#     <keydef keys="onClientRoleChanged" href="../API/onClientRoleChanged.dita">
#         <topicmeta>
#             <keywords>
#                 <keyword>onClientRoleChanged</keyword>
#             </keywords>
#         </topicmeta>
#     </keydef>
#
# <xref keyref="setChannelProfile"/> for each API category

# CPP
for xref in root.iter("xref"):
    # print(xref.get("keyref"))
    # For each xref, perform the following operations:
    # 1. Get the ditamap file per platform
    # 2. Extract href text from ditamap
    # 3. Set href text in current dita
    href_text = ""
    if xref.get("keyref") is not None:
        # xref.text = str(xref.get("keyref"))
        # ET.SubElement(xref, "text")
        dita_file_tree = ET.parse(cpp_full_path)
        dita_file_root = dita_file_tree.getroot()
        for keydef in dita_file_root.iter("keydef"):
            if keydef.get("keys") == xref.get("keyref"):
                href_text = keydef.get("href")
        print("----------------------href text--------------------")
        print(href_text)
        print("----------------------href text--------------------")

        if sys.platform == 'darwin':
            print("macOS")
            dir = path.join(working_dir, href_text).replace("../", "")
        elif sys.platform == 'win32':
            print("Windows")
            dir = path.join(working_dir, href_text).replace("../", "").replace("/", "\\")
        print(dir)
        dita_file_tree = ET.parse(dir)
        dita_file_root = dita_file_tree.getroot()
        # Get title
        title = dita_file_root.find("./title")
        title_ph = dita_file_root.find("./title/ph")
        print(title)
        if title.text is not None:
            title_text = title.text
        elif title_ph.get("keyref") is not None:
            dita_file_tree = ET.parse(cpp_full_path)
            dita_file_root = dita_file_tree.getroot()
            for keydef in dita_file_root.iter("keydef"):
                if keydef.get("keys").strip() == title_ph.get("keyref").strip():
                    title_text = "".join(keydef.itertext()).strip()

        print("----------------------title text--------------------")
        print(title_text)
        print("----------------------title text--------------------")
        xref.text = title_text
        print(xref.text)

        print(ET.tostring(root, 'utf-8', method="xml"))
# Android


# Rust


# Get the following information
# API ID (reference id = "xxx")
# Short description (shortdesc)
# Detailed description ()
# Parameter description
# Return value

# Get API ID
api_id = root.attrib
api_id = api_id.get("id")
print("----------------------- App ID ------------------------")
print(api_id)
print("----------------------- App ID ------------------------")

# Get short description
short_desc = root.find('shortdesc')
short_desc = short_desc.text
if short_desc is None:
    short_desc = "Empty"
print("----------------------- Short desc ------------------------")
print(short_desc)
print("----------------------- Short desc ------------------------")

# Get detailed description
detailed_desc = ""
for section in root.findall('./refbody/section'):
    # print(section)
    if section.get("id") == "detailed_desc":
        for text in section.itertext():
            if text is not None:
                print(type(text))
                # new_text = text.text
                # print(new_text)
                #if new_text is not None:
                detailed_desc = detailed_desc + text

detailed_desc = detailed_desc.strip()
print(detailed_desc)
#detailed_desc_text = ""

#for i in detailed_desc:
    #detailed_desc_text = detailed_desc_text + i

print("----------------------- Detailed desc ------------------------")
print(detailed_desc)
print("----------------------- Detailed desc ------------------------")

api_desc = short_desc + detailed_desc

# Get parameter description <plentry> by id
# parameter name <pt>
# parameter description <pd>
# Use a dictionary for param/desc pair
param_pair = {}
param_name = ""
param_desc = ""
for param_list in root.findall('./refbody/section/parml'):
    # print(section)
    # For each <plentry> in <parml>, get <pt> and <pd>
    if param_list.get("id") != "return_values":
        for child in param_list:
            param_name = child.find("pt").text
            for text in child.find("pd").iter():
                if text is not None:
                    new_text = text.text
                    # print(new_text)
                    if new_text is not None:
                        param_desc = param_desc + new_text
            param_pair[param_name] = param_desc

print(param_pair)

json_array = []
for key, value in param_pair.items():
    # Append a new dictionary separating keys and values from the original dictionary to the array:
    json_array.append({key: value})
print(json_array)

# Get return value
# No need to tell each return value
# Get return value
return_values = ""
for section in root.findall('./refbody/section'):
    print(section)
    if section.get("id") == "return_values":
        for text in section.itertext():
            print(text)
            return_values = return_values + text

print("----------------------- Return values ------------------------")
print(return_values)
print("----------------------- Return values ------------------------")

# ------------------------------------------------------------------
# Migrate the information to a JSON file.
# ------------------------------------------------------------------
# See the following template
# {
#   "id": "",
#   "description": "",
#   "parameters": [
#     {"param1": "desc"},
#     {"param2": "desc"}
#   ],
#   "returns": ""
# }


data = {}

data['id'] = api_id
data['description'] = api_desc
data['parameters'] = json_array
data['returns'] = return_values

print(data)

with open('interface.json', 'w', encoding="utf-8") as outfile:
    json.dump(data, outfile)
