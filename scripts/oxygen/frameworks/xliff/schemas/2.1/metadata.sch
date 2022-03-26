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
    xmlns:mda="urn:oasis:names:tc:xliff:metadata:2.0"
    queryBinding='xslt2' 
    schemaVersion='ISO19757-3'>
    <iso:title>Schematron rules for checking the constraints of the Metadata module against XLIFF Version &version;</iso:title>
    <iso:ns prefix="mda" uri="urn:oasis:names:tc:xliff:metadata:2.0"/>
    <iso:ns prefix="xlf" uri="urn:oasis:names:tc:xliff:document:2.0"/>
    
    <iso:pattern>
        <iso:rule context="mda:metadata[@id]" see="&this-loc;/&name;-&stage;.html#meta_id">
            <iso:let name="id" value="@id"/>
            <iso:let name="d-check" value="count(descendant::mda:*[@id=$id])"/>
            <iso:assert test="$d-check=0" diagnostics="spec-quote">
                id duplication found. The &lt;mda:metadata&gt; element is using the same id value (<iso:value-of select="$id"/>) as its descendant element(s). 
            </iso:assert>
        </iso:rule>
    </iso:pattern>
    <iso:pattern>
        <iso:rule context="mda:metaGroup[@id]" see="&this-loc;/&name;-&stage;.html#meta_id">
            <iso:let name="id" value="@id"/>
            <iso:let name="self-check" value="count(following-sibling::mda:metaGroup[@id=$id] | descendant::mda:metaGroup[@id=$id] | ancestor::mda:metadata//mda:metaGroup[@id=$id])"/>
            <iso:assert test="$self-check=0" diagnostics="spec-quote">
                id duplication found among &lt;metaGroup&gt; elements within the enclosing &lt;metadata&gt; element.
            </iso:assert>
        </iso:rule>
    </iso:pattern>
    
    <iso:diagnostics>
        <iso:diagnostic id="spec-quote">
            The values of id attributes <iso:emph>must</iso:emph> be unique among all &lt;metaGroup&gt; and &lt;metadata&gt; elements within the given enclosing &lt;metadata&gt; element.
        </iso:diagnostic>
    </iso:diagnostics>
</iso:schema>