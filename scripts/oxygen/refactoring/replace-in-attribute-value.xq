(: 
    XQuery document used to implement the 'Replace in Attribute Value' operation from the XML Refactoring tool. 
    This operation matches a regexp pattern inside an attribute value and replaces it with a given string.
:)

import module namespace xr = "http://www.oxygenxml.com/ns/xmlRefactoring" at "http://www.oxygenxml.com/ns/xmlRefactoring/resources/commons.xq";

declare namespace saxon = "http://saxon.sf.net/";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare option output:method "xml";
declare option output:indent "no";

(: The XPath expression used to identify the attributes to change. :)
declare variable $attribute_xpath as xs:string external;

(: Specifies the string to find and the replacement string. :)
declare variable $to_find as xs:string external;
declare variable $replace_with as xs:string external;

(: Evaluate the input XPath expression :)
let $attributes := saxon:evaluate($attribute_xpath)
for $attr in $attributes
(: 
   Make sure that the sequence resulted after evaluating 
   the input XPath expression contains attributes. 
:)
where $attr instance of attribute()
let $oldAttrValue as xs:string := string($attr)
let $newAttrValue as xs:string := replace($oldAttrValue, $to_find, $replace_with)
(: Check if the replacement took place. :)
where not(compare($oldAttrValue, $newAttrValue) = 0)
return
    replace value of node $attr
        with $newAttrValue