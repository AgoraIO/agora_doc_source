<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    xmlns:xr="http://www.oxygenxml.com/ns/xmlRefactoring"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <!-- 
       All HTML page layout files should be specified. 
    -->
    <sch:pattern id="html-page-layout-files">
        <sch:rule context="html-page-layout-files">
            <!-- Change the assert expression. -->
            <sch:assert test="page-layout-file[@page='main']">The HTML layout file for main page should be specified.</sch:assert>            
            <sch:assert test="page-layout-file[@page='search']">The HTML layout file for search page should be specified.</sch:assert>
            <sch:assert test="page-layout-file[@page='topic']">The HTML layout file for topic page should be specified.</sch:assert>
            <sch:assert test="page-layout-file[@page='index-terms']">The HTML layout file for index-terms page should be specified.</sch:assert>
        </sch:rule>        
    </sch:pattern>
    
    <!-- Customization folder URI -->
    <sch:let name="cfURI" value="concat(string-join(tokenize(base-uri(), '/')[position() &lt; last()], '/'), '/')"/>
    
    <!-- Test that the files associated with HTML page templates exist on disk -->
    <sch:pattern id="page-layout-file">
        <sch:rule context="page-layout-file[@file]">
            <sch:let name="pageTemplateURI" value="concat($cfURI, @file)"/>                
            <sch:assert test="doc-available($pageTemplateURI)">The HTML layout page file does not exist: <sch:value-of select="$pageTemplateURI"/>.</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <!-- Test that the files associated with template resources exist on disk -->
    <sch:pattern id="resources">         
        <sch:rule context="css[@file]">
            <sch:let name="cssURI" value="concat($cfURI, @file)"/>
            <sch:assert test="
                unparsed-text-available($cssURI)">The CSS template resource does not exist: <sch:value-of select="$cssURI"/>.</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <!-- 
        Test that the files associated with XSLT extension points exist on disk 
    -->
    <sch:pattern id="xslt-resources">         
        <sch:rule context="xslt/extension[@file]">
            <sch:let name="resourcesURI" value="concat($cfURI, @file)"/>          
            <sch:assert test="doc-available($resourcesURI)">The referenced XSLT stylesheet does not exist: <sch:value-of select="$resourcesURI"/>.</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <!-- 
        Test that the files associated with HTML-fragments extension points exist on disk 
    -->
    <sch:pattern id="html-fragment-resources">         
        <sch:rule context="html-fragments/fragment[@file]">
            <sch:let name="resourcesURI" value="concat($cfURI, @file)"/>          
            <sch:assert test="doc-available($resourcesURI)">The resource associated with the HTML fragment does not exist: <sch:value-of select="$resourcesURI"/>.</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <!-- Test that a CSS file is associated either in css element or 'args.css' parameter -->
    <sch:pattern id="css-resources">
        <sch:rule context="parameter" role="warning">
            <sch:assert test="not(@name = 'args.css')">The CSS template resource should be referenced inside the resources/css element.</sch:assert>
        </sch:rule>
    </sch:pattern>
</sch:schema>