<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    Converts the DIVS the foreign elements, like map, index.
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:opentopic="http://www.idiominc.com/opentopic"
    xmlns:oxy="http://www.oxygenxml.com/extensions/author"
    xmlns:opentopic-index="http://www.idiominc.com/opentopic/index"
    xmlns:ot-placeholder="http://suite-sol.com/namespaces/ot-placeholder"
    
    exclude-result-prefixes="#all"
    version="2.0">
   
  <!--
    All the elements from other namespaces should have their contents 
    transformed in a tree of 'div' elements. They already have a @class
    attribute added by the merged map post-processing step.
    
    We except the change tracking structure.
  -->
    <xsl:template match="
            opentopic-index:* |
            opentopic:* |
            ot-placeholder:tablelist |
            ot-placeholder:figurelist |
            oxy:*[not(oxy:oxy-comment)][not(oxy:oxy-delete)][not(oxy:oxy-insert)][not(oxy:oxy-attributes)]">
        <xsl:apply-templates select="." mode="div-it"/>
    </xsl:template>

    <!-- 
      The change tracking structures (nested in the index or toc) should be processed in 
      the default mode, so that the change tracking specific spans are generated, not generic divs.
    -->
    <xsl:template match="oxy:oxy-comment | oxy:oxy-delete | oxy:oxy-insert | oxy:oxy-attributes | oxy:oxy-range-start | oxy:oxy-range-end" mode="div-it">
        <xsl:apply-templates select="." mode="#default"/>
    </xsl:template>


    <!-- Found a DITA element inside, go back to the default transformation -->
    <xsl:template match="*[contains(@class, ' topic/topic ')]" mode="div-it">
        <xsl:apply-templates select="."/>
    </xsl:template>
    <xsl:template match="*[contains(@class, ' topic/title ')]/*" mode="div-it">
        <xsl:apply-templates select="."/>
    </xsl:template>
    <xsl:template match="*[contains(@class, ' topic/navtitle ')]/*" mode="div-it">
        <xsl:apply-templates select="."/>
    </xsl:template>

    <!-- Indexterms from the topic content and from the prolog (moved into title) should become spans
        and be styled as transparent from the CSS. In this way they do not break the lines. -->
    <xsl:template match="
            *[ancestor-or-self::*[contains(@class, ' index/entry ')]][ancestor::*[contains(@class, ' topic/topic ')]] |
            *[contains(@class, ' topic/title ')]/opentopic-index:*" mode="div-it" priority="2">
        <span>
            <xsl:call-template name="div-it-element-content"/>
        </span>
    </xsl:template>

    <xsl:template match="*" mode="div-it">
        <div>
            <xsl:call-template name="div-it-element-content"/>
        </div>
    </xsl:template>

    <!-- Generates attributes and children for a foreign element -->
    <xsl:template name="div-it-element-content">
        <xsl:apply-templates select="@* except @class" mode="div-it"/>
        <xsl:call-template name="commonattributes"/>
        <xsl:apply-templates select="node()" mode="div-it"/>
    </xsl:template>

    <xsl:template match="text()" mode="div-it">
        <xsl:copy/>
    </xsl:template>

    <xsl:template match="@*" mode="div-it">
        <xsl:copy/>
    </xsl:template>

    <xsl:template match="@xtrf" mode="div-it" priority="2"/>
    <xsl:template match="@xtrc" mode="div-it" priority="2"/>

</xsl:stylesheet>
