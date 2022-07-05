<?xml version="1.0" encoding="UTF-8" ?>
<!--
    
Oxygen Webhelp plugin
Copyright (c) 1998-2021 Syncro Soft SRL, Romania.  All rights reserved.

-->

<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <!--
  <xsl:import href="plugin:org.dita.xhtml:xsl/dita2xhtml.xsl"/>
  -->  
  <xsl:import href="plugin:org.dita.html5:xsl/dita2html5Impl.xsl"/>
  
  
  <xsl:import href="plugin:org.dita.xhtml:xsl/map2xhtmltoc.xsl"/>  
  <!--<xsl:import href="plugin:org.dita.html5:xsl/map2html5Impl.xsl"/>-->
  

  <xsl:import href="map2webhelptoc.xsl"/>
  <xsl:import href="../localization.xsl"/>
  <xsl:import href="../functions.xsl"/>

  <xsl:param name="TOC_FILE_NAME" select="'toc.html'"/>
  <xsl:param name="BASEDIR"/>
  <xsl:param name="OUTPUTDIR"/>
  <xsl:param name="LANGUAGE" select="'en-us'"/>
  
  <xsl:output method="xhtml" 
                   encoding="UTF-8"
                   indent="no"
                   doctype-public=""
                   doctype-system="about:legacy-compat"
                   omit-xml-declaration="yes"/>
</xsl:stylesheet>