(: 
    XQuery document used to implement 'Convert attribute to element' operation from XML Refactoring tool.
:)

import module namespace xr = "http://www.oxygenxml.com/ns/xmlRefactoring" at "http://www.oxygenxml.com/ns/xmlRefactoring/resources/commons.xq";

declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare namespace fn = "http://www.w3.org/2005/xpath-functions";
declare option output:method   "xml";
declare option output:indent   "no"; 

(: Xpath to identify the target elements. :)
declare variable $element_xpath as xs:string external;

(: The local name of the attribute to be converted :)
declare variable $attribute_localName as xs:string external;

(: The namespace of the attribute to be converted :)
declare variable $attribute_namespace as xs:string external;

(: Local name of the new element. :)
declare variable $new_element_localName as xs:string external;

(: Namespace of the new element. :)
declare variable $new_element_namespace as xs:string external;

(: Convert attribute to element:)

let $elements := saxon:evaluate($element_xpath)
for $elem in $elements
let $attrNode := $elem/@*[xr:check-local-name($attribute_localName, ., false()) 
        and xr:check-namespace-uri($attribute_namespace, ., true())]
let $prefix := xr:find-prefix($new_element_namespace, $elem)
let $new_element_qName := xr:compute-qname(
        if (string-length($new_element_localName) > 0) then ($new_element_localName) else ($attribute_localName),
        $new_element_namespace,
        $elem)

  return 
      if (exists($attrNode)) then
        (
        insert node element {$new_element_qName} {string($attrNode)} as first into $elem,
        delete node $attrNode
        )
        else ()