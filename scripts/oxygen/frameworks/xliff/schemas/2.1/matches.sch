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
    xmlns:mtc="urn:oasis:names:tc:xliff:matches:2.0"
    queryBinding='xslt2' 
    schemaVersion='ISO19757-3'>
    <iso:title>Schematron rules for checking the constraints of the Translation Candidate Annotation module against XLIFF Version &version;</iso:title>
    <iso:ns prefix="mtc" uri="urn:oasis:names:tc:xliff:matches:2.0"/>
    <iso:ns prefix="xlf" uri="urn:oasis:names:tc:xliff:document:2.0"/>    
    <iso:pattern>
        <iso:rule context="mtc:match[@id]" see="&this-loc;/&name;-&stage;.html#candidates_id">
            <iso:let name="id" value="@id"/>
            <iso:let name="id-check" value="count(following-sibling::mtc:match[@id=$id])"/>
            <iso:assert test="$id-check=0" diagnostics="spec-qoute">
                id duplication found. The value '<iso:value-of select="$id"/>' is used more than once for &lt;match&gt; elements within the enclosing &lt;matches&gt; element.
            </iso:assert>
        </iso:rule>        
    </iso:pattern>
        
    <iso:pattern>
        <iso:rule context="mtc:match[@subType]" see="&this-loc;/&name;-&stage;.html#candidates_subtype">
            <iso:assert test="@type" diagnostics="spec-qoute-sub">
                subType attribute is used, but the type attribute is missing.
            </iso:assert>
        </iso:rule>
    </iso:pattern>
    
    <iso:diagnostics>
        <iso:diagnostic id="spec-qoute">
            The id value <iso:emph>must</iso:emph> be unique within the enclosing &lt;matches&gt; element.
        </iso:diagnostic>
        <iso:diagnostic id="spec-qoute-sub">
            If the attribute subType is used, the attribute type <iso:emph>must</iso:emph> be explicitly set.
        </iso:diagnostic>
    </iso:diagnostics>
</iso:schema>