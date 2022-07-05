<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:editlink="http://oxygenxml.com/xslt/editlink/"
    exclude-result-prefixes="xs editlink"
    version="2.0">
  
  <xsl:import href="link.xsl"/>
  
  <xsl:param name="editlink.remote.ditamap.url"/>
  <xsl:param name="editlink.web.author.url"/>
  <xsl:param name="editlink.present.only.path.to.topic"/>
  <xsl:param name="editlink.local.ditamap.path"/>
  <xsl:param name="editlink.local.ditaval.path"/>
  <xsl:param name="editlink.ditamap.edit.url"/>
  <xsl:param name="editlink.additional.query.parameters"/>
  
  <!-- Override the topic/title processing to add 'Edit Link' action. -->  
  <xsl:template match="*[contains(@class, ' topic/topic ')]/*[contains(@class, ' topic/title ')]">
    <xsl:choose>
      <xsl:when test="@xtrf
        and (string-length($editlink.remote.ditamap.url) > 0
          or string-length($editlink.ditamap.edit.url) > 0
          or $editlink.present.only.path.to.topic = 'true')">
        <!-- Get the default output in a temporary variable -->
        <xsl:variable name="topicTitleFragment">
          <xsl:next-match/>
        </xsl:variable>
        
        <!-- Process the generated HTML to add the 'Edit Link' action -->
        <xsl:apply-templates select="$topicTitleFragment" mode="add-edit-link">
          <xsl:with-param name="xtrf" select="@xtrf" tunnel="yes"/>
        </xsl:apply-templates>  
      </xsl:when>
      <xsl:otherwise>
        <xsl:next-match/>
      </xsl:otherwise>
    </xsl:choose>
         
  </xsl:template>
  
  <!-- Add a span element associated with the 'Edit Link' action -->
  <xsl:template match="*[starts-with(local-name(), 'h')]" mode="add-edit-link" priority="5">
   <xsl:param name="xtrf" tunnel="yes"/>
    
    <!-- The edit link -->
    <span class="edit-link">
      <xsl:attribute name="style">font-size:12px; opacity:0.6; text-align:right; vertical-align:middle</xsl:attribute>
      <xsl:choose>
        <xsl:when test="$editlink.present.only.path.to.topic = 'true'">
          <xsl:value-of select="editlink:makeRelative(editlink:toUrl($editlink.local.ditamap.path), $xtrf)"/>
        </xsl:when>
        <xsl:otherwise>
          <a target="_blank">
            <xsl:attribute name="href">
              <xsl:value-of select="editlink:compute($editlink.remote.ditamap.url, $editlink.local.ditamap.path, $xtrf, $editlink.web.author.url, $editlink.local.ditaval.path, $editlink.ditamap.edit.url, $editlink.additional.query.parameters)"/>
            </xsl:attribute>Edit online</a>
        </xsl:otherwise>
      </xsl:choose>
    </span>
    <!-- Done with the edit link -->
    
    <xsl:copy>
      <xsl:apply-templates select="@*|node()" mode="#current"/>
    </xsl:copy>
  </xsl:template>

  <!-- Copy template for the add-edit-link mode -->
  <xsl:template match="node() | @*" mode="add-edit-link">
    <xsl:copy>
      <xsl:apply-templates select="node() | @*" mode="#current"/>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>
