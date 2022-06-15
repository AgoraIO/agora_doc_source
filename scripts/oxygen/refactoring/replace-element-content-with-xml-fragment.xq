xquery version "3.0" encoding "utf-8";
(: 
    XQuery document used to implement 'Insert XML Fragment' operation from XML Refactor tool.    
:)

import module namespace xr = "http://www.oxygenxml.com/ns/xmlRefactoring" at "http://www.oxygenxml.com/ns/xmlRefactoring/resources/commons.xq";

declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";

declare option output:method "xml";
declare option output:indent "no";

declare variable $element_xpath as xs:string external;

(: The XML fragment to be inserted :)
declare variable $xml_fragment as xs:string external;

(: Parse the XML fragment :)
let $xmlFragmentSequence as node()* := xr:parse-xml-fragment($xml_fragment)
let $elements := saxon:evaluate($element_xpath)
for $elem in $elements
let $content := $elem/node()
where $elem instance of element()
return
  if (count($content) = 1) then
    replace node $content
      with $xmlFragmentSequence
  else
    ((: Delete the target element's content :) delete nodes $content,
    (: Insert the nodes from the XML fragment inside the target element :)
    insert nodes $xmlFragmentSequence
      as first into $elem)