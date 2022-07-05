<?xml version="1.0" encoding="UTF-8"?>
<!-- 

  This stylesheet changes the tables structure.

-->
<xsl:stylesheet version="2.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:opentopic="http://www.idiominc.com/opentopic"
  xmlns:oxy="http://www.oxygenxml.com/extensions/author"
  xmlns:dita2html="http://dita-ot.sourceforge.net/ns/200801/dita2html"
  xmlns:opentopic-index="http://www.idiominc.com/opentopic/index"
  xmlns:ot-placeholder="http://suite-sol.com/namespaces/ot-placeholder"
  xmlns:dita-ot="http://dita-ot.sourceforge.net/ns/201007/dita-ot"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:table="http://dita-ot.sourceforge.net/ns/201007/dita-ot/table"
  
  exclude-result-prefixes="#all">
  
  <xsl:param name="table.title.placement" select="'top'"/>
  <xsl:param name="table.title.repeat" select="'yes'"/>
  
  <!--
    DCP-539 Move the tgroup/@cols attribute on the parent table,
    so it can be used for styling wide tables.
    Extracted from org.dita.html5/xsl/tables.xsl.
  -->
  <xsl:template match="*[contains(@class, ' topic/table ') ]" mode="table:common">
    <xsl:next-match/>
    <xsl:variable name="cols" select="child::*[contains(@class, ' topic/tgroup ') ]/@cols"/>
    <xsl:if test="$cols">
      <xsl:attribute name="data-cols" select="$cols"/>
    </xsl:if>
  </xsl:template>
  
  <!--
    DCP-270 Putting a topic/title class on the caption, so it can be 
    styled together with all other titles from the publication.
  -->
  <xsl:template match="*[contains(@class, ' topic/table ')][child::*[contains(@class, ' topic/title ')]]" mode="table:title">
    <caption class="- topic/title title tablecap">
      <xsl:attribute name="data-caption-side" select="$table.title.placement"/>
      <xsl:if test="$table.title.repeat = 'yes'">
        <xsl:attribute name="data-is-repeated">true</xsl:attribute>
      </xsl:if>
      <xsl:apply-templates select="*[contains(@class, ' topic/title ')]" mode="label"/>
      <xsl:apply-templates select="
        *[contains(@class, ' topic/title ')] | *[contains(@class, ' topic/desc ')]
        "/>
    </caption>
  </xsl:template>

  <xsl:template match="*[contains(@class, ' topic/table ')]/*[contains(@class, ' topic/title ')]" name="topic.table_title">
    <span>
      <xsl:call-template name="commonattributes"/>
      <xsl:call-template name="setid"/>
      <xsl:attribute name="class" select="'table--title'" />
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <!-- DCP-263 The number from the table label is wrapped in a span, so it can be styled from CSS. -->
  <xsl:template match="*[contains(@class, ' topic/table ')]/*[contains(@class, ' topic/title ')]" mode="title-number">
    <xsl:param name="number" as="xs:integer"/>
    
    <xsl:variable name="ancestorlang">
      <xsl:call-template name="getLowerCaseLang"/>
    </xsl:variable>
    
    <!-- 
      DCP-414 Hungarian table titles should be under the form "1. Táblázat"
      Extract from org.dita.html5/xsl/tables.xsl "place-tbl-lbl"
    -->
    <xsl:choose>
      <xsl:when test="$ancestorlang = ('hu', 'hu-hu')">
        <span class="table--title-label-number">
          <xsl:sequence select="$number"/>
        </span>
        <span class="table--title-label-punctuation">
          <xsl:text>. </xsl:text>
        </span>
        <xsl:value-of select="dita-ot:get-variable(., 'Table')"/>
        <xsl:text> </xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="dita-ot:get-variable(., 'Table')"/>
        <span class="table--title-label-number">
          <xsl:text> </xsl:text>
          <xsl:sequence select="$number"/>
        </span>
        <span class="table--title-label-punctuation">
          <xsl:text>. </xsl:text>
        </span>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- 
    WH-1485: Add a wrapper for simple tables, in order to avoid
    wide tables overflowing the topic content area. 
  -->
  <xsl:template match="*[contains(@class, ' topic/simpletable ')]" priority="2">
    <div class="simpletable-container">
      <xsl:next-match/>
    </div>
  </xsl:template>
  
  <!--
  	 DCP-448: Replace 'table:get-entry-colsep' from org.dita.html5/xsl/functions.xsl
  	 To be removed after DITA-OT fix.
   -->
  <xsl:function name="table:get-entry-colsep" as="attribute(colsep)?">
    <xsl:param name="el" as="element()"/>

    <xsl:variable name="colsep-attr" select="
      ($el/@colsep,
       table:get-entry-colspec($el)/@colsep,
       table:get-current-table($el)/@colsep,
       table:get-current-tgroup($el)/@colsep)[1]
    "/>

    <xsl:variable name="colsep">    
      <xsl:for-each select="$el">
        
        <xsl:variable name="x-end">
          <xsl:choose>
            <xsl:when test="@dita-ot:morecols">
              <xsl:value-of select="@dita-ot:x + @dita-ot:morecols"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="@dita-ot:x"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        
        <xsl:variable name="nb-cols" select="ancestor::*[contains(@class, ' topic/tgroup ')][1]/@cols"/>
        
        <xsl:choose>
          <xsl:when test="number($colsep-attr) = 1 and number($x-end) &lt; number($nb-cols)">
            <xsl:sequence>1</xsl:sequence>
          </xsl:when>
          <xsl:otherwise>
            <xsl:sequence>0</xsl:sequence>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:for-each>
    </xsl:variable>
    
    <xsl:attribute name="colsep" select="$colsep"/>
  </xsl:function>
  
  <!--
  	 DCP-448: Replace 'table:get-entry-rowsep' from org.dita.html5/xsl/functions.xsl
  	 To be removed after DITA-OT fix.
   -->
  <xsl:function name="table:get-entry-rowsep" as="attribute(rowsep)?">
    <xsl:param name="el" as="element()"/>
    
    <xsl:variable name="rowsep-attr" select="
      ($el/@rowsep,
      table:get-entry-colspec($el)/@rowsep,
      table:get-current-table($el)/@rowsep,
      table:get-current-tgroup($el)/@rowsep)[1]
      "/>
    
    <xsl:variable name="rowsep">    
      <xsl:for-each select="$el">
        <xsl:variable name="y-end">
          <xsl:choose>
            <xsl:when test="@morerows">
              <xsl:value-of select="@dita-ot:y + @morerows"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="@dita-ot:y"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        
        <xsl:variable name="nb-rows" select="count(../ancestor::node()[contains(@class, ' topic/tgroup ')]//*[contains(@class, ' topic/row ')])"/>
          
        <xsl:choose>
          <xsl:when test="number($rowsep-attr) = 1 and $y-end &lt; $nb-rows">
            <xsl:sequence>1</xsl:sequence>
          </xsl:when>
          <xsl:otherwise>
            <xsl:sequence>0</xsl:sequence>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:for-each>
    </xsl:variable>
    
    <xsl:attribute name="rowsep" select="$rowsep"/>
  </xsl:function>
</xsl:stylesheet>