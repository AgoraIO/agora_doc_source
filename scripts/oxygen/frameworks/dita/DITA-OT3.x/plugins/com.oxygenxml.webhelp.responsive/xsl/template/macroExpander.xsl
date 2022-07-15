<?xml version="1.0" encoding="UTF-8"?>
<!--
    
Oxygen Webhelp plugin
Copyright (c) 1998-2022 Syncro Soft SRL, Romania.  All rights reserved.

-->

<!-- 
    Used to expand Webhelp macros like: oxygen-webhelp-output-dir.  
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:oxy="http://www.oxygenxml.com/functions"
    xmlns:relpath="http://dita2indesign/functions/relpath"
    xmlns:whc="http://www.oxygenxml.com/webhelp/components"
    xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc"
    xmlns:oxygen="http://www.oxygenxml.com/functions"
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:html="http://www.w3.org/1999/xhtml"
    xmlns:index="http://www.oxygenxml.com/ns/webhelp/index"
    xmlns:mcr="http://www.oxygenxml.com/ns/webhelp/macro"
    xmlns:Evaluate="java:com.oxygenxml.dita.xsltextensions.Evaluate"
    exclude-result-prefixes="#all"
    version="2.0">
    
    <xsl:import href="macroRegex.xsl"/>
    
    <xsl:template 
        match="@*[contains(., '${')]" 
        mode="copy_template"
        priority="10">
        <xsl:param name="i18n_context" tunnel="yes" as="element()*"/>
        <xsl:attribute name="{name()}">
            <xsl:call-template name="expand-macros">
                <xsl:with-param name="value" select="."/>
                <xsl:with-param name="contextNode" select="."/>
                <xsl:with-param name="i18n_context" select="$i18n_context"/>
            </xsl:call-template>
        </xsl:attribute>
    </xsl:template>
    
    <xsl:template match="whc:macro" mode="copy_template" priority="10">
        <xsl:param name="i18n_context" tunnel="yes" as="element()*"/>
        
        <xsl:call-template name="expand-macros">
            <xsl:with-param name="value" select="@value"/>
            <xsl:with-param name="contextNode" select="."/>
            <xsl:with-param name="i18n_context" select="$i18n_context"/>
        </xsl:call-template>
    </xsl:template>
    
    <xsl:template name="expand-macros">
        <xsl:param name="value"/>
        <xsl:param name="contextNode"/>
        <xsl:param name="i18n_context" as="element()*"/>
        
        <xsl:analyze-string select="$value" regex="{mcr:macro-regex()}" flags="{$FLAGS}">
            <xsl:matching-substring>
                <xsl:variable name="macroName" select="regex-group(1)"/>
                <xsl:variable name="paramsString" select="string(regex-group(3))"/>
                <!--<xsl:variable name="macroParams" select="mcr:tokenize-params($paramsString)"/>-->
                <xsl:variable name="macroParams" select="mcr:trim($paramsString)"/>
                
                <xsl:call-template name="wh-macro">
                    <xsl:with-param name="name" select="$macroName"/>
                    <xsl:with-param name="params" select="$macroParams"/>
                    <xsl:with-param name="i18n_context" select="$i18n_context"/>
                    <xsl:with-param name="contextNode" select="$contextNode"/>
                    <xsl:with-param name="matchedString" select="."/>
                </xsl:call-template>
            </xsl:matching-substring>
            <xsl:non-matching-substring>
                <xsl:choose>
                    <xsl:when test="not($contextNode) or $contextNode instance of attribute()">
                        <xsl:value-of select="."/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:message>Cannot expand macro: [<xsl:value-of select="$value"/>]</xsl:message>
                        <xsl:copy-of select="$contextNode"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:non-matching-substring>
        </xsl:analyze-string>
    </xsl:template>
    
    <xsl:template name="wh-macro">
        <xsl:param name="name" as="xs:string"/>
        <xsl:param name="params" as="xs:string*"/>
        <xsl:param name="i18n_context" as="element()*"/>
        <xsl:param name="contextNode"/>
        <xsl:param name="matchedString"/>
        <xsl:choose>
            <xsl:when test="'i18n' eq $name">
                <xsl:call-template name="wh-macro-i18n">
                    <xsl:with-param name="params" select="$params"/>
                    <xsl:with-param name="i18n_context" select="$i18n_context"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:when test="'timestamp' eq $name">
                <xsl:call-template name="wh-macro-timestamp">
                    <xsl:with-param name="params" select="$params"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:when test="'map-xpath' eq $name">
                <xsl:call-template name="wh-macro-map-xpath">
                    <xsl:with-param name="params" select="$params"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:when test="'topic-xpath' eq $name">
                <xsl:call-template name="wh-macro-topic-xpath">
                    <xsl:with-param name="params" select="$params"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:when test="'system-property' eq $name">
                <xsl:call-template name="wh-macro-system-property">
                    <xsl:with-param name="params" select="$params"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:when test="'env' eq $name">
                <xsl:call-template name="wh-macro-env">
                    <xsl:with-param name="params" select="$params"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:when test="$name = 'path'">
                <xsl:call-template name="wh-macro-path">
                    <xsl:with-param name="params" select="$params"/>
                </xsl:call-template>
            </xsl:when>
            <!-- Backwards compatibility with the old way of referring paths as macros. -->
            <xsl:when test="$name = ('oxygen-webhelp-output-dir', 'oxygen-webhelp-assets-dir','oxygen-webhelp-template-dir')">
                <xsl:call-template name="wh-macro-path">
                    <xsl:with-param name="params" select="$name"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:when test="'param' eq $name">
                <xsl:call-template name="wh-macro-param">
                    <xsl:with-param name="params" select="$params"/>
                    <xsl:with-param name="contextNode" select="$contextNode"/>
                    <xsl:with-param name="i18n_context" select="$i18n_context"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:when test="starts-with($name, 'webhelp.fragment') or $name = ('args.hdr', 'args.hdf', 'webhelp.google.search.script')">
                <!-- Backwards compatibility: in older versions of the templates files we used parameters names as macros (e.g.: ${args.hdf})  -->
                <xsl:call-template name="wh-macro-param">
                    <xsl:with-param name="params" select="$name"/>
                    <xsl:with-param name="contextNode" select="$contextNode"/>
                    <xsl:with-param name="i18n_context" select="$i18n_context"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:when test="$name = 'oxygen-webhelp-build-number'">
                <xsl:call-template name="wh-macro-build-number"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="wh-macro-extension">
                    <xsl:with-param name="name" select="$name"/>
                    <xsl:with-param name="params" select="$params"/>
                    <xsl:with-param name="contextNode" select="$contextNode"/>
                    <xsl:with-param name="matchedString" select="$matchedString"/>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- Extension template for expanding custom macro constructs -->
    <xsl:template name="wh-macro-extension">
        <xsl:param name="name"/>
        <xsl:param name="params"/>
        <xsl:param name="contextNode"/>
        <xsl:param name="matchedString"/>
        
        <xsl:choose>
            <xsl:when test="not($contextNode) or $contextNode instance of attribute()">
                <xsl:value-of select="$matchedString"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:message>Cannot expand macro: [<xsl:value-of select="$matchedString"/>]</xsl:message>
                <xsl:copy-of select="$contextNode"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- Expands a 'param' macro. -->
    <xsl:template name="wh-macro-param">
        <xsl:param name="params"/>
        <xsl:param name="i18n_context" as="element()*"/>
        <xsl:param name="contextNode"/>
        
        <xsl:variable name="paramName" select="$params[1]"/>
        
        <xsl:variable name="paramValue" select="oxygen:getParameter($paramName)"/>
        <xsl:choose>
            <xsl:when test="contains($paramValue, '${')">
                <!-- The parameter value may contain macros -> let's expand them -->
                <xsl:call-template name="expand-macros">
                    <xsl:with-param name="value" select="$paramValue"/>
                    <xsl:with-param name="i18n_context" select="$i18n_context"/>
                    <!-- 
                        Do not forward $contextNode, otherwise <whc:macro ...> won't be expanded and it will be copied as is
                        -> see expand-macros non matching substring processing 
                    -->
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$paramValue"/>
            </xsl:otherwise>
        </xsl:choose>
        
    </xsl:template>

    <!-- Expands an 'env' macro. Returns the value of the environment variable specified as the macro's first parameter. -->
    <xsl:template name="wh-macro-env">
        <xsl:param name="params"/>
        <xsl:variable name="paramName" select="string($params[1])"/>
        <xsl:value-of select="oxygen:getParameter(concat('env.', $paramName))"/>
    </xsl:template>
    
    <!-- Expands a 'system-property' macro. Returns the value of the system property specified as the macro's first parameter. -->
    <xsl:template name="wh-macro-system-property">
        <xsl:param name="params"/>
        <xsl:value-of select="system-property(string($params[1]))"/>
    </xsl:template>
    
    <!-- Expands a 'map-xpath' macro. -->
    <xsl:template name="wh-macro-map-xpath">
        <xsl:param name="params"/>
        <xsl:variable name="xpathExpr" as="xs:string" select="$params[1]"/>
        
        <xsl:call-template name="wh-execute-macro-xpath">
            <xsl:with-param name="xpathExpression" select="$xpathExpr"/>
            <xsl:with-param name="fileUrl" select="$WEBHELP_DITAMAP_URL"/>
        </xsl:call-template>
    </xsl:template>
    
    <!-- Expands a 'topic-xpath' macro. -->
    <xsl:template name="wh-macro-topic-xpath">
        <xsl:param name="params"/>
        <!-- The topic-xpath macro is only available in topics pages. -->
        <!-- This template is overridden in the 'topicComponentsExpander.xsl' -->
        <xsl:copy-of select="."/>
    </xsl:template>
    
    <!-- Executes an XPath expression over the given resource. -->
    <xsl:template name="wh-execute-macro-xpath">
        <xsl:param name="xpathExpression" as="xs:string"/>
        <xsl:param name="fileUrl" as="xs:string"/>
        
        <xsl:variable name="xpathContextNode" select="doc($fileUrl)"/>
        <xsl:variable name="xpathResult" xmlns:saxon="http://saxon.sf.net/">
            <whc:macro-xpath-result>
                <xsl:for-each select="$xpathContextNode">
                    <xsl:copy-of select="Evaluate:evaluate($xpathExpression)"/>
                </xsl:for-each>
            </whc:macro-xpath-result>
        </xsl:variable>
        <xsl:apply-templates select="$xpathResult/whc:macro-xpath-result/(node() | @*)" mode="copy-macro-xpath-result"/>
    </xsl:template>
    
    <!-- Expands a 'timestamp' macro. Returns the current date and time formatted according to the given pattern. -->
    <xsl:template name="wh-macro-timestamp">
        <xsl:param name="params"/>
        <xsl:variable name="format">
            <xsl:choose>
                <xsl:when test="$params[1] and string-length($params[1]) > 0">
                    <xsl:value-of select="$params[1]"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="'[h1]:[m01] [P] [M01]/[D01]/[Y0001]'"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:value-of select="format-dateTime(current-dateTime(), $format)"/>
    </xsl:template>
    
    <!-- Expands an 'i18n' macro. Returns the localized value of the string specified as the macro's first parameter. -->
    <xsl:template name="wh-macro-i18n">
        <xsl:param name="params"/>
        <xsl:param name="i18n_context" as="element()*"/>
        <xsl:if test="exists($i18n_context)">
            <xsl:for-each select="$i18n_context">
                <xsl:call-template name="getWebhelpString">
                    <xsl:with-param name="stringName" select="$params[1]"/>
                </xsl:call-template>
            </xsl:for-each>
        </xsl:if>
    </xsl:template>
    
    <!-- Expands a 'path' macro. Returns the path associated with the ID specified as the macro's first parameter. -->
    <xsl:template name="wh-macro-path">
        <xsl:param name="params"/>
        <xsl:variable name="pathId" select="$params[1]"/>
        <xsl:variable name="outputDirPath">
            <xsl:choose>
                <xsl:when test="string-length($PATH2PROJ) = 0">
                    <xsl:value-of select="'.'"/>
                </xsl:when>
                <xsl:when test="ends-with($PATH2PROJ, '/')">
                    <xsl:variable name="length" select="string-length($PATH2PROJ)" as="xs:integer"/>
                    <xsl:value-of select="substring($PATH2PROJ, 1, $length - 1)"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$PATH2PROJ"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        
        <xsl:choose>
            <xsl:when test="'oxygen-webhelp-output-dir' = $pathId">
                <xsl:value-of select="$outputDirPath"/>
            </xsl:when>
            <xsl:when test="'oxygen-webhelp-assets-dir' = $pathId">
                <xsl:choose>
                    <xsl:when test="string-length($outputDirPath) = 0">
                        <xsl:value-of select="'oxygen-webhelp'"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="concat($outputDirPath, '/oxygen-webhelp')"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="'oxygen-webhelp-template-dir' = $pathId">
                <xsl:choose>
                    <xsl:when test="string-length($outputDirPath) = 0">
                        <xsl:value-of select="'oxygen-webhelp/template'"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="concat($outputDirPath, '/oxygen-webhelp/template')"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="wh-macro-custom-path">
                    <xsl:with-param name="pathId" select="$pathId"/>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- Expands the 'oxygen-webhelp-build-number' macro. -->
    <xsl:template name="wh-macro-build-number">
        <xsl:value-of select="$WEBHELP_BUILD_NUMBER"/>
    </xsl:template>
    
    <!-- Extension template for expanding a custom path macro. -->
    <xsl:template name="wh-macro-custom-path">
        <xsl:param name="pathId"/>
        <xsl:value-of select="$pathId"/>
    </xsl:template>
</xsl:stylesheet>