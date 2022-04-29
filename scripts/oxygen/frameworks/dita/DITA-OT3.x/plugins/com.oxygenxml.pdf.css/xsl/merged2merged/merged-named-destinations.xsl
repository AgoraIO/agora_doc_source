<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    Propagate the DITA attributes to the output.
    In this way the print CSSs developed for the direct 
    transformation are common with the ones for the HTML transformation.
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:oxy="http://www.oxygenxml.com/extensions/author"
    xmlns:nd="http://www.oxygenxml.com/css2fo/named-destinations"
    exclude-result-prefixes="xs oxy nd"
    
    version="2.0">
    
    <xsl:template match="@id" priority="20">
    
      <xsl:next-match/>
    
      <xsl:choose>
        <xsl:when test="../@oid">
          <xsl:attribute name="nd:nd-id" select="../@oid"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="extracted-oid" select="oxy:getOriginalDITAIDValue(.)"/>
          <xsl:if test="not($extracted-oid = .) and string-length($extracted-oid) > 0">
            <xsl:attribute name="nd:nd-id" select="$extracted-oid"/>
          </xsl:if>
        </xsl:otherwise>
      </xsl:choose>
      
    </xsl:template>
    
</xsl:stylesheet>