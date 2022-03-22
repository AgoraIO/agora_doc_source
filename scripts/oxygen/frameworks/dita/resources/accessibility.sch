<?xml version="1.0" encoding="UTF-8"?>
<!--
  Copyright (c) 2018 Syncro Soft SRL - All Rights Reserved.

  This file contains proprietary and confidential source code.
  Unauthorized copying of this file, via any medium, is strictly prohibited.
  
  Check accessibility rules.
-->
<schema xmlns="http://purl.oclc.org/dsdl/schematron" 
    queryBinding="xslt2" xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <title>Accessibility rules for DITA 1.2</title>
    
    <ns uri="http://dita.oasis-open.org/architecture/2005/" prefix="ditaarch"/>
    
    <pattern id="no_alt_desc">
        <!-- EXM-28035 Avoid reporting warnings when the image has a @conref or @conkeyref, the attribute might be on the target. -->
        <rule context="*[contains(@class, ' topic/image ')][not(@conref)][not(@conkeyref)]">
            <assert test="@alt | alt" 
                flag="non-WAI" role="warning" sqf:fix="addAltElem" see="https://www.oxygenxml.com/dita/1.3/specs/langRef/base/image.html">                
                Images must have text alternatives that describe the information or function represented by them.</assert>
            
            <sqf:fix id="addAltElem">
                <sqf:description>
                    <sqf:title>Add alt element</sqf:title>   
                </sqf:description>
                <sqf:add node-type="element" target="alt"><xsl:processing-instruction name="oxy-placeholder">content="Insert alternate text here"</xsl:processing-instruction></sqf:add>                
            </sqf:fix>
        </rule>
    </pattern>    
</schema>