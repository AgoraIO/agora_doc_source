<?xml version="1.0" encoding="UTF-8"?>
<!--
    
Oxygen WebHelp Plugin
Copyright (c) 1998-2022 Syncro Soft SRL, Romania.  All rights reserved.

-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:xhtml="http://www.w3.org/1999/xhtml"  
  exclude-result-prefixes="xs xhtml"
  version="2.0">
  <!--Fix up all empty namespaces to the XHTML namespace -->
  <xsl:template match="*[namespace-uri() eq '']" mode="fixup_XHTML_NS">
    <xsl:element name="{name()}" namespace="http://www.w3.org/1999/xhtml">
      <xsl:apply-templates select="@* | node()" mode="fixup_XHTML_NS"/>
    </xsl:element>
  </xsl:template>
  
  <xsl:template match="@* | node()" mode="fixup_XHTML_NS">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()" mode="fixup_XHTML_NS"/>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>