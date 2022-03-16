#!/usr/local/bin/python3
# -*- coding: utf-8 -*-
#
# Developed by Lutkin Wang
#
# Story: Replace the prototype section so that manual copy & paste is no longer needed
#
# <section id="prototype">
#         <p props="rtc-ng" outputclass="codeblock">
#                 <codeblock props="android" outputclass="language-java">public abstract void onMetadataReceived(byte[] buffer, int uid, long timeStampMs);</codeblock>
#                 <codeblock props="ios mac" outputclass="language-objectivec">- (void)receiveMetadata:(NSData * _Nonnull)data
#     fromUser:(NSInteger)uid atTimestamp:(NSTimeInterval)timestamp;</codeblock>
#             </p>
#         <p props="rtc" outputclass="codeblock">
#                 <codeblock props="android" outputclass="language-java"/>
#                 <codeblock props="ios mac" outputclass="language-objectivec"/>
#                 <codeblock props="windows unity" outputclass="language-cpp">virtual void onMetadataReceived(const Metadata &amp;metadata) = 0;
#     };</codeblock>
#                 <codeblock props="electron" outputclass="language-typescript">on(evt: EngineEvents.RECEIVE_METADATA, cb: (
#     metadata: Metadata
#     ) => void): this;</codeblock>
#                 <codeblock props="rn" outputclass="language-typescript"/>
#                 <codeblock props="flutter" outputclass="language-dart"/>
#         </p>
#         </section>
#
# from: C:\Users\WL\Documents\GitHub\doc_source\dita\RTC\API\xxx.dita
#
# with: C:\Users\WL\Documents\GitHub\doc_source\en-US\dita\RTC\API\xxx.dita
#

import xml.etree.ElementTree as ET
import os
from os import path
import argparse


def main():

    parser = argparse.ArgumentParser(description="Prototype syncer")

    parser.add_argument("--src_dir",
                    help="src dir",
                    action="store")
    parser.add_argument("--dest_dir", help="dest dir", action="store")

    args = vars(parser.parse_args())

    src_dir = args['src_dir']
    dest_dir = args['dest_dir']

    # src_dir = "C:\\Users\\WL\\Documents\\GitHub\\doc_source\\dita\\RTC\\API"
    # src_dir = "D:\\github_lucas\\doc_source\\dita\\RTC\\API"
    # src_dir = "C:\\Users\\WL\\Documents\\GitHub\\\doc_source\\en-US\\dita\\RTC\\API"

    # dest_dir = "C:\\Users\\WL\\Documents\\GitHub\\doc_source\\en-US\\dita\\RTC\\API"
    # dest_dir = "D:\\github_lucas\\doc_source\\en-US\\dita\\RTC\\API"
    # dest_dir = "C:\\Users\\WL\\Documents\\GitHub\\doc_source\\dita\\RTC\\API"

    src_proto_section_obj = None
    dest_proto_section_obj = None
    dest_dita_file_tree = None

    # Copy cn protos to en
    for file_name in os.listdir(src_dir):

        file_ready_for_copy = True

        if file_name.startswith("api_") or file_name.startswith("class_"):

            try:
                cn_path = path.join(src_dir, file_name)
                cn_dita_file_tree = ET.parse(cn_path)
                cn_dita_file_root = cn_dita_file_tree.getroot()
            except ET.ParseError as e:
                print("[ERROR] Parse error for: " + file_name + " Code: " + str(e.code) + " Position: " + str(e.position))

            en_path = path.join(dest_dir, file_name)

            try:
                dest_dita_file_tree = ET.parse(en_path)
                en_dita_file_root = dest_dita_file_tree.getroot()
            except FileNotFoundError as e:
                print("[ERROR] File not found in en: " + file_name)
                file_ready_for_copy = False

            except ET.ParseError as e:
                print("[ERROR] Parse error for: " + file_name + " Code: " + str(e.code) + " Position: " + str(e.position))
                file_ready_for_copy = False

            if file_ready_for_copy:

                for section in cn_dita_file_root.iter("section"):
                    if section.get("id") == "prototype":
                        src_proto_section_obj = section

                refbody = en_dita_file_root.find("./refbody")

                for section in en_dita_file_root.iter("section"):
                    if section.get("id") == "prototype":
                        refbody.remove(section)
                        refbody.insert(0, src_proto_section_obj)

                dest_dita_file_tree.write(dest_dir + "//" + file_name, encoding='utf-8')

                header = """<?xml version="1.0" encoding="UTF-8"?>\n<!DOCTYPE reference PUBLIC "-//OASIS//DTD DITA Reference//EN" "reference.dtd">\n"""

                with open(dest_dir + "//" + file_name, "r", encoding='utf-8') as f:
                    text = header + f.read()

                with open(dest_dir + "//" + file_name, "w", encoding='utf-8') as f:
                    f.write(text)


if __name__ == '__main__':
    main()
