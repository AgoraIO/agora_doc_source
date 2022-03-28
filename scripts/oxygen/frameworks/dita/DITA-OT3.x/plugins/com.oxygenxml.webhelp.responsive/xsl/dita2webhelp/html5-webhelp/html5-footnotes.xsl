<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    Footnotes fixes.
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
      

  <!-- Adds the topic/fn class token to the class attibute -->
  <xsl:template match="*[contains(@class, ' topic/fn ')]" name="topic.fn">
    <xsl:variable name="gen-fn"><xsl:next-match/></xsl:variable>
    <xsl:apply-templates select="$gen-fn" mode="add-class-for-footnotes"/>
  </xsl:template>
  
  <xsl:template match="*|node()" mode="add-class-for-footnotes">
    <xsl:copy>
      <xsl:apply-templates select="@*" mode="#current"/>
      <xsl:apply-templates select="*|node()" mode="#current"/>    
    </xsl:copy>
  </xsl:template>

  <xsl:template match="a" mode="add-class-for-footnotes">
    <xsl:copy>
      <xsl:apply-templates select="@*" mode="#current"/>
      <xsl:attribute name="class" select="' topic/fn-call fn-call '"/>
      <xsl:apply-templates select="*|node()" mode="#current"/>    
    </xsl:copy>
  </xsl:template>

  <xsl:template match="@*" mode="add-class-for-footnotes">
    <xsl:copy-of select="."/>
  </xsl:template>

  
</xsl:stylesheet>