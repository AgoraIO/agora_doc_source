<?xml version="1.0" encoding="UTF-8"?>
<!-- 

  This stylesheet changes the figures layout.

-->
<xsl:stylesheet version="2.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:opentopic="http://www.idiominc.com/opentopic"
  xmlns:oxy="http://www.oxygenxml.com/extensions/author"
  xmlns:dita2html="http://dita-ot.sourceforge.net/ns/200801/dita2html"
  xmlns:opentopic-index="http://www.idiominc.com/opentopic/index"
  xmlns:ot-placeholder="http://suite-sol.com/namespaces/ot-placeholder"
  
  exclude-result-prefixes="#all">

  
  <xsl:param name="figure.title.placement" select="'top'"/>
  
  <!-- =========== FIGURE =========== -->
  <!-- Overriding org.dita.html5/xsl/topic.xsl -->
  <xsl:template match="*[contains(@class, ' topic/fig ') and not(contains(@class, ' ut-d/imagemap '))]" name="topic.fig">
    <xsl:variable name="default-fig-class">
      <xsl:apply-templates select="." mode="dita2html:get-default-fig-class"/>
    </xsl:variable>
    <xsl:apply-templates select="*[contains(@class, ' ditaot-d/ditaval-startprop ')]" mode="out-of-line"/>
    <figure>
      <xsl:if test="$default-fig-class != ''">
        <xsl:attribute name="class" select="$default-fig-class"/>
      </xsl:if>
      <xsl:call-template name="commonattributes">
        <xsl:with-param name="default-output-class" select="$default-fig-class"/>
      </xsl:call-template>
      <xsl:call-template name="setscale"/>
      <xsl:call-template name="setidaname"/>
      
      <!-- DCP-78 Move the figure caption depending on a parameter. -->
      <xsl:choose>
        <xsl:when test="$figure.title.placement = 'top'">
          <xsl:call-template name="place-fig-lbl"/>
          <xsl:apply-templates select="node() except *[contains(@class, ' topic/title ') or contains(@class, ' topic/desc ')]"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates select="node() except *[contains(@class, ' topic/title ') or contains(@class, ' topic/desc ')]"/>
          <xsl:call-template name="place-fig-lbl"/>
        </xsl:otherwise>
      </xsl:choose>
      
    </figure>
    <xsl:apply-templates select="*[contains(@class, ' ditaot-d/ditaval-endprop ')]" mode="out-of-line"/>
  </xsl:template>
  
  <!-- DCP-263 The number from the figure label is wrapped in a span, so it can be styled from CSS. -->
  <!-- Figure caption -->
  <xsl:template name="place-fig-lbl">
    <xsl:param name="stringName"/>
    <!-- Number of fig/title's including this one -->
    <xsl:variable name="fig-count-actual" select="count(preceding::*[contains(@class, ' topic/fig ')]/*[contains(@class, ' topic/title ')])+1"/>
    <xsl:variable name="ancestorlang">
      <xsl:call-template name="getLowerCaseLang"/>
    </xsl:variable>
    <xsl:choose>
      <!-- title -or- title & desc -->
      <xsl:when test="*[contains(@class, ' topic/title ')]">
        <figcaption>
          <xsl:choose>
            <xsl:when
              test="*[contains(@class, ' topic/image ')][@placement = 'break'][@align = 'center']">
              <xsl:attribute name="class">- topic/title title figcapcenter</xsl:attribute>
            </xsl:when>
            <xsl:when
              test="*[contains(@class, ' topic/image ')][@placement = 'break'][@align = 'right']">
              <xsl:attribute name="class">- topic/title title figcapright</xsl:attribute>
            </xsl:when>
            <xsl:when
              test="*[contains(@class, ' topic/image ')][@placement = 'break'][@align = 'justify']">
              <xsl:attribute name="class">- topic/title title figcapjustify</xsl:attribute>
            </xsl:when>
            <xsl:otherwise>
              <xsl:attribute name="class">- topic/title title figcap</xsl:attribute>
            </xsl:otherwise>
          </xsl:choose>
          <!-- OXYGEN PATCH END  EXM-18109 -->
          <!-- OXYGEN PATCH START EXM-31371 
            Using just the "Figure: " static text, with the 
            figure number placed in a span that can be hidden in webhelp. It is hidden  
            because this number is reset at each topic, it is not useful for small topics. -->
          <span class="figtitleprefix fig--title-label">
            <xsl:call-template name="getVariable">
              <xsl:with-param name="id" select="'Figure'"/>
            </xsl:call-template>
            <span class="fig--title-label-number">
              <xsl:text> </xsl:text>            
              <xsl:value-of select="$fig-count-actual"/>
            </span>
            <span class="fig--title-label-punctuation">
              <xsl:text>. </xsl:text>
            </span>
            <!--<xsl:choose>      
              <!-\- Hungarian: "1. Figure " -\->
              <xsl:when test="$ancestorlang = ('hu', 'hu-hu')">
                <span class="fig-\-title-label-number">
                  <xsl:value-of select="$fig-count-actual"/>
                  <xsl:text>. </xsl:text>
                </span>
                <xsl:call-template name="getVariable">
                  <xsl:with-param name="id" select="'Figure'"/>
                </xsl:call-template>
                <xsl:text> </xsl:text>
              </xsl:when>
              <xsl:otherwise>
                <xsl:call-template name="getVariable">
                  <xsl:with-param name="id" select="'Figure'"/>
                </xsl:call-template>
                <xsl:text> </xsl:text>
                <span class="fig-\-title-label-number">
                  <xsl:value-of select="$fig-count-actual"/>
                  <xsl:text>. </xsl:text>
                </span>
              </xsl:otherwise>
            </xsl:choose>-->
          </span>
          <xsl:apply-templates select="*[contains(@class, ' topic/title ')]" mode="figtitle"/>
          <xsl:if test="*[contains(@class, ' topic/desc ')]">
            <xsl:text>. </xsl:text>
          </xsl:if>
          <xsl:for-each select="*[contains(@class, ' topic/desc ')]">
            <span class="figdesc">
              <xsl:call-template name="commonattributes"/>
              <xsl:apply-templates select="." mode="figdesc"/>
            </span>
          </xsl:for-each>
        </figcaption>
      </xsl:when>
      <!-- desc -->
      <xsl:when test="*[contains(@class, ' topic/desc ')]">
        <xsl:for-each select="*[contains(@class, ' topic/desc ')]">
          <figcaption class="figdesc">
            <xsl:call-template name="commonattributes"/>
            <xsl:apply-templates select="." mode="figdesc"/>
          </figcaption>
        </xsl:for-each>
      </xsl:when>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="*[contains(@class, ' topic/fig ')]/*[contains(@class, ' topic/title ')]" mode="figtitle">
    <span>
      <xsl:call-template name="setid"/>
      <xsl:call-template name="commonattributes"/>
      <xsl:attribute name="class" select="'fig--title'"/>
      <xsl:apply-templates/>
    </span>
  </xsl:template>
  
</xsl:stylesheet>