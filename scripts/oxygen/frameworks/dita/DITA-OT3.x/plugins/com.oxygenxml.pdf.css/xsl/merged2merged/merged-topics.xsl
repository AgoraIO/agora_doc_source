<!-- 
    
    This stylesheet processes the topics from the main content.

-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
  xmlns:ditaarch="http://dita.oasis-open.org/architecture/2005/"
  xmlns:opentopic-index="http://www.idiominc.com/opentopic/index"
  xmlns:opentopic="http://www.idiominc.com/opentopic"
  xmlns:oxy="http://www.oxygenxml.com/extensions/author" xmlns:saxon="http://saxon.sf.net/"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" 
  exclude-result-prefixes="#all">
  
  <!-- 
      Copy attributes on root element for single topic publishing output.
   -->
   <xsl:template match="/*[contains(@class, ' topic/topic ')]" priority="2">
      <xsl:copy>
          <xsl:call-template name="add-namespace-declarations"/>
          
          <xsl:copy-of select="@*"/>
          
          <xsl:call-template name="add-root-attributes-from-param"/>
          
          <!-- Maybe it has Oxygen attribute changes processing instructions before it. Move them into the root. --> 
          <xsl:call-template name="add-review-pis-for-root"/>
          
          <xsl:apply-templates/>
      </xsl:copy>
  </xsl:template>
    
    
    
  <!-- 
      Annotate the outputclass attribute with the value form the corresponding topicrefs.
      
      In this way we can style the topic based on outputclass of the topicref. For instance one 
      can use outputclass="page-break-before", and this value will go on the topic. 
      The page break can be imposed using some CSS rules.
      
      We match the @id in case there is no @outputclass set on the topic.
      
      We match the profiling attributes to not let the default copy template dictates the processing order.
      If we do not do so, some profiling attribute will be overriden with the value from topic.
      
      In addition, transfers the value of the @class attribute from the topicref to the
      target topic element. In this way we can distinguish between different types of topics:
      preface, notice, plain topics, copyright, etc.
   -->
   <xsl:template match="*[contains(@class, ' topic/topic ')]/@id |
                        *[contains(@class, ' topic/topic ')]/@outputclass |
                        *[contains(@class, ' topic/topic ')]/@audience |
                        *[contains(@class, ' topic/topic ')]/@platform |
                        *[contains(@class, ' topic/topic ')]/@product |
                        *[contains(@class, ' topic/topic ')]/@otherprops |
                        *[contains(@class, ' topic/topic ')]/@props">
     <xsl:next-match/>

     <xsl:if test="../@id">
       <xsl:variable name="topicref" select="key('map-id', ../@id)"/>
       
       <xsl:if test="$topicref">
         <xsl:if test="$topicref/ancestor-or-self::*[contains(@class, 'bookmap/frontmatter')]">
           <xsl:attribute name="is-frontmatter">true</xsl:attribute>
         </xsl:if>
         
         <xsl:if test="$topicref/ancestor-or-self::*[contains(@class, 'bookmap/backmatter')]">
           <xsl:attribute name="is-backmatter">true</xsl:attribute>
         </xsl:if>
         
         <!-- Deals with the topicref class attribute -->
         <xsl:if test="$topicref/@class">
           <xsl:attribute name="topicrefclass" select="$topicref/@class"/>
         </xsl:if>
         
         <!-- Deals with topicrefs toc attribute -->
         <xsl:if test="$topicref/@toc">
           <xsl:attribute name="topicreftoc" select="$topicref/@toc"/>
         </xsl:if>
       
          <!-- Deals with the outputclass -->
          <xsl:if test="$topicref/@outputclass">
            <xsl:choose>
              <xsl:when test="../@outputclass">
                <xsl:attribute name="outputclass" select="concat(../@outputclass,' ', $topicref/@outputclass)"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:attribute name="outputclass" select="$topicref/@outputclass"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:if>
  
          <!-- Deals with profiling attributes -->
          <xsl:if test="$topicref/@audience">
            <xsl:choose>
              <xsl:when test="../@audience">
                <xsl:attribute name="audience" select="concat(../@audience,' ', $topicref/@audience)"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:attribute name="audience" select="$topicref/@audience"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:if>
          <xsl:if test="$topicref/@platform">
            <xsl:choose>
              <xsl:when test="../@platform">
                <xsl:message>CONCAT = <xsl:value-of select="concat(../@platform,' ', $topicref/@platform)"/></xsl:message>
                <xsl:attribute name="platform" select="concat(../@platform,' ', $topicref/@platform)"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:attribute name="platform" select="$topicref/@platform"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:if>
          <xsl:if test="$topicref/@product">
            <xsl:choose>
              <xsl:when test="../@product">
                <xsl:message>CONCAT = <xsl:value-of select="concat(../@product,' ', $topicref/@product)"/></xsl:message>
                <xsl:attribute name="product" select="concat(../@product,' ', $topicref/@product)"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:attribute name="product" select="$topicref/@product"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:if>
         <xsl:if test="$topicref/@otherprops">
           <xsl:choose>
             <xsl:when test="../@otherprops">
               <xsl:attribute name="otherprops" select="concat(../@otherprops,' ', $topicref/@otherprops)"/>
             </xsl:when>
             <xsl:otherwise>
               <xsl:attribute name="otherprops" select="$topicref/@otherprops"/>
             </xsl:otherwise>
           </xsl:choose>
         </xsl:if>
         <xsl:if test="$topicref/@props">
           <xsl:choose>
             <xsl:when test="../@props">
               <xsl:attribute name="props" select="concat(../@props,' ', $topicref/@props)"/>
             </xsl:when>
             <xsl:otherwise>
               <xsl:attribute name="props" select="$topicref/@props"/>
             </xsl:otherwise>
           </xsl:choose>
         </xsl:if>
          
        </xsl:if>
      </xsl:if>
      
  </xsl:template>
  
  
  
  <!--
    A title that does not have a "titlealts" following it.
  
    If the topicref that points to this topic has a navtitle element, the DITA-OT default processing
    would have copied it already to a "titleats" element in the topic.
    
    But if the topicref that points to this topic has a navtitle attribute, the default processing 
    does not create the "titleatls" element, so we need to synthesize it.
    -->
  <xsl:template match="*[contains(@class, ' topic/topic ')]/
                            *[contains(@class, ' topic/title ')]
                              [not(following-sibling::*[contains(@class, 'topic/titlealts')])]" priority="2">
  
    <xsl:variable name="topic-id" select="../@id"/>

    <xsl:variable name="navtitle-attr"
      select="//*[contains(@class, ' map/topicref ')][@id = $topic-id][@locktitle = 'yes']/@navtitle"/>
    
    
    <xsl:choose>
      <xsl:when test="$navtitle-attr">
      
        <!-- Emit the title. -->
        <xsl:next-match/>

      
        <titlealts class="- topic/titlealts ">
          <navtitle class="- topic/navtitle "><xsl:value-of select="$navtitle-attr"/></navtitle>
        </titlealts>
      </xsl:when>
      
      <xsl:otherwise>
        <!-- Emit the title. -->
        <xsl:next-match/>
        
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  
</xsl:stylesheet>
