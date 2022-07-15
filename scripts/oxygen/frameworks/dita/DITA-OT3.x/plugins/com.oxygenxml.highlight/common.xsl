<?xml version='1.0'?>
<!--
    
Oxygen Codeblock Highlights plugin
Copyright (c) 1998-2022 Syncro Soft SRL, Romania.  All rights reserved.
Licensed under the terms stated in the license file README.txt 
available in the base directory of this plugin.

-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:d="http://docbook.org/ns/docbook"
  xmlns:ConnectorSaxonEE="java:net.sf.xslthl.ConnectorSaxonEE"
  xmlns:ConnectorSaxonB="java:net.sf.xslthl.ConnectorSaxonB"
  xmlns:saxonb="http://saxon.sf.net/" 
  xmlns:exsl="http://exslt.org/common"
  xmlns:xslthl="http://xslthl.sf.net"
  xmlns:version="java:net.sf.saxon.Version"
  xmlns:oxy="http://www.oxygenxml.com/ns/author/xpath-extension-functions"
  exclude-result-prefixes="exsl ConnectorSaxonEE ConnectorSaxonB d oxy"
  version='2.0'>
	
	<!-- Sequence containing all highlight IDs -->
	<xsl:param name="allConfigHighlights" select="document('highlighters/xslthl-config.xml')//highlighter/@id"/>
  
  <xsl:template name="outputStyling" use-when="function-available('version:getProductVersion') or function-available('oxy:highlight')">
    <xsl:choose>
      <xsl:when test="@outputclass">
        <xsl:variable name="type">
          <xsl:choose>
            <xsl:when test="starts-with(@outputclass, 'language-')">
              <!-- Either starts with a certain language -->
              <xsl:value-of select="substring-after(@outputclass, 'language-')"/>
            </xsl:when>
            <xsl:otherwise>
              <!-- or not -->
              <xsl:value-of select="@outputclass"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <!-- CONFIG FILE FOR SH -->
        <xsl:variable name="config" select="document('highlighters/xslthl-config.xml')"/>
        <!-- We'll try to use XSLTHL -->
        <xsl:variable name="content">
          <xsl:apply-templates/>
        </xsl:variable>
        <xsl:choose>
          <xsl:when test="$config//*[@id=$type]">
            <!-- We found a SH for it -->
            <xsl:apply-templates select="$content" mode="highlight-content">
              <xsl:with-param name="config-base-uri" select="base-uri($config)"/>
              <xsl:with-param name="type" select="$type"/>
            </xsl:apply-templates>
          </xsl:when>
          <xsl:otherwise>
            <xsl:copy-of select="$content"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <!-- No syntax highlight -->
        <xsl:apply-templates/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <!-- Only the text content is passed to the highlighter -->
  <xsl:template match="text()" mode="highlight-content">
    <xsl:param name="config-base-uri"/>
    <xsl:param name="type"/>
    <xsl:variable name="textValue"><xsl:value-of select="."/></xsl:variable>
    <xsl:apply-templates 
      select="oxy:highlight($type, $textValue, $config-base-uri)" mode="xslthl" 
      use-when="function-available('oxy:highlight')"/>
    <xsl:apply-templates 
      select="if(version:getProductVersion() ne '9.1.0.8') then ConnectorSaxonEE:highlight($type, $textValue, $config-base-uri) else /.." mode="xslthl" 
      use-when="not(function-available('oxy:highlight')) and function-available('ConnectorSaxonEE:highlight') and function-available('version:getProductVersion')"/>
    <xsl:apply-templates 
      select="if(version:getProductVersion() eq '9.1.0.8') then ConnectorSaxonB:highlight($type, $textValue, $config-base-uri) else /.." mode="xslthl" 
      use-when="function-available('ConnectorSaxonB:highlight') and function-available('version:getProductVersion')"/>
    <xsl:value-of select="$textValue" 
      use-when="(:Saxon HE without oxy:highlight installed:)
      (not(function-available('version:getProductVersion')) and not(function-available('oxy:highlight'))) or
      (:No highlight function available:)
      (not(function-available('ConnectorSaxonEE:highlight')) and not(function-available('ConnectorSaxonB:highlight')) and not(function-available('oxy:highlight')))"/>
  </xsl:template>
  
  <xsl:template match="* | comment() | processing-instruction() | @*" mode="highlight-content">
    <xsl:param name="config-base-uri"/>
    <xsl:param name="type"/>
    <xsl:copy>
      <xsl:apply-templates select="node() | @*" mode="highlight-content">
        <xsl:with-param name="config-base-uri" select="$config-base-uri"/>
        <xsl:with-param name="type" select="$type"/>
      </xsl:apply-templates>
    </xsl:copy>
  </xsl:template>
  
  <!-- A fallback when the specific style isn't recognized -->
  <xsl:template match="xslthl:*" mode="xslthl">
    <xsl:message>
      <xsl:text>unprocessed xslthl style: </xsl:text>
      <xsl:value-of select="local-name(.)" />
      in fragment:
      <xsl:copy-of select="."/>
    </xsl:message>
    <xsl:apply-templates mode="xslthl"/>
  </xsl:template>
  
  <!-- Copy over already produced markup (FO/HTML) -->
  <xsl:template match="node()" mode="xslthl" priority="-1">
    <xsl:copy>
      <xsl:apply-templates select="node()" mode="xslthl"/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="*" mode="xslthl">
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates select="node()" mode="xslthl"/>
    </xsl:copy>
  </xsl:template>
  
</xsl:stylesheet>
