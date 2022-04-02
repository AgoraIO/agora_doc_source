<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  exclude-result-prefixes="#all" version="2.0">
  
  <!--  Header navigation.  -->
  <xsl:template match="/|node()|@*" mode="gen-user-header">    
      <!-- Navigation to the next, previous siblings and to the parent. -->
      <span id="topic_navigation_links" class="navheader">              
        <xsl:if test="$NOPARENTLINK = 'no'">
          <xsl:for-each
            select="
	          descendant::*[contains(@class, ' topic/link ')][@role='parent'][1] 
	          |
	          descendant::*[contains(@class, ' topic/link ')][@role='previous'][1]
	          |
	          descendant::*[contains(@class, ' topic/link ')][@role='next'][last()]
	          ">
            <xsl:text>&#10;</xsl:text>
            <xsl:variable name="cls">
              <xsl:choose>
                <xsl:when test="@role = 'parent'">
                  <xsl:text>navparent</xsl:text>
                </xsl:when>
                <xsl:when test="@role = 'previous'">
                  <xsl:text>navprev</xsl:text>
                </xsl:when>
                <xsl:when test="@role = 'next'">
                  <xsl:text>navnext</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:text>nonav</xsl:text>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:variable>
            <span>
              <xsl:attribute name="class">
                <xsl:value-of select="$cls"/>
              </xsl:attribute>
              <xsl:variable name="textLinkBefore">
                <span class="navheader_label">
                  <xsl:choose>
                    <xsl:when test="@role = 'parent'">
                      <xsl:call-template name="getWebhelpString">
                        <xsl:with-param name="stringName" select="'Parent topic'"/>
                      </xsl:call-template>
                    </xsl:when>
                    <xsl:when test="@role = 'previous'">
                      <xsl:call-template name="getWebhelpString">
                        <xsl:with-param name="stringName" select="'Previous topic'"/>
                      </xsl:call-template>
                    </xsl:when>
                    <xsl:when test="@role = 'next'">
                      <xsl:call-template name="getWebhelpString">
                        <xsl:with-param name="stringName" select="'Next topic'"/>
                      </xsl:call-template>
                    </xsl:when>
                  </xsl:choose>
                </span>
                <span class="navheader_separator">
                  <xsl:text>: </xsl:text>
                </span>
              </xsl:variable>
              <xsl:call-template name="makelink">
                <xsl:with-param name="label" select="$textLinkBefore"/>
              </xsl:call-template>
            </span>
            <xsl:text>  </xsl:text>
          </xsl:for-each>
        </xsl:if>
      </span>
  </xsl:template>
  
  <!-- TODO: Dan& Radu C, aces -->
  <xsl:template name="makelink">
    <xsl:param name="label"/>
    <xsl:call-template name="linkdupinfo"/>
    <xsl:apply-templates select="*[contains(@class,' ditaot-d/ditaval-startprop ')]" mode="out-of-line"/>
    <xsl:apply-templates select="." mode="add-link-highlight-at-start"/>
            <a>
              <xsl:call-template name="commonattributes"/>
              <xsl:apply-templates select="." mode="add-linking-attributes"/>
              <!-- OXYGEN PATCH START EXM-17248 -->
              <!--<xsl:attribute name="onclick">parent.tocwin.expandThis(this.getAttribute('href'))</xsl:attribute>-->
              <xsl:attribute name="title">                
                <xsl:choose>
                  <xsl:when test="*[contains(@class, ' topic/linktext ')]"><xsl:apply-templates select="*[contains(@class, ' topic/linktext ')]"/></xsl:when>
                  <xsl:otherwise><!--use href--><xsl:call-template name="href"/></xsl:otherwise>
                </xsl:choose>
              </xsl:attribute>
              
              <xsl:if test="string-length($label)>0">
                <xsl:attribute name="aria-label">                
                  <xsl:choose>
                    <xsl:when test="*[contains(@class, ' topic/linktext ')]"><xsl:if test="string-length($label)>0"><xsl:value-of select="$label"/></xsl:if> <xsl:apply-templates select="*[contains(@class, ' topic/linktext ')]"/></xsl:when>
                    <xsl:otherwise><!--use href--><xsl:if test="string-length($label)>0"><xsl:value-of select="$label"/></xsl:if> <xsl:call-template name="href"/></xsl:otherwise>
                  </xsl:choose>
                </xsl:attribute>
              
                <xsl:attribute name="rel">                
                    <xsl:choose>
                      <xsl:when test="@role = 'previous'">prev</xsl:when>
                      <xsl:otherwise><xsl:value-of select="@role"/></xsl:otherwise>
                    </xsl:choose>                
                </xsl:attribute>
              </xsl:if>
              
              <xsl:if test="string-length($label) = 0">
                <xsl:attribute name="class">navheader_parent_path</xsl:attribute>
              </xsl:if>
              <!-- OXYGEN PATCH END EXM-17248 -->
              
              <!-- EXM-37539 - Do not use the short description as hover text for Next and Previous buttons-->
              <xsl:if test="not(@role) or (@role != 'next' and @role != 'previous')">
                <xsl:apply-templates select="." mode="add-desc-as-hoverhelp"/>
              </xsl:if>
              
              <!-- OXYGEN PATCH START EXM-17248 -->
              <xsl:choose>
                <xsl:when test="string-length($label) > 0">
                  <xsl:copy-of select="$label"/>
                  <span class="navheader_linktext">
                    <xsl:choose>
                      <xsl:when test="*[contains(@class, ' topic/linktext ')]"><xsl:apply-templates select="*[contains(@class, ' topic/linktext ')]"/></xsl:when>
                      <xsl:otherwise><!--use href--><xsl:call-template name="href"/></xsl:otherwise>
                    </xsl:choose>
                  </span>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:choose>
                    <xsl:when test="*[contains(@class, ' topic/linktext ')]"><xsl:apply-templates select="*[contains(@class, ' topic/linktext ')]"/></xsl:when>
                    <xsl:otherwise><!--use href--><xsl:call-template name="href"/></xsl:otherwise>
                  </xsl:choose>
                </xsl:otherwise>
              </xsl:choose>
              <!-- OXYGEN PATCH END EXM-17248 -->
       </a>
       <xsl:apply-templates select="." mode="add-link-highlight-at-end"/>
       <xsl:apply-templates select="*[contains(@class,' ditaot-d/ditaval-endprop ')]" mode="out-of-line"/>
  </xsl:template>  
  
</xsl:stylesheet>