<?xml version="1.0" encoding="UTF-8"?>

<!--
    Used to contribute values for parameter/@name attribute by looking in the declared parameters from WebHelp plugin.
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    exclude-result-prefixes="xs xd"
    xmlns:f="http://oxygenxml.com/publishing-template/functions"
    version="2.0">
    
    <xsl:include href="cc_config_common.xsl"/>
    
    <xsl:param name="documentSystemID"></xsl:param>
    <xsl:param name="contextElementXPathExpression" as="xs:string"></xsl:param>
    
    <xsl:template name="start">
        <xsl:variable 
            name="descriptorDoc" 
            select="doc($documentSystemID)"/>
        
        <!-- Find the current edited parameter -->
        <xsl:variable name="currentParam" as="element()*">
            <xsl:evaluate xpath="$contextElementXPathExpression" as="element()*" context-item="$descriptorDoc"/>
        </xsl:variable>
        
        <!-- Get all available params -->        
        <xsl:variable name="webhelpContext" select="exists($currentParam/ancestor::webhelp)" as="xs:boolean"/>        
        
        <xsl:variable name="allParams" select="
            if ($webhelpContext)
            then f:getAllWebHelpParams()
            else f:getAllPDFCSSParams()"/>
        
        <xsl:if test="exists($allParams)">           
           <items action="replace">
               <xsl:apply-templates select="$allParams">
                   <xsl:sort select="@name"/>
               </xsl:apply-templates>
           </items>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="param">
        <item 
            value="{@name}" 
            annotation="{@desc}"/>
    </xsl:template>
    
</xsl:stylesheet>