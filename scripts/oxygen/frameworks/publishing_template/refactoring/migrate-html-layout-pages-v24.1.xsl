<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xr="http://www.oxygenxml.com/ns/xmlRefactoring"
    xmlns:whc="http://www.oxygenxml.com/webhelp/components"
    xmlns:saxon="http://saxon.sf.net/"
    exclude-result-prefixes="xs xr saxon"
    xpath-default-namespace="http://www.w3.org/1999/xhtml"
    version="3.0">
    
    <!-- Change whc:version attribute value -->
    <xsl:template match="@whc:version" mode="#default">
        <xsl:attribute name="whc:version">24.1</xsl:attribute>
    </xsl:template>
    
    <!-- Udpate publicatoin toc component -->
    <xsl:template match="whc:webhelp_publication_toc" mode="#default">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*" mode="publication-toc"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="nav" mode="publication-toc">
        <xsl:copy>
            <xsl:apply-templates select="@*" mode="#current" />
            <xsl:text>&#xa;</xsl:text>
            <div id="wh_publication_toc_content">
                <xsl:text>&#xa;</xsl:text>
                <whc:include_html>
                    <xsl:attribute name="href">${webhelp.fragment.before.publication.toc}</xsl:attribute>
                </whc:include_html>
                <xsl:text>&#xa;</xsl:text>
                <xsl:apply-templates select="node()" mode="#current"/>
                <xsl:text>&#xa;</xsl:text>
                <whc:include_html>
                    <xsl:attribute name="href">${webhelp.fragment.after.publication.toc}</xsl:attribute>
                </whc:include_html>
                <xsl:text>&#xa;</xsl:text>
            </div>
            <xsl:text>&#xa;</xsl:text>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="nav/@class" mode="publication-toc">
        <xsl:attribute name="class">col-lg-3 col-md-3 col-sm-12 d-md-block d-none d-print-none</xsl:attribute>
    </xsl:template>
    
    <!-- Udpate topic toc component -->
    <xsl:template match="whc:webhelp_topic_toc" mode="#default">
        <xsl:copy>
            <xsl:apply-templates select="@*" mode="topic-toc" />
            <xsl:text>&#xa;</xsl:text>
            <xsl:apply-templates select="node()" mode="topic-toc"/>
            <xsl:text>&#xa;</xsl:text>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="nav" mode="topic-toc">
        <xsl:copy>
            <xsl:apply-templates select="@*" mode="#current" />
            <xsl:text>&#xa;</xsl:text>
            <div id="wh_topic_toc_content">
                <xsl:text>&#xa;</xsl:text>
                <whc:include_html>
                    <xsl:attribute name="href">${webhelp.fragment.before.topic.toc}</xsl:attribute>
                </whc:include_html>
                <xsl:text>&#xa;</xsl:text>
                <xsl:apply-templates select="node()" mode="#current"/>
                <xsl:text>&#xa;</xsl:text>
                <whc:include_html>
                    <xsl:attribute name="href">${webhelp.fragment.after.topic.toc}</xsl:attribute>
                </whc:include_html>
                <xsl:text>&#xa;</xsl:text>
            </div>
            <xsl:text>&#xa;</xsl:text>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="whc:include_html" mode="publication-toc topic-toc"/>

    <xsl:template match="* | text() | processing-instruction() | comment() | @*" mode="#default topic-toc publication-toc" >
        <xsl:copy>
            <xsl:apply-templates select="node() | @*" />
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>