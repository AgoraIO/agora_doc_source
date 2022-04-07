<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:f="http://www.oxygenxml.com/xsl/functions"
    exclude-result-prefixes="xs xsi f"
    version="2.0">
    
    <xsl:import href="../refactoring/dita-files-conversion-stylesheets/handle-schema-conversion.xsl"/>
    
    <xsl:variable name="root-element" select="'bookmap'"/>
    <xsl:variable name="public-literal-target" select="'-//OASIS//DTD DITA BookMap//EN'"/>
    <xsl:variable name="system-literal-target" select="'bookmap.dtd'"/>
    
    <xsl:template match="@xsi:noNamespaceSchemaLocation">
        <xsl:call-template name="convert-schema-location"></xsl:call-template>
    </xsl:template>
    
    <xsl:template match="/">
        <xsl:if test="f:fromMap(/*)">
            <xsl:call-template name="convert-header"/>
        </xsl:if>
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="node() | @*">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="map">
        <xsl:element name="bookmap">
            <xsl:apply-templates select="node() | @*"/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="title[f:fromMap(/*)]">
        <xsl:element name="booktitle">
            <xsl:element name="mainbooktitle">
                <xsl:apply-templates select="node() | @*"/>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="topicmeta[parent::map]">
        <xsl:element name="bookmeta">
            <xsl:apply-templates select="node() | @*"/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="copyright[f:fromMap(/*)]">
        <xsl:element name="bookrights">
            <xsl:apply-templates select="node() | @*"/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="copyrholder[f:fromMap(/*)]">
        <xsl:element name="bookowner">
            <xsl:apply-templates select="node() | @*"/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="topicref[parent::map] | topichead[parent::map] | topicgroup[parent::map] | topicset[parent::map]">
        <xsl:element name="chapter">
            <xsl:apply-templates select="node() | @*"/>
        </xsl:element>
    </xsl:template>
    
    <!-- Function that checks if the local name of the root element is 'map'.
        This is needed because there are elements (eg title) that can be matched
        in topics and modify documents that we don't whant to. -->
    <xsl:function name="f:fromMap" as="xs:boolean">
        <xsl:param name="root" as="node()"/>
        <xsl:sequence select="$root/local-name() = 'map'"/>
    </xsl:function>
    
</xsl:stylesheet>