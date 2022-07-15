<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:saxon="http://saxon.sf.net/"
  exclude-result-prefixes="xs"
  version="2.0">
  
  <xsl:param name="documentSystemID" as="xs:string"></xsl:param>
  <xsl:param name="contextElementXPathExpression" as="xs:string"></xsl:param>
  
  <xsl:template name="start">
    <xsl:apply-templates select="doc($documentSystemID)" mode="start"/>
  </xsl:template>
  
  <xsl:template match="/" mode="start">
    <xsl:variable name="propertyElement" 
      select="saxon:eval(saxon:expression($contextElementXPathExpression, ./*))"/>
    <xsl:variable name="transtype" select="$propertyElement/../@transtype"/>
    
    <items>
      <xsl:apply-templates select="doc('platform:config/plugins.xml')//transtype[@name=$transtype]"/>
    </items>
  </xsl:template>
  
  
  
  <xsl:template match="transtype">
      <xsl:apply-templates/>
    <xsl:choose>
      <xsl:when test="@extends">
        <xsl:apply-templates select="//transtype[@name=@extends]"/>
      </xsl:when>
      <xsl:otherwise>
        <!-- Add base params if not specified explicitly -->
        <xsl:if test="not(@name='base')">
          <xsl:apply-templates select="//transtype[@name='base']"/>
        </xsl:if>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="param">
    <item xmlns="http://www.oxygenxml.com/ns/ccfilter/config" value="{@name}" annotation="{@desc}&#10;Type: {@type} {for $i in ./val return concat('&#10;  ', $i, (if ($i/@desc) then ' - ' else ''), normalize-space($i/@desc))}"/>
  </xsl:template>
  
  
</xsl:stylesheet>




  
