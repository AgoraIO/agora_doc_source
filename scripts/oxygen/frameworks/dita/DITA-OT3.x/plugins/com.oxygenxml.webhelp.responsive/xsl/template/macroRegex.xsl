<?xml version="1.0" encoding="UTF-8"?>
<!--
    
Oxygen Webhelp plugin
Copyright (c) 1998-2022 Syncro Soft SRL, Romania.  All rights reserved.

-->

<!-- 
    Used to parse Webhelp macros like: ${path(oxygen-webhelp-output-dir)}.  
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
    exclude-result-prefixes="#all"
    version="2.0">
    <!-- One or more spaces. -->
    <xsl:variable name="S" select="'[ \t\r\n]+'"/>
    <!-- Optional spaces -->
    <xsl:variable name="S0" select="'[ \t\r\n]*'"/>
    <!-- RegEx flags -->
    <xsl:variable name="FLAGS" select="'ims'"/>
    
    <!-- 
       Returns a regex expression that matches a template macro reference. 
    -->
    <xsl:function name="mcr:macro-regex" as="xs:string">
        <!-- Macro regex -->
        <!-- '${' name S? ( '(' S? param S? (, S? param S?)* ')' )? } -->
        <xsl:value-of
            select="concat('\$\{', $S0, mcr:name-regex(), $S0, mcr:params-regex(), $S0, '\}' )"
        />
    </xsl:function>
    <xsl:function name="mcr:name-regex">
        <!-- ?: marks a non-capturing group -->
        <xsl:value-of>([a-z0-9\-_\.:]+)</xsl:value-of>
    </xsl:function>
    
    <!--
        <!-\- Multiple-args macros -\->
        <xsl:function name="mcr:params-regex">
        <!-\- ?: marks a non-capturing group -\->
        <xsl:variable name="param">[^,]+</xsl:variable>
        <xsl:variable name="params-list" select="concat('(', $S0, $param, $S0, '(,', $S0, $param, $S0, ')*)' )"/>
        <xsl:value-of select="concat('(\(', $params-list, '\))?')"/>
    </xsl:function>-->
    
    <!-- One-arg macros -->
    <xsl:function name="mcr:params-regex">
        <!-- ?: marks a non-capturing group -->
        <xsl:variable name="param">[^\}]+</xsl:variable>
        <xsl:variable name="params-list" select="concat($S0, '(', $param, ')', $S0)"/>
        <xsl:value-of select="concat('(\(', $params-list, '\))?')"/>
    </xsl:function>
    
    <!-- Tokenize parameteres and returns them as a sequence -->
    <xsl:function name="mcr:tokenize-params" as="xs:string*">
        <xsl:param name="paramsString" as="xs:string"/>
        <xsl:variable name="trimmedParams" select="mcr:trim($paramsString)"/>
        <xsl:variable name="paramsList" select="tokenize($trimmedParams, concat($S0, ',[^,]', $S0), $FLAGS)"/>
        <xsl:sequence select="$paramsList"/>
    </xsl:function>
    
    <!-- Trim leading and trailing spaces -->
    <xsl:function name="mcr:trim">
        <xsl:param name="string" as="xs:string"/>
        <xsl:value-of select="replace($string, mcr:leading-trailing-spaces(), '', $FLAGS)"/>
    </xsl:function>
    
    <!-- Leading or Tariling spaces regular expression. -->
    <xsl:function name="mcr:leading-trailing-spaces" as="xs:string">
        <!-- (^([ \t\r\n]+)) | (([ \t\r\n]+)$) -->
        <xsl:value-of select="concat('(^', $S, ')|(', $S, '$)' )"/>
    </xsl:function>
</xsl:stylesheet>