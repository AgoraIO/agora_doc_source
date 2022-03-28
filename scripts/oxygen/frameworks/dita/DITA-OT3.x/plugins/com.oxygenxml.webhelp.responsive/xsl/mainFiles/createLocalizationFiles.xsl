<?xml version="1.0" encoding="UTF-8"?>
<!--
    
Oxygen WebHelp Plugin
Copyright (c) 1998-2022 Syncro Soft SRL, Romania.  All rights reserved.

-->

<!--
    Generate localization files for JS and PHP.
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns:d="http://docbook.org/ns/docbook" xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc"
    xmlns:index="http://www.oxygenxml.com/ns/webhelp/index"
    xmlns:oxygen="http://www.oxygenxml.com/functions"
    exclude-result-prefixes="xs toc" version="2.0">

    <!-- Localization of text strings displayed in Webhelp output. -->
    <xsl:import href="../util/functions.xsl"/>
    
    <xsl:import href="../util/relpath_util.xsl"/>

    <!-- Declares all available parameters -->
    <xsl:include href="params.xsl"/>

    <xsl:param name="DITA_OT_PLUGINS_FILE_PATH"/>

    <!-- 
        Creates the localization files. 
    -->
    <xsl:template match="/">
        <!-- Get current detected language -->
        <xsl:variable name="language" select="lower-case(oxygen:getParameter('webhelp.language'))"/>
        
        <!-- 
        	WH-1931 - Get strings from extension plugins 
        --> 
        <xsl:variable name="extensionsStrings">
            <xsl:call-template name="copyExtensionPluginStrings">
                <xsl:with-param name="language" select="$language"/>
            </xsl:call-template>            
        </xsl:variable>
        

        <xsl:variable name="stringFileName" select="*/lang[@xml:lang = $language]/@filename"/>
        <xsl:variable name="stringFile"
            select="
                concat($BASEDIR, '/oxygen-webhelp/resources/localization/',
                if (string-length($stringFileName) > 0) then
                    $stringFileName
                else
                    'strings-en-us.xml')"/>
        
        <xsl:variable name="stringFileUrl"
            select="oxygen:makeURL($stringFile)"/>        
        
        <xsl:variable name="stringsElem" select="document($stringFileUrl, .)/strings"/>
        
        <!-- WH-1931 - Merge localization strings -->
        <xsl:variable name="mergedStringsElem">
            <xsl:apply-templates 
                select="$stringsElem" 
                mode="merge-location-strings">
                <xsl:with-param name="extensionStrings" select="$extensionsStrings" tunnel="yes"/>
            </xsl:apply-templates>            
        </xsl:variable>
        

        <!-- Generate localization files for JS -->
        <xsl:call-template name="generateJsLocalizationFile">
            <xsl:with-param name="stringsElem" select="$mergedStringsElem"/>
        </xsl:call-template>
        
    </xsl:template>
    
    <!--
        WH-1931 - Merge localization strings with the ones from extension plugins
        
        <str name="jump.to.content" js="true" php="false">Changed Jump to main content</str>
    -->
    <xsl:template match="str" mode="merge-location-strings">
        <xsl:param name="extensionStrings" tunnel="yes"/>
        <xsl:variable name="stringName" select="@name"/>
        <xsl:choose>
            <xsl:when test="$extensionStrings//str[@name = $stringName]">                
                <xsl:copy-of select="$extensionStrings//str[@name = $stringName]"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:copy>
                    <xsl:apply-templates select="node() | @*" mode="#current"/>            
                </xsl:copy>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="node() | @*" mode="merge-location-strings">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*" mode="#current"/>            
        </xsl:copy>
    </xsl:template>
    
    <!--
	    WH-1931
        Verify if there is any language extensions plugin for WebHelp.        
        If any, then copy the strings according to the current language.
    -->    
    <xsl:template name="copyExtensionPluginStrings">
        <xsl:param name="language"/>
        
        <!-- URL to DITA-OT plugins file. Ussualy located in resources folder -->
        <xsl:variable name="ditaotPluginsURL" select="oxygen:makeURL($DITA_OT_PLUGINS_FILE_PATH)"/>
        
        <xsl:choose>
            <xsl:when test="doc-available($ditaotPluginsURL)">
                <xsl:variable name="allPluginsDoc" select="doc($ditaotPluginsURL)"/>
                <xsl:variable 
                    name="xslStringsExtensionsFile" 
                    select="$allPluginsDoc//plugin[require/@plugin='com.oxygenxml.webhelp.responsive'][1]/feature[@extension='dita.xsl.strings']/@file"/>
                
                <xsl:choose>
                    <xsl:when 
                         test="exists($xslStringsExtensionsFile)">
                        <!-- There is an extensions plugins that contributes strings -->
                        <xsl:variable 
                            name="extensionPluginBaseURL" 
                            select="$allPluginsDoc//plugin[require/@plugin='com.oxygenxml.webhelp.responsive'][1][feature/@extension='dita.xsl.strings']/@xml:base"/>
                        <!--<xsl:message>xml:base: <xsl:value-of select="$extensionPluginBaseURL"/></xsl:message>-->
                        
                        <xsl:variable name="extensionPluginURL" 
                            select="resolve-uri(
                            $extensionPluginBaseURL,
                            $ditaotPluginsURL)"/>
                        
                        <xsl:variable name="extensionsStringURL" 
                            select="resolve-uri(
                            $xslStringsExtensionsFile,
                            $extensionPluginURL)"/>                        
                        
                        <xsl:choose>
                            <xsl:when test="doc-available($extensionsStringURL)">
                                <!-- Strings file for language -->
                                <xsl:variable 
                                    name="stringFileName" 
                                    select="doc($extensionsStringURL)//lang[lower-case(@xml:lang) = lower-case($language)]/@filename"/>
                                
                                
                                <xsl:variable name="stringFileURL"
                                    select="resolve-uri($stringFileName, $extensionPluginURL)"/>
                                
                                <xsl:choose>
                                    <xsl:when test="doc-available($stringFileURL)">
                                        <xsl:sequence select="doc($stringFileURL)/*"/>                                        
                                    </xsl:when>
                                </xsl:choose>
                            </xsl:when>
                        </xsl:choose>
                    </xsl:when>
                </xsl:choose>
                
            </xsl:when>
            <xsl:otherwise>
                <xsl:message>ERROR: The 'resources/plugins.xml' resource is not available.</xsl:message>
            </xsl:otherwise>
        </xsl:choose>
        
        
    </xsl:template>

    <!--
        Generate localization file for JS.
    -->
    <xsl:template name="generateJsLocalizationFile">
        <xsl:param name="stringsElem"/>

        <xsl:variable name="jsResponsiveFileName" select="'oxygen-webhelp/app/localization/strings.js'"/>
        <xsl:variable name="jsURL" select="oxygen:makeURL(concat($OUTPUTDIR, '/', $jsResponsiveFileName))"/>
        
        <xsl:result-document href="{$jsURL}" method="text">
            
            <!-- Generate RequireJS define call -->
            <xsl:text>define(function() {</xsl:text>
            
            <xsl:text>var localization = new Array();</xsl:text>
            <xsl:text>&#10;</xsl:text>
            <xsl:call-template name="generateArrayElements">
                <xsl:with-param name="arrayName" select="'localization'"/>
                <xsl:with-param name="strings" select="$stringsElem//str[@js = 'true']"/>
            </xsl:call-template>
            
            <!-- End of RequireJS define call -->
            <xsl:text>return localization;});</xsl:text>
        </xsl:result-document>

    </xsl:template>

    <!-- Generate localization array. -->
    <xsl:template name="generateArrayElements">
        <xsl:param name="arrayName"/>
        <xsl:param name="strings"/>

        <xsl:if test="count($strings) > 0">
            <xsl:for-each select="$strings">
                <xsl:value-of select="$arrayName"/>
                <xsl:text>["</xsl:text>
                <xsl:value-of select="@name"/>
                <xsl:text>"]="</xsl:text>
                <xsl:value-of select="normalize-space()"/>
                <xsl:text>";</xsl:text>
                <xsl:text>&#10;</xsl:text>
            </xsl:for-each>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>
