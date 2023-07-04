import xml.etree.ElementTree as ET
import sys 
import re
import os

from Objects import APIJsonObject
from Objects import ClassInfo
from Objects import APIInfo
from Functions import findFileNameWithPath
from Functions import printXMLNode

class PlatformDitaMapParser: 
    # public methods
    def __init__(self, 
                 path, 
                 nodeHideAttributes = []):
        self.path = path
        self.nodeHideAttributes = nodeHideAttributes

    def createClassInfoList(self) -> []:
        node = self._private_findReferenceNode()
        
        list = []

        for item in node:
            if self._private_nodeIsClass(item):
                classInfo = self._private_createClassInfoItem(item)
                if classInfo != None:
                    list.append(classInfo)

        return list

    # private methods
    # eg: <topichead navtitle="C++ API Reference for All Platforms">
    def _private_findReferenceNode(self) -> ET.Element:
        tree = ET.parse(self.path)
        root = tree.getroot()

        topichead = 'topichead'
        topicref = 'topicref'
        href = 'href'
        api = 'API'

        topicheads = root.findall(topichead)
        
        for node in topicheads:
            topicrefs = node.findall(topicref)
            
            for subNode in topicrefs:
                if href in subNode.attrib:
                    value = subNode.attrib[href]
                    
                    if api in value:
                        return node
    
    # eg:  <topicref href="API/rtc_interface_class.dita" chunk="to-content"> or <topicref keyref="IRtcEngine" chunk="to-content">
    def _private_nodeIsClass(self, 
                             node: ET.Element) -> bool:
        if self.nodeIsHide(node):
            return False

        keyref = 'keyref'
        chunk = 'chunk'
        href = 'href'

        if chunk in node.attrib and keyref in node.attrib and len(node) > 0: 
            return True
        elif chunk in node.attrib and href in node.attrib and len(node) > 0:
            return True
        else:
            return False

    def _private_createClassInfoItem(self,
                                     node: ET.Element) -> ClassInfo:
        keyref = 'keyref'
        href = 'href'

        # class is hide
        isHide = self.nodeIsHide(node)

        if isHide == True:
            return None

        # class name
        className = ''

        if keyref in node.attrib:
            className = node.attrib[keyref]
        elif href in node.attrib:
            className = node.attrib[href]

        # api array
        apiArray = []

        # for 'api node' in 'class node'
        for item in node:
            isHide = self.nodeIsHide(item)

            if isHide == True:
                continue
            
            # api name
            apiName = item.attrib[keyref]

            api = APIInfo(apiName)
            
            apiArray.append(api)

        classItem = ClassInfo(className, 
                              apiArray)
        
        return classItem
    
    def nodeIsHide(self,
                   node: ET.Element) -> bool:
        processingRole = 'processing-role'
        resourceOnly = 'resource-only'
        props = 'props'

        # processing-role="resource-only"
        if processingRole in node.attrib:
            if node.attrib[processingRole] == resourceOnly:
                return True
        elif props in node.attrib:
            if node.attrib[props] in self.nodeHideAttributes:
                return True
        else:
            return False