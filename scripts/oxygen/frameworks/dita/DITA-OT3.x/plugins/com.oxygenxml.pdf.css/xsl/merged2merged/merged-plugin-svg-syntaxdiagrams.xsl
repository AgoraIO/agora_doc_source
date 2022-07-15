<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    exclude-result-prefixes="xs"
    version="2.0">

    <xsl:template match="*[contains(@class, ' topic/object ')][@*:urisyntaxpath]">
        <image class=" topic/image ">
            <xsl:attribute name="href" select="@*:urisyntaxpath"/>
            <xsl:if test="*[contains(@class, ' topic/desc ')]">
                <xsl:attribute name="alt" select="*[contains(@class, ' topic/desc ')]"/>
            </xsl:if>
            <xsl:apply-templates select="@id | @height | @width | @outputclass"/>
        </image>
    </xsl:template>

</xsl:stylesheet>
