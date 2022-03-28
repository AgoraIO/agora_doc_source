<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:template match="* | text() | @*" mode="processComments">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*" mode="processComments"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="comment()" mode="processComments"/>
    
    <xsl:template match="comment()[starts-with(., '&lt;m:oMath')]" mode="processComments">
        <xsl:copy/>
    </xsl:template>
    
</xsl:stylesheet>