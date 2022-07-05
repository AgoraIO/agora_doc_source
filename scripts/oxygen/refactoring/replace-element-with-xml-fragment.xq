xquery version "3.0" encoding "utf-8";

(: 
    XQuery document used to implement 'Replace element with XML fragment' operation.    
:)

import module namespace xr = "http://www.oxygenxml.com/ns/xmlRefactoring" at "http://www.oxygenxml.com/ns/xmlRefactoring/resources/commons.xq";

declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";

declare option output:method   "xml";
declare option output:indent   "no";

declare variable $element_xpath as xs:string external;

(: The XML fragment to be inserted :)
declare variable $xml_fragment as xs:string external;

(: Parse the XML fragment :)
let $xmlFragmentSequence as node()* := xr:parse-xml-fragment($xml_fragment)
let $elements := saxon:evaluate($element_xpath)
for $elem in $elements
where $elem instance of element()
return 
  (
    (: Insert the nodes from the XML fragment before the target element :)
    insert nodes $xmlFragmentSequence before $elem,
         
    (: Delete the target element :)     
    delete node $elem
  )   