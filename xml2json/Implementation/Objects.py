from typing import Dict

class ClassInfo:
    def __init__(self, 
                 name: str, 
                 apiArray: []):
        self.name = name
        self.apiArray = apiArray

class APIInfo:
    def __init__(self, 
                 name: str):
        self.name = name

class APIJsonObject:
    def __init__(self, 
                 id: str,
                 name: str, 
                 description: str, 
                 parameters: [], 
                 returns: str):
        self.id = id
        self.name = name                 
        self.description = description
        self.parameters = parameters     
        self.returns = returns

    def createDictionary(self) -> Dict:
        dictionary = vars(self)

        isHideKey = 'isHide'

        if isHideKey in dictionary:
            value = dictionary[isHideKey]
            
            if value == False:
                del dictionary[isHideKey]
                
        return dictionary
