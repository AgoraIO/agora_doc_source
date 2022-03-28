<?xml version="1.0" encoding="UTF-8"?>
<!--
    
Oxygen WebHelp Plugin
Copyright (c) 1998-2021 Syncro Soft SRL, Romania.  All rights reserved.

-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:oxygen="http://www.oxygenxml.com/functions"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:param name="DITA_OT_PLUGINS_FILE_PATH"/>
    
    <xsl:template name="generateLocalizationFiles">
        <xsl:param name="jsURL"/>
        <xsl:param name="phpURL"/>
        <xsl:result-document href="{$jsURL}" method="text">
            <xsl:text>var localization = new Array();

</xsl:text>
            <xsl:call-template name="generateArrayElements">
                <xsl:with-param name="arrayName" select="'localization'"/>
                <xsl:with-param name="outputLang" select="'js'"/>
            </xsl:call-template>
        </xsl:result-document>
        
    </xsl:template>
    
    
    <xsl:template name="generateArrayElements">
        <xsl:param name="arrayName"/>
        <xsl:param name="outputLang"/>
                
        <xsl:variable name="language">
            <xsl:call-template name="getLowerCaseLang"/>
        </xsl:variable>
        <xsl:variable name="languageFileList" select="'../oxygen-webhelp/resources/localization/strings.xml'"/>
        <xsl:variable name="stringFileName"
            select="document($languageFileList)/*/lang[@xml:lang=$language]/@filename"/>
            <xsl:variable name="stringFile" 
                select="concat('../oxygen-webhelp/resources/localization/', 
                               if (string-length($stringFileName) > 0) then $stringFileName 
                                   else 'strings-en-us.xml')"/>
            <xsl:variable name="strings">
                <xsl:choose>
                    <xsl:when test="$outputLang = 'js'">
                        <xsl:copy-of select="document($stringFile)/strings/str[@js = 'true']"/>
                    </xsl:when>
                    <xsl:when test="$outputLang = 'php'">
                        <xsl:copy-of select="document($stringFile)/strings/str[@php = 'true']"/>
                    </xsl:when>
                </xsl:choose>
            </xsl:variable>
            
            <!-- 
            	WH-1931 - Get strings from extension plugins 
            --> 
            <xsl:variable name="extensionsStrings">
                <xsl:call-template name="copyExtensionPluginStrings">
                    <xsl:with-param name="language" select="$language"/>
                </xsl:call-template>            
            </xsl:variable>
            
        
            <!-- WH-1931 - Merge localization strings -->
            <xsl:variable name="mergedStringsElem">
                <xsl:apply-templates 
                    select="$strings" 
                    mode="merge-location-strings">
                    <xsl:with-param name="extensionStrings" select="$extensionsStrings" tunnel="yes"/>
                </xsl:apply-templates>            
            </xsl:variable>
        
        
            <xsl:if test="count($strings) > 0">
                <xsl:for-each select="$mergedStringsElem/str">
                    <xsl:value-of select="$arrayName"/>
                    <xsl:text>["</xsl:text><xsl:value-of select="@name"/><xsl:text>"]="</xsl:text>
                    <xsl:value-of select="normalize-space()"/>
                    <xsl:text>";
    </xsl:text>
                </xsl:for-each>
            </xsl:if>
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
                    select="$allPluginsDoc//plugin[require/@plugin='com.oxygenxml.webhelp.classic'][1]/feature[@extension='dita.xsl.strings']/@file"/>
                
                <xsl:choose>
                    <xsl:when 
                        test="exists($xslStringsExtensionsFile)">
                        <!-- There is an extensions plugins that contributes strings -->
                        <xsl:variable 
                            name="extensionPluginBaseURL" 
                            select="$allPluginsDoc//plugin[require/@plugin='com.oxygenxml.webhelp.classic'][1][feature/@extension='dita.xsl.strings']/@xml:base"/>
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
</xsl:stylesheet>