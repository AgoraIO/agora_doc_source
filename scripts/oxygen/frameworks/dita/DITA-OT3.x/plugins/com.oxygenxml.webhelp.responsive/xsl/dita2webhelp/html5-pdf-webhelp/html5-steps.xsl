<?xml version="1.0" encoding="UTF-8"?>
<!-- 

  This stylesheet changes the tasks steps structure.

-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                exclude-result-prefixes="xs"
                version="2.0">
  
  <!-- Copied from: org.dita.html5/xsl/task.xsl -->
  <!-- Marks the parent step section with step class (ol/ul) -->
  <xsl:template match="*[contains(@class,' task/steps ') or contains(@class,' task/steps-unordered ')]"
    mode="common-processing-within-steps">
    <xsl:param name="step_expand"/>
    <xsl:param name="list-type">
      <xsl:choose>
        <xsl:when test="contains(@class,' task/steps ')">ol</xsl:when>
        <xsl:otherwise>ul</xsl:otherwise>
      </xsl:choose>
    </xsl:param>
    <xsl:variable name="result">
      <xsl:next-match/>
    </xsl:variable>
    
    <xsl:apply-templates select="$result" mode="add-section-class">
      <xsl:with-param name="list-type" select="$list-type"/>
    </xsl:apply-templates>
  </xsl:template>
  
  <xsl:template match="node() | @*" mode="add-section-class">
    <xsl:copy>
      <xsl:apply-templates select="node() | @*" mode="#current"/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="section[not(@class)]" mode="add-section-class">
    <xsl:param name="list-type"/>
    <xsl:copy>
      <!-- Default HTML5 style-sheet already set an id on section child (div, ol or ul). -->
      <xsl:apply-templates select="@* except (@id, @data-ofbid)" mode="#current"/>
      <xsl:choose>
        <xsl:when test="$list-type = 'ol'">
          <xsl:attribute name="class">- topic/ol task/steps ol steps</xsl:attribute>
        </xsl:when>
        <xsl:otherwise>
          <xsl:attribute name="class">- topic/ul task/steps-unordered ul steps-unordered</xsl:attribute>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="node()" mode="#current"/>
    </xsl:copy>
  </xsl:template>
  
  <!-- Created using template from: org.dita.html5/xsl/task.xsl -->
  <!-- Process task/steptroubleshooting as other task sub-elements -->
  <!-- Maybe to be removed if DITA-OT update includes this template -->
  <xsl:template match="*[contains(@class,' task/steptroubleshooting ')]" name="topic.task.steptroubleshooting">
    <xsl:call-template name="generateItemGroupTaskElement"/>
  </xsl:template>
  
</xsl:stylesheet>
