<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:param name="pi_target" select="''"/>
    
    <xsl:template match="comment() | * | @*">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="processing-instruction()">
        <xsl:choose>
            <xsl:when test="$pi_target = ''">
                <!-- Ignore PI -->
            </xsl:when>
            <xsl:when test="name() = $pi_target">
                <!-- Ignore PI -->
            </xsl:when>
            <xsl:otherwise>
                <!-- Pass it through -->
                <xsl:copy/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>