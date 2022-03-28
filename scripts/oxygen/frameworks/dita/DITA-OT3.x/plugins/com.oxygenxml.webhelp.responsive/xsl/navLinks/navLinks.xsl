<?xml version="1.0" encoding="UTF-8"?><!--
    
Oxygen Webhelp plugin
Copyright (c) 1998-2022 Syncro Soft SRL, Romania.  All rights reserved.

--><xsl:stylesheet xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="#all" version="2.0">
    
  <xsl:import href="navLinksImpl.xsl"/>

  <!--
    XSLT extension point for the stylesheet used to create the navigation links related files. 
  -->
  
  
  <!-- WH-1782 com.oxygenxml.webhelp.xsl.createNavLinks extension point -->
  <xsl:import xmlns:dita="http://dita-ot.sourceforge.net" href="template:xsl/com.oxygenxml.webhelp.xsl.createNavLinks"/>  
</xsl:stylesheet>