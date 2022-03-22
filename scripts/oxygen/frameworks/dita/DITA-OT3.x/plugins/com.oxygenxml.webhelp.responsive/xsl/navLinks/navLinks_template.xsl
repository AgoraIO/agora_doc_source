<?xml version="1.0" encoding="UTF-8"?>
<!--
    
Oxygen Webhelp plugin
Copyright (c) 1998-2022 Syncro Soft SRL, Romania.  All rights reserved.

-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    exclude-result-prefixes="#all"
    version="2.0">
    
  <xsl:import href="navLinksImpl.xsl"/>

  <!--
    XSLT extension point for the stylesheet used to create the navigation links related files. 
  -->
  <dita:extension id="com.oxygenxml.webhelp.xsl.createNavLinks"
        behavior="org.dita.dost.platform.ImportXSLAction"
        xmlns:dita="http://dita-ot.sourceforge.net"/>
  
  <!-- WH-1782 com.oxygenxml.webhelp.xsl.createNavLinks extension point -->
  <xsl:import href="template:xsl/com.oxygenxml.webhelp.xsl.createNavLinks"/>  
</xsl:stylesheet>
