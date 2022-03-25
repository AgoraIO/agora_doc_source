<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs"
  xmlns:xr="http://www.oxygenxml.com/ns/xmlRefactoring" version="3.0"
  xmlns:oxy="http://www.oxygenxml.com/oxy"
  xmlns:xrf="http://www.oxygenxml.com/ns/xmlRefactoring/functions">
  
  <!-- The XPath that identifies the elements to be updated -->
  <xsl:param name="element_names" as="xs:string" required="yes"/>
  <xsl:variable name="names" select="tokenize(translate($element_names, ' ', ''), ',')"/>
  
  <!-- The name of the id attributes to be added -->
  <xsl:variable name="attribute_name" as="xs:string" select="'id'"/>
  <!-- The name of the id attributes to be added -->
  <xsl:param name="value_pattern" as="xs:string" required="yes"/>
  
  <xsl:variable name="alphabet">qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM</xsl:variable>
  <xsl:variable name="length">20</xsl:variable>
  
  <xsl:template match="node() | @*">
    <xsl:copy>
      <xsl:apply-templates select="node() | @*"/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="*[name() = $names and not(exists(@*[name()=$attribute_name]))]" 
     priority="10">
    <xsl:copy>
      <xsl:attribute name="{$attribute_name}" select="xr:generateId($value_pattern, .)"/>
      <xsl:apply-templates select="node() | @*"/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:function name="xr:generateId" as="xs:string">
    <xsl:param name="pattern"/>
    <xsl:param name="node"/>
    
    <xsl:variable name="result1">
      <xsl:choose>
        <xsl:when use-when="function-available('xrf:expand-editor-variables')" test="true()">
          <xsl:value-of select="xrf:expand-editor-variables($value_pattern, base-uri($node))"/>
        </xsl:when>
        <xsl:when test="contains($pattern, '${id}')">
          <xsl:value-of select="replace($pattern, '\$\{id\}', generate-id($node))"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="concat($pattern, generate-id($node))"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="result2">
          <xsl:value-of select="replace($result1, '\$\{localName\}', local-name($node))"/>
    </xsl:variable>
    <xsl:value-of select="$result2"/>
  </xsl:function>
  
  <xsl:function name="xr:toText">
    <xsl:param name="seq"/>
    <xsl:variable name="result">
    <xsl:for-each select="$seq">
      <xsl:value-of select="substring($alphabet, current(), 1)"/>
    </xsl:for-each>
    </xsl:variable>
    <xsl:value-of select="$result"/>
  </xsl:function>
  
</xsl:stylesheet>
