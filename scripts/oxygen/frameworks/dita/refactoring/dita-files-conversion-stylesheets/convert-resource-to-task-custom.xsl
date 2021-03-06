<?xml version="1.0" encoding="UTF-8"?>
<!--
    Copyright 2001-2017 Syncro Soft SRL. All rights reserved.
 -->
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="3.0">

    <xsl:import href="convert-resource-to-task.xsl"/>

    <!-- Match root -->
    <xsl:template match="topic|troubleshooting|concept|reference">
        <task>
            <xsl:copy-of select="namespace::*"/>
            <xsl:apply-templates select="@*"/>
            <xsl:apply-templates select="node()"/>
        </task>
    </xsl:template>

    <!-- Match body -->
    <xsl:template match="/*[ self::topic or self::concept or self::reference or self::task or self::troubleshooting ]/*[ self::body or self::conbody or self::refbody or self::taskbody or self::troublebody ]">
        <taskbody>
            <xsl:choose>
                <xsl:when test="child::*[  self::ol or self::steps or self::substeps   or   self::ul or self::steps-unordered or self::choices  ]">
                    <xsl:apply-templates select="@*"></xsl:apply-templates>

                    <xsl:variable name="ol" select="child::*[  self::ol or self::steps or self::substeps   or   self::ul or self::steps-unordered or self::choices  ][1]"/>
                    <xsl:variable name="before" select="$ol/preceding-sibling::*"/>
                    <xsl:variable name="after" select="$ol/following-sibling::*"/>

                    <xsl:if test="$before">
                      <xsl:choose>
                          <xsl:when test = "$before/*[ self::section or self::refsyn or self::prereq or self::context or self::steps-informal or self::tasktroubleshooting or self::result or self::postreq or self::condition or self::cause or self::remedy ]">
                            <xsl:for-each select="$before">
                                <xsl:apply-templates select="."></xsl:apply-templates>
                            </xsl:for-each>
                        </xsl:when>
                        <xsl:otherwise>
                            <context>
                                <xsl:apply-templates select="$before"></xsl:apply-templates>
                            </context>
                        </xsl:otherwise>
                    </xsl:choose>
                  </xsl:if>

                    <xsl:for-each select="$ol">
                        <xsl:apply-templates select="." mode="first-list"></xsl:apply-templates>
                    </xsl:for-each>

                    <xsl:if test="$after">
                        <postreq>
                            <xsl:apply-templates select="$after"></xsl:apply-templates>
                        </postreq>
                    </xsl:if>
                </xsl:when>
                <xsl:when test="child::*[  self::p ] and count(child::*[ self::p ]) = count(child::*[ self::*])">
                    <context>
                        <xsl:apply-templates select="@*|node()"/>
                    </context>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates select="@*|node()"/>
                </xsl:otherwise>
            </xsl:choose>
        </taskbody>
    </xsl:template>

    <xsl:template match="ul" mode="first-list">
        <steps-unordered>
            <xsl:apply-templates select="@*|node()" mode="first-list"/>
        </steps-unordered>
    </xsl:template>

    <xsl:template match="ol" mode="first-list">
        <steps>
            <xsl:apply-templates select="@*|node()" mode="first-list"/>
        </steps>
    </xsl:template>

    <xsl:param name="unallowedInCmd" select="('codeblock', 'div', 'dl', 'equation-block', 'equation-figure', 'fig', 'hazardstatement', 'imagemap',
     'itemgroup', 'note', 'lines', 'lq', 'msgblock', 'ol', 'p', 'pre', 'screen', 'simpletable', 'sl', 'syntaxdiagram', 'table', 'ul')"/>

    <xsl:template match="li" mode="first-list">
        <step>
            <xsl:choose>
                <xsl:when test="not(child::*[ self::cmd ])">
               		<xsl:apply-templates select="@*"/>
                    <xsl:choose>
                        <xsl:when test="child::*[local-name(.) = $unallowedInCmd]">
                        	<xsl:variable name="firstBlockElement" select="child::*[local-name(.) = $unallowedInCmd][1]"/>
                        	<cmd>
					            <xsl:apply-templates select="$firstBlockElement/preceding-sibling::node()"/>
					        </cmd>
					        <info>
					            <xsl:apply-templates select="$firstBlockElement"/>
					            <xsl:apply-templates select="$firstBlockElement/following-sibling::node()"/>
					        </info>
                        </xsl:when>
                        <xsl:otherwise>
                            <cmd>
                                <xsl:apply-templates select="node()"/>
                            </cmd>  
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates select="@*|node()"/>
                </xsl:otherwise>
            </xsl:choose>
        </step>
    </xsl:template>
    
    <!-- Handle default matching for other elements in first-list mode -->
    <xsl:template match="@*|node()" mode="first-list">
        <xsl:apply-templates select="."/>
    </xsl:template>

    <xsl:template match="ul">
        <ul>
            <xsl:apply-templates select="@*|node()"/>
        </ul>
    </xsl:template>

    <xsl:template match="ol">
        <ol>
            <xsl:apply-templates select="@*|node()"/>
        </ol>
    </xsl:template>

    <xsl:template match="li">
        <li>
            <!-- Maybe avoid adding cmd here? -->
            <xsl:apply-templates select="@*|node()"/>
        </li>
    </xsl:template>

    <!-- To avoid another math that will transform the para in responsibleParty -->
    <xsl:template match="p">
        <p>
            <xsl:apply-templates select="@*|node()"/>
        </p>
    </xsl:template>
</xsl:stylesheet>
