<?xml version="1.0" encoding="UTF-8"?>

<!--
    Used to contribute values for fragment/@placeholder attribute by looking in 
    the WebHelp plugin templates and plugin files.
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    exclude-result-prefixes="xs xd"
    xmlns:f="http://oxygenxml.com/publishing-template/functions"
    xmlns:whc="http://www.oxygenxml.com/webhelp/components"
    version="2.0">
    
    <xsl:param name="documentSystemID"></xsl:param>
    <xsl:param name="contextElementXPathExpression" as="xs:string"></xsl:param>
    
    <xsl:variable name="defaultFragmentDoc">Specifies either an XHTML fragment or the path to an XHTML file.</xsl:variable>
    
    <xsl:include href="cc_config_common.xsl"/>
    
    <xsl:template name="start">
        <!-- Get all available HTML fragments -->        
        <xsl:variable 
            name="allFragments" 
            select="f:getAllFragmentIDs()"/>
        
        <xsl:if test="exists($allFragments)">
            <items action="replace">
                <xsl:for-each select="$allFragments">
                    <xsl:sort select="@href"/>
                    
                    <xsl:variable name="fragmentID" 
                        select="substring-before(substring-after(./@href, '{'), '}')"/>
                    
                    <!-- Get the documentation from the parameter's description -->
                    <xsl:variable name="allParams" select="f:getAllWebHelpParams()"/>                    
                    <xsl:variable 
                        name="descr" 
                        select="$allParams[@name = $fragmentID]/@desc"/>
                    
                    <item 
                        value="{$fragmentID}" 
                        annotation="{$descr}"/>
                </xsl:for-each>
            </items>                
        </xsl:if>
    </xsl:template>
    
    <!--
        Function to get all available WebHelp HTML Fragments.
    -->
    <xsl:function name="f:getAllFragmentIDs">
        <xsl:variable name="wh-res-main-page-uri"
            select="resolve-uri('../../dita/DITA-OT3.x/plugins/com.oxygenxml.webhelp.responsive/oxygen-webhelp/page-templates/wt_index.html')"/>
                
        <xsl:variable name="wh-fragments-main-page">
            <xsl:if test="doc-available($wh-res-main-page-uri)">
                <xsl:sequence select="doc($wh-res-main-page-uri)//whc:include_html"/>
            </xsl:if>
        </xsl:variable>
        
        <xsl:variable name="wh-res-topic-page-uri"
            select="resolve-uri('../../dita/DITA-OT3.x/plugins/com.oxygenxml.webhelp.responsive/oxygen-webhelp/page-templates/wt_topic.html')"/>        
        <xsl:variable name="wh-fragments-topic-page">
            <xsl:if test="doc-available($wh-res-topic-page-uri)">
                <xsl:sequence select="doc($wh-res-topic-page-uri)//whc:include_html"/>
            </xsl:if>
        </xsl:variable>
        
        <xsl:variable name="wh-res-search-page-uri"
            select="resolve-uri('../../dita/DITA-OT3.x/plugins/com.oxygenxml.webhelp.responsive/oxygen-webhelp/page-templates/wt_search.html')"/>        
        <xsl:variable name="wh-fragments-search-page">
            <xsl:if test="doc-available($wh-res-search-page-uri)">
                <xsl:sequence select="doc($wh-res-search-page-uri)//whc:include_html"/>
            </xsl:if>
        </xsl:variable>
        
        <xsl:variable name="wh-res-terms-page-uri"
            select="resolve-uri('../../dita/DITA-OT3.x/plugins/com.oxygenxml.webhelp.responsive/oxygen-webhelp/page-templates/wt_terms.html')"/>        
        <xsl:variable name="wh-fragments-terms-page">
            <xsl:if test="doc-available($wh-res-terms-page-uri)">
                <xsl:sequence select="doc($wh-res-terms-page-uri)//whc:include_html"/>
            </xsl:if>
        </xsl:variable>
        
        <xsl:sequence select="
            $wh-fragments-main-page/* 
            union $wh-fragments-topic-page/*
            union $wh-fragments-search-page/*
            union $wh-fragments-terms-page/*"/>
    </xsl:function>
    
</xsl:stylesheet>