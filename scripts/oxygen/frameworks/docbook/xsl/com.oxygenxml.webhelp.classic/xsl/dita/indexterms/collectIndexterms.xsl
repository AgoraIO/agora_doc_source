<?xml version="1.0" encoding="UTF-8"?>
<!--
    
Oxygen WebHelp Plugin
Copyright (c) 1998-2021 Syncro Soft SRL, Romania.  All rights reserved.

-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
                    xmlns:oxygen="http://www.oxygenxml.com/functions"
                    exclude-result-prefixes="oxygen"
                    version="2.0">
    
    <xsl:import href="../../functions.xsl"/>
    
    <!-- URL of folder with indexterm files. -->
    <xsl:param name="TEMPFOLDER"/>
    
    <!-- List of topic files that contain indexterms. -->
    <xsl:param name="JOB_FILE"/>
    
    <xsl:template match="/">
        <xsl:variable name="terms">
            <xsl:variable name="jobContents" select="document(oxygen:makeURL($JOB_FILE))"/>
            <xsl:for-each select="$jobContents//file[@format='dita'][not(@resource-only='true')]/@uri">
                <xsl:variable 
                    name="INDEXFILE_URL" 
                    select="oxygen:makeURL(concat($TEMPFOLDER, '/', ., '.indexterms'))"/>
                <xsl:copy-of select="document($INDEXFILE_URL)/*/*"/>
            </xsl:for-each>
        </xsl:variable>
        
        <index xmlns="http://www.oxygenxml.com/ns/webhelp/index">
            <xsl:call-template name="mergeIndexterms">
                <xsl:with-param name="terms" select="$terms/*"/>
            </xsl:call-template>
        </index>
    </xsl:template>

    <xsl:template name="mergeIndexterms">
        <xsl:param name="terms"/>
        <xsl:for-each-group select="$terms" group-by="normalize-space(upper-case(@name))">
            <xsl:sort select="current-grouping-key()" order="ascending"/>
            <term name="{normalize-space(@name)}" sort-as="{@sort-as}" xmlns="http://www.oxygenxml.com/ns/webhelp/index">
                <xsl:for-each select="current-group()/@target">
                    <xsl:sort select="." order="ascending"/>
                    <target><xsl:value-of select="."/></target>
                </xsl:for-each>
                <xsl:call-template name="mergeIndexterms">
                    <xsl:with-param name="terms" select="current-group()/*"/>
                </xsl:call-template>
            </term>
        </xsl:for-each-group>
    </xsl:template>
</xsl:stylesheet>