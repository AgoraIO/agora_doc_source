(: 
    XQuery document used to implement the 'Delete comments' operation for the XML Refactoring tool.
:)
declare namespace saxon = "http://saxon.sf.net/";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare option output:method "xml";
declare option output:indent "no";

(: The XPath expression used to identify the elements containig the comments to be deleted.:)
declare variable $element_xpath as xs:string external;

(: Delete comments:)
let $elements := saxon:evaluate($element_xpath)
return
    delete nodes $elements//comment()
