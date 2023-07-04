import xml.etree.ElementTree as ET
import sys 
import re

from KeysDitaMapParser import KeysDitaMapParser
from Objects import APIJsonObject
from Objects import ClassInfo

from NodeExtension import findNodeWithConkeyrefNode
from NodeExtension import nodeBelongsToPlatform
from NodeExtension import spliceNodeDescription
from NodeExtension import nodeHasPlatformProps
from NodeExtension import nodeHasAttrib
from NodeExtension import findNode

from Functions import spliceTextWithBlank
from Functions import printXMLNode
from Functions import printXMLNodeArray
from Functions import cusLineBreakTextReplace

class APIDetailDitaParser:
    # public methods
    def __init__(self, 
                 name: str, 
                 platform: str, 
                 keysMapParser: KeysDitaMapParser):
        self.platform = platform
        self.keysMapParser = keysMapParser
        self.name = None

        fileName = self.keysMapParser.findAPIDitaFileName(name)

        if fileName == None:
            return

        apiName = self.keysMapParser.findAccurateAPIName(name)

        if apiName == None:
            return

        filePath = self.keysMapParser.findDitaFilePath(fileName)

        tree = ET.parse(filePath)

        self.root = tree.getroot()

        self.name = apiName

        self.jsonId = fileName.split('.')[0]

    def createJsonObject(self) -> APIJsonObject:
        if self.name == None:
            return None

        # json
        jsonId = self.jsonId

        name = self.name
        
        description = self._private_findMethodDescription()

        parameters = self._private_findParameters()

        returns = self._private_findReturnDescription()

        object = APIJsonObject(jsonId, 
                               name, 
                               description, 
                               parameters, 
                               returns)

        return object

    def _private_findMethodDescription(self) -> str:
        description = ''

        # short description
        shortDesc = self.root.find(".//shortdesc[@id='short']")

        if shortDesc != None:
            desc = spliceNodeDescription(shortDesc, 
                                         self.platform, 
                                         self.keysMapParser)
            description = desc + "\n"

        # detail description
        detailDesc = self.root.find(".//section[@id='detailed_desc']")

        if detailDesc != None:
            desc = spliceNodeDescription(detailDesc, 
                                         self.platform, 
                                         self.keysMapParser, 
                                         ignoreTags=['title'], 
                                         lineBreak=True)

            description = description + desc
        
        description = cusLineBreakTextReplace(description)

        return description

    def _private_findParameters(self) -> []:
        array = []

        plentrys = self._private_findAllPlentyNode()
        
        if plentrys == None:
            return array

        for node in plentrys:
            plentryNode = self._private_getPlentryNode(node)

            if plentryNode == None:
                continue

            paraDic = self._private_findPerParameter(plentryNode)

            if paraDic == None:
                continue
            array.append(paraDic)

        return array
    
    def _private_findAllPlentyNode(self) -> []:
        parameters = self.root.find(".//section[@id='parameters']")

        # This method does no have any parameters
        if parameters == None:
            return None

        conkeyref = 'conkeyref'

        if nodeHasAttrib(conkeyref, parameters):
            parameters = findNodeWithConkeyrefNode(parameters, 
                                                   self.keysMapParser)
        
        parml = parameters.find('parml')

        if parml == None:
            return None

        plentrys = parml.findall('plentry')

        return plentrys
    
    def _private_getPlentryNode(self, 
                                node: ET.Element) -> ET.Element:
        if nodeHasPlatformProps(node):
            if nodeBelongsToPlatform(node, self.platform) == False:
                return None

        conkeyref = 'conkeyref'

        if nodeHasAttrib(conkeyref, node):
            plenty = findNodeWithConkeyrefNode(node, 
                                               self.keysMapParser)
            
            return plenty
        else:
            return node

    def _private_findPerParameter(self,
                                  node: ET.Element) -> {}:
        # parameter name
        name = ''

        # pt, multi platform
        pts = node.findall('pt')

        for pt in pts:
            text = spliceNodeDescription(pt, 
                                         self.platform, 
                                         self.keysMapParser)
            
            if len(text) > 0:
                name = text

        # parameter description
        pd = node.find('pd')

        description = spliceNodeDescription(pd, 
                                            self.platform, 
                                            self.keysMapParser,
                                            lineBreak=True)
        
        description = cusLineBreakTextReplace(description)
       
        # 如果参数的
        if len(name) == 0:
            return None
        else:
            dictionary = {name: description}

        return dictionary

    def _private_findReturnDescription(self) -> str:
        description = ''

        return_values = self.root.find(".//section[@id='return_values']")

        if return_values == None:
            return description
        
        # 存在 <p></p> 与 <ul></ul> 两种情况
        p = return_values.find('p')

        if p != None:
            text = spliceNodeDescription(p, 
                                         self.platform,
                                         self.keysMapParser, 
                                         lineBreak=True)
            
            description += text

        uls = return_values.findall('ul')

        if len(uls) > 0:
            for ul in uls:
                text = spliceNodeDescription(ul, 
                                             self.platform, 
                                             self.keysMapParser, 
                                             lineBreak=True)
            
                description += text
        
        description = cusLineBreakTextReplace(description)
        
        return description    