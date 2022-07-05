<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" 
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:html="http://www.w3.org/1999/xhtml"
    exclude-result-prefixes="xs toc" version="2.0">
    <xsl:variable name="NO_PARENT">MAP</xsl:variable>
    <xsl:variable name="NEW_LINE" select="'&#10;'"/>
    <xsl:template match="toc:toc" mode="linkToParent">
        <xsl:result-document href="{$TEMP_DIR_URL}/search-link-to-parent.properties" format="props">
            <xsl:apply-templates mode="linkToParent"/>
        </xsl:result-document>
    </xsl:template>
    <xsl:output name="props" method="text"/>
    <xsl:template match="toc:topic" mode="linkToParent">
        <xsl:variable name="topicID" select="@wh-toc-id"/>
        <xsl:variable name="parentID">
            <xsl:choose>
                <xsl:when test="parent::toc:topic">
                    <xsl:value-of select="parent::toc:topic/@wh-toc-id"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$NO_PARENT"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:value-of select="concat($topicID, '=', $parentID, $NEW_LINE)"/>
        <xsl:apply-templates select="toc:topic" mode="linkToParent"/>
    </xsl:template>
    <xsl:template match="text()" mode="linkToParent"/>
</xsl:stylesheet>