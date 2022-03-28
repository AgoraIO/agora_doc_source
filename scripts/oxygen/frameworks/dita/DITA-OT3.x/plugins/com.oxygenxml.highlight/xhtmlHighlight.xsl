<?xml version="1.0" encoding="UTF-8"?>
<!--
    
Oxygen Codeblock Highlights plugin
Copyright (c) 1998-2022 Syncro Soft SRL, Romania.  All rights reserved.
Licensed under the terms stated in the license file README.txt 
available in the base directory of this plugin.

-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="2.0"
    xmlns:xslthl="http://xslthl.sf.net" exclude-result-prefixes="xslthl oxy"
    xmlns:version="java:net.sf.saxon.Version"
    xmlns:oxy="http://www.oxygenxml.com/ns/author/xpath-extension-functions">
  
  <xsl:include href="common.xsl"/>
  
  <!-- PRE -->
	<xsl:template match="*[contains(@class,' topic/pre ')][contains(@outputclass, 'language-') or @outputclass=$allConfigHighlights]" name="topic.pre" use-when="function-available('version:getProductVersion') or function-available('oxy:highlight')">
    <!-- This template is deprecated in DITA-OT 1.7. Processing will moved into the main element rule. -->
    <xsl:if test="contains(@frame,'top')"><hr /></xsl:if>
    <xsl:apply-templates select="*[contains(@class,' ditaot-d/ditaval-startprop ')]" mode="out-of-line"/>
    <xsl:call-template name="spec-title-nospace"/>
    <pre>
      <xsl:attribute name="class"><xsl:value-of select="name()"/></xsl:attribute>
      <xsl:call-template name="commonattributes"/>
      <xsl:call-template name="setscale"/>
      <xsl:call-template name="setidaname"/>
      <xsl:call-template name="outputStyling"/>
    </pre>
    <xsl:apply-templates select="*[contains(@class,' ditaot-d/ditaval-endprop ')]" mode="out-of-line"/>
    <xsl:if test="contains(@frame,'bot')"><hr /></xsl:if>
  </xsl:template>
  
  <xsl:template match="xslthl:json_key" mode="xslthl">
    <span class="hl-json_key">
      <xsl:apply-templates mode="xslthl"/>
    </span>
  </xsl:template>
  <xsl:template match="xslthl:keyword" mode="xslthl">
    <strong class="hl-keyword">
      <xsl:apply-templates mode="xslthl"/>
    </strong>
  </xsl:template>
  <xsl:template match="xslthl:string" mode="xslthl">
    <span class="hl-string">
      <xsl:apply-templates mode="xslthl"/>
    </span>
  </xsl:template>
  <xsl:template match="xslthl:comment" mode="xslthl">
    <em class="hl-comment">
      <xsl:apply-templates mode="xslthl"/>
    </em>
  </xsl:template>
  <xsl:template match="xslthl:directive" mode="xslthl">
    <span class="hl-directive">
      <xsl:apply-templates mode="xslthl"/>
    </span>
  </xsl:template>
  <xsl:template match="xslthl:tag" mode="xslthl">
    <strong class="hl-tag">
      <xsl:apply-templates mode="xslthl"/>
    </strong>
  </xsl:template>
  <xsl:template match="xslthl:attribute" mode="xslthl">
    <span class="hl-attribute">
      <xsl:apply-templates mode="xslthl"/>
    </span>
  </xsl:template>
  <xsl:template match="xslthl:value" mode="xslthl">
    <span class="hl-value">
      <xsl:apply-templates mode="xslthl"/>
    </span>
  </xsl:template>
  <xsl:template match='xslthl:html' mode="xslthl">
    <span class="hl-html">
      <xsl:apply-templates mode="xslthl"/>
    </span>
  </xsl:template>
  <xsl:template match="xslthl:xslt" mode="xslthl">
    <strong class="hl-xsl">
      <xsl:apply-templates mode="xslthl"/>
    </strong>
  </xsl:template>
  <!-- Not emitted since XSLTHL 2.0 -->
  <xsl:template match="xslthl:section" mode="xslthl">
    <strong class="hl-section">
      <xsl:apply-templates mode="xslthl"/>
    </strong>
  </xsl:template>
  <xsl:template match="xslthl:number" mode="xslthl">
    <span class="hl-number">
      <xsl:apply-templates mode="xslthl"/>
    </span>
  </xsl:template>
  <xsl:template match="xslthl:annotation" mode="xslthl">
    <em>
      <span class="hl-annotation">
        <xsl:apply-templates mode="xslthl"/>
      </span>
    </em>
  </xsl:template>
  <!-- Not sure which element will be in final XSLTHL 2.0 -->
  <xsl:template match="xslthl:doccomment" mode="xslthl">
    <span class="hl-tag-doctype-comment">
      <xsl:apply-templates mode="xslthl"/>
    </span>
  </xsl:template>
  <xsl:template match="xslthl:doctype" mode="xslthl">
    <span class="hl-tag-doctype">
      <xsl:apply-templates mode="xslthl"/>
    </span>
  </xsl:template>
  
</xsl:stylesheet>