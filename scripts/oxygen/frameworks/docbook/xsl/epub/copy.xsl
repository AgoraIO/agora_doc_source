<?xml version="1.0" encoding="UTF-8"?>
<!--   /*
 * Copyright (c) 2018 Syncro Soft SRL - All Rights Reserved.
 *
 * This file contains proprietary and confidential source code.
 * Unauthorized copying of this file, via any medium, is strictly prohibited.
 */
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.0" xmlns:xhtml="http://www.w3.org/1999/xhtml">
    <xsl:template match="node() | @*">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*"/>
        </xsl:copy>
    </xsl:template>
    
    <!-- Fix any element that may end up in the XHTML namesapce -->
    <xsl:template match="xhtml:*">
        <xsl:element name="{local-name()}" namespace="{namespace-uri(/*[1])}">
            <xsl:apply-templates select="node() | @*"/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="xhtml:head/@profile"/>
</xsl:stylesheet>