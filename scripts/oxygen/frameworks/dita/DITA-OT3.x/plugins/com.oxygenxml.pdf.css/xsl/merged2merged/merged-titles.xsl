<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0" xmlns:ditaarch="http://dita.oasis-open.org/architecture/2005/"
  xmlns:oxy="http://www.oxygenxml.com/extensions/author" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="#all">

  <xsl:variable name="deep-numbering" select="contains($css.params,'numbering=deep')" />

  <!-- Wraps the titles into a span - better styling options for numbering, one can isolate the number set as :before and the content in inline blocks for instance. -->
  <xsl:template
    match="*[contains(@class,' topic/topic ')]/*[contains(@class,' topic/title ')]|
           *[contains(@class,' topic/table ')]/*[contains(@class,' topic/title ')]|
           *[contains(@class,' topic/figure ')]/*[contains(@class,' topic/title ')]">
    <xsl:copy>
      <xsl:apply-templates select="@*" />
      <ph class="- topic/ph topic/title-wrapper "><xsl:apply-templates /></ph>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>