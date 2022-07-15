<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:topicpull="http://dita-ot.sourceforge.net/ns/200704/topicpull"
  exclude-result-prefixes="xs topicpull" version="2.0">

  <xsl:param name="use.navtitles.in.all.links" select="'no'" />

  <!-- DCP-98 Get the link text from a specific topic, and prefer the navigation title if set and if the parameter allows it. -->
  <!-- From: plugins/org.dita.base/xsl/preprocess/topicpullImpl.xsl -->

  <xsl:template match="*[contains(@class, ' topic/topic ')]" mode="topicpull:resolvelinktext">
    <xsl:choose>
      <xsl:when test="$use.navtitles.in.all.links = 'yes' and *[contains(@class, ' topic/titlealts ')]/*[contains(@class, ' topic/navtitle ')]">
        <xsl:variable name="target-text" as="xs:string*">
          <xsl:apply-templates select="*[contains(@class, ' topic/titlealts ')]/*[contains(@class, ' topic/navtitle ')]" mode="text-only" />
        </xsl:variable>
        <xsl:value-of select="normalize-space(string-join($target-text, ''))" />
      </xsl:when>
      <xsl:otherwise>
        <!-- Delegate to the default DITA-OT implementation. -->
        <xsl:next-match/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
  