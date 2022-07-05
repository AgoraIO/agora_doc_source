xquery version "3.0" encoding "utf-8";

(: 
    XQuery document used to implement 'Insert new element' operation from XML Refactor tool.    
:)

import module namespace xr = "http://www.oxygenxml.com/ns/xmlRefactoring" at "http://www.oxygenxml.com/ns/xmlRefactoring/resources/commons.xq";

declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare namespace saxon = "http://saxon.sf.net/";

declare option output:method   "xml";
declare option output:indent   "no";

(: The XPath that localize the anchor elements. The new element will be inserted relatively to these node. :)
declare variable $element_anchor_xpath as xs:string external;

(: The insert position relative to the node determined by the 'Element XPath' expression. :)
declare variable $insert_position as xs:string external;

(: The local name of the element to be inserted :)
declare variable $new_element_localname as xs:string external;

(: The namespace of the element to be inserted :)
declare variable $new_element_namespace as xs:string external;

(: Evaluate the XPath expression to get all anchor nodes :)
declare variable $anchorNodes := saxon:evaluate($element_anchor_xpath);

for $elem in $anchorNodes
  (: Compute the QName for the element to insert :)
  let $elementQName := xr:compute-qname($new_element_localname, $new_element_namespace, $elem)
    return
      switch ($insert_position) 
        case 'firstChild' 
            return insert nodes element {$elementQName} {} 
                as first into $elem
        case 'lastChild' 
            return insert nodes element {$elementQName} {} 
            as last into $elem
        case 'after'
        	return insert nodes element {$elementQName} {} 
            after $elem
        case 'before'
        	return insert nodes element {$elementQName} {} 
            before $elem
       default return ()