<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
  exclude-result-prefixes="xs xd"
  version="2.0">
  <xsl:param name="documentSystemID"></xsl:param>
  
  <xsl:template name="start">
    <items action="replace">
      <xsl:apply-templates select="doc($documentSystemID)"/>
    </items>
  </xsl:template>
    
  <xsl:template match="*:context[@id]">
    <item xmlns="http://www.oxygenxml.com/ns/ccfilter/config" value="{@id}" annotation="{@name}"/>
  </xsl:template>
  
  <xsl:template match="*:include[@href]">
    <xsl:variable name="doc" select="if (doc-available(resolve-uri(@href, base-uri()))) then document(@href) else ()"/>
    <xsl:apply-templates select="$doc"/>
  </xsl:template>
</xsl:stylesheet>