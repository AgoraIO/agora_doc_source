<?xml version="1.0" encoding="UTF-8"?>
<!--   /*
 * Copyright (c) 2018 Syncro Soft SRL - All Rights Reserved.
 *
 * This file contains proprietary and confidential source code.
 * Unauthorized copying of this file, via any medium, is strictly prohibited.
 */
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xhtml="http://www.w3.org/1999/xhtml"
  xmlns:opf="http://www.idpf.org/2007/opf"
  xmlns:File="java.io.File"
  exclude-result-prefixes="File xhtml"
  version="1.0">

  <!-- The XHTML file that contains the images. -->
  <xsl:param name="inputFile"/>
  
  <xsl:template match="node() | @*">
    <xsl:copy>
      <xsl:apply-templates select="node() | @*"/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="opf:manifest">
    <xsl:copy>
      <xsl:apply-templates select="node() | @*"/>
      <xsl:variable name="backslashToSlashInputFile" select="translate($inputFile, '\\', '/')"/>
      <xsl:variable name="htmlFile" select="File:toURL(File:new($backslashToSlashInputFile))"/>
        <xsl:variable name="numberOfExistingImages" 
            select="count(opf:item[starts-with(@media-type, 'image/')]|opf:item[starts-with(@media-type, 'video/')])"/>
      <xsl:variable name="manifestElement" select="."/>
      <xsl:for-each select="document($htmlFile)//xhtml:img[@src]
                                      [not(@src = $manifestElement/opf:item/@href)]
                                      [not(preceding::xhtml:img/@src = ./@src)] 
                                    | document($htmlFile)//xhtml:object[@type='image/svg+xml']
                                      [not(@data = $manifestElement/opf:item/@href)]
                                      [not(preceding::xhtml:object/@data = ./@data)]
                                    | document($htmlFile)//xhtml:video[xhtml:source[@src]][parent::xhtml:div[contains(@class, 'mediaobject')]]
                                    [not(xhtml:source/@src = $manifestElement/opf:item/@href)]
                                    [not(preceding::xhtml:video[parent::xhtml:div[contains(@class, 'mediaobject')]]/xhtml:source/@src = ./xhtml:source/@src)]
                                    | document($htmlFile)//xhtml:embed[@src][parent::xhtml:div[contains(@class, 'mediaobject')]]
                                      [not(@src = $manifestElement/opf:item/@href)]
                                      [not(preceding::xhtml:embed[parent::xhtml:div[contains(@class, 'mediaobject')]]/@src = ./@src)]">
          <xsl:element namespace="http://www.idpf.org/2007/opf" name="item">
            <xsl:choose>
              <xsl:when test="parent::xhtml:div[@id = 'cover-image']">
                <xsl:attribute name="id">
                  <xsl:value-of select="'cover-image'"/> 
                </xsl:attribute>
              </xsl:when>
              <xsl:otherwise>
                <xsl:attribute name="id"> 
                  <xsl:value-of select="concat('imageID-', string($numberOfExistingImages + position()))"/> 
                </xsl:attribute>
              </xsl:otherwise>
            </xsl:choose>
            <xsl:attribute name="media-type">
              <xsl:choose>
                <xsl:when test="contains(@src, '.gif') or contains(@src, 'GIF')">
                  <xsl:text>image/gif</xsl:text>
                </xsl:when>
                <xsl:when test="contains(@src, '.png') or contains(@src, 'PNG')">
                  <xsl:text>image/png</xsl:text>
                </xsl:when>
                <xsl:when test="contains(@src, '.jpeg') or contains(@src, 'JPEG') or contains(@src, '.jpg') or contains(@src, 'JPG')">
                  <xsl:text>image/jpeg</xsl:text>
                </xsl:when>
                <xsl:when test="contains(@src, '.svg') or contains(@src, 'SVG')">
                  <xsl:text>image/svg+xml</xsl:text>
                </xsl:when>
                <xsl:when test="contains(@type, 'image/svg+xml')">
                  <xsl:text>image/svg+xml</xsl:text>
                </xsl:when>
                <xsl:when test="contains(@src, '.mathml') or contains(@src, 'MATHML') 
                             or contains(@src, '.mml') or contains(@src, 'MML')">
                  <xsl:text>image/mathml+xml</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:text>video/</xsl:text>
                  <xsl:value-of select="substring-after(xhtml:source/@src, '.')"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:attribute>
            <xsl:choose>
              <xsl:when test="@src">
                <xsl:attribute name="href"><xsl:value-of select="@src"/></xsl:attribute>
              </xsl:when>
              <xsl:when test="@data">
                <xsl:attribute name="href"><xsl:value-of select="@data"/></xsl:attribute>
              </xsl:when>
              <xsl:when test="xhtml:source/@src">
                <xsl:attribute name="href"><xsl:value-of select="xhtml:source/@src"/></xsl:attribute>
              </xsl:when>
            </xsl:choose>
          </xsl:element>
      </xsl:for-each>
      <xsl:for-each select="document($htmlFile)//xhtml:video[@poster]
        [not(@poster = $manifestElement/opf:item/@href)]">
        <xsl:element namespace="http://www.idpf.org/2007/opf" name="item">
          <xsl:attribute name="id"> 
            <xsl:value-of select="concat('imageID-', string($numberOfExistingImages + position()))"/> 
          </xsl:attribute>
          <xsl:attribute name="media-type">
            <xsl:choose>
              <xsl:when test="contains(@poster, '.gif') or contains(@poster, 'GIF')">
                <xsl:text>image/gif</xsl:text>
              </xsl:when>
              <xsl:when test="contains(@poster, '.png') or contains(@poster, 'PNG')">
                <xsl:text>image/png</xsl:text>
              </xsl:when>
              <xsl:when test="contains(@poster, '.jpeg') or contains(@poster, 'JPEG') or contains(@poster, '.jpg') or contains(@poster, 'JPG')">
                <xsl:text>image/jpeg</xsl:text>
              </xsl:when>
              <xsl:when test="contains(@poster, '.svg') or contains(@poster, 'SVG')">
                <xsl:text>image/svg+xml</xsl:text>
              </xsl:when>
              <xsl:otherwise>
                <xsl:text>image/</xsl:text>
                <xsl:value-of select="substring-after(xhtml:source/@poster, '.')"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:attribute>
          <xsl:attribute name="href"><xsl:value-of select="@poster"/></xsl:attribute>
        </xsl:element>
      </xsl:for-each>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>