<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs oxy"
    xmlns:oxy="http://www.oxygenxml.com/extensions"
    version="2.0">
    
    <xsl:output indent="no"/>
    
    <xsl:template match="node() | @*">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*"/>
        </xsl:copy>
    </xsl:template>
    
    <!-- Match any DITA topicref and define a key for it. -->
  <xsl:template match="*[local-name() = ('topicref', 'chapter', 'booklist', 'backmatter', 'chapter', 'preface', 'colophon', 'trademarklist', 'appendix', 'appendices', 'part', 'dedication', 'tablelist', 'toc', 'amendments', 'abbrevlist', 'frontmatter', 'bibliolist', 'bookabstract', 'booklists', 'glossarylist', 'draftintro', 'notices', 'figurelist', 'indexlist')][@href][not(@keys)][not(@keyref)][not(@scope) or @scope = 'local'][not(@format) or @format = 'dita']">
        <xsl:copy>
            <xsl:attribute name="keys" select="oxy:extractKeyName(@href)"/>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
	
	<!-- Change link with href to keyref. -->
	<xsl:template match="(link|xref)[not(@keyref)][not(@keys)][@href][not(@scope) or @scope = 'local'][not(@format) or @format = 'dita']">
		<xsl:copy>
		  <xsl:choose>
		    <xsl:when test="not(starts-with(normalize-space(@href), '#'))">
		      <xsl:attribute name="keyref">
		        <xsl:choose>
		          <xsl:when test="contains(@href, '#')">
		            <!-- #html_page_templates/topic-topic-toc -->
		            <xsl:variable name="anchor" select="tokenize(@href, '#')[last()]"/>
		            <xsl:choose>
		              <xsl:when test="contains($anchor, '/')">
		                <!--Preserve only the element ID-->
		                <xsl:value-of select="oxy:extractKeyName(@href)"/>/<xsl:value-of select="tokenize($anchor, '/')[last()]"/>	
		              </xsl:when>
		              <xsl:otherwise>
		                <!-- Reference to topic, use only key name -->
		                <xsl:value-of select="oxy:extractKeyName(@href)"/>
		              </xsl:otherwise>
		            </xsl:choose>
		          </xsl:when>
		          <xsl:otherwise>
		            <!-- Reference only to topic, use key ref name -->
		            <xsl:value-of select="oxy:extractKeyName(@href)"/>
		          </xsl:otherwise>
		        </xsl:choose>
		      </xsl:attribute>
		    </xsl:when>
		    <xsl:otherwise>
		      <xsl:apply-templates select="@href"/>
		    </xsl:otherwise>
		  </xsl:choose>
			<xsl:apply-templates select="@* except @href"/>
			<xsl:apply-templates select="node()"/>
		</xsl:copy>
	</xsl:template>
  
  <!-- Replace conref with conkeyref -->
  <xsl:template match="*[not(@conkeyref)][@conref]">
    <xsl:copy>
      <xsl:choose>
        <xsl:when test="not(starts-with(normalize-space(@conref), '#'))">
          
          <xsl:attribute name="conkeyref">
            <xsl:choose>
              <xsl:when test="contains(@conref, '#')">
                <xsl:variable name="anchor" select="tokenize(@conref, '#')[last()]"/>
                <xsl:choose>
                  <xsl:when test="contains($anchor, '/')">
                    <!--Preserve only the element ID-->
                    <xsl:value-of select="oxy:extractKeyName(@conref)"/>/<xsl:value-of select="tokenize($anchor, '/')[last()]"/>	
                  </xsl:when>
                  <xsl:otherwise>
                    <!-- Reference to topic, use only key name -->
                    <xsl:value-of select="oxy:extractKeyName(@conref)"/>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:when>
              <xsl:otherwise>
                <!-- Reference only to topic, use key ref name -->
                <xsl:value-of select="oxy:extractKeyName(@conref)"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:attribute>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates select="@conref"/>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="@* except @conref"/>
      <xsl:apply-templates select="node()"/>
    </xsl:copy>
  </xsl:template>
    
    <!-- Try to create a key name from a reference value -->
    <xsl:function name="oxy:extractKeyName">
        <xsl:param name="reference"/>
        <xsl:variable name="lastPart">
          <xsl:value-of select="tokenize(replace($reference, '#(.*)', ''), '/')[last()]"/>
        </xsl:variable>
    	<xsl:variable name="lastPart" select="replace($lastPart, '\.(.*)', '')"/>
    	<xsl:value-of select="replace($lastPart, '%20', '_')"/>
    </xsl:function>
</xsl:stylesheet>
