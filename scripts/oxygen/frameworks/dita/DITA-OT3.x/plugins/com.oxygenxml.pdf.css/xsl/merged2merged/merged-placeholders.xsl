<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
  xmlns:ot-placeholder="http://suite-sol.com/namespaces/ot-placeholder"
  xmlns:opentopic-index="http://www.idiominc.com/opentopic/index"
  xmlns:oxy="http://www.oxygenxml.com/extensions/author"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:opentopic="http://www.idiominc.com/opentopic" exclude-result-prefixes="#all">
  
  
  <!-- Set of all tables with a title. Keeps only the ID (original or generated). -->
  <xsl:variable name="tableset">
    <xsl:for-each
      select="//*[contains(@class, ' topic/table ')][*[contains(@class, ' topic/title ')]]">
      <xsl:copy>
        <xsl:copy-of select="@*"/>
        <xsl:if test="not(@id)">
          <xsl:attribute name="id">
            <xsl:call-template name="get-id"/>
          </xsl:attribute>
        </xsl:if>
      </xsl:copy>
    </xsl:for-each>
  </xsl:variable>
  
  <!-- Set of all tables with a title. Keeps only the ID (original or generated). -->
  <xsl:variable name="figureset">
    <xsl:for-each
      select="//*[contains(@class, ' topic/fig ')][*[contains(@class, ' topic/title ')]]">
      <xsl:copy>
        <xsl:copy-of select="@*"/>
        <xsl:if test="not(@id)">
          <xsl:attribute name="id">
            <xsl:call-template name="get-id"/>
          </xsl:attribute>
        </xsl:if>
      </xsl:copy>
    </xsl:for-each>
  </xsl:variable>
  
  <!-- 
    ============================================================================

    TOC references to the lists.

    ============================================================================    
    -->
  
  <xsl:template name="generate-list-reference-in-the-toc">
    <xsl:param name="label-id" as="xs:string"/>  
    <xsl:if test="$hide.frontpage.toc.index.glossary = 'no'">
      <xsl:copy>
        <xsl:attribute name="class" select="@class"/>
        <xsl:variable name="href" select="concat('#', @id)"/>
        <xsl:attribute name="href" select="$href" />
        <topicmeta class="- map/topicmeta ">
          <navtitle href="{$href}" class="- topic/navtitle ">
            <xsl:call-template name="getVariable">
            <xsl:with-param name="id" select="$label-id"/>
          </xsl:call-template>
          </navtitle>
        </topicmeta>
      </xsl:copy>      
    </xsl:if>
  </xsl:template>
    
  <xsl:template match="*[contains(@class, ' bookmap/tablelist ')]">    
    <xsl:if test="//*[contains(@class, ' topic/table ')]/*[contains(@class, ' topic/title ')]">
      <xsl:call-template name="generate-list-reference-in-the-toc">
        <xsl:with-param name="label-id" select="'List of Tables'"/>
      </xsl:call-template>
    </xsl:if>    
  </xsl:template>
  
  <xsl:template match="*[contains(@class, ' bookmap/figurelist ')]">  
    <xsl:if test="//*[contains(@class, ' topic/fig ')]/*[contains(@class, ' topic/title ')]">
      <xsl:call-template name="generate-list-reference-in-the-toc">
        <xsl:with-param name="label-id" select="'List of Figures'"/>
      </xsl:call-template>
    </xsl:if>    
  </xsl:template>
  
  <xsl:template match="*[contains(@class, ' bookmap/indexlist ')]">
    <xsl:if test="//opentopic-index:index.groups">
      <xsl:call-template name="generate-list-reference-in-the-toc">
        <xsl:with-param name="label-id" select="'Index'"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
  
  <xsl:template match="*[contains(@class, ' bookmap/glossarylist ')][not(@href)]">
    <xsl:if test="//*[contains(@class, ' glossentry/glossentry ')]/*[contains(@class, ' topic/title ')]">
      <xsl:call-template name="generate-list-reference-in-the-toc">
        <xsl:with-param name="label-id" select="'Glossary'"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
  
  
  <!-- 
    ============================================================================

    List of Tables, Figures

    ============================================================================    
    -->
    
  <xsl:template name="generate-list-of">
    <xsl:param name="list-title"/>
    <xsl:param name="list-label-prefix"/>
    <xsl:param name="target-class"/>
    <xsl:param name="target-set"/>
    
    <xsl:if test="$hide.frontpage.toc.index.glossary = 'no'">
    
      <xsl:if test="//*[contains(@class, $target-class)]/*[contains(@class, ' topic/title ')]">
        <xsl:copy>
          <xsl:attribute name="id" select="@id"/>
          <xsl:attribute name="class" select="concat('- placeholder/', lower-case(local-name()), ' ')"/>
                  
          <title class="- topic/title ">
            <xsl:call-template name="getVariable">
              <xsl:with-param name="id" select="$list-title"/>
            </xsl:call-template>
          </title>
          
          <xsl:variable name="prefix">
            <xsl:call-template name="getVariable">
              <xsl:with-param name="id" select="$list-label-prefix"/>
            </xsl:call-template>
          </xsl:variable>
          
          <xsl:for-each
            select="//*[contains(@class, $target-class)][child::*[contains(@class, ' topic/title ')]]">
            
            <xsl:variable name="href">
                <xsl:text>#</xsl:text>
                <xsl:call-template name="get-id"/>
            </xsl:variable>
            
            <entry class="- listentry/entry " href="{$href}">
               <!-- DCP-263 The href is placed also on the prefix, so it can be used from the CSS on static text. -->              
              <prefix class="- listentry/prefix " href="{$href}">
                <xsl:value-of select="$prefix"/>
              </prefix>
  
              <number class="- listentry/number ">
                <xsl:variable name="id">
                  <xsl:call-template name="get-id"/>
                </xsl:variable>
                <xsl:number format="1"
                  value="count($target-set/*[@id = $id]/preceding-sibling::*) + 1"/>
              </number>
  
              <xsl:apply-templates select="./*[contains(@class, ' topic/title ')]"/>
            </entry>
          </xsl:for-each>
        </xsl:copy>
      </xsl:if>
      
    </xsl:if>
  </xsl:template>  
    
    
  <xsl:template match="ot-placeholder:tablelist">
    <xsl:call-template name="generate-list-of">
      <xsl:with-param name="list-title" select="'List of Tables'"/>
      <xsl:with-param name="list-label-prefix" select="'Table'"/>
      <xsl:with-param name="target-class" select="' topic/table '"/>
      <xsl:with-param name="target-set" select="$tableset"/>      
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="ot-placeholder:figurelist">
    <xsl:call-template name="generate-list-of">
      <xsl:with-param name="list-title" select="'List of Figures'"/>
      <xsl:with-param name="list-label-prefix" select="'Figure'"/>
      <xsl:with-param name="target-class" select="' topic/fig '"/>
      <xsl:with-param name="target-set" select="$figureset"/>      
    </xsl:call-template>
  </xsl:template>
  
  
  <!-- 
    ============================================================================

    Index

    ============================================================================    
    -->
  <xsl:template match="ot-placeholder:indexlist">
      <xsl:if test="//opentopic-index:index.groups/*">
        <!-- It already has a root node, no need to use the placeholder as a container -->
          <xsl:apply-templates select="/*/opentopic-index:index.groups">
            <xsl:with-param name="placeholder-id" select="@id" tunnel="yes"/>
          </xsl:apply-templates>
      </xsl:if>
  </xsl:template>
  
  <!-- 
         Disable the processing of the index, unless match is triggered from a placeholder - 
         or if there is no placeholder at all in a plain map. The plain maps do not generate 
         a placeholder, just the DITA bookmaps do.  

         For instance the plain maps do not generate a placeholder, just the bookmaps do.  
    -->
  <xsl:template match="opentopic-index:index.groups" priority="3">
    <xsl:param name="placeholder-id" select="false()" tunnel="yes"/>
    <xsl:if test="$hide.frontpage.toc.index.glossary = 'no'">
      <xsl:if test="$placeholder-id or (not(/*/ot-placeholder:indexlist) and not(/*[contains(@class, ' bookmap/bookmap ')]))">
        <xsl:next-match/>
      </xsl:if>
    </xsl:if>
  </xsl:template>
  
  
  <!-- 
    ============================================================================

    TOC

    ============================================================================    
    -->
  <xsl:template match="ot-placeholder:toc">    
    <!-- It already has a root node, no need to use the placeholder as a container -->    
      <xsl:apply-templates select="/*/opentopic:map">
        <xsl:with-param name="from-placeholder" select="'true()'"/>
      </xsl:apply-templates>
  </xsl:template>
  
  <!-- 
         Disable the processing of the toc, unless match is triggered from a placeholder - 
         or if there is no placeholder at all in a plain map. The plain maps do not generate 
         a placeholder, just the DITA bookmaps do.  
    -->
  <xsl:template match="opentopic:map" priority="2">
    <xsl:param name="from-placeholder" select="false()"/>
    <xsl:if test="$hide.frontpage.toc.index.glossary = 'no'">
      <xsl:if test="$from-placeholder or (not(/*/ot-placeholder:toc) and not(/*[contains(@class, ' bookmap/bookmap ')]))">
        <xsl:next-match/>
      </xsl:if>
    </xsl:if>
  </xsl:template>
  
  <!-- 
    ============================================================================

    Glossary

    ============================================================================    
    -->
  <xsl:template match="ot-placeholder:glossarylist">
    <xsl:if test="$hide.frontpage.toc.index.glossary = 'no'">
      <topic>
        <xsl:apply-templates select="@*"/>
        <xsl:attribute name="class" select="'- topic/topic bookmap/glossarylist '"/>
      
        <title class="- topic/title ">
            <xsl:call-template name="getVariable">
                <xsl:with-param name="id" select="'Glossary'"/>
            </xsl:call-template>
        </title>  
      
        <xsl:variable name="lang" select="oxy:get-lang(/)"/>
      
        <xsl:apply-templates>
          <xsl:sort select="*[contains(@class, ' topic/title ')]" data-type="text" lang="{$lang}" order="ascending"/>      
        </xsl:apply-templates>
        
      </topic>
    </xsl:if>
  </xsl:template>
  
  
  
  
  
  <!-- Warn for unknown placeholder. -->
  <xsl:template match="ot-placeholder:*" name="ot-placeholder">
    <xsl:message terminate="no"> Placeholder not processed <xsl:copy-of select="."/></xsl:message>
  </xsl:template>
  
  
  
  
  
  <xsl:function name="oxy:get-lang">
    <xsl:param name="doc"/>    
    <xsl:value-of select="if ($doc/*/@xml:lang) then $doc/*/@xml:lang else 'en-US'"/>    
  </xsl:function>
  
  
  <!-- Get ID for an element, generate ID if not explicitly set. -->
  <xsl:template name="get-id">
    <xsl:param name="element" select="."/>
    <xsl:choose>
      <xsl:when test="$element/@id">
        <xsl:value-of select="$element/@id"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="generate-id($element)"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>
