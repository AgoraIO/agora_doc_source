<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:f="http://www.oxygenxml.com/xsl/functions"
    exclude-result-prefixes="xs xsi f"
    version="2.0">
    
    <xsl:import href="../refactoring/dita-files-conversion-stylesheets/handle-schema-conversion.xsl"/>
    
    <xsl:variable name="root-element" select="'map'"/>
    <xsl:variable name="public-literal-target" select="'-//OASIS//DTD DITA Map//EN'"/>
    <xsl:variable name="system-literal-target" select="'map.dtd'"/>
    
    <xsl:template match="@xsi:noNamespaceSchemaLocation">
        <xsl:call-template name="convert-schema-location"></xsl:call-template>
    </xsl:template>
    
    <xsl:template match="/">
        <xsl:if test="f:fromBookmap(/*)">
            <xsl:call-template name="convert-header"/>
        </xsl:if>
        <xsl:apply-templates/>
    </xsl:template>
    
	<xsl:template match="@* | node()">
        <xsl:copy>
        	<xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="bookmap">
        <xsl:element name="map">
        	<xsl:apply-templates select="@* | * | comment() | processing-instruction()"/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="mainbooktitle">
        <xsl:element name="title">
        	<xsl:apply-templates select="@* | node()"/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="booktitle">
        <!-- hide the element, but keep the children -->
    	<xsl:apply-templates select="@* | node()"/>
    </xsl:template>
    
    <xsl:template match="bookmeta">
        <xsl:element name="topicmeta">
        	<xsl:apply-templates select="@* | node()"/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="bookrights">
        <xsl:element name="copyright">
        	<xsl:apply-templates select="@* | node()"/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="bookowner">
        <xsl:element name="copyrholder">
        	<xsl:apply-templates select="@* | node()"/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="booklist | backmatter | chapter | preface | colophon | trademarklist | appendix | appendices | part | dedication | tablelist | toc | amendments | abbrevlist | frontmatter | bibliolist | bookabstract | booklists | glossarylist | draftintro | notices | figurelist | indexlist">
        <xsl:element name="topicref">
        	<xsl:apply-templates select="@* | node()"/>
        </xsl:element>
    </xsl:template>
    
    
    <!-- Function that checks if the local name of the root element is 'bookmap' -->
    <xsl:function name="f:fromBookmap" as="xs:boolean">
        <xsl:param name="root" as="node()"/>
        <xsl:sequence select="$root/local-name() = 'bookmap'"/>
    </xsl:function>
    
</xsl:stylesheet>