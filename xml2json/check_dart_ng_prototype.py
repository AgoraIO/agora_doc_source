#!/usr/local/bin/python3
# -*- coding: utf-8 -*-

# Developed by Lutkin Wang
# Check prototype in
# Future<void> startAudioFrameDump(
#      String channel_id,
#      uid_t user_id,
#      String location,
#      String uuid,
#      String passwd,
#      int duration_ms,
#      bool auto_upload);

import os
import re
import argparse

log_name = "prototype_check_flutter_ng.txt"


def removeComments(string):
    string = re.sub(re.compile("/\*.*?\*/", re.DOTALL), "",
                    string)  # remove all occurrences streamed comments (/*COMMENT */) from string
    string = re.sub(re.compile("//.*?\n"), "",
                    string)  # remove all occurrence single-line comments (//COMMENT\n ) from string
    return string


def write_log(text):
    with open(log_name, encoding='utf8', mode='a') as f:
        f.write(text + "\n")
        print(text + "\n")


def read_ditamap(filename):
    with open(filename, encoding='utf8', mode='r') as f:
        text = f.read()
    return text

def main():

    parser = argparse.ArgumentParser(description="Prototype checker")

    parser.add_argument("--code_location",
                    help="code dir",
                    action="store")
    parser.add_argument("--dita_location", help="DITA location", action="store")
    parser.add_argument("--dita_map_location", help="DITA map location", action="store")
    parser.add_argument("--decomment_code_location", help="Decomment code location", action="store")

    args = vars(parser.parse_args())

    code_location = args['code_location']
    dita_location = args['dita_location']
    dita_map_location = args['dita_map_location']
    decomment_code_location = args['decomment_code_location']

    # A list of DITA files
    dita_file_list = []

    # A list of DITA protos
    dita_proto_list = []

    # A list of code files
    code_file_list = []

    # A list of proto files
    code_proto_list = []

    ditamap_content = read_ditamap(dita_map_location)

    # Handle the DITA files
    for file in os.scandir(dita_location):
        if (file.path.endswith(".dita")) and not file.path.startswith(dita_location + "/enum_") and not file.path.startswith(dita_location + "/rtc_") and file.is_file() and os.path.basename(file) in ditamap_content:
            print(file.path)
            dita_file_list.append(file.path)
            with open(file.path, encoding='utf8') as f:
                content = f.read()
                # Use substring methods to get the proto from DITA
                # Here, we assume that the DITA file contains a single codeblock for each programming language
                after_codeblock_start_tag = re.split('<codeblock props="flutter" outputclass="language-dart">',
                                                     content)
                try:
                    before_codeblock_end_tag = re.split('</codeblock>', after_codeblock_start_tag[1])
                    proto_text = before_codeblock_end_tag[0]
                except IndexError:
                    proto_text = "Error: No prototype"

                proto_text = proto_text.replace("&amp;", "&")
                proto_text = proto_text.replace("&lt;", "<")
                proto_text = proto_text.replace("&gt;", ">")

                print(proto_text)
                dita_proto_list.append(proto_text)

    dictionary = dict(zip(dita_file_list, dita_proto_list))

    # Handle the interface files

    # Decomment all oc files
    for root, dirs, files in os.walk(code_location):
        for file in files:
            if file.endswith(".dart"):
                with open(os.path.join(root, file), encoding='utf8', mode='r') as f:
                    text = removeComments(f.read())
                    with open(decomment_code_location + "/" + "concatenated.dart", encoding='utf8', mode='a') as f1:
                        f1.write(text)

    with open(decomment_code_location + "/" + "concatenated.dart", encoding='utf8', mode='r') as f:
        content = f.read()
        content1 = content.replace("&amp;", "&")
        content2 = content1.replace("&lt;", "<")
        content3 = content2.replace("&gt;", ">")
        content4 = content3.replace(" ", "")
        content5 = content4.replace("\n", "")

        open(log_name, "w").close()

        i = 1

        write_log("The DITAMAP used is " + dita_map_location + "\n")

        for file, code in dictionary.items():
            code1 = code.replace("&amp;", "&")
            code2 = code1.replace("&lt;", "<")
            code3 = code2.replace("&gt;", ">")
            code4 = code3.replace(" ", "")
            code5 = code4.replace("\n", "")

            if content5.find(code5) == -1:
                write_log("No. " + str(i) + " Mismatch found")
                i = i + 1
                write_log("\n")
                write_log("-------------------------------------------------------------------------------")
                write_log("-------------------------------------------------------------------------------")
                write_log("For the DITA file: " + file)
                write_log("This prototype in DITA cannot be located in the source code: \n " + code + "\n")
                write_log("-------------------------------------------------------------------------------")
                write_log("-------------------------------------------------------------------------------")
                write_log("\n")


    # Clean folder
    for root, dirs, files in os.walk(decomment_code_location):
        for file in files:
            os.remove(os.path.join(root, file))


if __name__ == '__main__':
    main()
