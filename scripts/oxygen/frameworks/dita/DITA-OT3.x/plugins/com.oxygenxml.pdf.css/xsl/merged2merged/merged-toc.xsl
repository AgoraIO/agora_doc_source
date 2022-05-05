<!-- 
    
    This stylesheet processes the TOC.

-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:ditaarch="http://dita.oasis-open.org/architecture/2005/"
    xmlns:opentopic-index="http://www.idiominc.com/opentopic/index"
    xmlns:opentopic="http://www.idiominc.com/opentopic"
    xmlns:oxy="http://www.oxygenxml.com/extensions/author"
    xmlns:saxon="http://saxon.sf.net/"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    exclude-result-prefixes="#all">
    
    <!-- Mapping from topic id to topicref. -->
    <xsl:key name="map-id" match="//*[contains(@class, ' map/topicref ')]" use="@id"/>
    
    <!-- Remove the the link text, leave only the navtitle, which has markup. -->
    <xsl:template match="opentopic:map//*[contains(@class, ' map/linktext ')]"/>
    
    <!-- Remove the reltables from the toc. -->
    <xsl:template match="opentopic:map//*[contains(@class, ' map/reltable ')]"/>
    
    <!-- Remove the id from the topicref. The id is declared again in the topic from the main content and would break linking. -->
    <xsl:template match="opentopic:map//*[contains(@class, ' map/topicref ')]/@id"/>

    
    <!-- Remove references marked as not entering the TOC. -->
    <xsl:template match="opentopic:map//*[contains(@class, ' map/topicref ')][@toc = 'no']" priority="100"/>
    
    <!-- Remove the TOC reference from the frontmatter or backmatter TOC sections. -->
    <xsl:template match="*[contains(@class, ' bookmap/toc ')]"/>
    
    
    
    <!--
        For topicrefs without topic meta that have just a @navtitle, generate a topicmeta for it.
        (This happens for bookmap parts with just a navtitile and have no href)
    -->
    <xsl:template match="opentopic:map//*[contains(@class, ' map/topicref ')][@navtitle][not(*[contains(@class, ' map/topicmeta ')])]" priority="2">
        <xsl:copy>
            <xsl:apply-templates select="@* except @id"/>            
            <topicmeta class="- map/topicmeta ">
                <navtitle class="- topic/navtitle " href="#{@id}"><xsl:value-of select="@navtitle"/></navtitle>
            </topicmeta>                    
            <xsl:apply-templates select="node()"/>
        </xsl:copy>
    </xsl:template>
    
    
    <!-- Add sections to the TOC, if the numbering sections parameter is active. -->
    <xsl:template match="opentopic:map//*[contains(@class, ' map/topicref ')]" priority="3">
        <xsl:choose>
          <xsl:when test="$numbering-sections">
              <xsl:variable name="nm">
                <xsl:next-match/>
              </xsl:variable>
              <xsl:apply-templates select="$nm" mode="expand-sections-in-toc">
                <xsl:with-param name="target-topic" select="key('ids_in_content', @id)[last()]"/>
              </xsl:apply-templates>
          </xsl:when>
          <xsl:otherwise>
            <xsl:next-match/>          
          </xsl:otherwise>
        </xsl:choose>    
    </xsl:template>
  
    <xsl:template match="*[contains(@class, ' map/topicref ')]" mode="expand-sections-in-toc">
      <xsl:param name="target-topic"/>
      <xsl:copy>
              
        <xsl:copy-of select="@*"/>
        <!-- Metadata, like topicmeta with navtitles -->
        <xsl:copy-of select="* except(*[contains(@class, ' map/topicref')])"/>
        
        <!-- Creates references to sections from content.
          Aware of specializations: we are matching only the pure sections! -->
        <xsl:for-each select="$target-topic/*[contains(@class, '- topic/body ')]/*[@class = '- topic/section ']">
        
          <xsl:variable name="section-id" select="if(@id) then @id else generate-id(.)"/>
          
          <topicref class="- map/topicref " href="#{$section-id}" type="topic">
            <topicmeta class="- map/topicmeta " data-topic-id="$section-id">
              <resourceid appid="{$section-id}" class="- topic/resourceid " oxy-source="topic"/>
              <xsl:variable name="title-content">
                <xsl:apply-templates select="*[contains(@class, ' topic/title ')]"/>
              </xsl:variable>
              <navtitle href="#{$section-id}" class="- topic/navtitle "><xsl:copy-of select="$title-content/*/node()"/></navtitle>
            </topicmeta>
          </topicref>
        </xsl:for-each>
        
        <!-- The rest of children topicrefs -->
        <xsl:copy-of select="*[contains(@class, ' map/topicref ')]"/>
        
      </xsl:copy>
    </xsl:template>
    
    <!--
         Adds a href attribute to the navtitle, builds its content.

         1. Remove the TM markup from the <navtitle> children. It caused Prince to break the
         lines in the TOC before and after each of the inline elements.
         2. Rebuilds the navtitle content, by extracting the topic title. For DITA composites
         the preprocessing reuses the first embedded topic title for next embedded topics,
         so we cannot use it reliably.
    -->
    <xsl:template match="opentopic:map//*[contains(@class, ' topic/navtitle ')]">
        <xsl:copy>
            <xsl:call-template name="navtitle.href"/>
            <xsl:apply-templates select="@*"/>
            <!--
                Try to get the content of the <navtitle> again from the hierarchy of topics in the content,
            -->
            <xsl:variable name="target-topic" select="key('ids_in_content', ancestor::*[contains(@class, ' map/topicref ')]/@id)[last()]"/>
            <xsl:variable name="input">
                <xsl:choose>
                    <xsl:when test="../../@locktitle">
                        <xsl:sequence select="node()|*"/>
                    </xsl:when>
                    <xsl:when test="$target-topic/*[contains(@class,' topic/titlealts ')]/*[contains(@class,' topic/navtitle ')]">
                        <xsl:sequence select="$target-topic/*[contains(@class,' topic/titlealts ')]/*[contains(@class,' topic/navtitle ')]/(node() | *)"/>
                    </xsl:when>
                    <xsl:when test="$target-topic/*[contains(@class,' topic/title ')]">
                        <xsl:sequence select="$target-topic/*[contains(@class,' topic/title ')]/(node() | *)"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:sequence select="node()|*"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>
            
            <xsl:apply-templates select="$input" mode="navtitle-remove-tms" />
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' topic/tm ')]" mode="navtitle-remove-tms">
        <xsl:choose>
            <xsl:when test="starts-with($transtype, 'pdf-css-html5')">
                <!-- Leave it as it is, the full markup will be transformed in merge2html stage. -->
                <xsl:apply-templates select="." mode="#default"/>
            </xsl:when>
            <xsl:otherwise>
                <!-- The direct XML + CSS transformation -->
                <!-- Output the text. -->
                <xsl:apply-templates mode="navtitle-remove-tms"/>
                <!-- And the trademark symbol. -->
                <xsl:choose>
                    <xsl:when test="@tmtype = 'tm'">&#8482;</xsl:when>
                    <xsl:when test="@tmtype = 'reg'">&#174;</xsl:when>
                    <xsl:when test="@tmtype = 'service'">&#8480;</xsl:when>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!--
      Computes the navtitle element href.
    -->
    <xsl:template name="navtitle.href">
        <xsl:attribute name="href">
            <!-- The parent topicref of the navtitle -->
            <xsl:variable name="topicref"
                select="ancestor-or-self::*[contains(@class, ' map/topicref ')][1]"/>
            <xsl:variable name="tid" select="$topicref/@first_topic_id"/>
            <xsl:choose>
                <xsl:when test="$tid">
                    <xsl:value-of select="$tid"/>
                </xsl:when>
                <!-- EXM-32190 Sometimes, when we have chunk=to-content on the root element, the first_topic_id attribute might be missing -->
                <xsl:when test="not($topicref/@id = '')">
                    <!-- Do not use the @href attribute, it does not point to the topic from the content.
                    Instead, use the @id, it has the same value as the @id from the content. -->
                    <!-- The id may be empty if having an external ref to a PDF for example. -->
                    <xsl:value-of select="concat('#', $topicref/@id)"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$topicref/@href"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:attribute>
    </xsl:template>
    
    <!--
          Use the @navtitle from the topicref, in case of topicheads, no need to look in the topic titles.
        For    topicheads, the topicmeta is not updated properly by DITA-OT.
       -->
    <xsl:template match="
        opentopic:map//topicmeta[../@navtitle][not(navtitle)] |
        opentopic:map//topicmeta[../@navtitle][../@locktitle='yes']" priority="2">
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <navtitle class="- topic/navtitle ">
                <xsl:call-template name="navtitle.href"/>
                <xsl:value-of select="../@navtitle"/>
            </navtitle>
        </xsl:copy>
    </xsl:template>
    
    <!-- 
        Sometimes the @navtitle attribute on the topicref element is used instead 
        of the <topicmeta>/<navtitle> element.
        DITA-OT generates a linktext in this case. To simplify CSS processing,
        we'll create a navtitle out of the linktext.
    -->
    <xsl:template match="opentopic:map//topicmeta[linktext][not(navtitle)][not(../@navtitle)]">
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <navtitle class="- topic/navtitle ">
                <xsl:call-template name="navtitle.href"/>
                <xsl:value-of select="linktext"/>
            </navtitle>
        </xsl:copy>
    </xsl:template>
    
    <!-- 
        Processes the opentopic:map element, this gives the main structure of the TOC.
    -->
    <xsl:template match="opentopic:map">
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:attribute name="class" select="'- toc/toc '"/>
            
            <!-- 
                Adds a title to the TOC. 
                The title is taken from the toc element @navtitle attribute.
                If it does not exist, leave the placeholder element in place 
                and mark it as empty, so it can be styled from CSS.
            -->            
            <oxy:toc-title class="- toc/title ">
                <xsl:variable name="toc-navtitile" select="//toc[1]/@navtitle"/>
                <xsl:choose>
                    <xsl:when test="$toc-navtitile">
                        <xsl:value-of select="$toc-navtitile"/>                        
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:attribute name="empty" select="'true'"/>
                    </xsl:otherwise>
                </xsl:choose>
            </oxy:toc-title>
            
            <!-- 
                Adds the TOC main content.
            -->
            <xsl:apply-templates select="node()"/>
            
            <!-- 
                Add a reference to the generated index element,
                but only if it contains at least one child and 
                there is not a reference to the index by means for 
                a indexlist element in the bookmap.
            -->
            <xsl:variable name="indexElem" select="//opentopic-index:index.groups[1]"/>
            <xsl:if test="$indexElem/* and not (//*[contains(@class, ' bookmap/indexlist ')]) and 
                    $hide.frontpage.toc.index.glossary = 'no'">
                    
                <xsl:variable name="indexId" select="generate-id($indexElem)"/>
                <topicref is-chapter="true" is-index="true" class="- map/topicref ">
                    <topicmeta class="- map/topicmeta ">
                        <navtitle href="#{$indexId}" class="- topic/navtitle ">
                         <xsl:call-template name="getVariable">
                            <xsl:with-param name="id" select="'Index'"/>
                         </xsl:call-template>
                        </navtitle>
                    </topicmeta>
                </topicref>
            </xsl:if>
        </xsl:copy>
    </xsl:template>
    
    <!-- 
      The topicgroup element is for creating groups of topicref elements without affecting 
      the hierarchy. 
    -->
    <xsl:template match="*[contains(@class,' mapgroup-d/topicgroup ')]">
      <xsl:apply-templates />
    </xsl:template>
    
</xsl:stylesheet>