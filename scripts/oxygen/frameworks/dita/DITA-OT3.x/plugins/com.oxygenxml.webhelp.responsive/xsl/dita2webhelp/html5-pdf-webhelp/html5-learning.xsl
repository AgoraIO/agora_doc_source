<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:opentopic="http://www.idiominc.com/opentopic"
  xmlns:oxy="http://www.oxygenxml.com/extensions/author"
  xmlns:dita2html="http://dita-ot.sourceforge.net/ns/200801/dita2html"
  xmlns:opentopic-index="http://www.idiominc.com/opentopic/index"
  xmlns:ot-placeholder="http://suite-sol.com/namespaces/ot-placeholder"
  xmlns:dita-ot="http://dita-ot.sourceforge.net/ns/201007/dita-ot"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  
  exclude-result-prefixes="#all">

  <!-- EXM-31518 Generate something that can be styled for learning and training lcTime -->
  <xsl:template match="*[contains(@class, ' learningBase/lcTime ')]">
    <span>
      <xsl:call-template name="commonattributes"/>
      <b>Time: </b>
      <xsl:choose>
        <xsl:when test="empty(node())">
          <xsl:value-of select="@value"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates/>
        </xsl:otherwise>
      </xsl:choose>
    </span>
  </xsl:template>
  
</xsl:stylesheet>