<?xml version="1.0" encoding="utf-8"?>
<!-- OXYGEN PATCH FOR EXM-41800
REMOVE HTML 5 elements from content.-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="2.0">

  <xsl:template match="/">
    <xsl:variable name="content" as="node()*">
      <xsl:apply-imports/>
    </xsl:variable>
    <xsl:apply-templates select="$content" mode="remove-html5"/>
  </xsl:template>

  <xsl:template match="node() | @*" mode="remove-html5">
    <xsl:copy>
      <xsl:apply-templates select="node() | @*" mode="remove-html5"/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="nav | section | figure | article" mode="remove-html5" priority="20">
    <xsl:element name="div">
      <xsl:apply-templates select="@* except @role | node()" mode="remove-html5"/>
    </xsl:element>
  </xsl:template>

  <!-- Group for root document node does not need extra XHTML div -->
  <xsl:template match="main/article" mode="remove-html5" priority="30">
    <xsl:apply-templates select="node()" mode="remove-html5"/>
  </xsl:template>

  <xsl:template match="header | footer | main" mode="remove-html5" priority="20">
    <xsl:apply-templates select="node()" mode="remove-html5"/>
  </xsl:template>
  
  <xsl:template match="div/@role" mode="remove-html5" priority="10"/>
  
  <xsl:template match="@*[starts-with(name(), 'data-')]" mode="remove-html5" priority="10"/>
  
</xsl:stylesheet>
