<?xml version="1.0" encoding="utf-8"?>
<!--
     XLIFF Version 2.1
     Committee Specification Draft 01 / Public Review Draft 01
     14 October 2016
     Copyright (c) OASIS Open 2016. All Rights Reserved.
     Source: http://docs.oasis-open.org/xliff/xliff-core/v2.1/csprd01/schemas/
     Latest version of narrative specification: http://docs.oasis-open.org/xliff/xliff-core/v2.1/xliff-core-v2.1.html
     TC IPR Statement: https://www.oasis-open.org/committees/xliff/ipr.php
     
-->

<!DOCTYPE schematron [
<!-- Entities for XLIFF V2.x publishing.................................... -->
<!--copy all of these to all *.sch files and also to the Oxygen framework for validating Docbook 4.5 if you use Oxygen -->
<!ENTITY name "xliff-core-v2.1">
<!ENTITY pversion "2.0">
<!ENTITY version "2.1">
<!ENTITY bschversion "2.0">
<!ENTITY cschversion "2.1">

<!ENTITY stage "csprd01">
<!ENTITY pstage "N/A">
<!ENTITY standard "Committee Specification Draft 01 / Public Review Draft 01">

<!ENTITY this-loc "http://docs.oasis-open.org/xliff/xliff-core/v&version;/&stage;">
<!ENTITY previous-loc "http://docs.oasis-open.org/xliff/xliff-core/v&version;/&pstage;">
<!ENTITY latest-loc "http://docs.oasis-open.org/xliff/xliff-core/v&version;">
<!ENTITY pubdate "14 October &pubyear;">
<!ENTITY pubyear "2016">
<!ENTITY releaseinfo "Standards Track Work Product">
<!-- End of XLIFF V2.x publishing entities -->
]>

<iso:schema xmlns="http://purl.oclc.org/dsdl/schematron" 
    xmlns:iso="http://purl.oclc.org/dsdl/schematron"
    xmlns:res="urn:oasis:names:tc:xliff:resourcedata:2.0"
    queryBinding='xslt2' 
    schemaVersion='ISO19757-3'>
    <iso:title>Schematron rules for checking the constraints of the Resource Data module against XLIFF Version &version;</iso:title>
    <iso:ns prefix="res" uri="urn:oasis:names:tc:xliff:resourcedata:2.0"/>
    <iso:ns prefix="xlf" uri="urn:oasis:names:tc:xliff:document:2.0"/>
    
    <iso:pattern>
        <iso:rule context="res:resourceItemRef[@id] | res:resourceItem[@id]" see="&this-loc;/&name;-&stage;.html#res_resourceItemRef">
            <iso:let name="id" value="@id"/>
            <iso:let name="check" value="count(following-sibling::res:resourceItemRef[@id=$id] | following-sibling::res:resourceItem[@id=$id])"/>
            <iso:assert test="$check=0" diagnostics="spec-quote-id">
                id duplication found among &lt;res:resourceItemRef&gt; and/or &lt;res:resourceItem&gt; elements within the enclosing &lt;resourceData&gt; element. 
            </iso:assert>
        </iso:rule>
    </iso:pattern>
    
    <iso:pattern>
        <iso:rule context="res:resourceItem[not(@mimeType)]" see="&this-loc;/&name;-&stage;.html#res_resourceItem">
            <iso:assert test="./res:source/* and ./res:target/*" diagnostics="spec-quote-mime">
                The children &lt;res:source&gt; and/or &lt;res:target&gt; elements are empty, but the mimeType attribute is missing.
            </iso:assert>
        </iso:rule>
    </iso:pattern>
    
    <iso:pattern>
        <iso:rule context="res:source[not(@href)]" see="&this-loc;/&name;-&stage;.html#res_source">
            <iso:assert test="*" diagnostics="spec-quote-href">
                The &lt;res:source&gt; element is empty, but the href attribute is missing.
            </iso:assert>
        </iso:rule>
    </iso:pattern>
    
    <iso:pattern>
        <iso:rule context="res:source[@xml:lang]" see="&this-loc;/&name;-&stage;.html#res_source">
            <iso:let name="srcLang" value="/xlf:xliff/@srcLang"/>
            <iso:assert test="lang($srcLang)" diagnostics="spec-quote-lang">
                xml:lang attribute of &lt;res:source&gt; element and srcLang of enclosing &lt;xliff&gt; are not matching.
            </iso:assert>
        </iso:rule>
    </iso:pattern>
    
    <iso:pattern>
        <iso:rule context="res:target[not(@href)]" see="&this-loc;/&name;-&stage;.html#res_target">
            <iso:assert test="*" diagnostics="spec-quote-t-href">
                The &lt;res:target&gt; element is empty, but the href attribute is missing.
            </iso:assert>
        </iso:rule>
    </iso:pattern>
    
    <iso:pattern>
        <iso:rule context="res:target[@xml:lang]" see="&this-loc;/&name;-&stage;.html#res_source">
            <iso:let name="trgLang" value="ancestor::xlf:xliff/@trgLang"/>
            <iso:assert test="lang($trgLang)" diagnostics="spec-quote-t-lang">
                xml:lang attribute of &lt;res:target&gt; element and trgLang of enclosing &lt;xliff&gt; are not matching.
            </iso:assert>
        </iso:rule>
    </iso:pattern>
    
    <iso:diagnostics>
        <iso:diagnostic id="spec-quote-id">
            The value of the <iso:emph>optional</iso:emph> id attribute <iso:emph>must</iso:emph> be unique among all &lt;resourceItem&gt; and &lt;resourceItemRef&gt; elements of the enclosing &lt;resourceData&gt; element.
        </iso:diagnostic>
        <iso:diagnostic id="spec-quote-mime">
            The mimeType attribute is <iso:emph>required</iso:emph> if &lt;target&gt; and &lt;source&gt; child elements are empty, otherwise it is <iso:emph>optional</iso:emph>.
        </iso:diagnostic>
        <iso:diagnostic id="spec-quote-href">
            The attribute href is <iso:emph>required</iso:emph> if and only if &lt;source&gt; is empty.
        </iso:diagnostic>
        <iso:diagnostic id="spec-quote-lang">
            When the <iso:emph>optional</iso:emph> xml:lang attribute is present, its value <iso:emph>must</iso:emph> be equal to the value of the srcLang attribute of the enclosing &lt;xliff&gt; element.
        </iso:diagnostic>
        <iso:diagnostic id="spec-quote-t-href">
            The attribute href is <iso:emph>required</iso:emph> if and only if &lt;target&gt; is empty.
        </iso:diagnostic>
        <iso:diagnostic id="spec-quote-t-lang">
            When the <iso:emph>optional</iso:emph> xml:lang attribute is present, its value <iso:emph>must</iso:emph> be equal to the value of the trgLang attribute of the enclosing &lt;xliff&gt; element.
        </iso:diagnostic>
    </iso:diagnostics>


</iso:schema>