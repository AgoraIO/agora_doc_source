<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    Add the namespace declarations on the root element. The resulting file is a lot smaller.
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
  <xsl:template name="add-namespace-declarations">
    <xsl:if test="not(namespace-uri-for-prefix('xs', .))">
      <xsl:namespace name="xs" select="'http://www.w3.org/2001/XMLSchema'"/>
    </xsl:if>
    <xsl:if test="not(namespace-uri-for-prefix('oxy', .))">
      <xsl:namespace name="oxy" select="'http://www.oxygenxml.com/extensions/author'"/>
    </xsl:if>
    <xsl:if test="not(namespace-uri-for-prefix('nd', .))">
      <xsl:namespace name="nd" select="'http://www.oxygenxml.com/css2fo/named-destinations'"/>
    </xsl:if>
    <xsl:if test="not(namespace-uri-for-prefix('ditaarch', .))">
      <xsl:namespace name="ditaarch" select="'http://dita.oasis-open.org/architecture/2005/'"/>
    </xsl:if>
    <xsl:if test="not(namespace-uri-for-prefix('opentopic-index', .))">
      <xsl:namespace name="opentopic-index" select="'http://www.idiominc.com/opentopic/index'"/>
    </xsl:if>
    <xsl:if test="not(namespace-uri-for-prefix('opentopic', .))">
      <xsl:namespace name="opentopic" select="'http://www.idiominc.com/opentopic'"/>
    </xsl:if>
    <xsl:if test="not(namespace-uri-for-prefix('css2fo', .))">
      <xsl:namespace name="css2fo" select="'http://www.oxygenxml.com/css2fo'"/>
    </xsl:if>
    <xsl:if test="not(namespace-uri-for-prefix('dita-ot', .))">
      <xsl:namespace name="dita-ot" select="'dita-ot.sourceforge.net/ns/201007/dita-ot'"/>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>
