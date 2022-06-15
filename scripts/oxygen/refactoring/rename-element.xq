xquery version "3.0" encoding "utf-8";

(: 
    XQuery document used to implement 'Insert new element' operation from XML Refactor tool.    
:)

declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare namespace saxon = "http://saxon.sf.net/";

declare option output:method   "xml";
declare option output:indent   "no";

(: The XPath that localize the element. :)
declare variable $element_xpath as xs:string external;


(: The new local name of the element :)
declare variable $new_element_localname as xs:string external;

let $elements := saxon:evaluate($element_xpath)
for $elem in $elements
    let $namespace := namespace-uri($elem)
    let $prefix := prefix-from-QName(node-name($elem))
    let $new_qname :=
      if (empty($prefix))
        then $new_element_localname
        else $prefix || ':' || $new_element_localname
	return 
	  rename node $elem as QName($namespace, $new_qname)