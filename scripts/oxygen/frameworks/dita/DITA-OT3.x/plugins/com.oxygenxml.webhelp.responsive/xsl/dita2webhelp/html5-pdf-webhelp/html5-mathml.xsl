<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    
    exclude-result-prefixes="#all"
    version="2.0">

  <!-- 
    Overrides the org.dita-community.dita13.html\xsl\equation-d2html.xsl
    and adds the original element class attributes. In this way the element can 
    be styled using the same CSS rules for the html5 and direct - merged 
    based transformation. 
  -->
  <xsl:template match="*[contains(@class, ' equation-d/equation-inline ')]">
    <span>
      <xsl:call-template name="commonattributes"/>
      <!-- We need eqn-inline in the class value. Otherwise the above call template would be enough. -->
      <xsl:attribute name="class" select="concat(@class,' eqn-inline ',@outputclass)"/>
      <xsl:apply-templates>
        <xsl:with-param name="blockOrInline" tunnel="yes" select="'inline'"/>
      </xsl:apply-templates></span>
  </xsl:template>
  
  <xsl:template match="*[contains(@class, ' equation-d/equation-block ')]">
    <div>
      <xsl:call-template name="commonattributes"/>
      <!-- We need eqn-block in the class value. Otherwise the above call template would be enough. -->
      <xsl:attribute name="class" select="concat(@class,' eqn-block ',@outputclass)"/>
      <xsl:apply-templates>
        <xsl:with-param name="blockOrInline" tunnel="yes" select="'block'"/>
      </xsl:apply-templates>
    </div>
  </xsl:template>
  
</xsl:stylesheet>