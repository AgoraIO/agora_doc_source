import xml.etree.ElementTree as ET
import glob
import re
import os

def printXMLNode(log: str, 
                 node: ET.Element):
    log = '-----' + log + ", tag:" + str(node.tag) + ", attrib:" + str(node.attrib) + ", text:" + str(node.text) + ", tail:" + str(node.tail) + ", count:" + str(len(node))
    print(log)

def printXMLNodeArray(log: str, 
                      array: []):
    print('array count:' + str(len(array)))

    for item in array:
        printXMLNode(log, 
                     item)

def textIsNotEmpty(text) -> bool:
    if text == None:
        return False
    elif len(text) > 0:
        return True
    else:
        return False

def lineBreakTextFilter(text: str) -> str:
    # filter '\n'
    text = re.sub('\n', 
                  '', 
                  text)

    return text

def cusLineBreakTextReplace(text: str) -> str:
    text = re.sub('<lineBreak><lineBreak>', 
                  '<lineBreak>', 
                  text)

    text = re.sub('<lineBreak> ', 
                  '\n', 
                  text)
    
    text = re.sub('<lineBreak>', 
                  '\n', 
                  text)

    text = text.strip()

    return text

# strip 不会移除中间的 \t、 \n ”空格“，但会移除首尾的 \t \n 和 ”空格“
def blankTextFilter(text: str) -> str:
    if text.isspace():
        return ''
    else:
        filterText = text.strip()
        return filterText

# 拼接字符串时，中间会有空格隔开
def spliceTextWithBlank(text1: str, 
                        text2: str) -> str:
    spliceText = ''

    if len(text2) == 0:
        return text1
    
    # 为了处理当 text2 开头为结束符号时，
    # text1 与 text2 拼接后，是 ‘MediaRecorderConfiguration.’ 而不是 ‘MediaRecorderConfiguration .’
    endMarks = ['.', ',', '!']

    if text2[0] in endMarks:
        spliceText = text1 + text2
    else:
        spliceText = text1 + " " + text2

    spliceText = spliceText.strip()
    
    return spliceText

def findFileNameWithPath(path: str) -> str:
    fileName = path.split('/')[-1]
    return fileName