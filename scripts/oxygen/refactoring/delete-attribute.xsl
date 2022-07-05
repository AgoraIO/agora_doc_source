<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs"
    xmlns:xr="http://www.oxygenxml.com/ns/xmlRefactoring" version="3.0">

    <!-- The XPath that identifies the attributes that will be removed -->
    <xsl:param name="attribute_xpath" as="xs:string" required="yes"/>

    <!-- Identifies the attributes to be deleted -->
    <xsl:variable name="attributes" as="attribute()*">
        <xsl:evaluate xpath="$attribute_xpath" as="attribute()*" context-item="/"/>
    </xsl:variable>

    <!-- A sequence with the local name of the attributes to be deleted -->
    <xsl:variable name="aln" select="distinct-values($attributes/local-name())"/>

    <xsl:template match="/|*">
        <xsl:copy>
            <!-- Copy only those attributes that were not matched by the '$attribute_xpath' XPath expression -->
            <xsl:apply-templates select="@*"/>
            <xsl:apply-templates select="node()"/>
        </xsl:copy>
    </xsl:template>

    <!-- Filter from output the attributes to be deleted -->
    <xsl:template match="@*[local-name()=$aln]">
        <xsl:if test="not(. intersect $attributes)">
            <xsl:copy/>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="text() | comment() | processing-instruction() | @*">
        <xsl:copy/>
    </xsl:template>
</xsl:stylesheet>
