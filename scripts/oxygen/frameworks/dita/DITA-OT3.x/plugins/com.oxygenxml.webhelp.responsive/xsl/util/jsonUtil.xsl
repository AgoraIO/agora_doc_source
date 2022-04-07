<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns:xhtml="http://www.w3.org/1999/xhtml"
    exclude-result-prefixes="xs toc xhtml"
    version="3.0"
    xmlns:t="http://www.oxygenxml.com/ns/webhelp/toc">
    
    <xsl:character-map name="xml">
        <!-- WH-1580: Escape XML special chars -->
        <xsl:output-character character="&amp;" string='&amp;&amp;amp;'/>
        <xsl:output-character character="&lt;" string='&amp;&amp;lt;'/>
        <xsl:output-character character="&gt;" string='&amp;&amp;gt;'/>
        <xsl:output-character character="&apos;" string='&amp;&amp;apos;'/>
    </xsl:character-map>
    
    <xsl:output name="json" method="text" />
    
    <xsl:template name="xml2Json">
        <xsl:param name="jsonXml" as="node()"/>

        <xsl:variable name="json" select="fn:xml-to-json($jsonXml, map{'indent':false()})"/>
        <xsl:value-of select="$json"/>
    </xsl:template>
    
    <xsl:template name="string-property">
        <xsl:param name="name"/>
        <xsl:param name="value"/>
        <fn:string key="{$name}">
            <xsl:call-template name="value">
                <xsl:with-param name="value" select="$value"/>
            </xsl:call-template>
        </fn:string>
    </xsl:template>
    
    <xsl:template name="boolean-property">
        <xsl:param name="name"/>
        <xsl:param name="value" as="xs:boolean"/>
        
        <fn:boolean key="{$name}"><xsl:value-of select="$value"/></fn:boolean>
    </xsl:template>
    
    <xsl:template name="object-property">
        <xsl:param name="name"/>
        <xsl:param name="value"/>
        <fn:map>
            <xsl:if test="$name">
                <xsl:attribute name="key" select="$name"/>
            </xsl:if>
            <xsl:copy-of select="$value"/>
        </fn:map>
    </xsl:template>
    
    <xsl:template name="array-property">
        <xsl:param name="name"/>
        <xsl:param name="value"/>
        <fn:array>
            <xsl:if test="$name">
                <xsl:attribute name="key" select="$name"/>
            </xsl:if>
            <xsl:copy-of select="$value"/>
        </fn:array>
    </xsl:template>
    
    <xsl:template name="value">
        <xsl:param name="value"/>
        <xsl:choose>
            <xsl:when test="$value instance of attribute() or $value instance of xs:string">
                <xsl:value-of select="$value"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:variable name="serializedNode">
                    <xsl:variable name="valueNoNs">
                        <xsl:apply-templates select="$value" mode="no-ns"/>
                    </xsl:variable>
                    <xsl:value-of select="fn:serialize($valueNoNs)"/>
                </xsl:variable>
                <xsl:value-of select="$serializedNode"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="*" mode="no-ns">
        <xsl:element name="{local-name()}">
            <xsl:apply-templates select="@* | node()" mode="no-ns"/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="@*" mode="no-ns">
        <xsl:attribute name="{local-name()}">
            <xsl:value-of select="."/>
        </xsl:attribute>
    </xsl:template>
    
    <xsl:template match="comment() | text() | processing-instruction()" mode="no-ns">
        <xsl:copy/>
    </xsl:template>    
</xsl:stylesheet>