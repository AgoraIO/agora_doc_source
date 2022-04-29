<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0" xmlns:ditaarch="http://dita.oasis-open.org/architecture/2005/" xmlns:oxy="http://www.oxygenxml.com/extensions/author"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="#all">

  <!-- 
  
    Controls the placement of the figure title.
     
  -->
  <xsl:template match="*[contains(@class,' topic/fig ')]">
    <xsl:copy>
      <xsl:apply-templates select="@*"/>
      <xsl:if test="not(@id) and *[contains(@class,' topic/title ')]">
      	<!-- Generate an ID for the figure, it may be referred from a list of figures -->
        <xsl:attribute name="id">
          <xsl:call-template name="get-id"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:choose>
        <xsl:when test="$figure.title.placement = 'top'">
          <xsl:apply-templates select="*[contains(@class,' topic/title ')]" />
          <xsl:apply-templates select="*[not(contains(@class,' topic/title '))]" />
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates select="*[not(contains(@class,' topic/title '))]" />
          <xsl:apply-templates select="*[contains(@class,' topic/title ')]" />
        </xsl:otherwise>
      </xsl:choose>
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>