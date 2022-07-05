<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  exclude-result-prefixes="xs"
  version="2.0">
  
  <!-- Call original template from org.dita.html5/xsl/hazard-d.xsl. -->
  <xsl:template match="*[contains(@class,' hazard-d/hazardstatement ')]">
    <xsl:variable name="result">
      <xsl:next-match/>
    </xsl:variable>
    <xsl:apply-templates select="$result" mode="hazard-table">
      <xsl:with-param name="type" select="(@type, 'caution')[1]" tunnel="yes"/>
    </xsl:apply-templates>
  </xsl:template>
  
  <xsl:template match="node() | @*" mode="hazard-table">
    <xsl:copy>
      <xsl:apply-templates select="node() | @*" mode="#current"/>
    </xsl:copy>
  </xsl:template>
  
  <!-- Add hazard type to class attribute. -->
  <xsl:template match="table/@class" mode="hazard-table">
    <xsl:param name="type" tunnel="yes"/>
    <xsl:variable name="output-class" select="string-join(($type, concat('hazardstatement_', $type)), ' ')"/>
    <xsl:attribute name="{local-name()}" select="concat(., ' ', $output-class)"/>
  </xsl:template>

  <!-- Add hazard header in a thead element and define colgroup. -->
  <xsl:template match="tr[1]" mode="hazard-table">
    <colgroup>
      <col class="hazardstatement--logo-col"/>
      <col class="hazardstatement--msg-col"/>
    </colgroup>
    <thead>
      <xsl:copy-of select="."/>
    </thead>
  </xsl:template>
  
  <!-- Add hazard content into a tbody element. -->
  <xsl:template match="tr[2]" mode="hazard-table">
    <tbody>
      <xsl:copy-of select="."/>
    </tbody>
  </xsl:template>
  
</xsl:stylesheet>