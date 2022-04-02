xquery version "3.0";

declare namespace array = "http://www.w3.org/2005/xpath-functions/array";

(: The URI of the document that is to be queried :)
declare variable $document-uri as xs:string external := "../personal.json";

(: The JSON document :)
declare variable $document := json-doc($document-uri);

(: The manager ID :)
declare variable $manager as xs:string := "Big.Boss";

(: The persons :)
declare variable $persons := $document?personnel?person;

(: Lists the manager's subordinates:)
for $i in (1 to array:size($persons))
    let $person := $persons($i)
    let $link := $person?link
    where (exists($link?manager) and (compare($link?manager, $manager) eq 0))
    return
        <person
            id="{$person?id}">
            <name>{$person?name?given, " ", $person?name?family}</name>
        </person>