<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:html="http://www.w3.org/1999/xhtml"
    xmlns:xr="http://www.oxygenxml.com/ns/xmlRefactoring"
    xmlns:whc="http://www.oxygenxml.com/webhelp/components"
    xmlns:saxon="http://saxon.sf.net/"
    exclude-result-prefixes="xs xr saxon"
    xpath-default-namespace="http://www.w3.org/1999/xhtml"
    version="3.0">
    
    <xsl:template match="/*[contains(@whc:version, '21.')]" priority="100">
        <xsl:copy>
        	<!-- 
        		Cristi: Do not change this version automatically at release. 
        	-->
            <xsl:attribute name="whc:version">22.0</xsl:attribute>
            <xsl:apply-templates select="node() | @* except @whc:version" mode="migrate-22"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="head[not(whc:page_libraries)]/script[@data-main][contains(@data-main, '${oxygen-webhelp-assets-dir}')]" mode="migrate-22" priority="200">
        <whc:page_libraries>
            <xsl:attribute name="page">
                <xsl:choose>
                    <xsl:when test="contains(@data-main, 'main-page.js')">main</xsl:when>
                    <xsl:when test="contains(@data-main, 'topic-page.js')">topic</xsl:when>
                    <xsl:when test="contains(@data-main, 'search-page.js')">search</xsl:when>
                    <xsl:when test="contains(@data-main, 'indexterms-page.js')">indexterms</xsl:when>
                </xsl:choose>
            </xsl:attribute>
        </whc:page_libraries>
    </xsl:template>
    
    <!-- Remove references to internal WebHelp JS libraries -->
    <xsl:template match="head[not(whc:page_libraries)]/script[contains(@src, '${oxygen-webhelp-assets-dir}')]" mode="migrate-22" priority="100">
        <!-- Drop -->
    </xsl:template>
    
    <!-- Remove references to internal WebHelp CSS libraries -->
    <xsl:template match="head[not(whc:page_libraries)]/link[contains(@href, '${oxygen-webhelp-assets-dir}')]" mode="migrate-22" priority="100">
        <!-- Drop -->
    </xsl:template>
    
    <xsl:template match="head[not(whc:page_libraries)]/style[text()][contains(text()[1], '.wh_search_results')]" mode="migrate-22" priority="100">
        <!-- Drop -->
    </xsl:template>
    
    <xsl:template match="head[not(whc:page_libraries)]/comment()[contains(., 'Bootstrap') or contains(., 'Template')]" mode="migrate-22" priority="100">
        <!-- Drop -->
    </xsl:template>

    <xsl:template match="* | text() | processing-instruction() | comment() | @*" mode="migrate-22 #default">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*" mode="#current"/>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>