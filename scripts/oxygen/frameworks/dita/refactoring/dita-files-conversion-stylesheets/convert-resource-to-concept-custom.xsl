<?xml version="1.0" encoding="UTF-8"?>
<!--
    Copyright 2001-2017 Syncro Soft SRL. All rights reserved.
 -->
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="3.0">

    <xsl:import href="convert-resource-to-concept.xsl"/>

    <!-- Match root -->
    <xsl:template match="topic|task|troubleshooting|reference">
        <concept>
            <xsl:copy-of select="namespace::*"/>
            <xsl:apply-templates select="@*"/>
            <xsl:apply-templates select="node()"/>
        </concept>
    </xsl:template>

    <xsl:template match="*[( self::section or self::refsyn or self::prereq or self::context or self::steps-informal or self::tasktroubleshooting or self::result or self::postreq or self::condition or self::cause or self::remedy )]">
        <section>
            <xsl:apply-templates select="@*|node()"/>
        </section>
    </xsl:template>

    <!-- only cmd element without attributes -->
    <xsl:template match="*[ self::cmd ][count(@*[local-name() != 'class' and namespace-uri() != 'http://www.oxygenxml.com/ns/xmlRefactoring/additional_attributes']) = 0]">
        <xsl:apply-templates select="node()"/>
    </xsl:template>
    
    <!-- only context element without attributes -->
    <xsl:template match="*[ self::context ][count(@*[local-name() != 'class' and namespace-uri() != 'http://www.oxygenxml.com/ns/xmlRefactoring/additional_attributes']) = 0]">
        <xsl:apply-templates select="node()"/>
    </xsl:template>
    
    <!-- context element with attributes -->
    <xsl:template match="*[ self::context ][count(@*[local-name() != 'class' and namespace-uri() != 'http://www.oxygenxml.com/ns/xmlRefactoring/additional_attributes']) > 0]">
        <div>
            <xsl:apply-templates select="@*|node()"/>
        </div>
    </xsl:template>
</xsl:stylesheet>
