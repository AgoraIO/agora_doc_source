import xml.etree.ElementTree as ET

from KeysDitaMapParser import KeysDitaMapParser
from Functions import printXMLNode
from Functions import textIsNotEmpty
from Functions import spliceTextWithBlank
from Functions import blankTextFilter

def nodeBelongsToPlatform(node: ET.Element, 
                          platform: str) -> bool:
    result = nodeHasPlatformProps(node)

    if result == False:
        return False

    platformKey = 'props'

    platformName = node.attrib[platformKey]
    
    if platformName == None:
        return False

    # special value: 'framework', always return True
    if platform.lower() in ['rn', 'electron', 'flutter', 'unity']:
        if platformName == 'framework' or 'framework' in platformName:
            return True
    
    if platform in platformName:
        return True
    
    return False

def nodeHasPlatformProps(node: ET.Element) -> bool:
    platformKey = 'props'

    return nodeHasAttrib(platformKey, 
                         node)
    
def nodeHasAttrib(key: str, 
                  node: ET.Element) -> bool:
    if key in node.attrib:
        return True
    else:
        return False

def findNode(root: ET.Element, 
             tag: str, 
             id: str) -> ET.Element:
    string = ".//yyy[@id='xxx']"

    string = string.replace('yyy',
                            tag)

    string = string.replace('xxx',
                            id)

    node = root.find(string)

    return node

# eg:  <plentry conkeyref="removeRemotePosition/uid"> or <plentry conkeyref="VideoCanvas/sourcetype"> 
def findNodeWithConkeyrefNode(conkeyrefNode: ET.Element, 
                              keyParser: KeysDitaMapParser) -> ET.Element:
    conkeyref = 'conkeyref'

    if nodeHasAttrib(conkeyref, conkeyrefNode):
        value = conkeyrefNode.attrib[conkeyref]
        array = value.split('/')
        apiName = array[0]
        parameter = array[1]

        fileName = keyParser.findDitaFileName(apiName)

        filePath = keyParser.findDitaFilePath(fileName)

        # detail dita file
        tree = ET.parse(filePath)
        root = tree.getroot()
        
        node = findNode(root,
                        conkeyrefNode.tag, 
                        parameter) 

        return node
    else:
        return None

# 将一个 Node 下以及它的 sub node 的所有内容拼接在一起
def spliceNodeDescription(node: ET.Element, 
                          platform: str,
                          keyParser: KeysDitaMapParser, 
                          ignoreTags = [], 
                          lineBreak = False) -> str:
    if node.tag in ignoreTags:
        return ''

    # multi platform
    if nodeHasPlatformProps(node):
        if nodeBelongsToPlatform(node, 
                                 platform) == False:
            return ''

    description = ''

    descNode = findNodeWithConkeyrefNode(node, 
                                         keyParser)

    if descNode != None:
        description = spliceNodeDescription(descNode, 
                                            platform, 
                                            keyParser,
                                            ignoreTags, 
                                            lineBreak)
    else:
        description = keyrefNodeDescription(node, 
                                            keyParser)
    
    for sub in node:
        subText = spliceNodeDescription(sub,
                                        platform, 
                                        keyParser, 
                                        ignoreTags, 
                                        lineBreak)

        description = spliceTextWithBlank(description,
                                          subText)

    if textIsNotEmpty(node.tail):
        tail = blankTextFilter(node.tail)
        description = spliceTextWithBlank(description,
                                          tail)

    if lineBreak == True:
        if node.tag == 'p' or node.tag == 'li':
            description = description + "<lineBreak>"

    return description

# <xref keyref="term-transocding">Transcoding</xref>
# 当一个 node 里有 keyref 的 attrib 时，需要特殊处理
# 当 node.text 有值时，使用 text
# 当 node.text 没有值时，使用 keyref 的 value，并通过 keys dita map 取到确切的值
def keyrefNodeDescription(node: ET.Element, 
                          keyParser: KeysDitaMapParser) -> str:
    description = ''
    
    keyref = 'keyref'

    if textIsNotEmpty(node.text):
        text = blankTextFilter(node.text)
        description = text
    elif keyref in node.attrib:
        text = node.attrib[keyref]

        accurate = keyParser.findAccurateName(text)

        if textIsNotEmpty(accurate):
            text = accurate
        
        description = blankTextFilter(text)
    
    return description
    