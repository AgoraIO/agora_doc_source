xquery version "3.0" encoding "utf-8";

(: 
    XQuery document used to implement 'Insert new element' operation from XML Refactor tool.    
:)
import module namespace xr = "http://www.oxygenxml.com/ns/xmlRefactoring" at "http://www.oxygenxml.com/ns/xmlRefactoring/resources/commons.xq";

declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare namespace saxon = "http://saxon.sf.net/";

declare option output:method   "xml";
declare option output:indent   "no";

declare variable $element_xpath as xs:string external;

declare variable $wrapper_element_local_name as xs:string external;

declare variable $wrapper_element_namespace_uri as xs:string external;

let $elements := saxon:evaluate($element_xpath)
for $elem in $elements
let $parentNode := $elem/parent::node()
let $elementQName := xr:compute-qname($wrapper_element_local_name, $wrapper_element_namespace_uri, $elem)
where $elem instance of element()
  return
    ( 
      insert node element {$elementQName} {$elem} before $elem,
      delete node $elem
    )