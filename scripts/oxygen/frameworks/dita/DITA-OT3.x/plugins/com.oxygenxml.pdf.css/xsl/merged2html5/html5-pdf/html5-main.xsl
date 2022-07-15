<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:css-param="http://www.oxygenxml.com/extensions/publishing/dita/css/params"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:svg="http://www.w3.org/2000/svg"
                xmlns:Evaluate="java:com.oxygenxml.dita.xsltextensions.Evaluate"
                exclude-result-prefixes="#all" >
  <xsl:param name="html5.css.links" />
  
  <!-- Add the links to the CSS files to the HTML head. -->
  <xsl:template name="generateCssLinks">
    <xsl:if test="$html5.css.links">    
      <xsl:text>&#10;</xsl:text>
      <xsl:copy-of select="parse-xml(concat('&lt;root>', $html5.css.links, '&lt;/root>'))/*/node()"/>
    </xsl:if>
  </xsl:template>  
  
  <!-- Add the publication title to the HTML head. -->
  <xsl:template name="generateChapterTitle">
    <title>
     
      <xsl:choose>
        <xsl:when test="@title">
          <xsl:value-of select="@title"/>
        </xsl:when>
        <xsl:when test="*[contains(@class, ' topic/title ')]">
          <xsl:value-of select="*[contains(@class, ' topic/title ')]"/>            
        </xsl:when>
        <xsl:when test="descendant:: *[contains(@class, ' front-page/front-page ')]
                          /*[contains(@class, ' front-page/front-page-title ')]
                          /*[contains(@class, ' bookmap/booktitle ')]
                          /*[contains(@class, ' bookmap/mainbooktitle ')]">
          
            <!-- For bookmaps, use the main book title. -->
            <xsl:value-of select="*[contains(@class, ' front-page/front-page ')]
                          /*[contains(@class, ' front-page/front-page-title ')]
                          /*[contains(@class, ' bookmap/booktitle ')]
                          /*[contains(@class, ' bookmap/mainbooktitle ')]"/>            
        </xsl:when>
        <xsl:otherwise>
            <!-- In other cases, like plain maps or bookmaps without mainbooktitles 
              use the front page title -->
          <xsl:value-of select="*[contains(@class, ' front-page/front-page ')]
                                /*[contains(@class, ' front-page/front-page-title ')]"/>
        </xsl:otherwise>
      </xsl:choose>
      
    </title>
  </xsl:template>
    
  <xsl:template match="/*[not(self::svg:svg)][not(self::math:math)]">
    <html>
      <!-- This can be used to solve relative images -->
      <xsl:copy-of select="@xtrf"/>
      <xsl:apply-templates select="@css-param:*"/>
      <!--  We need this for the :lang selector on :root -->      
      <xsl:apply-templates select="@xml:lang"/>
      
      
      <xsl:call-template name="chapterHead"/>
      <body class="wh_topic_page">
          <div class="wh_content_area">
            <div class="wh_topic_body">
              <div class="wh_topic_content">
                <div>
                  <xsl:apply-templates select="@css-param:*"/>
                  <xsl:call-template name="commonattributes"/>
                  <xsl:apply-templates/>
                </div>
              </div>
            </div>
          </div>
      </body>
    </html>
  </xsl:template>

  <!--
   These are additional root attributes add also a version without namespace,
   so the browsers can be used to debug the styling. -->
  <xsl:template match="@css-param:*" priority="2">
    <xsl:attribute name="{local-name()}" select="."/>
  </xsl:template>
  
</xsl:stylesheet>