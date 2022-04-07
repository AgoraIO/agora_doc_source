(: 
    XQuery document used to implement 'Change topic ID to file name' operation from XML Refactoring tool. 
:)
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare namespace local = "http://localFunction/";
declare option output:method   "xml";
declare option output:indent   "no";
declare variable $filename := local:fileNameToID(tokenize(document-uri(/), '/')[last()][1]);

declare function local:fileNameToID($fn as xs:string)
as xs:string
{
let $noExt := replace($fn, '\.(dita|ditamap|xml)$', '')
(:ä=ae, ö=oe, ü=ue, ß=ss:)
let $noEscapes := replace($noExt, "%C3%A4", "ae")
let $noEscapes := replace($noEscapes, "%C3%B6", "oe")
let $noEscapes := replace($noEscapes, "%C3%BC", "ue")
let $noEscapes := replace($noEscapes, "%C3%9F", "ss")

let $noEscapes := replace($noEscapes, "ä", "ae")
let $noEscapes := replace($noEscapes, "ö", "oe")
let $noEscapes := replace($noEscapes, "ü", "ue")
let $noEscapes := replace($noEscapes, "ß", "ss")
let $noEscapes := replace($noEscapes, "%[0-9a-fA-F][0-9a-fA-F]", "_") 
return $noEscapes
};

(: Set ID attribute on root :)
(
let $root := /*[not(@id=$filename)]
for $elem in $root
    let $attrNode := $elem/@id
     return if (exists($attrNode))
                then replace value of node $attrNode with $filename
                else ()
                ),
(
(: Set ID attribute on references to topic elements. :)
let $elements := //*[@href or @conref][not(@format) or @format='dita'][not(local-name() = 'coderef')][not(local-name() = 'image')]
for $elem in $elements
  let $possibleAttrs := $elem/@href | $elem/@conref
   for $attr in $possibleAttrs
     (:<xref href="../topics/flowers/iris.dita#irisgigi/p_vbr_bkc_5w"/>:)
    return if (exists($attr) and contains($attr, '#'))     
                then (
                    let $before := substring-before($attr, '#')
                    let $filename := local:fileNameToID(substring-before(tokenize(if($before='') then (document-uri()) else ($before), '/')[last()], '.'))
                    let $after := substring-after($attr, '#')
                    let $topicID := tokenize($after, '/')[1]
                    let $replaced := replace($after, $topicID, $filename)
                    return
                         if($topicID != $filename and $filename != '') then
                           replace value of node $attr with concat($before, '#', $replaced)
                         else ()  
                    )
                else ()
                )
    
