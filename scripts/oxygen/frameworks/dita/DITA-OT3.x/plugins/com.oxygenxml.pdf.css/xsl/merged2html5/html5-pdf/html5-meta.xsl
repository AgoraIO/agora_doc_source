<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:css-param="http://www.oxygenxml.com/extensions/publishing/dita/css/params"
                exclude-result-prefixes="#all" >
  
  <!-- Collect the keywords -->
  <xsl:template match="*" mode="gen-keywords-metadata">
    <xsl:variable name="keywords-content-at-map-level">
      <xsl:for-each select="descendant::*[contains(@class,' front-page/front-page ')]/*[contains(@class,' map/topicmeta ')]/*[contains(@class,' topic/keywords ')]/descendant-or-self::*">
          <!-- for each item inside keywords (including nested index terms) -->
          <xsl:if test="generate-id(key('meta-keywords',text()[1])[1]) = generate-id(.)">
            <xsl:variable name="first-keyword-position" select="if (contains(@class, 'topic/keyword')) then 2 else 3"/>
            <xsl:if test="position() > $first-keyword-position">
              <xsl:text>, </xsl:text>
            </xsl:if>
          </xsl:if>
          <xsl:value-of select="normalize-space(text()[1])"/>
      </xsl:for-each>
    </xsl:variable>

    <xsl:choose>
      <xsl:when test="string-length($keywords-content-at-map-level)">
        <!-- Map level keywords, these will be considered as important. -->
        <meta name="keywords" content="{$keywords-content-at-map-level}"/>
      </xsl:when>
      <xsl:otherwise>
        <!-- Copied from org.dita.html5/xsl/get-meta.xsl - default processing, that collects all keywords and indexterms from the content of the topics. -->
        <xsl:variable name="keywords-content">
          <!-- for each item inside keywords (including nested index terms) -->
          <xsl:for-each select="descendant::*[contains(@class,' topic/prolog ')]/*[contains(@class,' topic/metadata ')]/*[contains(@class,' topic/keywords ')]/descendant-or-self::*">
            <!-- If this is the first term or keyword with this value -->
            <xsl:if test="generate-id(key('meta-keywords',text()[1])[1]) = generate-id(.)">
              <xsl:variable name="first-keyword-position" select="if (contains(@class, 'topic/keyword')) then 2 else 3"/>
              <xsl:if test="position() > $first-keyword-position">
                <xsl:text>, </xsl:text>
              </xsl:if>
              <xsl:value-of select="normalize-space(text()[1])"/>
            </xsl:if>
          </xsl:for-each>
        </xsl:variable>
        
        <xsl:if test="string-length($keywords-content) > 0">
          <meta name="keywords" content="{$keywords-content}"/>
        </xsl:if>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
</xsl:stylesheet>