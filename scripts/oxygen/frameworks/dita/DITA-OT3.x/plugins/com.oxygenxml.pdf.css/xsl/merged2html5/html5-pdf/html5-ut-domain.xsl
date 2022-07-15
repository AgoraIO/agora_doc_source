<?xml version="1.0" encoding="UTF-8"?>
<!-- 
  This stylesheet alters the structure of the elements from the utility domain.
-->
<xsl:stylesheet version="2.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  exclude-result-prefixes="#all">

  <!--
  		Convert the imagemap to a div containing the image and the list of links.
  	-->
  <xsl:template match="*[contains(@class, ' ut-d/imagemap ')]" priority="2">
  
    <!-- Let the default stylesheet generate the HTML map element, 
    this will be interpreted by Chemistry and other processors. -->
    
    <xsl:variable name="nm">
      <xsl:next-match/>
    </xsl:variable>
    
    <!-- Inject an OL with the visible links after the HTML map -->
    <xsl:apply-templates select="$nm" mode="inject-list-of-links">
      <xsl:with-param name="ol" tunnel="yes">
        <ol class="imagemap--areas">
          <xsl:apply-templates select="*[contains(@class, ' ut-d/area ')]"/>
        </ol>      
      </xsl:with-param>
     </xsl:apply-templates>
  </xsl:template>

  <xsl:template match="node() | @*" mode="inject-list-of-links">
    <xsl:copy>
      <xsl:apply-templates select="node() | @*" mode="#current"/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="*[local-name() = 'map']" mode="inject-list-of-links">
    <xsl:param name="ol" tunnel="yes"/>
    <xsl:next-match/>
    <xsl:copy-of select="$ol"/>
  </xsl:template>
  
  
  <xsl:template match="*[contains(@class, ' ut-d/area ')]">
    <li>
      <xsl:call-template name="commonattributes"/>
      <xsl:apply-templates/>
    </li>
  </xsl:template>

  <xsl:template match="*[contains(@class, ' ut-d/shape ')]"/>

  <xsl:template match="*[contains(@class, ' ut-d/coords ')]"/>
</xsl:stylesheet>
