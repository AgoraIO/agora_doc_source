# coding utf-8
# using Python 3.x
# Created by Lu Wang 2020-12-16
 
# ---------------------------------------------------------------------
# TODO: Need to process all dita files and provide a combined JSON file
# ---------------------------------------------------------------------
 
import xml.etree.ElementTree as ET
import json
from os import path
 
# -------------------------------------------------------------
# TODO: Need to resolve conrefs and keyrefs in dita files
# TODO: conrefs and keyrefs may exist in parameter descriptions,
# TODO: and return values
# -------------------------------------------------------------
 
# ------------------------------------------------------
# Parse the dita file to get information. Child's play.
# ------------------------------------------------------
 
working_dir = '/Users/jie/DITA/LwDITA-test'
file_dir = '/Users/jie/DITA/LwDITA-test/API/api_joinchannel.dita'
tree = ET.parse(file_dir)
root = tree.getroot()
 
# Iterate over all dita files
 
# ---------------------------------
# Replace keyrefs with actual names
# For example:
# <xref keyref="setClientRole"/>
# ---------------------------------
for xref in root.iter("xref"):
    # print(xref.get("keyref"))
    if xref.get("keyref") is not None:
        xref.text = str(xref.get("keyref"))
        # ET.SubElement(xref, "text")
 
# ----------------------------------------------------------------------------
# Implement all conrefs with the actual content
# For example:
# <p conref="../conref/conref_rtc_api.dita#apidef/onClientRoleChanged"> </p>
# ----------------------------------------------------------------------------
for child in root.iter('*'):
    if child.get("conref") is not None:
        conref = str(child.get("conref"))
        conref = conref.split("#")
        if "../" in str(conref[0]):
            new_working_dir = path.split(working_dir)
            print(new_working_dir[0])
            print(conref[0].replace("../", ""))
        conref_path = path.join(new_working_dir[0], str(conref[0]).replace("../", "").replace("/", "\\"))
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
        for text in section.iter():
            if text is not None:
                print(type(text))
                new_text = text.text
                # print(new_text)
                if new_text is not None:
                    detailed_desc = detailed_desc + new_text
 
 
print(detailed_desc)
detailed_desc_text = ""
 
for i in detailed_desc:
    detailed_desc_text = detailed_desc_text + i
 
print("----------------------- Detailed desc ------------------------")
print(detailed_desc_text)
print("----------------------- Detailed desc ------------------------")
 
api_desc = short_desc + detailed_desc_text
 
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