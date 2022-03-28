<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fo="http://www.w3.org/1999/XSL/Format"
  xmlns:editlink="http://oxygenxml.com/xslt/editlink/" exclude-result-prefixes="xs editlink"
  version="2.0">
  
  <xsl:import href="link.xsl"/>
  
  <xsl:param name="editlink.remote.ditamap.url"/>
  <xsl:param name="editlink.web.author.url"/>
  <xsl:param name="editlink.local.ditamap.path"/>
  <xsl:param name="editlink.present.only.path.to.topic"/>
  <xsl:param name="editlink.local.ditaval.path"/>
  <xsl:param name="editlink.ditamap.edit.url"/>
  <xsl:param name="editlink.additional.query.parameters"/>
  
  <!-- Template to add edit link to the map -->
  <xsl:template name="add-map-edit-link">
    <fo:basic-link xsl:use-attribute-sets="fo-link-attrs">
      <xsl:attribute name="external-destination">
        <xsl:value-of select="concat($editlink.web.author.url, 'app/oxygen.html?url=', encode-for-uri($editlink.remote.ditamap.url))"/>
      </xsl:attribute>
      Edit online
    </fo:basic-link>
  </xsl:template>
  
  <xsl:template match="*" mode="processTopicTitle">
    <xsl:choose>
      <xsl:when test="editlink:should-add-edit-link() and @xtrf">
        <xsl:variable name="original">
          <xsl:next-match/>
        </xsl:variable>
        
        <xsl:variable name="nodeToProcess" 
          select="($original//fo:block[starts-with(@id, '_OPENTOPIC_TOC_PROCESSING')] | 
          $original//fo:block[./fo:wrapper[starts-with(@id, '_OPENTOPIC_TOC_PROCESSING')]])[1]"/>
        
        <!-- Process the generated FO to add the 'Edit Link' action -->
        <xsl:apply-templates select="$original" mode="add-edit-link">
          <xsl:with-param name="xtrf" select="@xtrf" tunnel="yes"/>
          <xsl:with-param name="nodeToProcess" select="$nodeToProcess" tunnel="yes"/>
        </xsl:apply-templates>
      </xsl:when>
      <xsl:otherwise>
        <xsl:next-match/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:function name="editlink:should-add-edit-link" as="xs:boolean">
    <xsl:sequence 
      select="(string-length($editlink.remote.ditamap.url) > 0
      or string-length($editlink.ditamap.edit.url) > 0
      or $editlink.present.only.path.to.topic = 'true')"/>
  </xsl:function>
  
  <!-- Chapters -->
  <xsl:template match="*" mode="processTopicChapterInsideFlow">
    <xsl:call-template name="add-edit-link-following-sibling"/>
  </xsl:template>
  
  <!-- Topics in front matter -->
  <xsl:template match="*" mode="processTopicFrontMatterInsideFlow">
    <xsl:choose>
      <xsl:when test="editlink:should-add-edit-link() and @xtrf">
        <xsl:variable name="original">
          <xsl:next-match/>
        </xsl:variable>
        <xsl:variable name="nodeToProcess" 
          select="($original//fo:block[starts-with(@id, '_OPENTOPIC_TOC_PROCESSING')])[1]"/>
        <!-- Process the generated FO to add the 'Edit Link' action -->
        <xsl:apply-templates select="$original" mode="add-edit-link">
          <xsl:with-param name="xtrf" select="@xtrf" tunnel="yes"/>
          <xsl:with-param name="nodeToProcess" select="$nodeToProcess" tunnel="yes"/>
        </xsl:apply-templates>
      </xsl:when>
      <xsl:otherwise>
        <xsl:next-match/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <!-- Preface -->
  <xsl:template match="*" mode="processTopicPrefaceInsideFlow">
    <xsl:call-template name="add-edit-link-following-sibling"/>
  </xsl:template>
  
  <!-- Appendix Chapter -->
  <xsl:template match="*" mode="processTopicAppendixInsideFlow">
    <xsl:call-template name="add-edit-link-following-sibling"/>
  </xsl:template>
  
  <!-- Process the $original node and add an edit link near 
    the following sibling of the element with 'opentopic' id. -->
  <xsl:template name="add-edit-link-following-sibling">
    <xsl:choose>
      <xsl:when test="editlink:should-add-edit-link() and @xtrf">
        <xsl:variable name="original">
          <xsl:next-match/>
        </xsl:variable>
        <xsl:variable name="nodeToProcess" 
          select="($original//fo:block[starts-with(@id, '_OPENTOPIC_TOC_PROCESSING')]/following-sibling::fo:block)[1]"/>
        <!-- Process the generated FO to add the 'Edit Link' action -->
        <xsl:apply-templates select="$original" mode="add-edit-link">
          <xsl:with-param name="xtrf" select="@xtrf" tunnel="yes"/>
          <xsl:with-param name="nodeToProcess" select="$nodeToProcess" tunnel="yes"/>
        </xsl:apply-templates>
      </xsl:when>
      <xsl:otherwise>
        <xsl:next-match/>
      </xsl:otherwise>
    </xsl:choose>    
  </xsl:template>
  
  <!-- Add a fo:basic-link element associated with the 'Edit Link' action -->
  <xsl:template match="*" mode="add-edit-link" priority="5">
    <xsl:param name="xtrf" tunnel="yes"/>
    <xsl:param name="nodeToProcess" tunnel="yes"/>
    
    <xsl:choose>
      <xsl:when test="generate-id($nodeToProcess) = generate-id(.)">
        <xsl:copy>
          <xsl:apply-templates select="@*" mode="#current"/>
          <fo:table>
            <fo:table-body>
              <fo:table-row>
                <fo:table-cell>
                  <fo:block>
                    <xsl:apply-templates select="node()" mode="#current"/>
                  </fo:block>
                </fo:table-cell>
                <fo:table-cell width="80pt">
                  <fo:block>
                    <xsl:choose>
                      <xsl:when test="$editlink.present.only.path.to.topic = 'true'">
                        <fo:inline text-align="right" white-space="nowrap" color="navy" font-size="8pt"
                          font-weight="normal" width="80pt" font-style="normal">
                          <xsl:value-of
                            select="editlink:makeRelative(editlink:toUrl($editlink.local.ditamap.path), $xtrf)"
                          />
                        </fo:inline>
                      </xsl:when>
                      <xsl:otherwise>
                        <fo:basic-link xsl:use-attribute-sets="fo-link-attrs">
                          <xsl:attribute name="external-destination">
                            <xsl:value-of
                              select="editlink:compute($editlink.remote.ditamap.url, $editlink.local.ditamap.path, $xtrf, $editlink.web.author.url, $editlink.local.ditaval.path, $editlink.ditamap.edit.url, $editlink.additional.query.parameters)"/>
                          </xsl:attribute> Edit online </fo:basic-link>
                      </xsl:otherwise>
                    </xsl:choose>
                  </fo:block>
                </fo:table-cell>
              </fo:table-row>
            </fo:table-body>
          </fo:table>
        </xsl:copy>    
      </xsl:when>
      <xsl:otherwise>
        <xsl:next-match/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <!-- Copy template for the add-edit-link mode -->
  <xsl:template match="node() | @*" mode="add-edit-link">
    <xsl:copy>
      <xsl:apply-templates select="node() | @*" mode="#current"/>
    </xsl:copy>
  </xsl:template>
  
</xsl:stylesheet>
