<!--
    Pass the following system properties to the transformation (not as parameters)
        - editlink.remote.ditamap.url
        - editlink.web.author.url
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns:editlink="http://oxygenxml.com/xslt/editlink/" 
    xmlns:fo="http://www.w3.org/1999/XSL/Format" 
    exclude-result-prefixes="xs" version="2.0">
    <xsl:import href="link.xsl"/>

    <xsl:param name="editlink.remote.ditamap.url"/>
    <xsl:param name="editlink.web.author.url"/>
    <xsl:param name="editlink.local.ditamap.path"/>
    <xsl:param name="editlink.local.ditaval.path"/>
    <xsl:param name="editlink.ditamap.edit.url"/>
    <xsl:param name="editlink.additional.query.parameters"/>

  <xsl:function name="editlink:should-add-edit-link" as="xs:boolean">
    <xsl:param name="titleEl"/>
    <xsl:sequence 
      select="$titleEl/@xtrf
      and (string-length($editlink.remote.ditamap.url) > 0
           or string-length($editlink.ditamap.edit.url) > 0)"/>
  </xsl:function>

  <xsl:template match="*[contains(@class, ' topic/topic ')]/*[contains(@class, ' topic/title ')]">
    <xsl:choose>
      <xsl:when test="editlink:should-add-edit-link(.)">
          <xsl:variable name="content">
            <xsl:next-match/>
        </xsl:variable>
        
        <fo:inline>
            <xsl:value-of select="$content"/>
            <fo:basic-link xsl:use-attribute-sets="fo-link-attrs">
                <xsl:attribute name="external-destination">
                    <xsl:value-of 
                        select="editlink:compute(
                            $editlink.remote.ditamap.url, 
                            $editlink.local.ditamap.path, 
                            @xtrf, 
                            $editlink.web.author.url, 
                            '',
                            $editlink.ditamap.edit.url,
                            $editlink.additional.query.parameters)"/>
                </xsl:attribute>
                Edit online
            </fo:basic-link>
          </fo:inline>
      </xsl:when>  
      <xsl:otherwise>
        <xsl:next-match/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>