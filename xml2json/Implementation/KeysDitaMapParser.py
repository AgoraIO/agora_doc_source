import xml.etree.ElementTree as ET
import re

from Functions import findFileNameWithPath
from Functions import printXMLNode

class KeysDitaMapParser:
    # public methods
    def __init__(self, 
                 path: str, 
                 apiDetailFolder: str):
        tree = ET.parse(path)
        root = tree.getroot()

        self.root = root 
        self.apiDetailFolder = apiDetailFolder

        # key: apiName, value: node
        self.noteMap = {}  

    def findDitaFilePath(self,
                         fileName: str) -> str:
        filePath = self.apiDetailFolder + '/' + fileName
        return filePath

    # api
    def findAPIDitaFileName(self, 
                            apiName: str) -> str:
        node = self._private_getNode(apiName)

        if node == None:
            return None

        fileName = self._private_findAPIDitaFileName(node)
        
        return fileName
    
    def findAccurateAPIName(self, 
                            apiName: str) -> str:
        return self.findAccurateName(apiName)

    # class, eg: <keydef keys="VideoCanvas" href="../API/class_videocanvas.dita">
    def findDitaFileName(self, 
                         keys: str) -> str:
        node = self._private_getNode(keys)

        if node == None:
            return None
        
        fileName = self._private_findDitaFileName(node)
        
        return fileName
    
    def findAccurateName(self, 
                         keys: str) -> str:
        node = self._private_getNode(keys)

        if node == None:
            return None

        name = self._private_findAccurateName(node)

        return name

    # private methods
    def _private_getNode(self, 
                         apiName: str) -> ET.Element:
        node = None

        if apiName in self.noteMap:
            node = self.noteMap[apiName]
        else:
            node = self._private_findAPINote(apiName, 
                                             self.root)

            if node != None:
                self.noteMap[apiName] = node

        return node
    
    def _private_findAPINote(self, 
                             apiName: str, 
                             root: ET.Element) -> ET.Element:
        string = ".//keydef[@keys='xxx']"

        string = string.replace('xxx',
                                apiName)

        array = root.findall('topichead')

        for node in array:
            subNode = node.find(string)

            if subNode != None:
                return subNode
        
        return None
    
    def _private_findAPIDitaFileName(self,
                                     node: ET.Element) -> str:
        callback = 'callback'
        api = 'api'
        
        fileName = self._private_findDitaFileName(node)

        if api in fileName:
            return fileName
        elif callback in fileName:
            return fileName
        else:
            return None
        
    def _private_findAccurateName(self,
                                  node: ET.Element) -> str:
        topicmeta = 'topicmeta'
        keywords = 'keywords'
        keyword = 'keyword'
        
        topicmetaNode = node.find(topicmeta)

        if topicmetaNode == None:
            return None

        keywordsNode = topicmetaNode.find(keywords)
        keywordNode = keywordsNode.find(keyword)

        text = keywordNode.text

        if text == None:
            return None

        pat = r'\b\w+'

        matches = re.findall(pat, 
                             text)

        name = matches[0]

        return name
    
    def _private_findDitaFileName(self,
                                  node: ET.Element) -> str:
        href = 'href'
        
        if href not in node.attrib:
            return None

        filePath = node.attrib[href]
        
        fileName = findFileNameWithPath(filePath)

        return fileName