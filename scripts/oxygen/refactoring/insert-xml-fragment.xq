xquery version "3.0" encoding "utf-8";

(: 
    XQuery document used to implement 'Insert XML Fragment' operation from XML Refactor tool.    
:)

import module namespace xr = "http://www.oxygenxml.com/ns/xmlRefactoring" at "http://www.oxygenxml.com/ns/xmlRefactoring/resources/commons.xq";

declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare namespace oxy = "http://www.oxygenxml.com/xml-refactor";


declare option output:method   "xml";
declare option output:indent   "no";


(: The XPath that localize the anchor elements. The XML fragment will be inserted relatively to these node. :)
declare variable $element_anchor_xpath as xs:string external;

(: The insert position relative to the node determined by the 'Element XPath' expression. :)
declare variable $insert_position as xs:string external;

(: The XML fragment to be inserted :)
declare variable $xml_fragment as xs:string external;

(: Evaluate the XPath expression to get all anchor nodes :)
declare variable $anchorNodes := saxon:evaluate($element_anchor_xpath);

(: Parse the XML fragment :)
let $xmlFragmentSequence as node()* := xr:parse-xml-fragment($xml_fragment)

for $elem in $anchorNodes
    return            
      switch ($insert_position) 
        case 'firstChild'             
            return insert nodes $xmlFragmentSequence as first into $elem
        case 'lastChild' 
            return insert nodes $xmlFragmentSequence as last into $elem
        case 'after'
        	return insert nodes $xmlFragmentSequence after $elem
        case 'before'
        	return insert nodes $xmlFragmentSequence before $elem
       default return ()