<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">

    <!--
        Remove whitespaces from element-only inline elements that are formatted by oXygen. 
    -->
    <xsl:template match="*[contains(@class, ' ui-d/menucascade ')]">
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates select="*"/>
        </xsl:copy>
    </xsl:template>

    <!--
        Emit a warning if indentation is made using both tabs and spaces.
    -->
    <xsl:template match="*[contains(@class, ' topic/pre ')] | *[contains(@class, ' topic/lines ')]">
        <xsl:variable name="text" select="string-join(text())"/>
        <xsl:if test="
                (matches($text, '^&#x9;') and matches($text, '\n&#x20;'))
                or (matches($text, '^&#x20;') and matches($text, '\n&#x9;'))
                or (matches($text, '\n&#x9;') and matches($text, '\n&#x20;'))
                or (matches($text, '&#x9;&#x20;')) or (matches($text, '&#x20;&#x9;'))">
            <xsl:variable name="node" select="
                    if (@id) then
                        concat('with id=', @id)
                    else
                        local-name()"/>
            <xsl:variable name="text" select="concat('&quot;', substring(normalize-space($text), 0, 80), '...', '&quot;')"/>
            <xsl:message terminate="no">[OXYWS01W][WARNING] Preformatted element <xsl:value-of select="$node"/> is indented with both spaces and tabs. It is recommended to replace tabs with spaces only as this can cause rendering issues in the published output. Element content: <xsl:value-of select="$text"/></xsl:message>
        </xsl:if>
        <xsl:next-match/>
    </xsl:template>

</xsl:stylesheet>
