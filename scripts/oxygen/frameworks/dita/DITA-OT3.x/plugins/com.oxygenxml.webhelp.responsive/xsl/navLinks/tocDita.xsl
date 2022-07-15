<?xml version="1.0" encoding="UTF-8"?><!--
    
Oxygen Webhelp plugin
Copyright (c) 1998-2022 Syncro Soft SRL, Romania.  All rights reserved.

--><xsl:stylesheet xmlns:index="http://www.oxygenxml.com/ns/webhelp/index" xmlns:oxygen="http://www.oxygenxml.com/functions" xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="#all" version="2.0">
    
  <xsl:import href="tocDitaImpl.xsl"/>

  <!--
    XSLT extension point for the stylesheet used to produce the toc.xml file. 
  -->
  
  
  <!-- WH-1439, WH-1829 com.oxygenxml.webhelp.xsl.createTocXML extension point -->
  <xsl:import xmlns:dita="http://dita-ot.sourceforge.net" href="template:xsl/com.oxygenxml.webhelp.xsl.createTocXML"/>
</xsl:stylesheet>