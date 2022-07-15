<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:ditaarch="http://dita.oasis-open.org/architecture/2005/"
    xmlns:opentopic-index="http://www.idiominc.com/opentopic/index"
    xmlns:opentopic="http://www.idiominc.com/opentopic"
    xmlns:oxy="http://www.oxygenxml.com/extensions/author"
    xmlns:css-param="http://www.oxygenxml.com/extensions/publishing/dita/css/params"
    xmlns:saxon="http://saxon.sf.net/"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    exclude-result-prefixes="#all">
    
    <!-- This is moved in the root. -->
    <xsl:template match="opentopic:map/*[contains(@class, ' map/topicmeta ')]"/>
    
    
    <!-- Copies the metainformation. Solves the possible relative hrefs to absolute locations. -->
    <xsl:template match="@href" mode="copy-meta">
      <xsl:attribute name="href">
        <xsl:value-of select="oxy:absolute-href(..)"/>
      </xsl:attribute>    
    </xsl:template>  
    <xsl:template match="node() | @*" mode="copy-meta">      
      <xsl:copy>  
        <xsl:apply-templates select="node() | @*" mode="copy-meta"/>
      </xsl:copy>
    </xsl:template>
    <xsl:template match="@xtrf" mode="copy-meta"/>
    <xsl:template match="@xtrc" mode="copy-meta"/>
      
  
    <!--
		
        Create a title page
        
	-->
    <xsl:template match="*[contains(@class, ' map/map ')]" priority="2">
        <xsl:copy>
            <xsl:call-template name="add-namespace-declarations"/>
 
            <xsl:copy-of select="@*"/>
            
            <xsl:call-template name="add-root-attributes-from-param"/>

            <oxy:front-page class="- front-page/front-page ">
                <!-- Move also metadata, so it can be used in the string-sets starting with the front page. -->
                <xsl:apply-templates select="opentopic:map/*[contains(@class, ' map/topicmeta ')]" mode="copy-meta"/>
            
                <oxy:front-page-title class="- front-page/front-page-title ">
                    <xsl:choose>
                        <xsl:when test="@title">
                            <xsl:value-of select="@title"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:apply-templates
                                select="opentopic:map/*[contains(@class, ' topic/title ')]"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </oxy:front-page-title>
            </oxy:front-page>
            

  			<!-- Maybe it has Oxygen attribute changes processing instructions before it. Move them into the root. --> 
            <xsl:call-template name="add-review-pis-for-root"/>

            <xsl:for-each select="node()">
                <xsl:choose>
                    <xsl:when test="self::opentopic:map">
                        <!-- Move the topics marked with "before-toc" before this element. -->
                        <xsl:apply-templates select="following-sibling::*[contains(@outputclass,'before-toc')] | 
                                                     following-sibling::*[contains(key('map-id', @id)/@outputclass, 'before-toc')]"/>
                        <xsl:apply-templates select="."/>
                    </xsl:when>
                    <xsl:when test="self::*[contains(@outputclass,'before-toc')] or self::*[contains(key('map-id', @id)/@outputclass, 'before-toc')]">
                        <!-- Ignore, was handled before -->
                    </xsl:when>
                    <xsl:otherwise>
                        <!-- Default processing -->
                        <xsl:apply-templates select="."/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:for-each>

        </xsl:copy>
    </xsl:template>
    
    <xsl:template name="add-root-attributes-from-param">
      <xsl:if test="$css.params">
        <xsl:analyze-string select="$css.params" regex="(.*?)=(.*?)\n">
          <xsl:matching-substring>
             <xsl:attribute name="css-param:{regex-group(1)}" select="regex-group(2)" />
          </xsl:matching-substring>
  
          <xsl:non-matching-substring>
            <xsl:message terminate="yes">
              Error parsing the list of attributes that are set on the root. Make sure you do not use newlines in their value.  
              The attribute set: <xsl:value-of select="$css.params"/> 
              The substring that was not matching : <xsl:value-of select="."/> 
            </xsl:message>
          </xsl:non-matching-substring>
        </xsl:analyze-string> 
      </xsl:if>
      
      <xsl:if test="$hide.frontpage.toc.index.glossary = 'yes'">
        <xsl:attribute name="css-param:hide-frontpage-toc-index-glossary" select="$hide.frontpage.toc.index.glossary"/>
      </xsl:if>

      <xsl:if test="$defaultLanguage and not(@xml:lang)">      
        <xsl:attribute name="xml:lang" select="$defaultLanguage"/>
      </xsl:if>
      
    </xsl:template>
</xsl:stylesheet>