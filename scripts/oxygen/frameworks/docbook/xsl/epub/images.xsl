<?xml version="1.0" encoding="UTF-8"?>
<!--   
  /*
 * Copyright (c) 2018 Syncro Soft SRL - All Rights Reserved.
 *
 * This file contains proprietary and confidential source code.
 * Unauthorized copying of this file, via any medium, is strictly prohibited.
 */
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
          xmlns:XSLTExtensionIOUtil="java:ro.sync.io.XSLTExtensionIOUtil"
          xmlns:opf="http://www.idpf.org/2007/opf"
          xmlns:xhtml="http://www.w3.org/1999/xhtml" 
          exclude-result-prefixes="XSLTExtensionIOUtil opf xhtml"
          version="1.0">
  
  <!-- Dir of input XML. -->
  <xsl:param name="inputDir"/>
  
  <!-- Dir of output HTML. -->
  <xsl:param name="outputDir"/>
  
  <!-- Dir of images. -->
  <xsl:param name="imagesDir"/>
  
  <xsl:template match="node() | @*">
    <xsl:copy>
      <xsl:apply-templates select="node() | @*"/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="@src[parent::xhtml:img]">
    <xsl:variable name="src" select="XSLTExtensionIOUtil:copyFile($inputDir, ., $outputDir, $imagesDir)"/>
    <xsl:attribute name="src"><xsl:value-of select="$src"/></xsl:attribute>
  </xsl:template>


    <xsl:template match="xhtml:video[parent::xhtml:div[contains(@class, 'mediaobject')]]">
        <xsl:variable name="src" select="XSLTExtensionIOUtil:copyFile($inputDir, @src, $outputDir, $imagesDir)"/>
        <xsl:call-template name="insertVideo">
            <xsl:with-param name="src"/>
        </xsl:call-template>
    </xsl:template>
    
  <xsl:template match="xhtml:embed[@src][parent::xhtml:div[contains(@class, 'mediaobject')]]">
      <xsl:variable name="src" select="XSLTExtensionIOUtil:copyFile($inputDir, @src, $outputDir, $imagesDir)"/>
      <xsl:call-template name="insertVideo">
          <xsl:with-param name="src" select="$src"/>
      </xsl:call-template>
  </xsl:template>
  
  <xsl:template name="insertVideo">
      <xsl:param name="src"/>
      <video class="videodata" controls="controls" xmlns="http://www.w3.org/1999/xhtml">
          <source src="{$src}"/>
          <p>Your browser does not support the video tag.</p>
      </video>
  </xsl:template>
  
  
  <xsl:template match="@data[parent::xhtml:object[@type='image/svg+xml']]">
    <xsl:variable name="imagePath" select="XSLTExtensionIOUtil:copyFile($inputDir, ., $outputDir, $imagesDir)"/>
    <xsl:attribute name="data"><xsl:value-of select="$imagePath"/></xsl:attribute>
  </xsl:template>
  
  <xsl:template match="@href[parent::xhtml:link[@rel='stylesheet'][@type='text/css']]">
    <xsl:choose>
      <xsl:when test="starts-with(., 'http') or starts-with(., 'ftp')">
        <xsl:value-of select="."/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="cssPath" select="XSLTExtensionIOUtil:copyFile($inputDir, ., $outputDir, 'css')"/>
        <xsl:attribute name="href"><xsl:value-of select="$cssPath"/></xsl:attribute>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>