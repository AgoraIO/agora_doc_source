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
    <xsl:variable name="paramName" select="$propertyElement/@name"/>
    
    <items>
      <xsl:apply-templates select="doc('platform:config/plugins.xml')//transtype[@name=$transtype]">
        <xsl:with-param name="paramName" select="$paramName" tunnel="yes"/>
      </xsl:apply-templates>
    </items>
  </xsl:template>
  
  
  <xsl:template match="transtype">
      <xsl:param name="paramName" tunnel="yes"/>
    
      <xsl:apply-templates select="param[@name=$paramName]"/>
    <xsl:choose>
      <xsl:when test="@extends">
        <xsl:apply-templates select="//transtype[@name=@extends]">
          <xsl:with-param name="paramName" select="$paramName" tunnel="yes"/>
        </xsl:apply-templates>
      </xsl:when>
      <xsl:otherwise>
        <!-- Add base params if not specified explicitly -->
        <xsl:if test="not(@name='base')">
          <xsl:apply-templates select="//transtype[@name='base']">
            <xsl:with-param name="paramName" select="$paramName" tunnel="yes"/>
          </xsl:apply-templates>
        </xsl:if>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="param">
    <xsl:for-each select="val">
      <item xmlns="http://www.oxygenxml.com/ns/ccfilter/config" 
        value="{.}" annotation="{@desc}&#10;Type: {../@type} {concat('&#10;', (if (@default='true') then 'Default value' else ''))}"/>
    </xsl:for-each>
  </xsl:template>
  
  
</xsl:stylesheet>




  
