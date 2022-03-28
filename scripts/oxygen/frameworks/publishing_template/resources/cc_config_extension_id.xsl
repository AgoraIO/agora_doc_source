<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    exclude-result-prefixes="xs xd"
    xmlns:f="http://oxygenxml.com/publishing-template/functions"
    version="3.0">
    
    <xsl:param name="documentSystemID"></xsl:param>
    <xsl:param name="contextElementXPathExpression" as="xs:string"></xsl:param>
    
    <xsl:template name="start">        
        <xsl:variable 
            name="descriptorDoc" 
            select="doc($documentSystemID)"/>
        
        <!-- Find the current edited extension -->
        <xsl:variable name="currentelem" as="element()*">
            <xsl:evaluate xpath="$contextElementXPathExpression" as="element()*" context-item="$descriptorDoc"/>
        </xsl:variable>
        
        <!-- 
            Define if it is a WebHelp extension point 
        -->
        <xsl:variable 
            name="webhelpExtensionPoint" 
            select="count($currentelem/ancestor::webhelp) eq 1" 
            as="xs:boolean"/>
        
        <xsl:choose>
            <xsl:when test="$webhelpExtensionPoint">
                <!-- 
                    WebHelp extension points. 
                -->
                <items action="replace">
                    <item value="com.oxygenxml.webhelp.xsl.dita2webhelp"/>
                    <item value="com.oxygenxml.webhelp.xsl.createMainPage"/>
                    <item value="com.oxygenxml.webhelp.xsl.createSearchPage"/>
                    <item value="com.oxygenxml.webhelp.xsl.createIndexTermsPage"/>
                    <item value="com.oxygenxml.webhelp.xsl.createTocXML"/>
                    <item value="com.oxygenxml.webhelp.xsl.createNavLinks"/>
                </items>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
</xsl:stylesheet>