<?xml version="1.0" encoding="UTF-8"?>
<!-- 

  This stylesheet changes the images layout.

-->
<xsl:stylesheet version="2.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <!-- =========== IMAGE/OBJECT =========== -->
  <!-- Overriding org.dita.html5/xsl/topic.xsl -->
  <xsl:template match="*[contains(@class, ' topic/image ')]" name="topic.image">
    <xsl:variable name="result">
      <xsl:next-match/>
    </xsl:variable>
    <xsl:apply-templates select="$result" mode="process-placement-break">
      <xsl:with-param name="placement" select="@placement" tunnel="yes"/>
    </xsl:apply-templates>
  </xsl:template>
  
  <xsl:template match="node() | @*" mode="process-placement-break">
    <xsl:copy>
      <xsl:apply-templates select="node() | @*" mode="#current"/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="br" mode="process-placement-break"/>
  
  <xsl:template match="@class" mode="process-placement-break">
    <xsl:param name="placement" tunnel="yes"/>
    <xsl:choose>
      <xsl:when test="$placement = 'break'">
        <xsl:attribute name="class" select="concat(., ' ', $placement)"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:next-match/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
</xsl:stylesheet>