<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" 
  version="2.0" xmlns:table="http://dita-ot.sourceforge.net/ns/201007/dita-ot/table"
  xmlns:dita-ot="http://dita-ot.sourceforge.net/ns/201007/dita-ot"
  xmlns:ditamsg="http://dita-ot.sourceforge.net/ns/200704/ditamsg"
  xmlns:related-links="http://dita-ot.sourceforge.net/ns/200709/related-links"
  xmlns:relpath="http://dita2indesign/functions/relpath"
  exclude-result-prefixes="xs table dita-ot related-links ditamsg relpath"
  >

  <xsl:import href="../../util/relpath_util.xsl"/>

 
  
<xsl:template match="*" mode="determine-final-href">
  <!-- OXYGEN PATCH START EXM-20602 -->
  <xsl:param name="final-path" tunnel="yes"/>
  <!-- OXYGEN PATCH END EXM-20602 -->
  <xsl:choose>
    <xsl:when test="normalize-space(@href)='' or not(@href)"/>
    <!-- For non-DITA formats - use the href as is -->
    <xsl:when test="(not(@format) and (@type='external' or @scope='external')) or (@format and not(@format='dita' or @format='DITA'))">
      <xsl:value-of select="relpath:encodeUri(@href)"/>
    </xsl:when>
    <!-- For DITA - process the internal href -->
    <xsl:when test="starts-with(@href,'#')">
      <xsl:call-template name="parsehref">
        <xsl:with-param name="href" select="relpath:encodeUri(@href)"/>
      </xsl:call-template>
    </xsl:when>
    <!-- It's to a DITA file - process the file name (adding the html extension)
    and process the rest of the href -->
    <!-- for local links respect dita.extname extension 
      and for peer links accept both .xml and .dita bug:3059256-->
    <xsl:when test="(not(@scope) or @scope='local' or @scope='peer') and (not(@format) or @format='dita' or @format='DITA')">
      <!-- OXYGEN PATCH START EXM-20602 -->
      <xsl:choose>
        <xsl:when test="string-length($final-path) > 0">
        <xsl:variable name="finalPathWithOutext">
          <xsl:call-template name="replace-extension">
            <xsl:with-param name="filename" select="$final-path"/>
            <xsl:with-param name="extension" select="$OUTEXT"/>
            <xsl:with-param name="forceReplace" select="true()"/>
          </xsl:call-template>
        </xsl:variable>
          <xsl:value-of select="relpath:encodeUri($finalPathWithOutext)"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="replace-extension">
            <xsl:with-param name="filename" select="@href"/>
            <xsl:with-param name="extension" select="$OUTEXT"/>
            <xsl:with-param name="ignore-fragment" select="true()"/>
            <xsl:with-param name="forceReplace" select="true()"/>
          </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>
      <!-- OXYGEN PATCH END EXM-20602 -->

      <xsl:if test="contains(@href, '#')">
          <xsl:text>#</xsl:text>
          <xsl:variable name="anchor">
            <xsl:value-of select="substring-after(@href, '#')"></xsl:value-of>
          </xsl:variable>
          <xsl:call-template name="parsehref">
            <xsl:with-param name="href" select="relpath:encodeUri($anchor)"/>
          </xsl:call-template>
      </xsl:if>
    </xsl:when>
    <xsl:otherwise>
      <xsl:apply-templates select="." mode="ditamsg:unknown-extension"/>
      <xsl:value-of select="relpath:encodeUri(@href)"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>
  
  
</xsl:stylesheet>
 