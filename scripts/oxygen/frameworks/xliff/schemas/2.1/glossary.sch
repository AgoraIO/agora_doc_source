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
    xmlns:gls="urn:oasis:names:tc:xliff:glossary:2.0"
    queryBinding='xslt2' 
    schemaVersion='ISO19757-3'>
    <iso:title>Schematron rules for checking the constraints of the Glossary module against XLIFF Vesrion &version; spec</iso:title>
    <iso:ns prefix="gls" uri="urn:oasis:names:tc:xliff:glossary:2.0"/>
    <iso:ns prefix="xlf" uri="urn:oasis:names:tc:xliff:document:2.0"/>    
    
    <iso:pattern>
        <iso:rule context="gls:glossEntry" see="&this-loc;/&name;-&stage;.html#glossentry">
            <iso:assert test="child::gls:translation or child::gls:definition" diagnostics="spec-quote-ge">
                Incomplete &lt;gls:glossEntry&gt; element.
            </iso:assert>
        </iso:rule>
    </iso:pattern>
    
    <iso:pattern>
        <iso:rule context="gls:glossEntry[@id]" see="&this-loc;/&name;-&stage;.html#gls_id">
            <iso:let name="id" value="@id"/>
            <iso:let name="check" value="count(following-sibling::gls:glossEntry[@id=$id] | ..//gls:translation[@id=$id])"/>
            <iso:assert test="$check=0" diagnostics="spec-quote-id">
                id duplication found among &lt;gls:glossEntry&gt; and/or &lt;gls:translation&gt; elements.
            </iso:assert>
        </iso:rule>
    </iso:pattern>    
    <iso:pattern>
        <iso:rule context="gls:translation[@id]" see="&this-loc;/&name;-&stage;.html#gls_id">
            <iso:let name="id" value="@id"/>
            <iso:let name="check" value="../..//gls:translation[@id=$id]"/>
            <iso:assert test="count($check)=1">
                id duplication found among &lt;gls:translation&gt; elements.
            </iso:assert>
        </iso:rule>
    </iso:pattern>
    
   <iso:diagnostics>
        <iso:diagnostic id="spec-quote-ge">
            A &lt;gls:glossEntry&gt; element <iso:emph>must</iso:emph> contain a &lt;gls:translation&gt; or a &lt;gls:definition&gt; element to be valid.
        </iso:diagnostic>
        <iso:diagnostic id="spec-quote-id">
            The values of id attributes <iso:emph>must</iso:emph> be unique among all &lt;glossEntry&gt; and &lt;translation&gt; elements within the given enclosing &lt;glossary&gt; element.
        </iso:diagnostic>
    </iso:diagnostics>
</iso:schema>
