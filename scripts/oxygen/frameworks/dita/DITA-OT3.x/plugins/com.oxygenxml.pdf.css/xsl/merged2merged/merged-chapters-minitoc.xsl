<!-- This stylesheet creates a minitoc in the bookmap chapters. -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0" xmlns:ditaarch="http://dita.oasis-open.org/architecture/2005/" xmlns:opentopic-index="http://www.idiominc.com/opentopic/index"
  xmlns:opentopic="http://www.idiominc.com/opentopic" xmlns:oxy="http://www.oxygenxml.com/extensions/author" xmlns:saxon="http://saxon.sf.net/" xmlns:xs="http://www.w3.org/2001/XMLSchema"
  exclude-result-prefixes="#all">

  <xsl:template match="*[contains(@class, ' topic/topic ')]">

    <xsl:choose>
    	<xsl:when test="($args.chapter.layout = 'MINITOC' or
                         $args.chapter.layout = 'MINITOC-BOTTOM-LINKS') and 
                         oxy:is-chapter(/, oxy:get-topicref-for-topic(/, @id)) and 
                         *[contains(@class, ' topic/topic ')]">
      	<!-- Minitoc. -->
        <xsl:copy>
          <xsl:apply-templates select="@*" />
          <xsl:apply-templates select="*[contains(@class, ' topic/title ')]" />
          <xsl:apply-templates select="*[contains(@class, ' topic/prolog ')]" />
          <xsl:apply-templates select="*[contains(@class, ' topic/titlealts ')]" />

		  <div>
          	<xsl:choose>
          		<xsl:when test="$args.chapter.layout = 'MINITOC'">
		          	<xsl:attribute name="class">- topic/div chapter/minitoc </xsl:attribute>
          			<xsl:call-template name="generate-minitoc-links"/>
          			<xsl:call-template name="generate-minitoc-desc"/>
          		</xsl:when>
          		<xsl:when test="$args.chapter.layout = 'MINITOC-BOTTOM-LINKS'">
          			<xsl:attribute name="class">- topic/div chapter/minitoc chapter/minitoc-bottom </xsl:attribute>
          			<xsl:call-template name="generate-minitoc-desc"/>
          			<xsl:call-template name="generate-minitoc-links"/>
          		</xsl:when>          		
          	</xsl:choose>
          </div>
          <xsl:apply-templates select="*[contains(@class, ' topic/topic ')]" />
        </xsl:copy>
      </xsl:when>
      <xsl:otherwise>
        <!-- No minitoc. -->
        <xsl:next-match/>
      </xsl:otherwise>
    </xsl:choose>    
  </xsl:template>
	
	<!-- 
		The chapter topic content. This has the role of describing the chapter.
	-->
	<xsl:template name="generate-minitoc-desc">
		<div class="- topic/div chapter/minitoc-desc ">
		    <xsl:apply-templates
                select="
                    *[not(contains(@class, ' topic/title ')) and
                    not(contains(@class, ' topic/prolog ')) and
                    not(contains(@class, ' topic/titlealts ')) and  
                    not(contains(@class, ' topic/topic '))] 
                    " />
		</div>
	</xsl:template>
	
	
	<!-- 
		Child links.
	-->
	<xsl:template name="generate-minitoc-links">
		<div class="- topic/div chapter/minitoc-links ">
			<related-links class="- topic/related-links ">
				<linklist class="- topic/linklist ">
					<desc class="- topic/desc ">
						<ph class="- topic/ph chapter/minitoc-label ">
							<xsl:call-template name="getVariable">
								<xsl:with-param name="id" select="'Mini Toc'"/>
							</xsl:call-template>
						</ph>
					</desc>
					<xsl:apply-templates select="*[contains(@class, ' topic/topic ')]"
						mode="in-this-chapter-list"/>
				</linklist>
			</related-links>
		</div>
	</xsl:template>


  <xsl:template match="*[contains(@class, ' topic/topic ')]" mode="in-this-chapter-list">
    <link class="- topic/link " href="#{@id}" type="topic" role="child">
      <linktext class="- topic/linktext ">
        <xsl:value-of select="*[contains(@class, ' topic/title ')]" />
      </linktext>
    </link>
  </xsl:template>

</xsl:stylesheet>
