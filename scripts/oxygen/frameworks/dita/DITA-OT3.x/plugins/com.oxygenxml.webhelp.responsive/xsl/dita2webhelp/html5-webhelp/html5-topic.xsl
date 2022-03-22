<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:oxygen="http://www.oxygenxml.com/functions"
    exclude-result-prefixes="xs"
    xmlns:dita-ot="http://dita-ot.sourceforge.net/ns/201007/dita-ot"
    version="2.0">
    
    <xsl:variable name="data-ofbid-elements" select="tokenize($DATA_OFBID_ELEMENTS, '\s*,\s*')"/>
    <xsl:variable name="data-ofbid-elements-to-exclude" select="tokenize($DATA_OFBID_ELEMENTS_TO_EXCLUDE, '\s*,\s*')"/>
    <xsl:variable name="timestamp" select="format-dateTime(current-dateTime(), '[Y0001][M01][D01][H01][m01][s01]')"/>

    <!--
        WH-2505 - Override the template from 'plugins/org.dita.html5/xsl/topic.xsl' to generate 'data-ofbid' attribute.    
    -->
    <xsl:template name="setidaname">
        <!-- Oxygen start path -->
        <!-- Replaced the setidattr template with setid. The setid template always calls setidattr template and
        additinally it checks if the data-ofbid should be added or not. -->
        <xsl:call-template name="setid"/>
        <!-- Oxygen end path -->
        <xsl:if test="@id">
            <xsl:call-template name="setanametag">
                <xsl:with-param name="idvalue" select="@id"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>

    <!--
        WH-2505 - Override the template from 'plugins/org.dita.html5/xsl/topic.xsl' to generate 'data-ofbid' attribute.    
    -->
    <xsl:template name="setid">
        <xsl:if test="@id">
            <xsl:call-template name="setidattr">
                <xsl:with-param name="idvalue" select="@id"/>
            </xsl:call-template>
        </xsl:if>
        
        <!-- Oxygen start path -->
       	<xsl:variable name="currentElementClass" select="tokenize(@class, '\s+')"/>
       
        <xsl:if test="$currentElementClass = $data-ofbid-elements and not($currentElementClass = $data-ofbid-elements-to-exclude)  
            and not(ancestor::*[tokenize(@class, '\s+') = $data-ofbid-elements-to-exclude]/@class)" >
            <xsl:choose>
                <xsl:when test="@id">
                    <!-- If the id attribute is set generate the data-ofbid as topicID__elementID -->
                    <xsl:call-template name="setDataOfbid">
                        <xsl:with-param name="idvalue" select="@id"/>
                    </xsl:call-template>
                </xsl:when>
                <xsl:otherwise>
                	<xsl:if test="oxygen:getParameter('webhelp.enable.block.elements.id.generation') = 'yes'">
	                    <!-- If the id attribute is not set generate the data-ofbid as uuid**timstamp -->
	                    <xsl:variable name="idValue" select="concat(generate-id(.), '__', $timestamp)"/>
	                    <xsl:call-template name="generateDataOfbid">
	                        <xsl:with-param name="idvalue" select="$idValue"/>
	                    </xsl:call-template>
       				</xsl:if>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
        <!-- Oxygen end path -->
    </xsl:template>
    
    <!-- Generated data-ofbid attribute -->
    <xsl:template name="setDataOfbid">
        <xsl:param name="idvalue"/>
        <xsl:attribute name="data-ofbid"
            select="dita-ot:get-prefixed-id($idvalue/parent::*, $idvalue)"/>
    </xsl:template>
    
    <xsl:template name="generateDataOfbid">
        <xsl:param name="idvalue"/>
        <xsl:attribute name="data-ofbid" select="$idvalue"/>
    </xsl:template>
    
    
</xsl:stylesheet>