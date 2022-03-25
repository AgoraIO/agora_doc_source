<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">

  <!--The name of the attribute for which we change a profiling attribute value-->
  <xsl:param name="attribute_name"/>
  <!-- The current value to rename or remove -->
  <xsl:param name="current_value"/>
  <!-- The new value to rename to -->
  <xsl:param name="new_value"/>
  <xsl:template match="node() | @*">
    <xsl:copy>
      <xsl:apply-templates select="node() | @*"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="@*[name() = $attribute_name]">
    <xsl:choose>
      <xsl:when test="$new_value = '' and normalize-space(.) = $current_value">
        <!-- Remove the entire attribute -->
      </xsl:when>
      <xsl:otherwise>
        <xsl:attribute name="{$attribute_name}">
          <xsl:variable name="attrValue">
            <xsl:analyze-string select="." regex="\s+">
              <xsl:matching-substring>
                <xsl:value-of select="."/>
              </xsl:matching-substring>
              <xsl:non-matching-substring>
                <xsl:choose>
                  <!--Rename-->
                  <xsl:when test=". = $current_value">
                    <xsl:value-of select="$new_value"/>
                  </xsl:when>
                  <xsl:otherwise>
                    <!-- Keep -->
                    <xsl:value-of select="."/>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:non-matching-substring>
            </xsl:analyze-string>
          </xsl:variable>
          <!-- Remove extra leading or trailing spaces -->
          <xsl:value-of select="normalize-space($attrValue)"/>
        </xsl:attribute>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>
