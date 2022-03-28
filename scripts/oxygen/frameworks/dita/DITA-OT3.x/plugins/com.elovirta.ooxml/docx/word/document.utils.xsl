<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
               xmlns:xs="http://www.w3.org/2001/XMLSchema"
               xmlns:ve="http://schemas.openxmlformats.org/markup-compatibility/2006"
               xmlns:o="urn:schemas-microsoft-com:office:office"
               xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships"
               xmlns:m="http://schemas.openxmlformats.org/officeDocument/2006/math"
               xmlns:v="urn:schemas-microsoft-com:vml"
               xmlns:wp="http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing"
               xmlns:w10="urn:schemas-microsoft-com:office:word"
               xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main"
               xmlns:wne="http://schemas.microsoft.com/office/word/2006/wordml"
               xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main"
               xmlns:pic="http://schemas.openxmlformats.org/drawingml/2006/picture"
               xmlns:opentopic-index="http://www.idiominc.com/opentopic/index"
               xmlns:opentopic="http://www.idiominc.com/opentopic"
               xmlns:ot-placeholder="http://suite-sol.com/namespaces/ot-placeholder"
               xmlns:x="com.elovirta.ooxml"
               exclude-result-prefixes="x xs opentopic opentopic-index ot-placeholder"
               version="2.0">

  <xsl:variable name="msgprefix" select="'DOTX'"/>

  <xsl:param name="template.dir"/>
  <xsl:param name="generate-header-number" select="false()" as="xs:boolean"/>

  <xsl:variable name="map" select="/*[contains(@class, ' map/map ')]/opentopic:map" as="element()"/>

  <xsl:key name="map-id"
    match="opentopic:map//*[@id][empty(ancestor::*[contains(@class, ' map/reltable ')])]"
    use="@id"/>

  <!-- Utilities -->
  
  <xsl:function name="x:parse-dateTime" as="xs:dateTime">
    <xsl:param name="dateTime" as="xs:string"/>
    <xsl:choose>
      <xsl:when test="matches($dateTime, '^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}(\.\d{3})?[-+]\d{4}$')">
        <xsl:sequence select="xs:dateTime(replace($dateTime, '(\d{4})-(\d{2})-(\d{2})T(\d{2}):(\d{2}):(\d{2})(\.\d{3})?([-+]\d{2})(\d{2})', '$1-$2-$3T$4:$5:$6$7$8:$9'))"/>
      </xsl:when>
      <xsl:when test="matches($dateTime, '^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}(\.\d{3})?[-+]\d{2}$')">
        <xsl:sequence select="xs:dateTime(concat($dateTime, ':00'))"/>
      </xsl:when>
      <xsl:when test="matches($dateTime, '^\d{4}-\d{2}-\d{2}$')">
        <xsl:sequence select="xs:dateTime(xs:date($dateTime))"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:sequence select="xs:dateTime($dateTime)"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>
  
  <xsl:function name="x:iso-dateTime" as="xs:string">
    <xsl:param name="dateTime" as="xs:dateTime"/>
    <xsl:value-of select="format-dateTime($dateTime, '[Y0001]-[M01]-[D01]T[H01]:[m01]:[s01][Z00:00t]')"/>
  </xsl:function>
  
  <xsl:function name="x:get-topicref">
    <xsl:param name="topic" as="element()"/>
    <xsl:variable name="id" select="$topic/ancestor-or-self::*[contains(@class, ' topic/topic ')][1]/@id" as="attribute()"/>
    <xsl:sequence select="key('map-id', $id, $map)"/>
  </xsl:function>
  
  <xsl:variable name="styles" select="document(concat($template.dir, 'word/styles.xml'))" as="document-node()?"/>
  
  <xsl:function name="x:get-style-indent" as="xs:integer?">
    <xsl:param name="style" as="xs:string"/>
    <xsl:variable name="left" select="$styles/w:styles/w:style[@w:styleId = $style]/w:pPr/w:ind/@w:left" as="attribute()?"/>
    <xsl:if test="exists($left)">
      <xsl:sequence select="xs:integer($left)"/>
    </xsl:if>
  </xsl:function>
    
  <xsl:variable name="default-dpi" select="96" as="xs:double"/>
  
  <xsl:function name="x:px-to-emu" as="xs:integer">
    <xsl:param name="px" as="xs:double"/>
    <xsl:param name="dpi" as="xs:double?"/>
    <xsl:variable name="d" select="if (exists($dpi)) then $dpi else $default-dpi" as="xs:double"/>
    <xsl:sequence select="if ($px > 0)
                          then xs:integer(round(($px div $d) * 914400))
                          else xs:integer(0)"/>
  </xsl:function>
  
  <!-- Units are English metric units: 1 EMU = 1 div 914400 in = 1 div 360000 cm -->
  <xsl:function name="x:to-emu" as="xs:integer">
    <xsl:param name="length" as="xs:string"/>
    <xsl:param name="dpi" as="xs:double?"/>
    <xsl:variable name="d" select="if (exists($dpi)) then $dpi else $default-dpi" as="xs:double"/>
    <xsl:variable name="value" select="number(translate($length, 'abcdefghijklmnopqrstuvwxyz', ''))"/>
    <xsl:variable name="unit" select="normalize-space(translate($length, '+-0123456789.', ''))"/>
    <xsl:choose>
      <xsl:when test="$unit = 'px' or $unit = ''">
        <xsl:sequence select="xs:integer(round(($value div $d) * 914400))"/>
      </xsl:when>
      <xsl:when test="$unit = 'cm'">
        <xsl:sequence select="xs:integer(round($value * 360000))"/>
      </xsl:when>
      <xsl:when test="$unit = 'mm'">
        <xsl:sequence select="xs:integer(round($value * 36000))"/>
      </xsl:when>
      <xsl:when test="$unit = 'in'">
        <xsl:sequence select="xs:integer(round($value * 914400))"/>
      </xsl:when>
      <xsl:when test="$unit = 'pt'">
        <xsl:sequence select="xs:integer(round($value * 12700))"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:message terminate="yes">ERROR: Unsupported unit "<xsl:value-of select="$unit"/>"</xsl:message>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>
    
  <!-- Test if element can contain only block content -->
  <xsl:function name="x:block-content" as="xs:boolean">
    <xsl:param name="element" as="node()"/>
    <xsl:variable name="class" select="string($element/@class)"/>
    <xsl:sequence select="contains($class, ' topic/body ') or
                          contains($class, ' topic/abstract ') or
                          contains($class, ' topic/pre ') or
                          contains($class, ' topic/note ') or
                          contains($class, ' topic/fig ') or
                          contains($class, ' topic/li ') or
                          contains($class, ' topic/sli ') or
                          (:contains($class, ' topic/dt ') or:)
                          contains($class, ' topic/dd ') or
                          contains($class, ' topic/itemgroup ') or
                          contains($class, ' topic/draft-comment ') or
                          contains($class, ' topic/section ') or
                          contains($class, ' topic/entry ') or
                          contains($class, ' topic/stentry ') or
                          contains($class, ' topic/example ')"/>
    <!--
      contains($class, ' topic/p ') or
      contains($class, ' topic/table ') or
      contains($class, ' topic/simpletable ') or
      contains($class, ' topic/dl ') or
      contains($class, ' topic/sl ') or
      contains($class, ' topic/ol ') or
      contains($class, ' topic/ul ') or
    -->
  </xsl:function>
  
  <!-- Test is element is block -->
  <xsl:function name="x:is-block" as="xs:boolean">
    <xsl:param name="element" as="node()"/>
    <xsl:variable name="class" select="string($element/@class)"/>
    <xsl:sequence select="contains($class, ' topic/body ') or
                          contains($class, ' topic/shortdesc ') or
                          contains($class, ' topic/abstract ') or
                          contains($class, ' topic/title ') or
                          contains($class, ' topic/section ') or 
                          contains($class, ' task/info ') or
                          contains($class, ' topic/p ') or
                          (contains($class, ' topic/image ') and $element/@placement = 'break') or
                          contains($class, ' topic/pre ') or
                          contains($class, ' topic/note ') or
                          contains($class, ' topic/fig ') or
                          contains($class, ' topic/dl ') or
                          contains($class, ' topic/sl ') or
                          contains($class, ' topic/ol ') or
                          contains($class, ' topic/ul ') or
                          contains($class, ' topic/li ') or
                          contains($class, ' topic/sli ') or
                          contains($class, ' topic/itemgroup ') or
                          contains($class, ' topic/section ') or
                          contains($class, ' topic/table ') or
                          contains($class, ' topic/entry ') or
                          contains($class, ' topic/simpletable ') or
                          contains($class, ' topic/stentry ') or
                          contains($class, ' topic/example ')"/>
  </xsl:function>
  
  <!-- bookmark fix-up -->
  
  <xsl:template match="@* | node()" mode="fixup" priority="-1000">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()" mode="fixup"/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="@w:rsidR | @w:rsidRPr | @w:rsidSect"
                mode="fixup" priority="1000"/>
  
  <xsl:template match="w:tc/w:tbl[empty(following-sibling::w:p)]" mode="fixup">
    <xsl:next-match/>
    <!-- generate after table in table because Word requires it -->
    <w:p>
      <w:pPr>
        <w:spacing w:before="0" w:after="0"/>
      </w:pPr>
    </w:p>
  </xsl:template>
  
  <xsl:template match="w:tc[empty(w:p | w:tbl)]" mode="fixup">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()" mode="fixup"/>
      <w:p>
        <w:pPr>
          <w:spacing w:before="0" w:after="0"/>
        </w:pPr>
      </w:p>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="w:body/w:bookmarkStart |
    w:body/w:bookmarkEnd"
    mode="fixup" priority="1000"/>
  
  <xsl:template match="w:bookmarkStart |
    w:bookmarkEnd"
    mode="fixup"
    name="output-bookmark">
    <xsl:param name="bookmarks" as="xs:string*" tunnel="yes"/>
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <xsl:if test="string(@w:id) = $bookmarks">
        <xsl:attribute name="w:id" select="index-of($bookmarks, string(@w:id))"/>
      </xsl:if>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="w:p" mode="fixup" priority="1000">
    <xsl:copy>
      <xsl:apply-templates select="@*" mode="fixup"/>
      <xsl:apply-templates select="w:pPr" mode="fixup"/>
      <xsl:apply-templates select="preceding-sibling::*[1]" mode="fixup.before"/>
      <xsl:apply-templates select="(* | processing-instruction()) except w:pPr" mode="fixup"/>
      <xsl:apply-templates select="following-sibling::*[1]" mode="fixup.after"/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="w:bookmarkStart" mode="fixup.before" priority="10">
    <xsl:call-template name="output-bookmark"/>
    <xsl:apply-templates select="preceding-sibling::*[1]" mode="fixup.before"/>
  </xsl:template>
  <xsl:template match="*" mode="fixup.before"/>
  
  <xsl:template match="w:bookmarkEnd" mode="fixup.after" priority="10">
    <xsl:call-template name="output-bookmark"/>
    <xsl:apply-templates select="following-sibling::*[1]" mode="fixup.after"/>
  </xsl:template>
  <xsl:template match="*" mode="fixup.after"/>
  
  <!-- Whitespace fix-up -->
  
  <xsl:template match="@* | node()" mode="whitespace" priority="-1000">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()" mode="whitespace"/>
    </xsl:copy>
  </xsl:template>
  
  <!-- Collapse whitespace to a single space character -->
  <xsl:template match="w:t" mode="whitespace">
    <xsl:param name="t" select="string(.)" as="xs:string"/>
    <xsl:copy>
      <xsl:apply-templates select="@*" mode="whitespace"/>
      <xsl:variable name="only-whitespace" select="matches($t, '^\s+$')" as="xs:boolean"/>
      <xsl:variable name="has-preceding" as="xs:boolean" select="exists(parent::w:r/preceding-sibling::w:r)"/>
      <xsl:variable name="has-following" as="xs:boolean" select="exists(parent::w:r/following-sibling::w:r)"/>
      <xsl:choose>
        <xsl:when test="$only-whitespace and (not($has-preceding) or not($has-following))"/>
        <xsl:when test="$only-whitespace">
          <xsl:attribute name="xml:space">preserve</xsl:attribute>
          <xsl:text> </xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="starts" select="matches($t, '^\s') and $has-preceding" as="xs:boolean"/>
          <xsl:variable name="ends" select="matches($t, '\s$') and $has-following" as="xs:boolean"/>
          <xsl:if test="$starts or $ends">
            <xsl:attribute name="xml:space">preserve</xsl:attribute>
          </xsl:if>
          <xsl:if test="$starts">
            <xsl:text> </xsl:text>
          </xsl:if>
          <xsl:value-of select="normalize-space($t)"/>
          <xsl:if test="$ends">
            <xsl:text> </xsl:text>
          </xsl:if>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="w:t[@xml:space = 'preserve']" mode="whitespace" priority="10">
    <xsl:copy-of select="."/>
  </xsl:template>

  <xsl:function name="x:generate-id" as="xs:string">
    <xsl:param name="node" as="node()"/>
    <!--xsl:choose>
      <xsl:when test="$node/self::*/@id">
        <xsl:value-of select="$node/@id"/>
      </xsl:when>
      <xsl:otherwise-->
        <xsl:value-of select="generate-id($node)"/>
      <!--/xsl:otherwise>
    </xsl:choose-->
  </xsl:function>

  <!-- PI -->
  
  <xsl:template match="processing-instruction()" mode="x:parse-pi" as="attribute()*">
    <xsl:variable name="regex" as="xs:string">([^\s"]+)="(.+?)"</xsl:variable>
    <xsl:analyze-string select="." regex="{$regex}" flags="ms">
      <xsl:matching-substring>
        <xsl:attribute name="{regex-group(1)}" select="regex-group(2)"/>
      </xsl:matching-substring>
    </xsl:analyze-string>
  </xsl:template>
  
</xsl:stylesheet>
