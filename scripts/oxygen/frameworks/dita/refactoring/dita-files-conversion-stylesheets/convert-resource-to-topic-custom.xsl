<?xml version="1.0" encoding="UTF-8"?>
<!--
    Copyright 2001-2017 Syncro Soft SRL. All rights reserved.
 -->
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="3.0">

    <xsl:import href="convert-resource-to-topic.xsl"/>

    <!-- Match root -->
    <xsl:template match="reference|task|troubleshooting|concept">
        <topic>
            <xsl:copy-of select="namespace::*"/>
            <xsl:apply-templates select="@*"/>
            <xsl:apply-templates select="node()"/>
        </topic>
    </xsl:template>

    <xsl:template match="*[ self::section or self::refsyn or self::prereq or self::context or self::steps-informal or self::tasktroubleshooting or self::result or self::postreq or self::condition or self::cause or self::remedy ]">
        <xsl:choose>
            <xsl:when test="not(@*[local-name() != 'class' and namespace-uri() != 'http://www.oxygenxml.com/ns/xmlRefactoring/additional_attributes']) and parent::*[ self::section or self::refsyn or self::prereq or self::context or self::steps-informal or self::tasktroubleshooting or self::result or self::postreq or self::condition or self::cause or self::remedy ]">
                <xsl:apply-templates select="node()"/>
           </xsl:when>
           <xsl:otherwise>
               <section>
                    <xsl:apply-templates select="@*|node()"/>
               </section>
           </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- only cmd element without attributes -->
    <xsl:template match="*[ self::cmd ][count(@*[local-name() != 'class' and namespace-uri() != 'http://www.oxygenxml.com/ns/xmlRefactoring/additional_attributes']) = 0]">
        <xsl:apply-templates select="node()"/>
    </xsl:template>
    
    <!-- only context element without attributes -->
    <xsl:template match="*[ self::context ][count(@*[local-name() != 'class' and namespace-uri() != 'http://www.oxygenxml.com/ns/xmlRefactoring/additional_attributes']) = 0]">
        <xsl:apply-templates select="node()"/>
    </xsl:template>
</xsl:stylesheet>
