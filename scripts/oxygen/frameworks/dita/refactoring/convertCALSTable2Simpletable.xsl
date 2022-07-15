<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="2.0">
    <xsl:template match="node() | @*">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*"/>
        </xsl:copy>
    </xsl:template>
    
    <!-- Process title. 
        If title is empty, do nothing.
        If table is in a paragraph, all nodes from title migrate in that paragraph.
        If table is not in a paragraph, wrap title in a new paragraph.
    -->
    <xsl:template match="table/title">
        <xsl:param name="isInsidePara"/>
        <xsl:if test="node()">
            <xsl:choose>
                <xsl:when test="$isInsidePara">
                    <xsl:apply-templates select="node()"/>
                </xsl:when>
                <xsl:otherwise>
                    <p>
                        <xsl:apply-templates select="node()"/>
                    </p>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="table[not(@conref) and not(@conkeyref)]">
        <xsl:call-template name="processTableTitle"/>
        <xsl:variable name="columnsNumber"><xsl:value-of select="tgroup/@cols"/></xsl:variable>
        <simpletable>
            <xsl:if test="tgroup/colspec[@colwidth]">
                <xsl:attribute name="relcolwidth">
                    <!-- A CALS table can have fixed or procentual columns widths, but simple tables will accept only procentual values.-->
                    <xsl:for-each select="tgroup/colspec">
                        <!-- We build a compound value, tokens are separated by a space: @relcolwidth=" 1* 2* 3*" -->
                        <xsl:if test="position() != 1">
                            <xsl:text> </xsl:text>
                        </xsl:if>
                        <xsl:choose>
                            <!-- CALS table have proportional column width. Copy value 'as is'.-->
                            <xsl:when test="contains(@colwidth, '*')">
                                <xsl:value-of select="@colwidth"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <!-- Fixed column width. Replace it with a default proportional value.-->
                                <xsl:text>1*</xsl:text>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:for-each>
                </xsl:attribute>
            </xsl:if>
            
            <!-- Title was processed before. -->
            <xsl:apply-templates select="@* | (node() except title)"/>
        </simpletable>
    </xsl:template>
    
    <xsl:template name="processTableTitle">
        <xsl:apply-templates select="title">
            <xsl:with-param name="isInsidePara" select="parent::p"/>
        </xsl:apply-templates>
    </xsl:template>
    
    <xsl:template match="tgroup | colspec | tbody | thead">
        <xsl:apply-templates/>
    </xsl:template>
    
    <!-- A CALS table can have multiple rows in header. Simple tables accepts only one.-->
    <xsl:template match="thead/row[1]">
        <sthead>
            <xsl:apply-templates/>
        </sthead>
    </xsl:template>
    
    <!-- Move extra rows from header in simple table's body.-->
    <xsl:template match="thead/row[position() > 1]">
        <strow>
            <xsl:apply-templates/>
        </strow>
    </xsl:template>
    
    <xsl:template match="row">
        <xsl:choose>
            <xsl:when test="ancestor-or-self::thead">
                <xsl:apply-templates/>
            </xsl:when>
            <xsl:otherwise>
                <strow>
                    <xsl:apply-templates/>
                </strow>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="entry">
        <stentry>
            <xsl:apply-templates/>
        </stentry>
    </xsl:template>
    
    <!-- Perform cleanup and remove unwanted attributes like class -->
    <xsl:template match="@class"/>
    <xsl:template match="@rowsep"/>
    <xsl:template match="@colsep"/>

</xsl:stylesheet> 