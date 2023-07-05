import json
import sys

from PlatformDitaMapParser import PlatformDitaMapParser
from APIDetailDitaParser import APIDetailDitaParser
from KeysDitaMapParser import KeysDitaMapParser
from Objects import ClassInfo

platformDitaMapFile = sys.argv[1]
keysDitaMapFile = sys.argv[2]
apiDetailFolder = sys.argv[3]
platform = sys.argv[4]
outputJsonFile = sys.argv[5]
nodeHideAttributes = sys.argv[6:]

platformParser = PlatformDitaMapParser(platformDitaMapFile, 
                                       nodeHideAttributes)

list = platformParser.createClassInfoList()

keysParser = KeysDitaMapParser(keysDitaMapFile, 
                               apiDetailFolder)

array = []

for classItem in list:
    for apiItem in classItem.apiArray:
        print('------------------')
        print(apiItem.name)

        detailParser = APIDetailDitaParser(apiItem.name,
                                           platform,
                                           keysParser)
        
        object = detailParser.createJsonObject()

        if object == None:
            continue
        
        print(object.id)

        dictionary = object.createDictionary()
        array.append(dictionary)

        print(dictionary)

with open(outputJsonFile, 'w') as f:
    json.dump(array, 
              f, 
              indent=4, 
              ensure_ascii=False)
