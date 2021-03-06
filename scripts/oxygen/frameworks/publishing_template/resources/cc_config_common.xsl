<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0"
    xmlns:funct="http://oxygenxml.com/publishing-template/functions">

    <!--
        Function to get all available WebHelp parameters.
    -->
    <xsl:function name="funct:getAllWebHelpParams">
        <xsl:variable name="wh-res-plugin-uri"
            select="resolve-uri('../../dita/DITA-OT3.x/plugins/com.oxygenxml.webhelp.responsive/plugin.xml')"/>
        
        <xsl:variable name="xhtml-plugin-uri"
            select="resolve-uri('../../dita/DITA-OT3.x/plugins/org.dita.xhtml/plugin.xml')"/>

        <xsl:variable name="wh-params">
            <xsl:if test="doc-available($wh-res-plugin-uri)">
                <xsl:sequence select="doc($wh-res-plugin-uri)//*:param"/>
            </xsl:if>
        </xsl:variable>
        
        <xsl:variable name="xhtml-params">
            <xsl:if test="doc-available($xhtml-plugin-uri)">
                <xsl:sequence select="doc($xhtml-plugin-uri)//*:param"></xsl:sequence>
            </xsl:if>
        </xsl:variable>
        
        <xsl:sequence select="$wh-params union $xhtml-params"/>
    </xsl:function>
    
    <!--
        Function to get all available PDF-CSS plugin parameters.
    -->
    <xsl:function name="funct:getAllPDFCSSParams">
        <xsl:variable name="pdf-css-res-plugin-uri"
            select="resolve-uri('../../dita/DITA-OT3.x/plugins/com.oxygenxml.pdf.css/plugin.xml')"/>                
        
        <xsl:variable name="params">
            <xsl:if test="doc-available($pdf-css-res-plugin-uri)">
                <xsl:sequence select="doc($pdf-css-res-plugin-uri)//*:param"/>
            </xsl:if>
        </xsl:variable>
        <xsl:sequence select="$params"/>
    </xsl:function>
</xsl:stylesheet>
