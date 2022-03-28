<?xml version="1.0" encoding="UTF-8"?>
<!-- Stylesheet used to generate an XML from the JSON input -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="3.0">
    <xsl:output method="xml" indent="yes"/>
    
    <!-- The input JSON file -->
    <xsl:param name="input" select="'../personal.json'"/>
    
    <!-- The initial template that process the JSON -->
    <xsl:template name="xsl:initial-template">
        <xsl:apply-templates select="json-to-xml(unparsed-text($input))" mode="copy"/>
    </xsl:template>
    
    <!-- The copy template -->
    <xsl:template match="node() | @*" mode="copy">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*" mode="copy"/>
        </xsl:copy>
    </xsl:template>    
</xsl:stylesheet>