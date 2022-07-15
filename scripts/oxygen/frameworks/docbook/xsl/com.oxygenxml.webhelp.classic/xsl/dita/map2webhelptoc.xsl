<?xml version="1.0" encoding="UTF-8" ?>
<!--
    
Oxygen Webhelp plugin
Copyright (c) 1998-2021 Syncro Soft SRL, Romania.  All rights reserved.

-->

<xsl:stylesheet version="2.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:oxygen="http://www.oxygenxml.com/functions"
    exclude-result-prefixes="oxygen">

   <!-- The language used by the Webhelp indexer when it will parse the words from the HTML pages. -->
   <xsl:param name="INDEXER_LANGUAGE"/>


    <xsl:template name="generateMapTitleInBody">
      <!-- from map2htmltoc.xsl, added h1's -->
      <xsl:choose>
        <xsl:when test="/*[contains(@class,' map/map ')]/*[contains(@class,' topic/title ')]">
          <h1>
            <xsl:value-of select="normalize-space(/*[contains(@class,' map/map ')]/*[contains(@class,' topic/title ')])"/>
          </h1>          
        </xsl:when>
        <xsl:when test="/*[contains(@class,' map/map ')]/@title">
          <h1>
            <xsl:value-of select="/*[contains(@class,' map/map ')]/@title"/>
          </h1>
        </xsl:when>
      </xsl:choose>
      
      <!-- end -->
  </xsl:template>
    
    
  <xsl:template match="/*[contains(@class, ' map/map ')]">
    <xsl:param name="pathFromMaplist"/>
    <xsl:if test=".//*[contains(@class, ' map/topicref ')][not(@toc='no')][not(@processing-role='resource-only')]">
      <!-- OXYGEN PATCH START EXM-17248 -->
    <div id="tree">
      <ul>
        <!-- OXYGEN PATCH END EXM-17248 -->
        
        <xsl:apply-templates select="*[contains(@class, ' map/topicref ')]">
          <xsl:with-param name="pathFromMaplist" select="$pathFromMaplist"/>
        </xsl:apply-templates>
      </ul>
    </div>
      
    </xsl:if>
  </xsl:template>
  
</xsl:stylesheet>