(: 
    XQuery document used to implement the 'Rename attribute' operation for the XML Refactor tool.
:)

import module namespace xr = "http://www.oxygenxml.com/ns/xmlRefactoring" at "http://www.oxygenxml.com/ns/xmlRefactoring/resources/commons.xq";

declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare option output:method   "xml";
declare option output:indent   "no"; 

(: The XPath expression used to identify the attributes to be renamed. :)
declare variable $attribute_xpath as xs:string external;

(: The new local name of the attribute :)
declare variable $new_attribute_localname as xs:string external;

(: Rename attribute :)
let $attributes := saxon:evaluate($attribute_xpath)
for $attribute in $attributes
where $attribute instance of attribute()
let $old_attr_qname := node-name($attribute)
let $new_attr_qname := xr:get-qname(prefix-from-QName($old_attr_qname), $new_attribute_localname, string(namespace-uri-from-QName($old_attr_qname)))
  return
    rename node $attribute as $new_attr_qname