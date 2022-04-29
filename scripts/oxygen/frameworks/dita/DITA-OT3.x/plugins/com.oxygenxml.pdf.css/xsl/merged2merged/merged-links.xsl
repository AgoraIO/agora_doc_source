<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns:xs="http://www.w3.org/2001/XMLSchema" 
  xmlns:opentopic="http://www.idiominc.com/opentopic"
  xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function"
  xmlns:opentopic-vars="http://www.idiominc.com/opentopic/vars"
  exclude-result-prefixes="xs opentopic opentopic-func opentopic-vars" version="2.0">
  
  <xsl:import href="plugin:org.dita.base:xsl/common/dita-utilities.xsl"/>
  <xsl:import href="plugin:org.dita.base:xsl/common/output-message.xsl"/>
  <xsl:param name="figurelink.style" select="'NUMTITLE'"/>
  <xsl:param name="tablelink.style" select="'NUMTITLE'"/>
  <xsl:param name="msgprefix" select="'CHEM'"></xsl:param>
  <xsl:key name="ids_in_content"   match="*[not(ancestor-or-self::opentopic:map)]"   use="@id"/>
  <xsl:key name="key_anchor" match="*[@id][not(contains(@class,' map/topicref '))]" use="@id"/>
  <xsl:key name="enumerableByClass"
    match="*[contains(@class, ' topic/fig ')][*[contains(@class, ' topic/title ')]] |
    *[contains(@class, ' topic/table ')][*[contains(@class, ' topic/title ')]] |
    *[contains(@class,' topic/fn ') and empty(@callout)]"
    use="tokenize(@class, ' ')"/>
  
  <xsl:function name="opentopic-func:getDestinationId">
    <xsl:param name="href"/>
    <xsl:call-template name="getDestinationIdImpl">
      <xsl:with-param name="href" select="$href"/>
    </xsl:call-template>
  </xsl:function>
  
  <xsl:template name="getDestinationIdImpl">
    <xsl:param name="href"/>
    
    <xsl:variable name="topic-id" select="substring-after($href, '#')"/>
    
    <xsl:variable name="element-id" select="substring-after($topic-id, '/')"/>
    
    <xsl:choose>
      <xsl:when test="$element-id = ''">
        <xsl:value-of select="$topic-id"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$element-id"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="*[contains(@class, ' topic/fig ')][*[contains(@class, ' topic/title ')]]" mode="retrieveReferenceTitle">
    <xsl:choose>
      <xsl:when test="$figurelink.style='NUMBER'">
        <xsl:call-template name="getVariable">
          <xsl:with-param name="id" select="'Figure Number'"/>
          <xsl:with-param name="params">
            <number xmlns="">
              <xsl:apply-templates select="*[contains(@class, ' topic/title ')]" mode="fig.title-number"/>
            </number>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="$figurelink.style='TITLE'">
        <xsl:apply-templates select="*[contains(@class, ' topic/title ')]" mode="insert-text"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="getVariable">
          <xsl:with-param name="id" select="'Figure.title'"/>
          <xsl:with-param name="params">
            <number>
              <xsl:apply-templates select="*[contains(@class, ' topic/title ')]" mode="fig.title-number"/>
            </number>
            <title>
              <xsl:apply-templates select="*[contains(@class, ' topic/title ')]" mode="insert-text"/>
            </title>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="*[contains(@class, ' topic/section ')][*[contains(@class, ' topic/title ')]]" mode="retrieveReferenceTitle">
    <xsl:variable name="title">
      <xsl:apply-templates select="*[contains(@class, ' topic/title ')]" mode="insert-text"/>
    </xsl:variable>
    <xsl:value-of select="normalize-space($title)"/>
  </xsl:template>
  
  <xsl:template match="*[contains(@class, ' topic/table ')][*[contains(@class, ' topic/title ')]]" mode="retrieveReferenceTitle">
    <xsl:choose>
      <xsl:when test="$tablelink.style='NUMBER'">
        <xsl:call-template name="getVariable">
          <xsl:with-param name="id" select="'Table Number'"/>
          <xsl:with-param name="params">
            <number>
              <xsl:apply-templates select="*[contains(@class, ' topic/title ')]" mode="table.title-number"/>
            </number>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="$tablelink.style='TITLE'">
        <xsl:apply-templates select="*[contains(@class, ' topic/title ')]" mode="insert-text"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="getVariable">
          <xsl:with-param name="id" select="'Table.title'"/>
          <xsl:with-param name="params">
            <number>
              <xsl:apply-templates select="*[contains(@class, ' topic/title ')]" mode="table.title-number"/>
            </number>
            <title>
              <xsl:apply-templates select="*[contains(@class, ' topic/title ')]" mode="insert-text"/>
            </title>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="*[contains(@class, ' topic/li ')]" mode="retrieveReferenceTitle">
    <xsl:call-template name="getVariable">
      <xsl:with-param name="id" select="'List item'"/>
    </xsl:call-template>
  </xsl:template>
  
  <xsl:template match="*[contains(@class, ' topic/fn ')]" mode="retrieveReferenceTitle">
    <xsl:call-template name="getVariable">
      <xsl:with-param name="id" select="'Foot note'"/>
    </xsl:call-template>
  </xsl:template>
  
  <!-- Default rule: if element has a title, use that, otherwise return '#none#' -->
  <xsl:template match="*" mode="retrieveReferenceTitle" >
    <xsl:choose>
      <xsl:when test="*[contains(@class,' topic/title ')]">
        <xsl:value-of select="string(*[contains(@class, ' topic/title ')])"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>#none#</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <!-- The insertReferenceTitle template is called from <xref> and <link> and is
         used to build link contents (using full FO syntax, not just the text). -->
  <!-- Process any cross reference or link with author-specified text. 
         The specified text is used as the link text. -->
  <xsl:template match="*[processing-instruction()[name()='ditaot'][.='usertext']]" mode="insertReferenceTitle">
    <xsl:apply-templates select="*[not(contains(@class,' topic/desc '))]|text()"/>
  </xsl:template>
  
  <!-- Process any cross reference or link with no content, or with content
         generated by the DITA-OT preprocess. The title will be retrieved from
         the target element, and combined with generated text such as Figure N. -->
  <xsl:template match="*" mode="insertReferenceTitle">
    <xsl:param name="href"/>
    <xsl:param name="titlePrefix"/>
    <xsl:param name="destination" tunnel="yes"/>
    <xsl:param name="element"/>
    
    <xsl:variable name="referenceContent">
      <xsl:choose>
        <xsl:when test="not($element) or ($destination = '')">
          <xsl:text>#none#</xsl:text>
        </xsl:when>
        <xsl:when test="contains($element/@class,' topic/li ') and 
          contains($element/parent::*/@class,' topic/ol ')">
          <!-- SF Bug 1839827: This causes preprocessor text to be used for links to OL/LI -->
          <xsl:text>#none#</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates select="$element" mode="retrieveReferenceTitle"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
    <xsl:if test="not($titlePrefix = '')">
      <xsl:call-template name="getVariable">
        <xsl:with-param name="id" select="$titlePrefix"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:choose>
      <xsl:when test="not($element) or ($destination = '') or $referenceContent='#none#'">
        <xsl:choose>
          <xsl:when test="*[not(contains(@class,' topic/desc '))] | text()">
            <xsl:apply-templates select="*[not(contains(@class,' topic/desc '))] | text()"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$href"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      
      <xsl:otherwise>
        <xsl:copy-of select="$referenceContent"/>
      </xsl:otherwise>
    </xsl:choose>
    
  </xsl:template>
  
  <xsl:template match="*[contains(@class,' topic/fig ')]/*[contains(@class,' topic/title ')]" mode="fig.title-number">
    <xsl:param name="destination" tunnel="yes"/>
  
    <!-- DCP-263 - allow replacing of numbers from the CSS. -->
    <ph class="- topic/ph " outputclass="fig--title-label-number ">
      <xsl:value-of select="count(key('enumerableByClass', 'topic/fig')[. &lt;&lt; current()])"/>
    </ph>
    <ph class="- topic/ph " outputclass="fig--title-label-number-placeholder " href="#{$destination}"/>    
  </xsl:template>
  
  <xsl:template match="*[contains(@class, ' topic/table ')]/*[contains(@class, ' topic/title ')]" mode="table.title-number">
    <xsl:param name="destination" tunnel="yes"/>
    <!-- DCP-263 - allow replacing of numbers from the CSS. -->
    <ph class="- topic/ph " outputclass="table--title-label-number ">
      <xsl:value-of select="count(key('enumerableByClass', 'topic/table')[. &lt;&lt; current()])"/>
    </ph>
    <ph class="- topic/ph " outputclass="table--title-label-number-placeholder " href="#{$destination}"/>        
  </xsl:template>
    
  <xsl:template match="*[contains(@class,' topic/xref ')][@type = ('fig', 'table')]">
    <xsl:variable name="destination" select="opentopic-func:getDestinationId(@href)"/>
    <xsl:variable name="element" select="key('key_anchor',$destination, /*)[1]"/>
    <xsl:variable name="referenceTitle" as="node()*">
      <xsl:apply-templates select="." mode="insertReferenceTitle">
        <xsl:with-param name="href" select="@href"/>
        <xsl:with-param name="titlePrefix" select="''"/>
        <xsl:with-param name="destination" select="$destination" tunnel="yes"/>
        <xsl:with-param name="element" select="$element"/>
      </xsl:apply-templates>
    </xsl:variable>
    <xsl:copy>
      <xsl:apply-templates select="@*"/>
      <xsl:choose>
        <xsl:when test="not(@scope = 'external' or not(empty(@format) or  @format = 'dita')) and exists($referenceTitle)">
          <xsl:copy-of select="$referenceTitle"/>
        </xsl:when>
        <xsl:otherwise><xsl:apply-templates/></xsl:otherwise>
      </xsl:choose>
    </xsl:copy>
  </xsl:template>

  <!-- 
        The merged DITA map file may contain cross references to elements from a topic. In this case, the reference looks like:
        
        <xref class="- topic/xref " 
            href="#unique_3/unique_3_Connect_42_my_table_id" 
            ohref="topics/care.dita#care/my_table_id"/>
            
        Where the "ohref" is the original value from the DITA source, and the "href" is generated by the merging process.
        The value of the href cannot be used by the XML+CSS to PDF processor, because it is not a valid IDREF (contains a / )
        so wee need to remove the part before the slash.
        
        Check out the @href attributes. If their value points to a non existing ID from the document, 
        an additional "broken-link" attribute is generated. 
    -->
  <xsl:template match="@href">
    <!-- Compute the target of the link. -->
    <xsl:choose>
    
      <xsl:when test="starts-with( ., '#')">
        <xsl:choose>
          <xsl:when test="contains(., '/')">
            <!-- Internal link. -->
            <xsl:call-template name="generate-href-for-internal-link">
              <xsl:with-param name="target" select="substring-after(., '/')" />
            </xsl:call-template>
          </xsl:when>
          <xsl:otherwise>
             <!-- Internal link. -->
            <xsl:call-template name="generate-href-for-internal-link">
              <xsl:with-param name="target" select="substring-after(., '#')" />
            </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>        
      </xsl:when>
      <xsl:otherwise>
        <!-- Web Link -->
        <xsl:attribute name="href" select="." />

      </xsl:otherwise>
    </xsl:choose>


  </xsl:template>

  <!-- 
    Generates the @href attribute. Checks if the link target exists. 
    If the target is not found in the document, the link is marked as broken.
  
    @param The ID of the target element.
   -->
  <xsl:template name="generate-href-for-internal-link">
    <xsl:param name="target" />

    <xsl:attribute name="href" select="concat('#',$target)" />
    <xsl:if test="not(key('ids_in_content', $target))">
      <!-- No matching ID, mark the link as broken. -->
      <!-- The IDs of the topicrefs should not be taken into account, are not real targets, but rather references. -->
      
      <xsl:attribute name="broken-link" select="'true'"/>
    </xsl:if>    
  </xsl:template>
  
  <xsl:template match="opentopic-vars:variable" mode="processVariableBody">
    <xsl:param name="params"/>
    
    <xsl:for-each select="node()">
      <xsl:choose>
        <xsl:when test="self::opentopic-vars:param">
          <!--Processing parametrized variable-->
          <xsl:variable name="param-name" select="@ref-name"/>
          <!--Copying parameter child as is-->
          <xsl:copy-of select="$params/descendant-or-self::*[local-name() = $param-name]/node()"/>
        </xsl:when>
        <xsl:when test="self::opentopic-vars:variable">
          <xsl:call-template name="getVariable">
            <xsl:with-param name="id" select="@id"/>
            <xsl:with-param name="params" select="$params"/>
          </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
          <xsl:copy-of select="."/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>