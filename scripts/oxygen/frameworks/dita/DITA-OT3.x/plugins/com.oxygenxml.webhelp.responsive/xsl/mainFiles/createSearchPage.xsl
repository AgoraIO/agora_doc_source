<?xml version="1.0" encoding="UTF-8"?><!--
    
Oxygen Webhelp plugin
Copyright (c) 1998-2022 Syncro Soft SRL, Romania.  All rights reserved.

 Generates the search results page for the WebHelp Responsive transformation.
--><xsl:stylesheet xmlns:index="http://www.oxygenxml.com/ns/webhelp/index" xmlns:oxygen="http://www.oxygenxml.com/functions" xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="#all" version="2.0">
    
  <xsl:import href="createSearchPageImpl.xsl"/>
  
  <!--
    XSLT extension point for the stylesheet used to produce the main HTML page 
    in the Webhelp Responsive transformation. 
  -->
  
  
  <!-- WH-1439 com.oxygenxml.webhelp.xsl.createSearchPage extension point -->
  <xsl:import xmlns:dita="http://dita-ot.sourceforge.net" href="template:xsl/com.oxygenxml.webhelp.xsl.createSearchPage"/>  
</xsl:stylesheet>