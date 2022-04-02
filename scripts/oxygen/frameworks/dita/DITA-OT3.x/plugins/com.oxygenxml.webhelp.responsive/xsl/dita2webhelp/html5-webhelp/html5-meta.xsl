<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:opentopic="http://www.idiominc.com/opentopic" xmlns:oxy="http://www.oxygenxml.com/extensions/author"
  xmlns:dita2html="http://dita-ot.sourceforge.net/ns/200801/dita2html" xmlns:opentopic-index="http://www.idiominc.com/opentopic/index"
  xmlns:ot-placeholder="http://suite-sol.com/namespaces/ot-placeholder" xmlns:dita-ot="http://dita-ot.sourceforge.net/ns/201007/dita-ot" xmlns:xs="http://www.w3.org/2001/XMLSchema"

  exclude-result-prefixes="#all">



  <!-- Finds all index terms and adds them to the meta element 'indexterms'. (EXM-20576) -->
  <xsl:template match="*" mode="gen-keywords-metadata">
    <xsl:next-match/>
    <xsl:variable name="indexterms-content">
      <xsl:for-each select="descendant::*[contains(@class,' topic/keywords ')]//*[contains(@class,' topic/indexterm ')]">
        <xsl:value-of select="normalize-space(text()[1])" />
        <xsl:if test="position() &lt; last()">
          <xsl:text>, </xsl:text>
        </xsl:if>
      </xsl:for-each>
    </xsl:variable>
    <xsl:if test="string-length($indexterms-content)>0">
      <meta name="indexterms" content="{$indexterms-content}" />
    </xsl:if>
    <!-- 
    <xsl:apply-imports />
     -->
  </xsl:template>


</xsl:stylesheet>