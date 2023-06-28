#!/usr/local/bin/python3
# -*- coding: utf-8 -*-
import re
from typing import Generator
import xml.etree.ElementTree as ET
import json
from os import path
import os
import logging
import sys

import argparse

# ------------------------------------------------------
# CLI for automation purposes
# ------------------------------------------------------
# python xml2json.py --working-dir C:\\Users\\WL\\Documents\\G
# itHub\\doc_source\\en-US\\dita\\RTC --platform-tag=flutter --json-file=flutter_newer.json --sdk-type=sdk --remove-s
# dk-type=sdk-ng --defined-path=flutter_full_path

working_dir = ''
platform_tag = ''
json_file = ''
sdk_type = ''
remove_sdk_type = ''

defined_path_text = ''

parser = argparse.ArgumentParser(description="JSON generator")

parser.add_argument("--working_dir",
                    help="Your working dir, such as C:\\Users\\WL\\Documents\\GitHub\\doc_source\\en-US\\dita\\RTC",
                    action="store")
parser.add_argument("--platform_tag", help="Your platform tag, such as flutter", action="store")
parser.add_argument("--json_file", help="Your json file name, such as flutter_interface_new.json", action="store")
parser.add_argument("--sdk_type", help="Your SDK type: sdk or sdk-ng", action="store")
parser.add_argument("--remove_sdk_type", help="Your remove SDK type: sdk or sdk-ng", action="store")
parser.add_argument("--defined_path", help="Your defined path, such as android, flutter, electron_ng", action="store")
parser.add_argument("--log_level", help="Log level for outputs. Set to debug, info or warning", default="info", action="store")
args = vars(parser.parse_args())

working_dir = args['working_dir']
platform_tag = args['platform_tag']
json_file = args['json_file']
sdk_type = args['sdk_type']
remove_sdk_type = args['remove_sdk_type']

localLogger = logging

def switchLog(lang):
    if lang == "debug":
        logging.Logger.setLevel(logging.root, logging.DEBUG)
    elif lang == "warning":
        logging.Logger.setLevel(logging.root, logging.WARNING)
    else: # including "info"
        logging.Logger.setLevel(logging.root, logging.INFO)

switchLog(args['log_level'])

defined_path_text = args['defined_path']

# ------------------------------------------------------
# CLI for automation purposes
# ------------------------------------------------------

# ------------------------------------------------------
# Parse the dita file to get information. Child's play.
# ------------------------------------------------------

# TODO: !!!!!!!!!!!!!!!!!!!!!!!!!  Set your working path here !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# working_dir = 'C:\\Users\\WL\\Documents\\GitHub\\doc_source\\en-US\\dita\\RTC'

# working_dir = 'C:\\Users\\WL\\Documents\\GitHub\\doc_source\\dita\\RTC'
# file_dir = ''

# TODO: !!!!!!!!!!!!!!!!!!!!!!!!!  Set your PLATFORM TAG here !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# platform_tag = "flutter"

# TODO: !!!!!!!!!!!!!!!!!!!!!!!!!  Set your JSON path here !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# json_file = "flutter_interface_new.json"

# TODO: !!!!!!!!!!!!!!!!!!!!!!!!!  Set your SDK here !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# sdk_type = "rtc-ng"
# remove_sdk_type = "rtc"
# sdk_type = "rtc"
# remove_sdk_type = "rtc-ng"
# Get path of ditamap files that contain refs
# These variables are used globally
# android_path, cpp_path, rust_full_path, electron_path
android_path = "config/keys-rtc-api-android.ditamap"
ios_ng_path = "config/keys-rtc-ng-api-ios.ditamap"
macos_ng_path = "config/keys-rtc-ng-api-macos.ditamap"
cpp_path = "config/keys-rtc-api-cpp.ditamap"
cpp_ng_path = "config/keys-rtc-ng-api-cpp.ditamap"
rust_path = "config/keys-rtc-api-rust.ditamap"
electron_path = "config/keys-rtc-api-electron.ditamap"
unity_path = "config/keys-rtc-api-unity.ditamap"
cs_path = "config/keys-rtc-api-cs.ditamap"
flutter_path = "config/keys-rtc-api-flutter.ditamap"
rn_path = "config/keys-rtc-api-rn.ditamap"
electron_ng_path = "config/keys-rtc-ng-api-electron.ditamap"
c_sharp_ng_path = "config/keys-rtc-ng-api-unity.ditamap"
flutter_ng_path = "config/keys-rtc-ng-api-flutter.ditamap"
rn_ng_path = "config/keys-rtc-ng-api-rn.ditamap"
unity_ng_path = "config/keys-rtc-ng-api-unity.ditamap"

if sys.platform == 'darwin' or sys.platform == 'linux':
    localLogger.debug("macOS")
    android_full_path = path.join(working_dir, android_path)
    cpp_full_path = path.join(working_dir, cpp_path)
    cpp_ng_full_path = path.join(working_dir, cpp_ng_path)
    rust_full_path = path.join(working_dir, rust_path)
    electron_full_path = path.join(working_dir, electron_path)
    unity_full_path = path.join(working_dir, unity_path)
    cs_full_path = path.join(working_dir, cs_path)
    flutter_full_path = path.join(working_dir, flutter_path)

    rn_full_path = path.join(working_dir, rn_path)
    electron_ng_full_path = path.join(working_dir, electron_ng_path)
    c_sharp_ng_full_path = path.join(working_dir, c_sharp_ng_path)
    flutter_ng_full_path = path.join(working_dir, flutter_ng_path)
    rn_ng_full_path = path.join(working_dir, rn_ng_path)
    unity_ng_full_path = path.join(working_dir, unity_ng_path)
    ios_ng_full_path = path.join(working_dir, ios_ng_path)
    macos_ng_full_path = path.join(working_dir, macos_ng_path)
    # Need to add electron??
elif sys.platform == 'win32':
    localLogger.debug("Windows")
    android_full_path = path.join(working_dir, android_path.replace("/", "\\"))
    ios_full_path = path.join(working_dir, ios_path.replace("/", "\\"))
    macos_full_path = path.join(working_dir, macos_path.replace("/", "\\"))
    cpp_full_path = path.join(working_dir, cpp_path.replace("/", "\\"))
    cpp_ng_full_path = path.join(working_dir, cpp_ng_path.replace("/", "\\"))
    rust_full_path = path.join(working_dir, rust_path.replace("/", "\\"))
    electron_full_path = path.join(working_dir, electron_path.replace("/", "\\"))
    unity_full_path = path.join(working_dir, unity_path.replace("/", "\\"))
    flutter_full_path = path.join(working_dir, flutter_path.replace("/", "\\"))

    rn_full_path = path.join(working_dir, rn_path.replace("/", "\\"))
    electron_ng_full_path = path.join(working_dir, electron_ng_path.replace("/", "\\"))
    c_sharp_ng_full_path = path.join(working_dir, c_sharp_ng_path.replace("/", "\\"))
    flutter_ng_full_path = path.join(working_dir, flutter_ng_path.replace("/", "\\"))
    rn_ng_full_path = path.join(working_dir, rn_ng_path.replace("/", "\\"))
    unity_ng_full_path = path.join(working_dir, unity_ng_path.replace("/", "\\"))
    # Need to add electron??

# localLogger.debug(android_full_path)
# localLogger.debug(cpp_full_path)
# localLogger.debug(cpp_full_path)
# localLogger.debug(rust_full_path)
# localLogger.debug(electron_full_path)
# localLogger.debug(unity_full_path)

# TODO: !!!!!!!!!!!!!!!!!!!!!!!!!  Set your defined path here !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

if defined_path_text == "flutter":
    defined_path = flutter_full_path
elif defined_path_text == "flutter-ng":
    defined_path = flutter_ng_full_path
elif defined_path_text == "electron":
    defined_path = electron_full_path
elif defined_path_text == "electron-ng":
    defined_path = electron_ng_full_path
elif defined_path_text == "unity":
    defined_path = unity_full_path
elif defined_path_text == "unity-ng":
    defined_path = unity_ng_full_path
elif defined_path_text == "rn":
    defined_path = rn_full_path
elif defined_path_text == "rn-ng":
    defined_path = rn_ng_full_path
elif defined_path_text == "cpp":
    defined_path = cpp_full_path
elif defined_path_text == "cpp-ng":
    defined_path = cpp_ng_full_path
elif defined_path_text == "cs":
    defined_path = cs_full_path
elif defined_path_text == "ios-ng":
    defined_path = ios_ng_full_path
elif defined_path_text == "macos-ng":
    defined_path = macos_ng_full_path
#
# defined_path = android_full_path
# defined_path = cpp_full_path
# defined_path = c_sharp_full_path


# rust_full_path
# cpp_full_path
# Other types of full path
rust_topicref_list = []
json_hide_id_list = []
try:
    dita_file_tree = ET.parse(defined_path)
except Exception as ex:
    localLogger.error("Woops!\n")
    localLogger.error("It most likely an error occur when parsing the xml file: {}\n".format(defined_path))
    localLogger.error("The exception detail show below:\n")
    localLogger.error(ex)
    raise ex

dita_file_root = dita_file_tree.getroot()
for topicref in dita_file_root.iter("keydef"):
    if topicref.get("href") is not None:
        path_new = path.basename(topicref.get("href"))
        localLogger.debug(path_new)
        rust_topicref_list.append(path_new)

localLogger.info("--------------- Topic ref list ------------------------")
localLogger.info(rust_topicref_list)
localLogger.info("--------------- Topic ref list ------------------------")

# Collect the hide API which mark props="hide" or "cn" in <topichead> or <keydef>
for topichead in dita_file_root.iter("topichead"):
    is_hide_topichead: bool = True if topichead.get("props") is not None and topichead.get("props") == "hide" or topichead.get("props") is not None and topichead.get("props") == "cn" else False

    for keydef in topichead.iter("keydef"):
        if keydef.get("href") is not None:
            dita_id = path.basename(keydef.get("href")).replace(".dita", "")
            if is_hide_topichead:
                json_hide_id_list.append(dita_id)
            elif keydef.get("props") is not None and (keydef.get("props") == "hide" or keydef.get("props") == "cn"):
                json_hide_id_list.append(dita_id)


localLogger.info("--------------- Hide id list ------------------------")
localLogger.info(json_hide_id_list)
localLogger.info("--------------- Hide id list ------------------------")

# Target platform

# List of platforms
props_platform_list = ["windows", "rust", "java", "python", "csharp", "objectivec"]


def combine_text_sections(base_text: str, sections: Generator[str, None, None]) -> str:
    """
    Concatenates text sections into a base text, adding spaces where appropriate.

    Args:
        base_text (str): The base text to which the sections will be added.
        sections (Generator[str, None, None]): A generator that yields text sections.

    Returns:
        str: The resulting text after adding the sections to the base text.

    Example:
        >>> base = "Hello,"
        >>> sections = ["how ", "are", " you?"]
        >>> result = combine_text_sections(base, sections)
        >>> print(result)
        Hello, how are you?
    """
    for text in sections:
        if text.rstrip():
            t_strip = text.rstrip()
            if not base_text:
                t_strip = text.strip()
            if base_text and base_text[-1] not in [" ", "("] and t_strip[0] not in [" ", ",", ".", ";", ")", "\n"]:
                base_text += " "
            base_text += t_strip
    return base_text

def create_json_from_xml(working_dir, file_dir, android_path, cpp_path, rust_path, platform="rust"):

    text = ""

    with open(file_dir, "r", encoding='utf-8') as f:
        text= f.read()
        text = re.sub('>\s+(?=<)', '>', text)

        #text = re.sub('<ph',' <ph', text)
        #text = re.sub('<apiname',' <apiname', text)
        #text = re.sub('<codeph',' <codeph', text)
        #text = re.sub('<parmname',' <parmname', text)  

    with open(file_dir, "w", encoding='utf-8') as f:
        f.write(text)

    localLogger.info("-------------Parsing file in " + file_dir + " -----------------------")
    tree = ET.parse(file_dir)
    root = tree.getroot()

    # Iterate over all dita files
    #
    # --------------------------------------------------------------------------------------------------------------------
    # Replace xref -> keyrefs with actual names
    # For example:
    # <xref keyref="setClientRole"/>
    # ------------------------------------------------------------------------------------------------------------------------
    # for xref in root.iter("xref"):
    #     # localLogger.debug(xref.get("keyref"))
    #     if xref.get("keyref") is not None:
    #         xref.text = str(xref.get("keyref"))
    #         # ET.SubElement(xref, "text")
    # -----------------------------------------------------------------------------------------------------------------------------
    # Wow Wow
    # Pre-process the files to make sure that tags with props = "" in which the value is not consistent with the current platform
    # For example, if the current platform is "rust", and we have values in props other than "rust", the whole tag will be removed.
    # Currently hard-coded to rust. Will have more in the long run.
    #
    # There's no direct support in the form of a parent attribute, but you can perhaps use the patterns described here to achieve the desired effect.
    # The following one-liner is suggested (updated from the linked-to post to Python 3.8) to create a child-to-parent mapping for a whole tree,
    # using the method xml.etree.ElementTree.Element.iter:
    #
    # parent_map = {c: p for p in tree.iter() for c in p}
    # Tag filtering 01, there is a second copy ahead
    # When you update this code, remember copy the code to 02!!!!!!!!!!!!!!!!!!!!!!!
    parent_map = {c: p for p in tree.iter() for c in p}
    for child in root.iter('*'):
         if child.get("props") is not None:
             # if platform_tag not in child.get("props") and "native" not in child.get("props") or remove_sdk_type in child.get("props") or platform_tag not in child.get("props") and "native" in child.get("props") and platform_tag != "windows" and platform_tag != "macos" and platform_tag != "android" and platform_tag != "ios":
            if platform_tag not in child.get("props") and "native" not in child.get(
                    "props") and "framework" not in child.get("props") and child.get("props") != "rtc" and child.get("props") != "rtc-ng" or remove_sdk_type in child.get("props") or platform_tag not in child.get(
                     "props") and "native" in child.get(
                 "props") and platform_tag != "cpp" and platform_tag != "macos" and platform_tag != "android" and platform_tag != "ios" and child.get("props") != "rtc" and child.get("props") != "rtc-ng" or child.get("props") == "hide" or child.get("props") == "cn":
                 localLogger.debug("------------------- Tag to remove ---------------------------")
                 localLogger.debug(child)
                 localLogger.debug(child.text)
                 localLogger.debug(child.tag)
                 localLogger.debug(child.get("id"))
                 localLogger.debug("--------------------Tag to remove ---------------------------")
                 # clear()
                 # Resets an element. This function removes all subelements, clears all attributes, and sets the text and tail attributes to None.
                 # child.clear()
                 parent_map[child].remove(child)
                 # child.text = ""

    # Remove all tables because we cannot afford to add tables to code
    for child in root.iter('*'):
        if child.tag == "table":
            localLogger.debug("------------------- Tag to remove ---------------------------")
            localLogger.debug(child)
            localLogger.debug(child.text)
            localLogger.debug(child.tag)
            localLogger.debug(child.get("id"))
            localLogger.debug("--------------------Tag to remove ---------------------------")
            parent_map[child].remove(child)
    #
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
                # localLogger.debug(new_working_dir[0])
                # localLogger.debug(conref[0].replace("../", ""))
            if sys.platform == 'darwin' or sys.platform == 'linux':
                localLogger.debug("macOS")
                conref_path = path.join(new_working_dir, str(conref[0]).replace("../", ""))

            elif sys.platform == 'win32':
                localLogger.debug("Windows")
                conref_path = path.join(new_working_dir, str(conref[0]).replace("../", "").replace("/", "\\"))
            localLogger.debug(" ---------------------- Get the conref path ----------------------------")
            localLogger.debug(conref_path)
            localLogger.debug(" ---------------------- Get the conref path ----------------------------")
            # ---------------------------------------------------------------------------------------------------
            # Read the referenced dita file and get the content
            # ---------------------------------------------------------------------------------------------------
            dita_file_tree = ET.parse(conref_path)
            dita_file_root = dita_file_tree.getroot()
            localLogger.debug(str(conref[1]))

            xpath_list = str(conref[1]).split("/")
            last_id = xpath_list[-1]
            # Get the last ID
            localLogger.debug(" ---------------------- Last ID ----------------------------")
            localLogger.debug(last_id)
            localLogger.debug(" ---------------------- Last ID ----------------------------")

            # Find tag by id
            dita_ref_text = ""
            for dita_tag in dita_file_root.iter('*'):
                # localLogger.debug(str(dita_tag.get("id")))
                # localLogger.debug(last_id)
                if dita_tag is not None:
                    if str(dita_tag.get("id")) == str(last_id):
                        localLogger.debug(dita_tag)
                        for tag in dita_tag.iter():
                            localLogger.debug(tag)
                            dita_ref_text = dita_ref_text + dita_tag.text

            localLogger.debug("------------------- Dita ref text -----------------------")
            localLogger.debug(dita_ref_text)
            localLogger.debug("------------------- Dita ref text -----------------------")

            # Inject text to the original conref
            child.text = dita_ref_text
            localLogger.debug("------------------- Final change -----------------------")
            localLogger.debug(child.text)
            localLogger.debug("------------------- Final change -----------------------")

    # ----------------------------------------------------------------------------
    #     # Implement all conkeyrefs with the actual content 01, 02, 03 and 04
    #     # For example:
    #     # <ph conkeyref="createAgoraRtcEngine1/shortdesc"/>
    #     # It is first a keyref then a conref
    #     # Conkeyrefs should be replaced at the element level!!!!!!!!!
    # ----------------------------------------------------------------------------
    i = 4
    while i > 0:
        for child in root.iter('*'):
            if child.get("conkeyref") is not None:
                conkeyref = str(child.get("conkeyref"))
                localLogger.debug("Conkeyref is " + conkeyref)
                conkeyref_array = conkeyref.split("/")
                # key
                key = conkeyref_array[0]
                # ref
                if len(conkeyref_array) > 1:
                    ref = conkeyref_array[1]
                else:
                    ref = ""
                # Assume that a conkeyref contains only two levels
                dita_file_tree = ET.parse(defined_path)
                dita_file_root = dita_file_tree.getroot()
                href_text = ""
                for keydef in dita_file_root.iter("keydef"):
                    if keydef.get("keys") == key:
                        href_text = keydef.get("href")
                localLogger.debug("----------------------href text--------------------")
                localLogger.debug(href_text)
                localLogger.debug("----------------------href text--------------------")

                final_parent = child

                # Get the parent old child
                for parent in root.iter('*'):
                    for d in parent.iterfind(child.tag):
                        if d is child:
                            final_parent = parent

                if sys.platform == 'darwin' or sys.platform == 'linux':
                    localLogger.debug("macOS")
                    if href_text:
                        dir = path.join(working_dir, href_text).replace("../", "")
                        dir = path.join("..", dir)
                    else:
                        dir = None
                elif sys.platform == 'win32':
                    localLogger.debug("Windows")
                    if href_text is not None and href_text != "":
                        dir = path.join(working_dir, href_text).replace("../", "").replace("/", "\\")
                    else:
                        dir = None
                if dir is not None:
                    localLogger.debug(dir)
                    new_dita_file_tree = ET.parse(dir)
                    new_dita_file_root = new_dita_file_tree.getroot()
                    # Find the keyref
                    for new_child in new_dita_file_root.iter('*'):
                        if new_child.get("id") == ref:
                            localLogger.debug("------------ Found a match for conkeyref -----------------")
                            localLogger.debug(ref)
                            localLogger.debug("------------ Found a match for conkeyref-----------------")
                            # Set the node from new child to old child
                            final_parent.insert(0, new_child)
                            final_parent.remove(child)

                    localLogger.debug("----------------------conkeyref text--------------------")
                    localLogger.debug(child)
                    localLogger.debug("----------------------conkeyref text--------------------")
        i -= 1

    # TODO: Implement API name keyrefs
    # Tags can be like <apiname keyref="addInjectStreamUrl"/> and <xref keyref="setChannelProfile"/>
    # The keys are defined in ditamap files such as:
    # Android: ../config/keys-rtc-api-android.ditamap
    # CPP: ../config/keys-rtc-api-cpp.ditamap
    # Rust: ../config/keys-rtc-api-rust.ditamap
    # ---------------------------------------------------------------------------
    # TODO: Use args to determine the platform
    # -- android
    # -- cpp
    # -- rust
    # ...
    # ---------------------------------------------------------------------------

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
        # localLogger.debug(xref.get("keyref"))
        # For each xref, perform the following operations:
        # 1. Get the ditamap file per platform
        # 2. Extract href text from ditamap
        # 3. Set href text in current dita
        href_text = ""
        if apiname.get("keyref") is not None:
            # xref.text = str(xref.get("keyref"))
            # ET.SubElement(xref, "text")
            # dita_file_tree = ET.parse(defined_path)
            dita_file_tree = ET.parse(defined_path)
            dita_file_root = dita_file_tree.getroot()
            for keydef in dita_file_root.iter("keydef"):
                if keydef.get("keys").strip() == apiname.get("keyref").strip():
                    href_text = "".join(keydef.itertext()).strip()
            localLogger.debug("----------------------apiname text--------------------")
            localLogger.debug(href_text.strip())
            localLogger.debug("----------------------apiname text--------------------")
            apiname.text = href_text.strip()
            localLogger.debug(apiname.text)

    for apiname in root.iter("parmname"):
        # localLogger.debug(xref.get("keyref"))
        # For each xref, perform the following operations:
        # 1. Get the ditamap file per platform
        # 2. Extract href text from ditamap
        # 3. Set href text in current dita
        href_text = ""
        if apiname.get("keyref") is not None:
            # xref.text = str(xref.get("keyref"))
            # ET.SubElement(xref, "text")
            # dita_file_tree = ET.parse(defined_path)
            dita_file_tree = ET.parse(defined_path)
            dita_file_root = dita_file_tree.getroot()
            for keydef in dita_file_root.iter("keydef"):
                if keydef.get("keys").strip() == apiname.get("keyref").strip():
                    href_text = "".join(keydef.itertext()).strip()
            localLogger.debug("----------------------parmname text--------------------")
            localLogger.debug(href_text.strip())
            localLogger.debug("----------------------parmname text--------------------")
            apiname.text = href_text.strip()
            localLogger.debug(apiname.text)

    for pt in root.iter("ph"):
        # localLogger.debug(xref.get("keyref"))
        # For each xref, perform the following operations:
        # 1. Get the ditamap file per platform
        # 2. Extract href text from ditamap
        # 3. Set href text in current dita
        href_text = ""
        if pt.get("keyref") is not None:
            # xref.text = str(xref.get("keyref"))
            # ET.SubElement(xref, "text")
            # dita_file_tree = ET.parse(defined_path)
            dita_file_tree = ET.parse(defined_path)
            dita_file_root = dita_file_tree.getroot()
            for keydef in dita_file_root.iter("keydef"):
                if keydef.get("keys").strip() == pt.get("keyref").strip():
                    href_text = "".join(keydef.itertext()).strip()
            localLogger.debug("----------------------pt text--------------------")
            localLogger.debug(href_text.strip())
            localLogger.debug("----------------------pt text--------------------")
            pt.text = href_text.strip()
            localLogger.debug(pt.text)

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

    # xref with keyref
    for xref in root.iter("xref"):
        # localLogger.debug(xref.get("keyref"))
        # For each xref, perform the following operations:
        # 1. Get the ditamap file per platform
        # 2. Extract href text from ditamap
        # 3. Set href text in current dita
        href_text = ""
        if xref.get("keyref") is not None:
            # TODO: Change xref keyref bits
            # xref.text = str(xref.get("keyref"))
            # ET.SubElement(xref, "text")
            # dita_file_tree = ET.parse(defined_path)
            dita_file_tree = ET.parse(defined_path)
            dita_file_root = dita_file_tree.getroot()
            for keydef in dita_file_root.iter("keydef"):
                if keydef.get("keys") == xref.get("keyref"):
                    # TODO: At the right map level, fetch href
                    # keydef.get("href") -> "../API/api_imediaplayercachemanager_getmaxcachefilesize.dita"
                    # open that file, find matching codeblock text for obj-c
                    for text in keydef.itertext():
                        href_text = href_text + text.strip()
                    xref.text = href_text
                href_text = ""

            if sys.platform == 'darwin' or sys.platform == 'linux':
                localLogger.debug("macOS")
                if href_text is not None and href_text != "" and not href_text.startswith("http"):
                    dir = path.join(working_dir, href_text).replace("../", "")
                    dir = path.join("..", dir)
                elif href_text is not None and href_text.startswith("http"):
                    xref.text = href_text
                    dir = None
                    localLogger.debug(xref.text)
                else:
                    dir = None
            elif sys.platform == 'win32':
                localLogger.debug("Windows")
                if href_text is not None and href_text != "" and not href_text.startswith("http"):
                    dir = path.join(working_dir, href_text).replace("../", "").replace("/", "\\")
                elif href_text is not None and href_text.startswith("http"):
                    xref.text = href_text
                    dir = None
                    localLogger.debug(xref.text)
                else:
                    dir = None
            """
            if dir is not None:
                localLogger.debug(dir)
                dita_file_tree = ET.parse(dir)
                dita_file_root = dita_file_tree.getroot()
                # Get title
                title = dita_file_root.find("./title")
                title_ph = dita_file_root.find("./title/ph")
                localLogger.debug(title)
                if title.text is not None:
                    title_text = title.text
                elif title_ph.get("keyref") is not None:
                    # dita_file_tree = ET.parse(defined_path)
                    dita_file_tree = ET.parse(defined_path)
                    dita_file_root = dita_file_tree.getroot()
                    for keydef in dita_file_root.iter("keydef"):
                        if keydef.get("keys").strip() == title_ph.get("keyref").strip():
                            title_text = "".join(keydef.itertext()).strip()

                localLogger.debug("----------------------title text--------------------")
                localLogger.debug(title_text)
                localLogger.debug("----------------------title text--------------------")
                xref.text = title_text
                localLogger.debug(xref.text)  """


        # xref with href
        # Example:
        # <plentry id="0">
        #    <pt><ph keyref="REMOTE_VIDEO_STATE_STOPPED"/></pt>
        #    <pd>0: 远端视频默认初始状态。在 <xref href="enum_remotevideostatereason.dita#enum_remotevideostatereason/3"/>、 <xref href="enum_remotevideostatereason.dita#enum_remotevideostatereason/5"/> 或
        #    <xref href="enum_remotevideostatereason.dita#enum_remotevideostatereason/7"/> 的情况下，会报告该状态。</pd>
        # </plentry>
        if xref.get("href") is not None and not xref.get("href").startswith("http") and not xref.get("href").endswith(
                "md") and not xref.get("href").startswith("mailto"):
            href = xref.get("href")
            splitted = href.split("#")
            if len(splitted) >= 2:
                dita_file_tree = ET.parse(path.join(working_dir, "API", splitted[0]))
                localLogger.debug(splitted[0])
                dita_file_root = dita_file_tree.getroot()
                plentry_id_list = splitted[1].split("/")
                plentry_id = plentry_id_list[-1]
                localLogger.debug("------------WWWWWWWWWWWWWWWWWWWWWWWWWWWWW------------")
                localLogger.debug(plentry_id)
                localLogger.debug("------------WWWWWWWWWWWWWWWWWWWWWWWWWWWWW------------")
                # Get the element by path
                for plentry in dita_file_root.findall("./refbody/section/parml/plentry"):
                    if plentry.get("id") == plentry_id:
                        ph_tag = plentry.find("./pt/ph")
                        ph_tag_key = ph_tag.get("keyref")
                        localLogger.debug("------------WWWWWWWWWWWWWW  PH Tag KEY  WWWWWWWWWWWWWWW------------")
                        localLogger.debug(ph_tag_key)
                        localLogger.debug("------------WWWWWWWWWWWWWWWWW PH Tag KEY     WWWWWWWWWWWW------------")

                        dita_file_tree = ET.parse(defined_path)
                        dita_file_root = dita_file_tree.getroot()
                        for keydef in dita_file_root.iter("keydef"):
                            if keydef.get("keys") == ph_tag_key:
                                for text in keydef.itertext():
                                    if text is not None:
                                        localLogger.debug(type(text))
                                        # new_text = text.text
                                        # localLogger.debug(new_text)
                                        # if new_text is not None:
                                        href_text = href_text + text

                xref.text = href_text
                # xref.text = href_text
                # localLogger.debug(xref.text)

            else:
                # 请确保在调用其他 API 前先调用
                #                     <xref keyref="createAgoraRtcEngine1" />
                #                     和
                #                     <apiname keyref="create2" />
                #                     创建并初始化
                #                     <xref href="class_irtcengine.dita" />
                #                     。
                localLogger.debug("-------- Doom Wheel --------------")
                localLogger.debug(path.join(working_dir, "API", href))
                localLogger.debug("-------------Doom Wheel------------")
                dita_file_tree = ET.parse(path.join(working_dir, "API", href))
                dita_file_root = dita_file_tree.getroot()

                title = dita_file_root.find("./title/ph")
                if title.text is not None:
                    title_text = title.text
                elif title.get("keyref") is not None:
                    # dita_file_tree = ET.parse(defined_path)
                    dita_file_tree = ET.parse(defined_path)
                    dita_file_root = dita_file_tree.getroot()
                    for keydef in dita_file_root.iter("keydef"):
                        if keydef.get("keys").strip() == title.get("keyref").strip():
                            title_text = "".join(keydef.itertext())
                xref.text = title_text.strip()


        elif xref.get("href") is not None and xref.get("href").startswith("http"):
            xref.text = xref.text + " (" + xref.get("href") + ")"

            # Ref to a file
            # elif len(splitted) == 1:
            # dita_file_tree = ET.parse(path.join(working_dir, "API", splitted[0]))
            # dita_file_root = dita_file_tree.getroot()

    # Tag filtering 02
    # Do tag filtering again!!!!!!!!!!
    parent_map = {c: p for p in tree.iter() for c in p}
    for child in root.iter('*'):
         if child.get("props") is not None:
             # if platform_tag not in child.get("props") and "native" not in child.get("props") or remove_sdk_type in child.get("props") or platform_tag not in child.get("props") and "native" in child.get("props") and platform_tag != "windows" and platform_tag != "macos" and platform_tag != "android" and platform_tag != "ios":
            if platform_tag not in child.get("props") and "native" not in child.get(
                    "props") and "framework" not in child.get("props") and child.get("props") != "rtc" and child.get("props") != "rtc-ng" or remove_sdk_type in child.get("props") or platform_tag not in child.get(
                     "props") and "native" in child.get(
                 "props") and platform_tag != "cpp" and platform_tag != "macos" and platform_tag != "android" and platform_tag != "ios" and child.get("props") != "rtc" and child.get("props") != "rtc-ng":
                 localLogger.debug("------------------- Tag to remove ---------------------------")
                 localLogger.debug(child)
                 localLogger.debug(child.text)
                 localLogger.debug(child.tag)
                 localLogger.debug(child.get("id"))
                 localLogger.debug("--------------------Tag to remove ---------------------------")
                 # clear()
                 # Resets an element. This function removes all subelements, clears all attributes, and sets the text and tail attributes to None.
                 # child.clear()
                 parent_map[child].remove(child)
                 # child.text = ""

    # Tag filtering 03
    # Once a tagged element. So more elements, more processings...
    # Do tag filtering again!!!!!!!!!!
    for child in root.iter('*'):
         if child.get("props") is not None:
             # if platform_tag not in child.get("props") and "native" not in child.get("props") or remove_sdk_type in child.get("props") or platform_tag not in child.get("props") and "native" in child.get("props") and platform_tag != "windows" and platform_tag != "macos" and platform_tag != "android" and platform_tag != "ios":
            if platform_tag not in child.get("props") and "native" not in child.get(
                    "props") and "framework" not in child.get("props") and child.get("props") != "rtc" and child.get("props") != "rtc-ng" or remove_sdk_type in child.get("props") or platform_tag not in child.get(
                     "props") and "native" in child.get(
                 "props") and platform_tag != "cpp" and platform_tag != "macos" and platform_tag != "android" and platform_tag != "ios" and child.get("props") != "rtc" and child.get("props") != "rtc-ng":
                 localLogger.debug("------------------- Tag to remove ---------------------------")
                 localLogger.debug(child)
                 localLogger.debug(child.text)
                 localLogger.debug(child.tag)
                 localLogger.debug(child.get("id"))
                 localLogger.debug("--------------------Tag to remove ---------------------------")
                 # clear()
                 # Resets an element. This function removes all subelements, clears all attributes, and sets the text and tail attributes to None.
                 # child.clear()
                 parent_map[child].remove(child)
                 # child.text = ""

    # Tag filtering 04
    # Once a tagged element. So more elements, more processings...
    # Do tag filtering again!!!!!!!!!!
    parent_map = {c: p for p in tree.iter() for c in p}
    for child in root.iter('*'):
         if child.get("props") is not None:
             # if platform_tag not in child.get("props") and "native" not in child.get("props") or remove_sdk_type in child.get("props") or platform_tag not in child.get("props") and "native" in child.get("props") and platform_tag != "windows" and platform_tag != "macos" and platform_tag != "android" and platform_tag != "ios":
            if platform_tag not in child.get("props") and "native" not in child.get(
                    "props") and "framework" not in child.get("props") and child.get("props") != "rtc" and child.get("props") != "rtc-ng" or remove_sdk_type in child.get("props") or platform_tag not in child.get(
                     "props") and "native" in child.get(
                 "props") and platform_tag != "cpp" and platform_tag != "macos" and platform_tag != "android" and platform_tag != "ios" and child.get("props") != "rtc" and child.get("props") != "rtc-ng":
                 localLogger.debug("------------------- Tag to remove ---------------------------")
                 localLogger.debug(child)
                 localLogger.debug(child.text)
                 localLogger.debug(child.tag)
                 localLogger.debug(child.get("id"))
                 localLogger.debug("--------------------Tag to remove ---------------------------")
                 # clear()
                 # Resets an element. This function removes all subelements, clears all attributes, and sets the text and tail attributes to None.
                 # child.clear()
                 parent_map[child].remove(child)
                 # child.text = ""

    # Tag filtering 05
    # Once a tagged element. So more elements, more processings...
    # Do tag filtering again!!!!!!!!!!
    parent_map = {c: p for p in tree.iter() for c in p}
    for child in root.iter('*'):
         if child.get("props") is not None:
             # if platform_tag not in child.get("props") and "native" not in child.get("props") or remove_sdk_type in child.get("props") or platform_tag not in child.get("props") and "native" in child.get("props") and platform_tag != "windows" and platform_tag != "macos" and platform_tag != "android" and platform_tag != "ios":
            if platform_tag not in child.get("props") and "native" not in child.get(
                    "props") and "framework" not in child.get("props") and child.get("props") != "rtc" and child.get("props") != "rtc-ng" or remove_sdk_type in child.get("props") or platform_tag not in child.get(
                     "props") and "native" in child.get(
                 "props") and platform_tag != "cpp" and platform_tag != "macos" and platform_tag != "android" and platform_tag != "ios" and child.get("props") != "rtc" and child.get("props") != "rtc-ng":
                 localLogger.debug("------------------- Tag to remove ---------------------------")
                 localLogger.debug(child)
                 localLogger.debug(child.text)
                 localLogger.debug(child.tag)
                 localLogger.debug(child.get("id"))
                 localLogger.debug("--------------------Tag to remove ---------------------------")
                 # clear()
                 # Resets an element. This function removes all subelements, clears all attributes, and sets the text and tail attributes to None.
                 # child.clear()
                 parent_map[child].remove(child)
                 # child.text = ""            
                    
    # Tag filtering 06
    # Once a tagged element. So more elements, more processings...
    # Do tag filtering again!!!!!!!!!!
    parent_map = {c: p for p in tree.iter() for c in p}
    for child in root.iter('*'):
         if child.get("props") is not None:
             # if platform_tag not in child.get("props") and "native" not in child.get("props") or remove_sdk_type in child.get("props") or platform_tag not in child.get("props") and "native" in child.get("props") and platform_tag != "windows" and platform_tag != "macos" and platform_tag != "android" and platform_tag != "ios":
            if platform_tag not in child.get("props") and "native" not in child.get(
                    "props") and "framework" not in child.get("props") and child.get("props") != "rtc" and child.get("props") != "rtc-ng" or remove_sdk_type in child.get("props") or platform_tag not in child.get(
                     "props") and "native" in child.get(
                 "props") and platform_tag != "cpp" and platform_tag != "macos" and platform_tag != "android" and platform_tag != "ios" and child.get("props") != "rtc" and child.get("props") != "rtc-ng":
                 localLogger.debug("------------------- Tag to remove ---------------------------")
                 localLogger.debug(child)
                 localLogger.debug(child.text)
                 localLogger.debug(child.tag)
                 localLogger.debug(child.get("id"))
                 localLogger.debug("--------------------Tag to remove ---------------------------")
                 # clear()
                 # Resets an element. This function removes all subelements, clears all attributes, and sets the text and tail attributes to None.
                 # child.clear()
                 parent_map[child].remove(child)
                 # child.text = ""    

    # Adds newlines at the start of smaller 'li' sections
    for child in root.iter('li'):
        if child.text is not None and child.text.strip() is not None:
            child.text = '\n ' + child.text.strip()
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
    localLogger.debug("----------------------- App ID ------------------------")
    localLogger.debug(api_id)
    localLogger.debug("----------------------- App ID ------------------------")

    # Get API name
    api_name = ""
    api_name_tag = root.find("title")
    for q in api_name_tag.itertext():
        api_name = api_name + q
    localLogger.debug("----------------------- App Name ------------------------")
    localLogger.debug(api_name)
    localLogger.debug("----------------------- App Name ------------------------")

    # Get short description
    short_desc_text = ""
    short_desc = root.find('shortdesc')
    if short_desc is not None:
        short_desc_text = combine_text_sections(short_desc_text, short_desc.itertext())

    localLogger.debug("----------------------- Short desc ------------------------")
    localLogger.debug(short_desc_text)
    localLogger.debug("----------------------- Short desc ------------------------")

    # Get detailed description
    # Tables exist in pd and detailed desc. Need to process tables.
    detailed_desc = ""
    for section in root.findall('./refbody/section'):
        # localLogger.debug(section)
        if section.get("id") == "detailed_desc":
            title = section.find("./title")
            if title is not None:
                title.clear()
            detailed_desc = combine_text_sections(detailed_desc, section.itertext())

    # detailed_desc_text = ""

    # for i in detailed_desc:
    # detailed_desc_text = detailed_desc_text + i

    localLogger.debug("----------------------- Detailed desc ------------------------")
    localLogger.debug(detailed_desc)
    localLogger.debug("----------------------- Detailed desc ------------------------")

    if detailed_desc.strip():
        short_desc_text += "\n\n"
    api_desc = short_desc_text + detailed_desc

    # Get parameter description <plentry> by id
    # parameter name <pt>
    # parameter description <pd>
    # Use a dictionary for param/desc pair
    param_pair = {}
    param_name = ""
    param_desc = ""
    # Tables exist in pd and detailed desc. Need to process tables.
    for param_list in root.findall('./refbody/section/parml'):
        # localLogger.debug(section)
        # For each <plentry> in <parml>, get <pt> and <pd>
        # if param_list.get("id") != "return_values":
        for child in param_list:
            if child.find("pt") is not None:
                param_name = child.find("pt").text
                if param_name is None and child.find("./pt/ph") is not None:
                    param_name = child.find("./pt/ph").text

                elif child.text is not None:
                    localLogger.debug("Something unexpected happened for " + child.text)

                elif child.text is None:
                    localLogger.debug("No text for this node")
                    localLogger.debug(child)

                if child.find("./pd") is not None:
                    param_desc = combine_text_sections(param_desc, child.find("./pd").itertext())
                else:
                    param_desc = ""
                    localLogger.debug("The param desc tag is empty")


            param_pair[param_name] = param_desc
            # Clean the param_desc variable to get new values
            param_desc = ""

    localLogger.debug(param_pair)

    json_array = []
    for key, value in param_pair.items():
        # Append a new dictionary separating keys and values from the original dictionary to the array:
        json_array.append({key: value})
    localLogger.debug(json_array)

    # Get return value
    # No need to tell each return value
    # Get return value
    return_values = ""
    for section in root.findall('./refbody/section'):
        if section.get("id") == "return_values":
            title = section.find("./title")
            if title is not None:
                title.clear()
            return_values = combine_text_sections(return_values, section.itertext())

    localLogger.debug("----------------------- Return values ------------------------")
    localLogger.debug(return_values)
    localLogger.debug("----------------------- Return values ------------------------")

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
    # save name, remove "\n"
    data['name'] = api_name.rstrip("\n ").rstrip(" ")
    # save description, remove "\n" and trailing spaces
    data['description'] = api_desc.rstrip("\n ").rstrip(" ")
    # save parameters, remove "\n" and trailing spaces
    data['parameters'] = [
        {key.rstrip("\n ").rstrip(" ") if isinstance(key, str) and key is not None else key:
        value.rstrip("\n ").rstrip(" ") if isinstance(value, str) and value is not None else value}
        for param in json_array
        for key, value in param.items()
    ]
    # save returns, remove "\n" and trailing spaces
    data['returns'] = return_values.rstrip("\n ")

    # for the hidden apis and the resource-only apis whose names are left blank, hide them
    data['is_hide'] = True if api_id in json_hide_id_list or data['name'] == "" else False

    localLogger.info(data)

    file_name = path.basename(path.normpath(file_dir))
    name_list = file_name.split(".")
    json_name = name_list[0]

    # Write to JSON
    # Test only: ensure_ascii=False is only used for UTF-8 characters
    with open(path.join(path.dirname(__file__), "json_files", json_name + '.json'), 'w', encoding="utf-8") as outfile:
        json.dump(data, outfile, ensure_ascii=False, indent=4)


    # Call the function to create a single JSON file
    # create_json_from_xml(working_dir, file_dir)


# Clean the json_files folder
for root, dirs, files in os.walk(path.join(path.dirname(__file__), "json_files")):
    for file in files:
        os.remove(os.path.join(root, file))

for file_name in os.listdir(path.join(working_dir, 'API')):
    if file_name.endswith(
            ".dita") and file_name != "API-overview.dita" and file_name != "api_data_type.dita" and file_name in rust_topicref_list:
        create_json_from_xml(working_dir, path.join(working_dir, 'API', file_name), android_full_path, cpp_full_path,
                             rust_full_path)

# Join all files in the json_files folder
# List of json files to merge
files = list()
for json_name in os.listdir(path.join(path.join(path.dirname(__file__), "json_files"))):
    files.append(path.join(path.dirname(__file__), "json_files", json_name))

localLogger.info(files)


def merge_JsonFiles(files):
    result = list()

    for file in files:
        localLogger.info(file)
        with open(file, 'r', encoding="utf-8") as infile:
            append_content = json.load(infile)
            result.append(append_content)

    error = json.loads("{\"id\": \"enum_errorcode\", \"name\": \"ErrorCode\", \"description\": \"Error codes. See https://docs.agora.io/en/Interactive%20Broadcast/error_rtc.\", \"parameters\": [], \"returns\": \"\"}")

    warning = json.loads("{\"id\": \"enum_warningcode\", \"name\": \"WarningCode\", \"description\": \"Warning codes. See https://docs.agora.io/en/Interactive%20Broadcast/error_rtc.\", \"parameters\": [], \"returns\": \"\"}")

    result.append(error)
    result.append(warning)

    with open(json_file, 'w', encoding="utf-8") as output_file:
        json.dump(result, output_file, ensure_ascii=False, indent=4)




def replace_newline():

    input_file = open(json_file, 'r', encoding="utf-8")
    # 2022.1.17 Clean up \n and spaces
    file_text = input_file.read()

    replaced_file_text = re.sub('Themaintain', 'The maintain', file_text)
    replaced_file_text = re.sub('byx', 'by x', replaced_file_text)
    replaced_file_text = re.sub('withx', 'with x', replaced_file_text)
    replaced_file_text = re.sub('case of', 'case of ', replaced_file_text)
    replaced_file_text = re.sub(' when', ' when ', replaced_file_text)
    replaced_file_text = re.sub(' set to', ' set to ', replaced_file_text)
    replaced_file_text = re.sub(' or ', ' or   ', replaced_file_text)
    replaced_file_text = re.sub(' and ', ' and   ', replaced_file_text)
    replaced_file_text = re.sub(r':[\s]{0,100}"[\s]{0,100}\\n[\s]{0,100}', ': "', replaced_file_text)

    replaced_file_text = re.sub(r'[\s]{0,100}\\n[\s]{0,100}\\n[\s]{0,100}\\n', ' ', replaced_file_text)
    # These two removing double newlines, which are required to separate abstract and long description
    # They were patching bugs from not removing newlines between other sections.
    # replaced_file_text = re.sub(r'[\s]{0,100}\\n[\s]{0,100}\\n[\s]{0,100}', ' ', replaced_file_text)
    # replaced_file_text = re.sub(r'[\r\t\f\v ]{2,100}', ' ', replaced_file_text)

    replaced_file_text = re.sub(r' See[\s\\n]{0,50}\.', '', replaced_file_text)
    replaced_file_text = re.sub(r' For more information[A-Za-z\s\\n,]{0,100}\.', '', replaced_file_text)
    replaced_file_text = re.sub(r' For more details[A-Za-z\s\\n,]{0,50}\.', '', replaced_file_text)
    replaced_file_text = re.sub(r' For details[A-Za-z\s\\n,]{0,50}\.', '', replaced_file_text)
    replaced_file_text = re.sub(r':[\s]{0,10}"\\n[\s\\n]{0,50}', ':"', replaced_file_text)

    # ------------------ Special processing for Flutter classes ------------------------------------------
    replaced_file_text = re.sub('class_rtc_render_view_rtcsurfaceview', 'class_rtcsurfaceview', replaced_file_text)
    replaced_file_text = re.sub('rtc_render_view: RtcSurfaceView', 'RtcSurfaceView', replaced_file_text)

    replaced_file_text = re.sub('class_rtc_render_view_rtctextureview', 'class_rtctextureview', replaced_file_text)
    replaced_file_text = re.sub('rtc_render_view: RtcTextureView', 'RtcTextureView', replaced_file_text)

    replaced_file_text = re.sub('api_rtc_local_view_textureview_screen', 'api_rtclocaltextureview_screenshare', replaced_file_text)
    replaced_file_text = re.sub('rtc_local_view: TextureView.screenShare', 'screenShare', replaced_file_text)

    replaced_file_text = re.sub('api_rtc_local_view_surfaceview_screen', 'api_rtclocalsurfaceview_screenshare', replaced_file_text)
    replaced_file_text = re.sub('rtc_local_view: SurfaceView.screenShare', 'screenShare', replaced_file_text)

    replaced_file_text = re.sub('class_rtc_local_view_surfaceview', 'class_rtclocalsurfaceview', replaced_file_text)
    replaced_file_text = re.sub('rtc_local_view: SurfaceView', 'RtcLocalSurfaceView', replaced_file_text)

    replaced_file_text = re.sub('class_rtc_local_view_textureview', 'class_rtclocaltextureview', replaced_file_text)
    replaced_file_text = re.sub('rtc_local_view: TextureView', 'RtcLocalTextureView', replaced_file_text)

    replaced_file_text = re.sub('class_rtc_remote_view_textureview', 'class_rtcremotetextureview', replaced_file_text)
    replaced_file_text = re.sub('rtc_remote_view: TextureView', 'RtcRemoteTextureView', replaced_file_text)

    replaced_file_text = re.sub('class_rtc_remote_view_surfaceview', 'class_rtcremotesurfaceview', replaced_file_text)
    replaced_file_text = re.sub('rtc_remote_view: SurfaceView', 'RtcRemoteSurfaceView', replaced_file_text)

    # replaced_file_text = re.sub('enum_cloudproxytype', 'enum_proxytype', replaced_file_text)

    replaced_file_text = re.sub('callback_onrecorderstatechanged', 'callback_imediarecorder_onrecorderstatechanged', replaced_file_text)
    replaced_file_text = re.sub('api_stoprecording', 'api_imediarecorder_stoprecording', replaced_file_text)
    replaced_file_text = re.sub('api_startrecording', 'api_imediarecorder_startrecording', replaced_file_text)
    replaced_file_text = re.sub('callback_onrecorderinfoupdated', 'callback_imediarecorder_onrecorderinfoupdated', replaced_file_text)
    replaced_file_text = re.sub('api_getmediarecorder', 'api_imediarecorder_getmediarecorder', replaced_file_text)
    replaced_file_text = re.sub('api_releaserecorder', 'api_imediarecorder_releaserecorder', replaced_file_text)

    replaced_file_text = re.sub('callback_airplayconnected', 'callback_onairplayconnected', replaced_file_text)

    replaced_file_text = re.sub('"": When this parameter is set as null, the encryption mode is set as "aes-128-gcm" by default.', '', replaced_file_text)

    replaced_file_text = re.sub('"": When setting as NULL, the encryption mode is set as "aes-128-xts" by default.', '', replaced_file_text)

    replaced_file_text = re.sub('"": ""', '', replaced_file_text)
    
    replaced_file_text = re.sub('{ "AgoraIidSignalingEngine": "" }', '{ "AgoraIidSignalingEngine": "This interface class is deprecated." }', replaced_file_text)
    replaced_file_text = re.sub('{ "agoraIidSignalingEngine": "" }', '{ "agoraIidSignalingEngine": "This interface class is deprecated." }', replaced_file_text)
    replaced_file_text = re.sub('{ "uid": "" }', '{ "uid": "The user ID." }', replaced_file_text)
    

    replaced_file_text = re.sub('id="callback_iaudioframeobserverbase_', 'id="callback_iaudioframeobserver_', replaced_file_text)
    replaced_file_text = re.sub('"LOCAL_VIDEO_STREAM_ERROR_DEVICE_NOT_FOUND": ""', '"LOCAL_VIDEO_STREAM_ERROR_DEVICE_NOT_FOUND": "8: Fails to find a local video capture device."', replaced_file_text)
    replaced_file_text = re.sub('{ "LOCAL_VIDEO_STREAM_ERROR_DEVICE_BUSY": "3: The local video capturing device is in use." },', '{ "LOCAL_VIDEO_STREAM_ERROR_DEVICE_BUSY": "3: The local video capturing device is in use." }, { "LOCAL_VIDEO_STREAM_ERROR_CAPTURE_FAILURE": "4: The local video capture fails. Check whether the capturing device is working properly." },', replaced_file_text)


    # ------------------ Special processing for Flutter classes ------------------------------------------

    # { "LOCAL_VIDEO_STREAM_ERROR_DEVICE_BUSY": "3: The local video capturing device is in use." },
    # { "LOCAL_VIDEO_STREAM_ERROR_DEVICE_BUSY": "3: The local video capturing device is in use." }, { "LOCAL_VIDEO_STREAM_ERROR_CAPTURE_FAILURE": "4: The local video capture fails. Check whether the capturing device is working properly." },

    input_file.close()

    output_file = open(json_file, 'w', encoding="utf-8")
    output_file.write(replaced_file_text)


# Merge the individual JSON files to a single JSON file
merge_JsonFiles(files)

replace_newline()
