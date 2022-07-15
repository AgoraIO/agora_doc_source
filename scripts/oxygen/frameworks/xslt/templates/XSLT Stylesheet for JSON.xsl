<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="3.0">
    <!-- The input JSON file -->
    <xsl:param name="input" select="'url to json file'"/>
    
    <!-- The initial template that process the JSON -->
    <xsl:template name="xsl:initial-template">
        <xsl:apply-templates select="json-doc($input)"/>
    </xsl:template>
    
    <!-- Template that matches the maps -->
    <xsl:template match=".[. instance of map(*)]">
        <xsl:apply-templates select="?*"/>
    </xsl:template>
</xsl:stylesheet>