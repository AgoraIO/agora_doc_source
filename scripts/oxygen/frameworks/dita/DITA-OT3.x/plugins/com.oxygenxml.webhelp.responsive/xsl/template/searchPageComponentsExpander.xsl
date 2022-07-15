<?xml version="1.0" encoding="UTF-8"?>
<!--
    
Oxygen Webhelp plugin
Copyright (c) 1998-2022 Syncro Soft SRL, Romania.  All rights reserved.

-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc"
  xmlns:index="http://www.oxygenxml.com/ns/webhelp/index"   
  xmlns:oxygen="http://www.oxygenxml.com/functions" xmlns:d="http://docbook.org/ns/docbook"
  xmlns:whc="http://www.oxygenxml.com/webhelp/components"
  xmlns="http://www.w3.org/1999/xhtml"    
  xmlns:xs="http://www.w3.org/2001/XMLSchema" 
  xmlns:html="http://www.w3.org/1999/xhtml"
  exclude-result-prefixes="#all" version="2.0">
  
  <xsl:import href="commonComponentsExpander.xsl"/>
  
  <xsl:template match="html:html" mode="copy_template">
    <xsl:copy copy-namespaces="no">
      <xsl:apply-templates select="@*" mode="#current"/>
      <xsl:attribute name="lang" select="oxygen:getParameter('webhelp.language')"/>
      <xsl:attribute name="dir" select="oxygen:getParameter('webhelp.page.direction')"/>
      
      <!-- Copy elements -->
      <xsl:apply-templates select="node()" mode="#current"/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="whc:webhelp_search_results" mode="copy_template">
    <xsl:param name="template_base_uri" tunnel="yes"/>
    <xsl:param name="i18n_context" tunnel="yes" as="element()*"/>
    
    <xsl:variable name="webhelp_search_results">
      <xsl:choose>
        <xsl:when test="string-length($WEBHELP_SEARCH_SCRIPT) > 0 and string-length($WEBHELP_SEARCH_RESULT) > 0">
          <xsl:copy-of select="doc($WEBHELP_SEARCH_RESULT)"/>
        </xsl:when>
        <xsl:when test="oxygen:getParameter('webhelp.custom.search.engine.enabled') = 'true'">
          <div class="wh_custom_search_engine_container">
            <xsl:call-template name="extractFileContent">
              <xsl:with-param name="href" select="oxygen:getParameter('webhelp.fragment.custom.search.engine.script')"/>
              <xsl:with-param name="template_base_uri" select="$template_base_uri"/>
            </xsl:call-template>
            <xsl:call-template name="extractFileContent">
              <xsl:with-param name="href" select="oxygen:getParameter('webhelp.fragment.custom.search.engine.results')"/>
              <xsl:with-param name="template_base_uri" select="$template_base_uri"/>
            </xsl:call-template>
          </div>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="whPluginDir" select="oxygen:getParameter('webhelp.responsive.dir')"/>
          <xsl:variable name="pageLibRefsDir" select="concat($whPluginDir, '/oxygen-webhelp/page-templates-fragments/search/')"/>
          <xsl:call-template name="extractFileContent">
            <xsl:with-param name="href" select="concat($pageLibRefsDir, 'search-results.html')"/>
            <xsl:with-param name="template_base_uri" select="$template_base_uri"/>
          </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
    <xsl:call-template name="outputComponentContent">
      <xsl:with-param name="compContent" select="$webhelp_search_results"/>
      <xsl:with-param name="compName" select="local-name()"/>
    </xsl:call-template>
  </xsl:template>
  
  <!-- 
    Concat Search Results with map title.
  -->
  <xsl:template name="generatePageTitle">
    <xsl:param name="mainBookTitle"/>
    <xsl:param name="mapTitle"/>
    <title>
      <xsl:choose>
        <xsl:when test="exists($i18n_context)">
          <xsl:for-each select="$i18n_context[1]">
            <xsl:call-template name="getWebhelpString">
              <xsl:with-param name="stringName" select="'SearchResults'"/>
            </xsl:call-template>
          </xsl:for-each>
        </xsl:when>
        <xsl:otherwise>Search Results</xsl:otherwise>
      </xsl:choose>
      
      <xsl:choose>
        <xsl:when test="exists($mainBookTitle)">
          <xsl:value-of select="concat(' - ', $mainBookTitle)"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="concat(' - ', $mapTitle)"/>
        </xsl:otherwise>
      </xsl:choose>
    </title>
  </xsl:template>
  
</xsl:stylesheet>