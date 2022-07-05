(: 
    XQuery document used to implement the 'Remove attribute' operation for the XML Refactoring tool.
:)
declare namespace saxon = "http://saxon.sf.net/";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare option output:method "xml";
declare option output:indent "no";

(: The XPath expression used to identify the attributes to be deleted. :)
declare variable $attribute_xpath as xs:string external;

(: Remove attribute :)
let $attributes := saxon:evaluate($attribute_xpath)
for $attribute in $attributes
where $attribute instance of attribute()
return
    delete node $attribute
