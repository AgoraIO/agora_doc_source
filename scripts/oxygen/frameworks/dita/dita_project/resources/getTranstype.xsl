<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
  exclude-result-prefixes="xs xd"
  version="2.0">
  <xsl:param name="documentSystemID"></xsl:param>
  
  <xsl:template name="start">
    <items action="append">
      <xsl:apply-templates select="doc('platform:config/plugins.xml')"/>
    </items>
  </xsl:template>
    
  <xsl:template match="transtype[not(@abstract='true')]">
    <item xmlns="http://www.oxygenxml.com/ns/ccfilter/config" value="{@name}" annotation="{@desc}"/>
  </xsl:template>
  
  
</xsl:stylesheet>