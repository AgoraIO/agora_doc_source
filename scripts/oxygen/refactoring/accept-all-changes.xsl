<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <!-- For Oxygen track changes insertions, deletions and attributes -->
    <xsl:param name="accept.all.oxygen.track.changes.markers" as="xs:boolean"/>
    <!-- For Oxygen comments -->
    <xsl:param name="remove.oxygen.comments" as="xs:boolean"/>
    <!-- For Oxygen highlights -->
    <xsl:param name="remove.oxygen.highlights" as="xs:boolean"/>
    
    <!-- default copy template -->
    <xsl:template match="node() | @*">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*"/>
        </xsl:copy>
    </xsl:template>
    
    <!-- Match insertions track changes -->
    <xsl:template match="processing-instruction()[starts-with(name(), 'oxy_insert')]">
        <!-- remove them is the corresponding param is true -->
        <xsl:call-template name="handleCurrentMarker">
            <xsl:with-param name="currentParamValue" select="$accept.all.oxygen.track.changes.markers"/>
        </xsl:call-template>
    </xsl:template>
    
    <!-- Match deletion track changes -->
    <xsl:template match="processing-instruction()[starts-with(name(), 'oxy_delete')]">
        <!-- remove them is the corresponding param is true -->
        <xsl:call-template name="handleCurrentMarker">
            <xsl:with-param name="currentParamValue" select="$accept.all.oxygen.track.changes.markers"/>
        </xsl:call-template>
    </xsl:template>
    
    <!-- Match attributes track changes -->
    <xsl:template match="processing-instruction()[starts-with(name(), 'oxy_attributes')]">
        <!-- remove them is the corresponding param is true -->
        <xsl:call-template name="handleCurrentMarker">
            <xsl:with-param name="currentParamValue" select="$accept.all.oxygen.track.changes.markers"/>
        </xsl:call-template>
    </xsl:template>
    
    <!-- Match comments -->
    <xsl:template match="processing-instruction()[starts-with(name(), 'oxy_comment')]">
        <!-- remove them is the corresponding param is true -->
        <xsl:call-template name="handleCurrentMarker">
            <xsl:with-param name="currentParamValue" select="$remove.oxygen.comments"/>
        </xsl:call-template>
    </xsl:template>
    
    <!-- Match highlights -->
    <xsl:template match="processing-instruction()[starts-with(name(), 'oxy_custom')]">
        <!-- remove them is the corresponding param is true -->
        <xsl:call-template name="handleCurrentMarker">
            <xsl:with-param name="currentParamValue" select="$remove.oxygen.highlights"/>
        </xsl:call-template>
    </xsl:template>
    
    <!-- This template has a parameter. If the value of the parameter is not true, the element is skipped. -->
    <xsl:template name="handleCurrentMarker">
        <xsl:param name="currentParamValue"/>
        <xsl:choose>
            <xsl:when test="$currentParamValue = true()"/>
            <xsl:otherwise>
                <xsl:copy>
                    <xsl:apply-templates/>
                </xsl:copy>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>