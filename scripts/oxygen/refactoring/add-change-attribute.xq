(: 
    XQuery document used to implement 'Set attribute' operation from XML Refactor tool. 
    This operation sets the value for an attribute. If the attribute is not found, then it will be inserted.
:)
import module namespace xr = "http://www.oxygenxml.com/ns/xmlRefactoring" at "http://www.oxygenxml.com/ns/xmlRefactoring/resources/commons.xq";

declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare option output:method   "xml";
declare option output:indent   "no";

(: The XPath expression taht matches the parent element of the attribute :)
declare variable $element_xpath as xs:string external;

(: The local name of the attribute to set :)
declare variable $attribute_name as xs:string external;

(: The namespace of the attribute to set :)
declare variable $attribute_namespace as xs:string external;

(: The new attribute value :)
declare variable $attribute_value as xs:string external;

(:
    Specifies which elements will be affected by this operation.
    
    There are three possible values:
    * selected elements where the attribute exists - to specify only the existing attributes will be modified;
    * selected elements where the attribute is missing - to specify that only new attributes will be inserted. 
      The already existing attributes will not be changed;
    * all selected elements - to specify that the already existing attributes will be changed, otherwise  
      new attributes will be inserted;
:)
declare variable $affected_elements as xs:string external;

(: Set attribute :)
let $elements := saxon:evaluate($element_xpath)

let $isXMLPrefixFound := starts-with($attribute_name, "xml:")

let $attribute_name := if ($isXMLPrefixFound) 
                            then (substring($attribute_name, 5)) 
                            else ($attribute_name)

let $attribute_namespace := if ($isXMLPrefixFound) 
                            then ("http://www.w3.org/XML/1998/namespace") 
                            else ($attribute_namespace)



for $elem in $elements
let $attrNode := $elem/@*[xr:check-local-name($attribute_name, ., false()) and xr:check-namespace-uri($attribute_namespace, ., true())]
    return      
        switch ($affected_elements) 
        case 'selected_elements_attr_exists'
            return if (exists($attrNode))
                then if(not($attrNode = $attribute_value)) then replace value of node $attrNode with $attribute_value else ()
                else ()            
        case 'selected_elements_attr_missing' 
            return if (not(exists($attrNode)))
                then insert node (
                    attribute {
                        xr:compute-qname($attribute_name, $attribute_namespace, $elem)}
                        {$attribute_value}) 
                    into $elem
                else ()            
        case 'selected_elements'
        	return if (exists($attrNode))
                then if(not($attrNode = $attribute_value)) then replace value of node $attrNode with $attribute_value else ()
                else insert node (
                    attribute {
                        xr:compute-qname($attribute_name, $attribute_namespace, $elem)}
                        {$attribute_value}) 
                    into $elem
       default return ()
    
