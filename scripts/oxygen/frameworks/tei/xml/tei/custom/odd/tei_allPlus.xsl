<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<xsl:stylesheet xmlns:dcr="http://www.isocat.org/ns/dcr"
                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                xmlns:rng="http://relaxng.org/ns/structure/1.0"
                xmlns:s="http://www.ascc.net/xml/schematron"
                xmlns:saxon="http://saxon.sf.net/"
                xmlns:sch="http://purl.oclc.org/dsdl/schematron"
                xmlns:schold="http://www.ascc.net/xml/schematron"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:teix="http://www.tei-c.org/ns/Examples"
                xmlns:xhtml="http://www.w3.org/1999/xhtml"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsd="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="2.0"><!--Implementers: please note that overriding process-prolog or process-root is 
    the preferred method for meta-stylesheets to use where possible. -->
   <xsl:param name="archiveDirParameter"/>
   <xsl:param name="archiveNameParameter"/>
   <xsl:param name="fileNameParameter"/>
   <xsl:param name="fileDirParameter"/>
   <xsl:variable name="document-uri">
      <xsl:value-of select="document-uri(/)"/>
   </xsl:variable>
   <!--PHASES-->
   <!--PROLOG-->
   <xsl:output method="text"/>
   <!--XSD TYPES FOR XSLT2-->
   <!--KEYS AND FUNCTIONS-->
   <!--DEFAULT RULES-->
   <!--MODE: SCHEMATRON-SELECT-FULL-PATH-->
   <!--This mode can be used to generate an ugly though full XPath for locators-->
   <xsl:template match="*" mode="schematron-select-full-path">
      <xsl:apply-templates select="." mode="schematron-get-full-path"/>
   </xsl:template>
   <!--MODE: SCHEMATRON-FULL-PATH-->
   <!--This mode can be used to generate an ugly though full XPath for locators-->
   <xsl:template match="*" mode="schematron-get-full-path">
      <xsl:apply-templates select="parent::*" mode="schematron-get-full-path"/>
      <xsl:text>/</xsl:text>
      <xsl:choose>
         <xsl:when test="namespace-uri()=''">
            <xsl:value-of select="name()"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:text>*:</xsl:text>
            <xsl:value-of select="local-name()"/>
            <xsl:text>[namespace-uri()='</xsl:text>
            <xsl:value-of select="namespace-uri()"/>
            <xsl:text>']</xsl:text>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:variable name="preceding"
                    select="count(preceding-sibling::*[local-name()=local-name(current())                                   and namespace-uri() = namespace-uri(current())])"/>
      <xsl:text>[</xsl:text>
      <xsl:value-of select="1+ $preceding"/>
      <xsl:text>]</xsl:text>
   </xsl:template>
   <xsl:template match="@*" mode="schematron-get-full-path">
      <xsl:apply-templates select="parent::*" mode="schematron-get-full-path"/>
      <xsl:text>/</xsl:text>
      <xsl:choose>
         <xsl:when test="namespace-uri()=''">@<xsl:value-of select="name()"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:text>@*[local-name()='</xsl:text>
            <xsl:value-of select="local-name()"/>
            <xsl:text>' and namespace-uri()='</xsl:text>
            <xsl:value-of select="namespace-uri()"/>
            <xsl:text>']</xsl:text>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <!--MODE: SCHEMATRON-FULL-PATH-2-->
   <!--This mode can be used to generate prefixed XPath for humans-->
   <xsl:template match="node() | @*" mode="schematron-get-full-path-2">
      <xsl:for-each select="ancestor-or-self::*">
         <xsl:text>/</xsl:text>
         <xsl:value-of select="name(.)"/>
         <xsl:if test="preceding-sibling::*[name(.)=name(current())]">
            <xsl:text>[</xsl:text>
            <xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1"/>
            <xsl:text>]</xsl:text>
         </xsl:if>
      </xsl:for-each>
      <xsl:if test="not(self::*)">
         <xsl:text/>/@<xsl:value-of select="name(.)"/>
      </xsl:if>
   </xsl:template>
   <!--MODE: SCHEMATRON-FULL-PATH-3-->
   <!--This mode can be used to generate prefixed XPath for humans 
	(Top-level element has index)-->
   <xsl:template match="node() | @*" mode="schematron-get-full-path-3">
      <xsl:for-each select="ancestor-or-self::*">
         <xsl:text>/</xsl:text>
         <xsl:value-of select="name(.)"/>
         <xsl:if test="parent::*">
            <xsl:text>[</xsl:text>
            <xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1"/>
            <xsl:text>]</xsl:text>
         </xsl:if>
      </xsl:for-each>
      <xsl:if test="not(self::*)">
         <xsl:text/>/@<xsl:value-of select="name(.)"/>
      </xsl:if>
   </xsl:template>
   <!--MODE: GENERATE-ID-FROM-PATH -->
   <xsl:template match="/" mode="generate-id-from-path"/>
   <xsl:template match="text()" mode="generate-id-from-path">
      <xsl:apply-templates select="parent::*" mode="generate-id-from-path"/>
      <xsl:value-of select="concat('.text-', 1+count(preceding-sibling::text()), '-')"/>
   </xsl:template>
   <xsl:template match="comment()" mode="generate-id-from-path">
      <xsl:apply-templates select="parent::*" mode="generate-id-from-path"/>
      <xsl:value-of select="concat('.comment-', 1+count(preceding-sibling::comment()), '-')"/>
   </xsl:template>
   <xsl:template match="processing-instruction()" mode="generate-id-from-path">
      <xsl:apply-templates select="parent::*" mode="generate-id-from-path"/>
      <xsl:value-of select="concat('.processing-instruction-', 1+count(preceding-sibling::processing-instruction()), '-')"/>
   </xsl:template>
   <xsl:template match="@*" mode="generate-id-from-path">
      <xsl:apply-templates select="parent::*" mode="generate-id-from-path"/>
      <xsl:value-of select="concat('.@', name())"/>
   </xsl:template>
   <xsl:template match="*" mode="generate-id-from-path" priority="-0.5">
      <xsl:apply-templates select="parent::*" mode="generate-id-from-path"/>
      <xsl:text>.</xsl:text>
      <xsl:value-of select="concat('.',name(),'-',1+count(preceding-sibling::*[name()=name(current())]),'-')"/>
   </xsl:template>
   <!--MODE: GENERATE-ID-2 -->
   <xsl:template match="/" mode="generate-id-2">U</xsl:template>
   <xsl:template match="*" mode="generate-id-2" priority="2">
      <xsl:text>U</xsl:text>
      <xsl:number level="multiple" count="*"/>
   </xsl:template>
   <xsl:template match="node()" mode="generate-id-2">
      <xsl:text>U.</xsl:text>
      <xsl:number level="multiple" count="*"/>
      <xsl:text>n</xsl:text>
      <xsl:number count="node()"/>
   </xsl:template>
   <xsl:template match="@*" mode="generate-id-2">
      <xsl:text>U.</xsl:text>
      <xsl:number level="multiple" count="*"/>
      <xsl:text>_</xsl:text>
      <xsl:value-of select="string-length(local-name(.))"/>
      <xsl:text>_</xsl:text>
      <xsl:value-of select="translate(name(),':','.')"/>
   </xsl:template>
   <!--Strip characters-->
   <xsl:template match="text()" priority="-1"/>
   <!--SCHEMA SETUP-->
   <xsl:template match="/">
      <xsl:apply-templates select="/" mode="M9"/>
      <xsl:apply-templates select="/" mode="M10"/>
      <xsl:apply-templates select="/" mode="M11"/>
      <xsl:apply-templates select="/" mode="M12"/>
      <xsl:apply-templates select="/" mode="M13"/>
      <xsl:apply-templates select="/" mode="M14"/>
      <xsl:apply-templates select="/" mode="M15"/>
      <xsl:apply-templates select="/" mode="M16"/>
      <xsl:apply-templates select="/" mode="M17"/>
      <xsl:apply-templates select="/" mode="M18"/>
      <xsl:apply-templates select="/" mode="M19"/>
      <xsl:apply-templates select="/" mode="M20"/>
      <xsl:apply-templates select="/" mode="M21"/>
      <xsl:apply-templates select="/" mode="M22"/>
      <xsl:apply-templates select="/" mode="M23"/>
      <xsl:apply-templates select="/" mode="M24"/>
      <xsl:apply-templates select="/" mode="M25"/>
      <xsl:apply-templates select="/" mode="M26"/>
      <xsl:apply-templates select="/" mode="M27"/>
      <xsl:apply-templates select="/" mode="M28"/>
      <xsl:apply-templates select="/" mode="M29"/>
      <xsl:apply-templates select="/" mode="M30"/>
      <xsl:apply-templates select="/" mode="M31"/>
      <xsl:apply-templates select="/" mode="M32"/>
      <xsl:apply-templates select="/" mode="M33"/>
      <xsl:apply-templates select="/" mode="M34"/>
      <xsl:apply-templates select="/" mode="M35"/>
      <xsl:apply-templates select="/" mode="M36"/>
      <xsl:apply-templates select="/" mode="M37"/>
      <xsl:apply-templates select="/" mode="M38"/>
      <xsl:apply-templates select="/" mode="M39"/>
      <xsl:apply-templates select="/" mode="M40"/>
      <xsl:apply-templates select="/" mode="M41"/>
      <xsl:apply-templates select="/" mode="M42"/>
      <xsl:apply-templates select="/" mode="M43"/>
      <xsl:apply-templates select="/" mode="M44"/>
      <xsl:apply-templates select="/" mode="M45"/>
      <xsl:apply-templates select="/" mode="M46"/>
      <xsl:apply-templates select="/" mode="M47"/>
      <xsl:apply-templates select="/" mode="M48"/>
      <xsl:apply-templates select="/" mode="M49"/>
      <xsl:apply-templates select="/" mode="M50"/>
      <xsl:apply-templates select="/" mode="M51"/>
      <xsl:apply-templates select="/" mode="M52"/>
      <xsl:apply-templates select="/" mode="M53"/>
      <xsl:apply-templates select="/" mode="M54"/>
      <xsl:apply-templates select="/" mode="M55"/>
      <xsl:apply-templates select="/" mode="M56"/>
      <xsl:apply-templates select="/" mode="M57"/>
      <xsl:apply-templates select="/" mode="M58"/>
      <xsl:apply-templates select="/" mode="M59"/>
      <xsl:apply-templates select="/" mode="M60"/>
      <xsl:apply-templates select="/" mode="M61"/>
      <xsl:apply-templates select="/" mode="M62"/>
      <xsl:apply-templates select="/" mode="M63"/>
      <xsl:apply-templates select="/" mode="M64"/>
      <xsl:apply-templates select="/" mode="M65"/>
      <xsl:apply-templates select="/" mode="M66"/>
      <xsl:apply-templates select="/" mode="M67"/>
      <xsl:apply-templates select="/" mode="M68"/>
      <xsl:apply-templates select="/" mode="M69"/>
      <xsl:apply-templates select="/" mode="M70"/>
      <xsl:apply-templates select="/" mode="M71"/>
      <xsl:apply-templates select="/" mode="M72"/>
      <xsl:apply-templates select="/" mode="M73"/>
      <xsl:apply-templates select="/" mode="M74"/>
      <xsl:apply-templates select="/" mode="M75"/>
      <xsl:apply-templates select="/" mode="M76"/>
      <xsl:apply-templates select="/" mode="M77"/>
      <xsl:apply-templates select="/" mode="M78"/>
      <xsl:apply-templates select="/" mode="M79"/>
      <xsl:apply-templates select="/" mode="M80"/>
      <xsl:apply-templates select="/" mode="M81"/>
      <xsl:apply-templates select="/" mode="M82"/>
      <xsl:apply-templates select="/" mode="M83"/>
      <xsl:apply-templates select="/" mode="M84"/>
      <xsl:apply-templates select="/" mode="M85"/>
      <xsl:apply-templates select="/" mode="M86"/>
      <xsl:apply-templates select="/" mode="M87"/>
      <xsl:apply-templates select="/" mode="M88"/>
      <xsl:apply-templates select="/" mode="M89"/>
      <xsl:apply-templates select="/" mode="M90"/>
      <xsl:apply-templates select="/" mode="M91"/>
      <xsl:apply-templates select="/" mode="M92"/>
      <xsl:apply-templates select="/" mode="M93"/>
      <xsl:apply-templates select="/" mode="M94"/>
      <xsl:apply-templates select="/" mode="M95"/>
      <xsl:apply-templates select="/" mode="M96"/>
      <xsl:apply-templates select="/" mode="M97"/>
      <xsl:apply-templates select="/" mode="M98"/>
      <xsl:apply-templates select="/" mode="M99"/>
      <xsl:apply-templates select="/" mode="M100"/>
      <xsl:apply-templates select="/" mode="M101"/>
      <xsl:apply-templates select="/" mode="M102"/>
      <xsl:apply-templates select="/" mode="M103"/>
      <xsl:apply-templates select="/" mode="M104"/>
      <xsl:apply-templates select="/" mode="M105"/>
      <xsl:apply-templates select="/" mode="M106"/>
      <xsl:apply-templates select="/" mode="M107"/>
      <xsl:apply-templates select="/" mode="M108"/>
      <xsl:apply-templates select="/" mode="M109"/>
      <xsl:apply-templates select="/" mode="M110"/>
      <xsl:apply-templates select="/" mode="M111"/>
      <xsl:apply-templates select="/" mode="M112"/>
      <xsl:apply-templates select="/" mode="M113"/>
      <xsl:apply-templates select="/" mode="M114"/>
      <xsl:apply-templates select="/" mode="M115"/>
      <xsl:apply-templates select="/" mode="M116"/>
      <xsl:apply-templates select="/" mode="M117"/>
   </xsl:template>
   <!--SCHEMATRON PATTERNS-->
   <!--PATTERN schematron-constraint-tei_allPlus-att.datable.w3c-att-datable-w3c-when-1-->
   <!--RULE -->
   <xsl:template match="tei:*[@when]" priority="1000" mode="M9">

		<!--REPORT nonfatal-->
      <xsl:if test="@notBefore|@notAfter|@from|@to">
         <xsl:message>The @when attribute cannot be used with any other att.datable.w3c attributes. (@notBefore|@notAfter|@from|@to / nonfatal)</xsl:message>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M9"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M9"/>
   <xsl:template match="@*|node()" priority="-2" mode="M9">
      <xsl:apply-templates select="*" mode="M9"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_allPlus-att.datable.w3c-att-datable-w3c-from-2-->
   <!--RULE -->
   <xsl:template match="tei:*[@from]" priority="1000" mode="M10">

		<!--REPORT nonfatal-->
      <xsl:if test="@notBefore">
         <xsl:message>The @from and @notBefore attributes cannot be used together. (@notBefore / nonfatal)</xsl:message>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M10"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M10"/>
   <xsl:template match="@*|node()" priority="-2" mode="M10">
      <xsl:apply-templates select="*" mode="M10"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_allPlus-att.datable.w3c-att-datable-w3c-to-3-->
   <!--RULE -->
   <xsl:template match="tei:*[@to]" priority="1000" mode="M11">

		<!--REPORT nonfatal-->
      <xsl:if test="@notAfter">
         <xsl:message>The @to and @notAfter attributes cannot be used together. (@notAfter / nonfatal)</xsl:message>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M11"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M11"/>
   <xsl:template match="@*|node()" priority="-2" mode="M11">
      <xsl:apply-templates select="*" mode="M11"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_allPlus-att.datable-calendar-calendar-4-->
   <!--RULE -->
   <xsl:template match="tei:*[@calendar]" priority="1000" mode="M12">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="string-length(.) gt 0"/>
         <xsl:otherwise>
            <xsl:message> @calendar indicates one or more systems or calendars to
              which the date represented by the content of this element belongs, but this
              <xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/> element has no textual content. (string-length(.) gt 0)</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M12"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M12"/>
   <xsl:template match="@*|node()" priority="-2" mode="M12">
      <xsl:apply-templates select="*" mode="M12"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_allPlus-att.measurement-att-measurement-unitRef-5-->
   <!--RULE -->
   <xsl:template match="tei:*[@unitRef]" priority="1000" mode="M13">

		<!--REPORT info-->
      <xsl:if test="@unit">
         <xsl:message>The @unit attribute may be unnecessary when @unitRef is present. (@unit / info)</xsl:message>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M13"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M13"/>
   <xsl:template match="@*|node()" priority="-2" mode="M13">
      <xsl:apply-templates select="*" mode="M13"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_allPlus-att.typed-subtypeTyped-6-->
   <!--RULE -->
   <xsl:template match="tei:*[@subtype]" priority="1000" mode="M14">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="@type"/>
         <xsl:otherwise>
            <xsl:message>The <xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/> element should not be categorized in detail with @subtype unless also categorized in general with @type (@type)</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M14"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M14"/>
   <xsl:template match="@*|node()" priority="-2" mode="M14">
      <xsl:apply-templates select="*" mode="M14"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_allPlus-att.pointing-targetLang-targetLang-7-->
   <!--RULE -->
   <xsl:template match="tei:*[not(self::tei:schemaSpec)][@targetLang]"
                 priority="1000"
                 mode="M15">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="@target"/>
         <xsl:otherwise>
            <xsl:message>@targetLang should only be used on <xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/> if @target is specified. (@target)</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M15"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M15"/>
   <xsl:template match="@*|node()" priority="-2" mode="M15">
      <xsl:apply-templates select="*" mode="M15"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_allPlus-att.spanning-spanTo-spanTo-2-8-->
   <!--RULE -->
   <xsl:template match="tei:*[@spanTo]" priority="1000" mode="M16">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="id(substring(@spanTo,2)) and following::*[@xml:id=substring(current()/@spanTo,2)]"/>
         <xsl:otherwise>
            <xsl:message>
The element indicated by @spanTo (<xsl:text/>
               <xsl:value-of select="@spanTo"/>
               <xsl:text/>) must follow the current element <xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/>
          (id(substring(@spanTo,2)) and following::*[@xml:id=substring(current()/@spanTo,2)])</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M16"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M16"/>
   <xsl:template match="@*|node()" priority="-2" mode="M16">
      <xsl:apply-templates select="*" mode="M16"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_allPlus-att.styleDef-schemeVersion-schemeVersionRequiresScheme-9-->
   <!--RULE -->
   <xsl:template match="tei:*[@schemeVersion]" priority="1000" mode="M17">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="@scheme and not(@scheme = 'free')"/>
         <xsl:otherwise>
            <xsl:message>
              @schemeVersion can only be used if @scheme is specified.
             (@scheme and not(@scheme = 'free'))</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M17"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M17"/>
   <xsl:template match="@*|node()" priority="-2" mode="M17">
      <xsl:apply-templates select="*" mode="M17"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_allPlus-p-abstractModel-structure-p-10-->
   <!--RULE -->
   <xsl:template match="tei:p" priority="1000" mode="M18">

		<!--REPORT -->
      <xsl:if test="not(ancestor::tei:floatingText) and (ancestor::tei:p or ancestor::tei:ab)          and not(parent::tei:exemplum                |parent::tei:item                |parent::tei:note                |parent::tei:q                |parent::tei:quote                |parent::tei:remarks                |parent::tei:said                |parent::tei:sp                |parent::tei:stage                |parent::tei:cell                |parent::tei:figure                )">
         <xsl:message>
        Abstract model violation: Paragraphs may not occur inside other paragraphs or ab elements.
       (not(ancestor::tei:floatingText) and (ancestor::tei:p or ancestor::tei:ab) and not(parent::tei:exemplum |parent::tei:item |parent::tei:note |parent::tei:q |parent::tei:quote |parent::tei:remarks |parent::tei:said |parent::tei:sp |parent::tei:stage |parent::tei:cell |parent::tei:figure ))</xsl:message>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M18"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M18"/>
   <xsl:template match="@*|node()" priority="-2" mode="M18">
      <xsl:apply-templates select="*" mode="M18"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_allPlus-p-abstractModel-structure-l-11-->
   <!--RULE -->
   <xsl:template match="tei:p" priority="1000" mode="M19">

		<!--REPORT -->
      <xsl:if test="(ancestor::tei:l or ancestor::tei:lg) and not(parent::tei:figure or parent::tei:note or ancestor::tei:floatingText)">
         <xsl:message>
        Abstract model violation: Lines may not contain higher-level structural elements such as div, p, or ab, unless p is a child of figure or note, or is a descendant of floatingText.
       ((ancestor::tei:l or ancestor::tei:lg) and not(parent::tei:figure or parent::tei:note or ancestor::tei:floatingText))</xsl:message>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M19"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M19"/>
   <xsl:template match="@*|node()" priority="-2" mode="M19">
      <xsl:apply-templates select="*" mode="M19"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_allPlus-desc-deprecationInfo-only-in-deprecated-12-->
   <!--RULE -->
   <xsl:template match="tei:desc[ @type eq 'deprecationInfo']"
                 priority="1000"
                 mode="M20">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="../@validUntil"/>
         <xsl:otherwise>
            <xsl:message>Information about a
        deprecation should only be present in a specification element
        that is being deprecated: that is, only an element that has a
        @validUntil attribute should have a child &lt;desc
        type="deprecationInfo"&gt;. (../@validUntil)</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M20"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M20"/>
   <xsl:template match="@*|node()" priority="-2" mode="M20">
      <xsl:apply-templates select="*" mode="M20"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_allPlus-rt-target-rt-target-not-span-13-->
   <!--RULE -->
   <xsl:template match="tei:rt/@target" priority="1000" mode="M21">

		<!--REPORT -->
      <xsl:if test="../@from | ../@to">
         <xsl:message>When target= is
            present, neither from= nor to= should be. (../@from | ../@to)</xsl:message>
      </xsl:if>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M21"/>
   <xsl:template match="@*|node()" priority="-2" mode="M21">
      <xsl:apply-templates select="*" mode="M21"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_allPlus-rt-from-rt-from-14-->
   <!--RULE -->
   <xsl:template match="tei:rt/@from" priority="1000" mode="M22">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="../@to"/>
         <xsl:otherwise>
            <xsl:message>When from= is present, the to=
            attribute of <xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/> is required. (../@to)</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M22"/>
   <xsl:template match="@*|node()" priority="-2" mode="M22">
      <xsl:apply-templates select="*" mode="M22"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_allPlus-rt-to-rt-to-15-->
   <!--RULE -->
   <xsl:template match="tei:rt/@to" priority="1000" mode="M23">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="../@from"/>
         <xsl:otherwise>
            <xsl:message>When to= is present, the from=
            attribute of <xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/> is required. (../@from)</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M23"/>
   <xsl:template match="@*|node()" priority="-2" mode="M23">
      <xsl:apply-templates select="*" mode="M23"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_allPlus-ptr-ptrAtts-16-->
   <!--RULE -->
   <xsl:template match="tei:ptr" priority="1000" mode="M24">

		<!--REPORT -->
      <xsl:if test="@target and @cRef">
         <xsl:message>Only one of the
attributes @target and @cRef may be supplied on <xsl:text/>
            <xsl:value-of select="name(.)"/>
            <xsl:text/>. (@target and @cRef)</xsl:message>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M24"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M24"/>
   <xsl:template match="@*|node()" priority="-2" mode="M24">
      <xsl:apply-templates select="*" mode="M24"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_allPlus-ref-refAtts-17-->
   <!--RULE -->
   <xsl:template match="tei:ref" priority="1000" mode="M25">

		<!--REPORT -->
      <xsl:if test="@target and @cRef">
         <xsl:message>Only one of the
	attributes @target' and @cRef' may be supplied on <xsl:text/>
            <xsl:value-of select="name(.)"/>
            <xsl:text/>
          (@target and @cRef)</xsl:message>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M25"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M25"/>
   <xsl:template match="@*|node()" priority="-2" mode="M25">
      <xsl:apply-templates select="*" mode="M25"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_allPlus-list-gloss-list-must-have-labels-18-->
   <!--RULE -->
   <xsl:template match="tei:list[@type='gloss']" priority="1000" mode="M26">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="tei:label"/>
         <xsl:otherwise>
            <xsl:message>The content of a "gloss" list should include a sequence of one or more pairs of a label element followed by an item element (tei:label)</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M26"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M26"/>
   <xsl:template match="@*|node()" priority="-2" mode="M26">
      <xsl:apply-templates select="*" mode="M26"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_allPlus-relatedItem-targetorcontent1-19-->
   <!--RULE -->
   <xsl:template match="tei:relatedItem" priority="1000" mode="M27">

		<!--REPORT -->
      <xsl:if test="@target and count( child::* ) &gt; 0">
         <xsl:message>
If the @target attribute on <xsl:text/>
            <xsl:value-of select="name(.)"/>
            <xsl:text/> is used, the
relatedItem element must be empty (@target and count( child::* ) &gt; 0)</xsl:message>
      </xsl:if>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="@target or child::*"/>
         <xsl:otherwise>
            <xsl:message>A relatedItem element should have either a 'target' attribute
        or a child element to indicate the related bibliographic item (@target or child::*)</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M27"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M27"/>
   <xsl:template match="@*|node()" priority="-2" mode="M27">
      <xsl:apply-templates select="*" mode="M27"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_allPlus-l-abstractModel-structure-l-20-->
   <!--RULE -->
   <xsl:template match="tei:l" priority="1000" mode="M28">

		<!--REPORT -->
      <xsl:if test="ancestor::tei:l[not(.//tei:note//tei:l[. = current()])]">
         <xsl:message>
        Abstract model violation: Lines may not contain lines or lg elements.
       (ancestor::tei:l[not(.//tei:note//tei:l[. = current()])])</xsl:message>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M28"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M28"/>
   <xsl:template match="@*|node()" priority="-2" mode="M28">
      <xsl:apply-templates select="*" mode="M28"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_allPlus-lg-atleast1oflggapl-21-->
   <!--RULE -->
   <xsl:template match="tei:lg" priority="1000" mode="M29">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="count(descendant::tei:lg|descendant::tei:l|descendant::tei:gap) &gt; 0"/>
         <xsl:otherwise>
            <xsl:message>An lg element
        must contain at least one child l, lg, or gap element. (count(descendant::tei:lg|descendant::tei:l|descendant::tei:gap) &gt; 0)</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M29"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M29"/>
   <xsl:template match="@*|node()" priority="-2" mode="M29">
      <xsl:apply-templates select="*" mode="M29"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_allPlus-lg-abstractModel-structure-l-22-->
   <!--RULE -->
   <xsl:template match="tei:lg" priority="1000" mode="M30">

		<!--REPORT -->
      <xsl:if test="ancestor::tei:l[not(.//tei:note//tei:lg[. = current()])]">
         <xsl:message>
        Abstract model violation: Lines may not contain line groups.
       (ancestor::tei:l[not(.//tei:note//tei:lg[. = current()])])</xsl:message>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M30"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M30"/>
   <xsl:template match="@*|node()" priority="-2" mode="M30">
      <xsl:apply-templates select="*" mode="M30"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_allPlus-quotation-quotationContents-23-->
   <!--RULE -->
   <xsl:template match="tei:quotation" priority="1000" mode="M31">

		<!--REPORT -->
      <xsl:if test="not(@marks) and not (tei:p)">
         <xsl:message>
On <xsl:text/>
            <xsl:value-of select="name(.)"/>
            <xsl:text/>, either the @marks attribute should be used, or a paragraph of description provided (not(@marks) and not (tei:p))</xsl:message>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M31"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M31"/>
   <xsl:template match="@*|node()" priority="-2" mode="M31">
      <xsl:apply-templates select="*" mode="M31"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_allPlus-citeStructure-delim-citestructure-inner-delim-24-->
   <!--RULE -->
   <xsl:template match="tei:citeStructure[parent::tei:citeStructure]"
                 priority="1000"
                 mode="M32">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="@delim"/>
         <xsl:otherwise>
            <xsl:message>A <xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/> with a parent <xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/> must have a @delim attribute. (@delim)</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M32"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M32"/>
   <xsl:template match="@*|node()" priority="-2" mode="M32">
      <xsl:apply-templates select="*" mode="M32"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_allPlus-citeStructure-match-citestructure-outer-match-25-->
   <!--RULE -->
   <xsl:template match="tei:citeStructure[not(parent::tei:citeStructure)]"
                 priority="1000"
                 mode="M33">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="starts-with(@match,'/')"/>
         <xsl:otherwise>
            <xsl:message>An XPath in @match on the outer <xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/> must start with '/'. (starts-with(@match,'/'))</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M33"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M33"/>
   <xsl:template match="@*|node()" priority="-2" mode="M33">
      <xsl:apply-templates select="*" mode="M33"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_allPlus-citeStructure-match-citestructure-inner-match-26-->
   <!--RULE -->
   <xsl:template match="tei:citeStructure[parent::tei:citeStructure]"
                 priority="1000"
                 mode="M34">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="not(starts-with(@match,'/'))"/>
         <xsl:otherwise>
            <xsl:message>An XPath in @match must not start with '/' except on the outer <xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/>. (not(starts-with(@match,'/')))</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M34"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M34"/>
   <xsl:template match="@*|node()" priority="-2" mode="M34">
      <xsl:apply-templates select="*" mode="M34"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_allPlus-div-abstractModel-structure-l-29-->
   <!--RULE -->
   <xsl:template match="tei:div" priority="1000" mode="M35">

		<!--REPORT -->
      <xsl:if test="(ancestor::tei:l or ancestor::tei:lg) and not(ancestor::tei:floatingText)">
         <xsl:message>
        Abstract model violation: Lines may not contain higher-level structural elements such as div, unless div is a descendant of floatingText.
       ((ancestor::tei:l or ancestor::tei:lg) and not(ancestor::tei:floatingText))</xsl:message>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M35"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M35"/>
   <xsl:template match="@*|node()" priority="-2" mode="M35">
      <xsl:apply-templates select="*" mode="M35"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_allPlus-div-abstractModel-structure-p-30-->
   <!--RULE -->
   <xsl:template match="tei:div" priority="1000" mode="M36">

		<!--REPORT -->
      <xsl:if test="(ancestor::tei:p or ancestor::tei:ab) and not(ancestor::tei:floatingText)">
         <xsl:message>
        Abstract model violation: p and ab may not contain higher-level structural elements such as div, unless div is a descendant of floatingText.
       ((ancestor::tei:p or ancestor::tei:ab) and not(ancestor::tei:floatingText))</xsl:message>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M36"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M36"/>
   <xsl:template match="@*|node()" priority="-2" mode="M36">
      <xsl:apply-templates select="*" mode="M36"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_allPlus-shift-shiftNew-31-->
   <!--RULE -->
   <xsl:template match="tei:shift" priority="1000" mode="M37">

		<!--ASSERT warning-->
      <xsl:choose>
         <xsl:when test="@new"/>
         <xsl:otherwise>
            <xsl:message>              
The @new attribute should always be supplied; use the special value
"normal" to indicate that the feature concerned ceases to be
remarkable at this point. (@new / warning)</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M37"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M37"/>
   <xsl:template match="@*|node()" priority="-2" mode="M37">
      <xsl:apply-templates select="*" mode="M37"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_allPlus-catchwords-catchword_in_msDesc-32-->
   <!--RULE -->
   <xsl:template match="tei:catchwords" priority="1000" mode="M38">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="ancestor::tei:msDesc or ancestor::tei:egXML"/>
         <xsl:otherwise>
            <xsl:message>The <xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/> element should not be used outside of msDesc. (ancestor::tei:msDesc or ancestor::tei:egXML)</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M38"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M38"/>
   <xsl:template match="@*|node()" priority="-2" mode="M38">
      <xsl:apply-templates select="*" mode="M38"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_allPlus-dimensions-duplicateDim-33-->
   <!--RULE -->
   <xsl:template match="tei:dimensions" priority="1000" mode="M39">

		<!--REPORT -->
      <xsl:if test="count(tei:width)&gt; 1">
         <xsl:message>
The element <xsl:text/>
            <xsl:value-of select="name(.)"/>
            <xsl:text/> may appear once only
       (count(tei:width)&gt; 1)</xsl:message>
      </xsl:if>
      <!--REPORT -->
      <xsl:if test="count(tei:height)&gt; 1">
         <xsl:message>
The element <xsl:text/>
            <xsl:value-of select="name(.)"/>
            <xsl:text/> may appear once only
       (count(tei:height)&gt; 1)</xsl:message>
      </xsl:if>
      <!--REPORT -->
      <xsl:if test="count(tei:depth)&gt; 1">
         <xsl:message>
The element <xsl:text/>
            <xsl:value-of select="name(.)"/>
            <xsl:text/> may appear once only
       (count(tei:depth)&gt; 1)</xsl:message>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M39"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M39"/>
   <xsl:template match="@*|node()" priority="-2" mode="M39">
      <xsl:apply-templates select="*" mode="M39"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_allPlus-secFol-secFol_in_msDesc-34-->
   <!--RULE -->
   <xsl:template match="tei:secFol" priority="1000" mode="M40">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="ancestor::tei:msDesc or ancestor::tei:egXML"/>
         <xsl:otherwise>
            <xsl:message>The <xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/> element should not be used outside of msDesc. (ancestor::tei:msDesc or ancestor::tei:egXML)</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M40"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M40"/>
   <xsl:template match="@*|node()" priority="-2" mode="M40">
      <xsl:apply-templates select="*" mode="M40"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_allPlus-signatures-signatures_in_msDesc-35-->
   <!--RULE -->
   <xsl:template match="tei:signatures" priority="1000" mode="M41">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="ancestor::tei:msDesc or ancestor::tei:egXML"/>
         <xsl:otherwise>
            <xsl:message>The <xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/> element should not be used outside of msDesc. (ancestor::tei:msDesc or ancestor::tei:egXML)</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M41"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M41"/>
   <xsl:template match="@*|node()" priority="-2" mode="M41">
      <xsl:apply-templates select="*" mode="M41"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_allPlus-msIdentifier-msId_minimal-36-->
   <!--RULE -->
   <xsl:template match="tei:msIdentifier" priority="1000" mode="M42">

		<!--REPORT -->
      <xsl:if test="not(parent::tei:msPart) and (local-name(*[1])='idno' or local-name(*[1])='altIdentifier' or normalize-space(.)='')">
         <xsl:message>An msIdentifier must contain either a repository or location. (not(parent::tei:msPart) and (local-name(*[1])='idno' or local-name(*[1])='altIdentifier' or normalize-space(.)=''))</xsl:message>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M42"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M42"/>
   <xsl:template match="@*|node()" priority="-2" mode="M42">
      <xsl:apply-templates select="*" mode="M42"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_allPlus-path-pathmustnotbeclosed-37-->
   <!--RULE -->
   <xsl:template match="tei:path[@points]" priority="1000" mode="M43">
      <xsl:variable name="firstPair" select="tokenize( normalize-space( @points ), ' ')[1]"/>
      <xsl:variable name="lastPair"
                    select="tokenize( normalize-space( @points ), ' ')[last()]"/>
      <xsl:variable name="firstX" select="xs:float( substring-before( $firstPair, ',') )"/>
      <xsl:variable name="firstY" select="xs:float( substring-after( $firstPair, ',') )"/>
      <xsl:variable name="lastX" select="xs:float( substring-before( $lastPair, ',') )"/>
      <xsl:variable name="lastY" select="xs:float( substring-after( $lastPair, ',') )"/>
      <!--REPORT -->
      <xsl:if test="$firstX eq $lastX  and  $firstY eq $lastY">
         <xsl:message>The first and
          last elements of this path are the same. To specify a closed polygon, use
          the zone element rather than the path element.  ($firstX eq $lastX and $firstY eq $lastY)</xsl:message>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M43"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M43"/>
   <xsl:template match="@*|node()" priority="-2" mode="M43">
      <xsl:apply-templates select="*" mode="M43"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_allPlus-addSpan-spanTo-38-->
   <!--RULE -->
   <xsl:template match="tei:addSpan" priority="1000" mode="M44">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="@spanTo"/>
         <xsl:otherwise>
            <xsl:message>The @spanTo attribute of <xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/> is required. (@spanTo)</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M44"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M44"/>
   <xsl:template match="@*|node()" priority="-2" mode="M44">
      <xsl:apply-templates select="*" mode="M44"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_allPlus-damageSpan-spanTo-40-->
   <!--RULE -->
   <xsl:template match="tei:damageSpan" priority="1000" mode="M45">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="@spanTo"/>
         <xsl:otherwise>
            <xsl:message>
The @spanTo attribute of <xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/> is required. (@spanTo)</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M45"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M45"/>
   <xsl:template match="@*|node()" priority="-2" mode="M45">
      <xsl:apply-templates select="*" mode="M45"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_allPlus-delSpan-spanTo-42-->
   <!--RULE -->
   <xsl:template match="tei:delSpan" priority="1000" mode="M46">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="@spanTo"/>
         <xsl:otherwise>
            <xsl:message>The @spanTo attribute of <xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/> is required. (@spanTo)</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M46"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M46"/>
   <xsl:template match="@*|node()" priority="-2" mode="M46">
      <xsl:apply-templates select="*" mode="M46"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_allPlus-subst-substContents1-44-->
   <!--RULE -->
   <xsl:template match="tei:subst" priority="1000" mode="M47">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="child::tei:add and (child::tei:del or child::tei:surplus)"/>
         <xsl:otherwise>
            <xsl:message>
               <xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/> must have at least one child add and at least one child del or surplus (child::tei:add and (child::tei:del or child::tei:surplus))</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M47"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M47"/>
   <xsl:template match="@*|node()" priority="-2" mode="M47">
      <xsl:apply-templates select="*" mode="M47"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_allPlus-rdgGrp-only1lem-45-->
   <!--RULE -->
   <xsl:template match="tei:rdgGrp" priority="1000" mode="M48">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="count(tei:lem) &lt; 2"/>
         <xsl:otherwise>
            <xsl:message>Only one &lt;lem&gt; element may appear within a &lt;rdgGrp&gt; (count(tei:lem) &lt; 2)</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M48"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M48"/>
   <xsl:template match="@*|node()" priority="-2" mode="M48">
      <xsl:apply-templates select="*" mode="M48"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_allPlus-variantEncoding-location-variantEncodingLocation-46-->
   <!--RULE -->
   <xsl:template match="tei:variantEncoding" priority="1000" mode="M49">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="(@location != 'external') or (@method != 'parallel-segmentation')"/>
         <xsl:otherwise>
            <xsl:message>
              The @location value "external" is inconsistent with the
              parallel-segmentation method of apparatus markup. ((@location != 'external') or (@method != 'parallel-segmentation'))</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M49"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M49"/>
   <xsl:template match="@*|node()" priority="-2" mode="M49">
      <xsl:apply-templates select="*" mode="M49"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_allPlus-relation-reforkeyorname-47-->
   <!--RULE -->
   <xsl:template match="tei:relation" priority="1000" mode="M50">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="@ref or @key or @name"/>
         <xsl:otherwise>
            <xsl:message>One of the attributes  'name', 'ref' or 'key' must be supplied (@ref or @key or @name)</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M50"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M50"/>
   <xsl:template match="@*|node()" priority="-2" mode="M50">
      <xsl:apply-templates select="*" mode="M50"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_allPlus-relation-activemutual-48-->
   <!--RULE -->
   <xsl:template match="tei:relation" priority="1000" mode="M51">

		<!--REPORT -->
      <xsl:if test="@active and @mutual">
         <xsl:message>Only one of the attributes @active and @mutual may be supplied (@active and @mutual)</xsl:message>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M51"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M51"/>
   <xsl:template match="@*|node()" priority="-2" mode="M51">
      <xsl:apply-templates select="*" mode="M51"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_allPlus-relation-activepassive-49-->
   <!--RULE -->
   <xsl:template match="tei:relation" priority="1000" mode="M52">

		<!--REPORT -->
      <xsl:if test="@passive and not(@active)">
         <xsl:message>the attribute 'passive' may be supplied only if the attribute 'active' is supplied (@passive and not(@active))</xsl:message>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M52"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M52"/>
   <xsl:template match="@*|node()" priority="-2" mode="M52">
      <xsl:apply-templates select="*" mode="M52"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_allPlus-objectIdentifier-objectIdentifier_minimal-50-->
   <!--RULE -->
   <xsl:template match="tei:objectIdentifier" priority="1000" mode="M53">

		<!--REPORT -->
      <xsl:if test="not(count(*) gt 0)">
         <xsl:message>An objectIdentifier must contain at minimum a single piece of locating or identifying information. (not(count(*) gt 0))</xsl:message>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M53"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M53"/>
   <xsl:template match="@*|node()" priority="-2" mode="M53">
      <xsl:apply-templates select="*" mode="M53"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_allPlus-link-linkTargets3-51-->
   <!--RULE -->
   <xsl:template match="tei:link" priority="1000" mode="M54">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="contains(normalize-space(@target),' ')"/>
         <xsl:otherwise>
            <xsl:message>You must supply at least two values for @target or  on <xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/>
          (contains(normalize-space(@target),' '))</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M54"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M54"/>
   <xsl:template match="@*|node()" priority="-2" mode="M54">
      <xsl:apply-templates select="*" mode="M54"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_allPlus-ab-abstractModel-structure-ab-52-->
   <!--RULE -->
   <xsl:template match="tei:ab" priority="1000" mode="M55">

		<!--REPORT -->
      <xsl:if test="not(ancestor::tei:floatingText) and (ancestor::tei:p or ancestor::tei:ab)          and not(parent::tei:exemplum         |parent::tei:item         |parent::tei:note         |parent::tei:q         |parent::tei:quote         |parent::tei:remarks         |parent::tei:said         |parent::tei:sp         |parent::tei:stage         |parent::tei:cell         |parent::tei:figure)">
         <xsl:message>
        Abstract model violation: ab may not occur inside paragraphs or other ab elements.
       (not(ancestor::tei:floatingText) and (ancestor::tei:p or ancestor::tei:ab) and not(parent::tei:exemplum |parent::tei:item |parent::tei:note |parent::tei:q |parent::tei:quote |parent::tei:remarks |parent::tei:said |parent::tei:sp |parent::tei:stage |parent::tei:cell |parent::tei:figure))</xsl:message>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M55"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M55"/>
   <xsl:template match="@*|node()" priority="-2" mode="M55">
      <xsl:apply-templates select="*" mode="M55"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_allPlus-ab-abstractModel-structure-l-53-->
   <!--RULE -->
   <xsl:template match="tei:ab" priority="1000" mode="M56">

		<!--REPORT -->
      <xsl:if test="(ancestor::tei:l or ancestor::tei:lg) and not(parent::tei:figure or parent::tei:note or ancestor::tei:floatingText)">
         <xsl:message>
        Abstract model violation: Lines may not contain higher-level divisions such as p or ab, unless ab is a child of figure or note, or is a descendant of floatingText.
       ((ancestor::tei:l or ancestor::tei:lg) and not(parent::tei:figure or parent::tei:note or ancestor::tei:floatingText))</xsl:message>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M56"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M56"/>
   <xsl:template match="@*|node()" priority="-2" mode="M56">
      <xsl:apply-templates select="*" mode="M56"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_allPlus-join-joinTargets3-54-->
   <!--RULE -->
   <xsl:template match="tei:join" priority="1000" mode="M57">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="contains(@target,' ')"/>
         <xsl:otherwise>
            <xsl:message>
You must supply at least two values for @target on <xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/>
          (contains(@target,' '))</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M57"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M57"/>
   <xsl:template match="@*|node()" priority="-2" mode="M57">
      <xsl:apply-templates select="*" mode="M57"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_allPlus-standOff-nested_standOff_should_be_typed-55-->
   <!--RULE -->
   <xsl:template match="tei:standOff" priority="1000" mode="M58">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="@type or not(ancestor::tei:standOff)"/>
         <xsl:otherwise>
            <xsl:message>This
      <xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/> element must have a @type attribute, since it is
      nested inside a <xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/>
          (@type or not(ancestor::tei:standOff))</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M58"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M58"/>
   <xsl:template match="@*|node()" priority="-2" mode="M58">
      <xsl:apply-templates select="*" mode="M58"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_allPlus-s-noNestedS-56-->
   <!--RULE -->
   <xsl:template match="tei:s" priority="1000" mode="M59">

		<!--REPORT -->
      <xsl:if test="tei:s">
         <xsl:message>You may not nest one s element within
      another: use seg instead (tei:s)</xsl:message>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M59"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M59"/>
   <xsl:template match="@*|node()" priority="-2" mode="M59">
      <xsl:apply-templates select="*" mode="M59"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_allPlus-span-targetfrom-57-->
   <!--RULE -->
   <xsl:template match="tei:span" priority="1000" mode="M60">

		<!--REPORT -->
      <xsl:if test="@from and @target">
         <xsl:message>
Only one of the attributes @target and @from may be supplied on <xsl:text/>
            <xsl:value-of select="name(.)"/>
            <xsl:text/>
          (@from and @target)</xsl:message>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M60"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M60"/>
   <xsl:template match="@*|node()" priority="-2" mode="M60">
      <xsl:apply-templates select="*" mode="M60"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_allPlus-span-targetto-58-->
   <!--RULE -->
   <xsl:template match="tei:span" priority="1000" mode="M61">

		<!--REPORT -->
      <xsl:if test="@to and @target">
         <xsl:message>
Only one of the attributes @target and @to may be supplied on <xsl:text/>
            <xsl:value-of select="name(.)"/>
            <xsl:text/>
          (@to and @target)</xsl:message>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M61"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M61"/>
   <xsl:template match="@*|node()" priority="-2" mode="M61">
      <xsl:apply-templates select="*" mode="M61"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_allPlus-span-tonotfrom-59-->
   <!--RULE -->
   <xsl:template match="tei:span" priority="1000" mode="M62">

		<!--REPORT -->
      <xsl:if test="@to and not(@from)">
         <xsl:message>
If @to is supplied on <xsl:text/>
            <xsl:value-of select="name(.)"/>
            <xsl:text/>, @from must be supplied as well (@to and not(@from))</xsl:message>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M62"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M62"/>
   <xsl:template match="@*|node()" priority="-2" mode="M62">
      <xsl:apply-templates select="*" mode="M62"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_allPlus-span-tofrom-60-->
   <!--RULE -->
   <xsl:template match="tei:span" priority="1000" mode="M63">

		<!--REPORT -->
      <xsl:if test="contains(normalize-space(@to),' ') or contains(normalize-space(@from),' ')">
         <xsl:message>
The attributes @to and @from on <xsl:text/>
            <xsl:value-of select="name(.)"/>
            <xsl:text/> may each contain only a single value (contains(normalize-space(@to),' ') or contains(normalize-space(@from),' '))</xsl:message>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M63"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M63"/>
   <xsl:template match="@*|node()" priority="-2" mode="M63">
      <xsl:apply-templates select="*" mode="M63"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_allPlus-att.repeatable-MINandMAXoccurs-61-->
   <!--RULE -->
   <xsl:template match="*[ @minOccurs  and  @maxOccurs ]" priority="1001" mode="M64">
      <xsl:variable name="min" select="@minOccurs cast as xs:integer"/>
      <xsl:variable name="max"
                    select="if ( normalize-space( @maxOccurs ) eq 'unbounded')                         then -1                         else @maxOccurs cast as xs:integer"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="$max eq -1  or  $max ge $min"/>
         <xsl:otherwise>
            <xsl:message>@maxOccurs should be greater than or equal to @minOccurs ($max eq -1 or $max ge $min)</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M64"/>
   </xsl:template>
   <!--RULE -->
   <xsl:template match="*[ @minOccurs  and  not( @maxOccurs ) ]"
                 priority="1000"
                 mode="M64">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="@minOccurs cast as xs:integer lt 2"/>
         <xsl:otherwise>
            <xsl:message>When @maxOccurs is not specified, @minOccurs must be 0 or 1 (@minOccurs cast as xs:integer lt 2)</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M64"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M64"/>
   <xsl:template match="@*|node()" priority="-2" mode="M64">
      <xsl:apply-templates select="*" mode="M64"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_allPlus-att.identified-spec-in-module-62-->
   <!--RULE -->
   <xsl:template match="tei:elementSpec[@module]|tei:classSpec[@module]|tei:macroSpec[@module]"
                 priority="1000"
                 mode="M65">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="         (not(ancestor::tei:schemaSpec | ancestor::tei:TEI | ancestor::tei:teiCorpus)) or         (not(@module) or          (not(//tei:moduleSpec) and not(//tei:moduleRef))  or         (//tei:moduleSpec[@ident = current()/@module]) or          (//tei:moduleRef[@key = current()/@module]))         "/>
         <xsl:otherwise>
            <xsl:message>
        Specification <xsl:text/>
               <xsl:value-of select="@ident"/>
               <xsl:text/>: the value of the module attribute ("<xsl:text/>
               <xsl:value-of select="@module"/>
               <xsl:text/>") 
should correspond to an existing module, via a moduleSpec or
      moduleRef ((not(ancestor::tei:schemaSpec | ancestor::tei:TEI | ancestor::tei:teiCorpus)) or (not(@module) or (not(//tei:moduleSpec) and not(//tei:moduleRef)) or (//tei:moduleSpec[@ident = current()/@module]) or (//tei:moduleRef[@key = current()/@module])))</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M65"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M65"/>
   <xsl:template match="@*|node()" priority="-2" mode="M65">
      <xsl:apply-templates select="*" mode="M65"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_allPlus-att.deprecated-validUntil-deprecation-two-month-warning-63-->
   <!--RULE -->
   <xsl:template match="tei:*[@validUntil]" priority="1000" mode="M66">
      <xsl:variable name="advance_warning_period"
                    select="current-date() + xs:dayTimeDuration('P60D')"/>
      <xsl:variable name="me_phrase"
                    select="if (@ident)                                                then concat('The ', @ident )                                                else concat('This ',                                                            local-name(.),                                                            ' of ',                                                            ancestor::tei:*[@ident][1]/@ident )"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="@validUntil cast as xs:date  ge  current-date()"/>
         <xsl:otherwise>
            <xsl:message>
               <xsl:text/>
               <xsl:value-of select="                  concat( $me_phrase,                          ' construct is outdated (as of ',                          @validUntil,                          '); ODD processors may ignore it, and its use is no longer supported'                        )"/>
               <xsl:text/>
          (@validUntil cast as xs:date ge current-date())</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <!--ASSERT nonfatal-->
      <xsl:choose>
         <xsl:when test="@validUntil cast as xs:date  ge  $advance_warning_period"/>
         <xsl:otherwise>
            <xsl:message>
               <xsl:text/>
               <xsl:value-of select="concat( $me_phrase, ' construct becomes outdated on ', @validUntil )"/>
               <xsl:text/>
          (@validUntil cast as xs:date ge $advance_warning_period / nonfatal)</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M66"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M66"/>
   <xsl:template match="@*|node()" priority="-2" mode="M66">
      <xsl:apply-templates select="*" mode="M66"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_allPlus-att.deprecated-validUntil-deprecation-should-be-explained-64-->
   <!--RULE -->
   <xsl:template match="tei:*[@validUntil][ not( self::valDesc | self::valList | self::defaultVal )]"
                 priority="1000"
                 mode="M67">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="child::tei:desc[ @type eq 'deprecationInfo']"/>
         <xsl:otherwise>
            <xsl:message>
              A deprecated construct should include, whenever possible, an explanation, but this <xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/> does not have a child &lt;desc type="deprecationInfo"&gt; (child::tei:desc[ @type eq 'deprecationInfo'])</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M67"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M67"/>
   <xsl:template match="@*|node()" priority="-2" mode="M67">
      <xsl:apply-templates select="*" mode="M67"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_allPlus-moduleRef-modref-65-->
   <!--RULE -->
   <xsl:template match="tei:moduleRef" priority="1000" mode="M68">

		<!--REPORT -->
      <xsl:if test="* and @key">
         <xsl:message>
Child elements of <xsl:text/>
            <xsl:value-of select="name(.)"/>
            <xsl:text/> are only allowed when an external module is being loaded
         (* and @key)</xsl:message>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M68"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M68"/>
   <xsl:template match="@*|node()" priority="-2" mode="M68">
      <xsl:apply-templates select="*" mode="M68"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_allPlus-moduleRef-prefix-not-same-prefix-66-->
   <!--RULE -->
   <xsl:template match="tei:moduleRef" priority="1000" mode="M69">

		<!--REPORT -->
      <xsl:if test="//*[ not( generate-id(.) eq generate-id(      current() ) ) ]/@prefix = @prefix">
         <xsl:message>The prefix attribute
	    of <xsl:text/>
            <xsl:value-of select="name(.)"/>
            <xsl:text/> should not match that of any other
	    element (it would defeat the purpose) (//*[ not( generate-id(.) eq generate-id( current() ) ) ]/@prefix = @prefix)</xsl:message>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M69"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M69"/>
   <xsl:template match="@*|node()" priority="-2" mode="M69">
      <xsl:apply-templates select="*" mode="M69"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_allPlus-schemaSpec-deprecate_schemaSpec_in_bizarre_places-67-->
   <!--RULE -->
   <xsl:template match="tei:schemaSpec|teix:schemaSpec" priority="1000" mode="M70">

		<!--ASSERT nonfatal-->
      <xsl:choose>
         <xsl:when test="             parent::teix:egXML      | parent::tei:encodingDesc  | parent::teix:encodingDesc      | parent::tei:front         | parent::teix:front      | parent::tei:back          | parent::teix:back      | parent::tei:body          | parent::teix:body      | parent::tei:div           | parent::teix:div      | parent::tei:div1          | parent::teix:div1      | parent::tei:div2          | parent::teix:div2      | parent::tei:div3          | parent::teix:div3      | parent::tei:div4          | parent::teix:div4      | parent::tei:div5          | parent::teix:div5      | parent::tei:div6          | parent::teix:div6      | parent::tei:div7          | parent::teix:div7"/>
         <xsl:otherwise>
            <xsl:message>WARNING: use of deprecated construct — the “schemaSpec” element will no longer be a valid child of “<xsl:text/>
               <xsl:value-of select="name(..)"/>
               <xsl:text/>” as of 2021-10-23; instead, it should be a child of “front”, “body”, “back”, “encodingDesc”, or a division element. (parent::teix:egXML | parent::tei:encodingDesc | parent::teix:encodingDesc | parent::tei:front | parent::teix:front | parent::tei:back | parent::teix:back | parent::tei:body | parent::teix:body | parent::tei:div | parent::teix:div | parent::tei:div1 | parent::teix:div1 | parent::tei:div2 | parent::teix:div2 | parent::tei:div3 | parent::teix:div3 | parent::tei:div4 | parent::teix:div4 | parent::tei:div5 | parent::teix:div5 | parent::tei:div6 | parent::teix:div6 | parent::tei:div7 | parent::teix:div7 / nonfatal)</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M70"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M70"/>
   <xsl:template match="@*|node()" priority="-2" mode="M70">
      <xsl:apply-templates select="*" mode="M70"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_allPlus-elementSpec-child-constraint-based-on-mode-68-->
   <!--RULE -->
   <xsl:template match="tei:elementSpec[ @mode eq 'delete' ]"
                 priority="1001"
                 mode="M71">

		<!--REPORT -->
      <xsl:if test="child::*">
         <xsl:message>This elementSpec element has a mode= of "delete" even though it has child elements. Change the mode= to "add", "change", or "replace", or remove the child elements. (child::*)</xsl:message>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M71"/>
   </xsl:template>
   <!--RULE -->
   <xsl:template match="tei:elementSpec[ @mode = ('add','change','replace') ]"
                 priority="1000"
                 mode="M71">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="child::* | (@* except (@mode, @ident))"/>
         <xsl:otherwise>
            <xsl:message>This elementSpec element has a mode= of "<xsl:text/>
               <xsl:value-of select="@mode"/>
               <xsl:text/>", but does not have any child elements or schema-changing attributes. Specify child elements, use validUntil=, predeclare=, ns=, or prefix=, or change the mode= to "delete". (child::* | (@* except (@mode, @ident)))</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M71"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M71"/>
   <xsl:template match="@*|node()" priority="-2" mode="M71">
      <xsl:apply-templates select="*" mode="M71"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_allPlus-model-no_dup_default_models-69-->
   <!--RULE -->
   <xsl:template match="tei:model[ not( parent::tei:modelSequence ) ][ not( @predicate ) ]"
                 priority="1000"
                 mode="M72">
      <xsl:variable name="output" select="normalize-space( @output )"/>
      <!--REPORT -->
      <xsl:if test="following-sibling::tei:model                             [ not( @predicate )]                             [ normalize-space( @output ) eq $output ]">
         <xsl:message>
          There are 2 (or more) 'model' elements in this '<xsl:text/>
            <xsl:value-of select="local-name(..)"/>
            <xsl:text/>'
          that have no predicate, but are targeted to the same output
          ("<xsl:text/>
            <xsl:value-of select="( $output, parent::modelGrp/@output, 'all')[1]"/>
            <xsl:text/>") (following-sibling::tei:model [ not( @predicate )] [ normalize-space( @output ) eq $output ])</xsl:message>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M72"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M72"/>
   <xsl:template match="@*|node()" priority="-2" mode="M72">
      <xsl:apply-templates select="*" mode="M72"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_allPlus-model-no_dup_models-70-->
   <!--RULE -->
   <xsl:template match="tei:model[ not( parent::tei:modelSequence ) ][ @predicate ]"
                 priority="1000"
                 mode="M73">
      <xsl:variable name="predicate" select="normalize-space( @predicate )"/>
      <xsl:variable name="output" select="normalize-space( @output )"/>
      <!--REPORT -->
      <xsl:if test="following-sibling::tei:model                             [ normalize-space( @predicate ) eq $predicate ]                             [ normalize-space( @output ) eq $output ]">
         <xsl:message>
          There are 2 (or more) 'model' elements in this
          '<xsl:text/>
            <xsl:value-of select="local-name(..)"/>
            <xsl:text/>' that have
          the same predicate, and are targeted to the same output
          ("<xsl:text/>
            <xsl:value-of select="( $output, parent::modelGrp/@output, 'all')[1]"/>
            <xsl:text/>") (following-sibling::tei:model [ normalize-space( @predicate ) eq $predicate ] [ normalize-space( @output ) eq $output ])</xsl:message>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M73"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M73"/>
   <xsl:template match="@*|node()" priority="-2" mode="M73">
      <xsl:apply-templates select="*" mode="M73"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_allPlus-modelSequence-no_outputs_nor_predicates_4_my_kids-71-->
   <!--RULE -->
   <xsl:template match="tei:modelSequence" priority="1000" mode="M74">

		<!--REPORT warning-->
      <xsl:if test="tei:model[@output]">
         <xsl:message>The 'model' children
      of a 'modelSequence' element inherit the @output attribute of the
      parent 'modelSequence', and thus should not have their own (tei:model[@output] / warning)</xsl:message>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M74"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M74"/>
   <xsl:template match="@*|node()" priority="-2" mode="M74">
      <xsl:apply-templates select="*" mode="M74"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_allPlus-sequence-sequencechilden-72-->
   <!--RULE -->
   <xsl:template match="tei:sequence" priority="1000" mode="M75">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="count(*)&gt;1"/>
         <xsl:otherwise>
            <xsl:message>The sequence element must have at least two child elements (count(*)&gt;1)</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M75"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M75"/>
   <xsl:template match="@*|node()" priority="-2" mode="M75">
      <xsl:apply-templates select="*" mode="M75"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_allPlus-alternate-alternatechilden-73-->
   <!--RULE -->
   <xsl:template match="tei:alternate" priority="1000" mode="M76">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="count(*)&gt;1"/>
         <xsl:otherwise>
            <xsl:message>The alternate element must have at least two child elements (count(*)&gt;1)</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M76"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M76"/>
   <xsl:template match="@*|node()" priority="-2" mode="M76">
      <xsl:apply-templates select="*" mode="M76"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_allPlus-constraintSpec-sch_no_more-74-->
   <!--RULE -->
   <xsl:template match="tei:constraintSpec" priority="1000" mode="M77">

		<!--REPORT -->
      <xsl:if test="tei:constraint/s:*  and  @scheme = ('isoschematron','schematron')">
         <xsl:message>Rules
        in the Schematron 1.* language must be inside a constraintSpec
        with a value other than 'schematron' or 'isoschematron' on the
        scheme attribute (tei:constraint/s:* and @scheme = ('isoschematron','schematron'))</xsl:message>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M77"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M77"/>
   <xsl:template match="@*|node()" priority="-2" mode="M77">
      <xsl:apply-templates select="*" mode="M77"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_allPlus-constraintSpec-isosch-75-->
   <!--RULE -->
   <xsl:template match="tei:constraintSpec" priority="1000" mode="M78">

		<!--REPORT -->
      <xsl:if test="tei:constraint/sch:*  and  not( @scheme eq 'schematron')">
         <xsl:message>Rules
        in the ISO Schematron language must be inside a constraintSpec
        with the value 'schematron' on the scheme attribute (tei:constraint/sch:* and not( @scheme eq 'schematron'))</xsl:message>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M78"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M78"/>
   <xsl:template match="@*|node()" priority="-2" mode="M78">
      <xsl:apply-templates select="*" mode="M78"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_allPlus-constraintSpec-needrules-76-->
   <!--RULE -->
   <xsl:template match="tei:macroSpec/tei:constraintSpec[@scheme eq 'schematron']/tei:constraint"
                 priority="1000"
                 mode="M79">

		<!--REPORT -->
      <xsl:if test="sch:assert|sch:report">
         <xsl:message>An ISO Schematron constraint specification for a macro should not
        have an 'assert' or 'report' element without a parent 'rule' element (sch:assert|sch:report)</xsl:message>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M79"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M79"/>
   <xsl:template match="@*|node()" priority="-2" mode="M79">
      <xsl:apply-templates select="*" mode="M79"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_allPlus-attDef-attDefContents-77-->
   <!--RULE -->
   <xsl:template match="tei:attDef" priority="1000" mode="M80">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="ancestor::teix:egXML[@valid='feasible'] or @mode eq 'change' or @mode eq 'delete' or tei:datatype or tei:valList[@type='closed']"/>
         <xsl:otherwise>
            <xsl:message>Attribute: the definition of the @<xsl:text/>
               <xsl:value-of select="@ident"/>
               <xsl:text/> attribute in the <xsl:text/>
               <xsl:value-of select="ancestor::*[@ident][1]/@ident"/>
               <xsl:text/>
               <xsl:text/>
               <xsl:value-of select="' '"/>
               <xsl:text/>
               <xsl:text/>
               <xsl:value-of select="local-name(ancestor::*[@ident][1])"/>
               <xsl:text/> should have a closed valList or a datatype (ancestor::teix:egXML[@valid='feasible'] or @mode eq 'change' or @mode eq 'delete' or tei:datatype or tei:valList[@type='closed'])</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M80"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M80"/>
   <xsl:template match="@*|node()" priority="-2" mode="M80">
      <xsl:apply-templates select="*" mode="M80"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_allPlus-attDef-noDefault4Required-78-->
   <!--RULE -->
   <xsl:template match="tei:attDef[@usage eq 'req']" priority="1000" mode="M81">

		<!--REPORT -->
      <xsl:if test="tei:defaultVal">
         <xsl:message>Since the @<xsl:text/>
            <xsl:value-of select="@ident"/>
            <xsl:text/> attribute is required, it will always be specified. Thus the default value (of "<xsl:text/>
            <xsl:value-of select="normalize-space(tei:defaultVal)"/>
            <xsl:text/>") will never be used. Either change the definition of the attribute so it is not required ("rec" or "opt"), or remove the defaultVal element. (tei:defaultVal)</xsl:message>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M81"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M81"/>
   <xsl:template match="@*|node()" priority="-2" mode="M81">
      <xsl:apply-templates select="*" mode="M81"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_allPlus-attDef-defaultIsInClosedList-twoOrMore-79-->
   <!--RULE -->
   <xsl:template match="tei:attDef[   tei:defaultVal   and   tei:valList[@type eq 'closed']   and   tei:datatype[    @maxOccurs &gt; 1    or    @minOccurs &gt; 1    or    @maxOccurs = 'unbounded'    ]   ]"
                 priority="1000"
                 mode="M82">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="     tokenize(normalize-space(tei:defaultVal),' ')     =     tei:valList/tei:valItem/@ident"/>
         <xsl:otherwise>
            <xsl:message>In the <xsl:text/>
               <xsl:value-of select="local-name(ancestor::*[@ident][1])"/>
               <xsl:text/> defining
        <xsl:text/>
               <xsl:value-of select="ancestor::*[@ident][1]/@ident"/>
               <xsl:text/> the default value of the
        @<xsl:text/>
               <xsl:value-of select="@ident"/>
               <xsl:text/> attribute is not among the closed list of possible
        values (tokenize(normalize-space(tei:defaultVal),' ') = tei:valList/tei:valItem/@ident)</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M82"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M82"/>
   <xsl:template match="@*|node()" priority="-2" mode="M82">
      <xsl:apply-templates select="*" mode="M82"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_allPlus-attDef-defaultIsInClosedList-one-80-->
   <!--RULE -->
   <xsl:template match="tei:attDef[   tei:defaultVal   and   tei:valList[@type eq 'closed']   and   tei:datatype[    not(@maxOccurs)    or (    if ( @maxOccurs castable as xs:integer )     then ( @maxOccurs cast as xs:integer eq 1 )     else false()    )]   ]"
                 priority="1000"
                 mode="M83">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="string(tei:defaultVal)      =      tei:valList/tei:valItem/@ident"/>
         <xsl:otherwise>
            <xsl:message>In the <xsl:text/>
               <xsl:value-of select="local-name(ancestor::*[@ident][1])"/>
               <xsl:text/> defining
        <xsl:text/>
               <xsl:value-of select="ancestor::*[@ident][1]/@ident"/>
               <xsl:text/> the default value of the
        @<xsl:text/>
               <xsl:value-of select="@ident"/>
               <xsl:text/> attribute is not among the closed list of possible
        values (string(tei:defaultVal) = tei:valList/tei:valItem/@ident)</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M83"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M83"/>
   <xsl:template match="@*|node()" priority="-2" mode="M83">
      <xsl:apply-templates select="*" mode="M83"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_allPlus-dataRef-restrictDataFacet-81-->
   <!--RULE -->
   <xsl:template match="tei:dataRef[tei:dataFacet]" priority="1000" mode="M84">

		<!--ASSERT nonfatal-->
      <xsl:choose>
         <xsl:when test="@name"/>
         <xsl:otherwise>
            <xsl:message>Data facets can only be specified for references to datatypes specified by
          XML Schemas: Part 2: Datatypes (@name / nonfatal)</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M84"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M84"/>
   <xsl:template match="@*|node()" priority="-2" mode="M84">
      <xsl:apply-templates select="*" mode="M84"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_allPlus-dataRef-restrictAttRestriction-82-->
   <!--RULE -->
   <xsl:template match="tei:dataRef[tei:dataFacet]" priority="1000" mode="M85">

		<!--REPORT nonfatal-->
      <xsl:if test="@restriction">
         <xsl:message>The attribute restriction cannot be used when dataFacet elements are present. (@restriction / nonfatal)</xsl:message>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M85"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M85"/>
   <xsl:template match="@*|node()" priority="-2" mode="M85">
      <xsl:apply-templates select="*" mode="M85"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_allPlus-dataRef-restrictAttResctrictionName-83-->
   <!--RULE -->
   <xsl:template match="tei:dataRef" priority="1000" mode="M86">

		<!--REPORT fatal-->
      <xsl:if test="@restriction and not(@name)">
         <xsl:message>The attribute restriction can only be used with a name attribute. (@restriction and not(@name) / fatal)</xsl:message>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M86"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M86"/>
   <xsl:template match="@*|node()" priority="-2" mode="M86">
      <xsl:apply-templates select="*" mode="M86"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="tei:value" priority="1000" mode="M87">

		<!--REPORT nonfatal-->
      <xsl:if test="true()">
         <xsl:message>
                  WARNING: use of deprecated element — The <xsl:text/>
            <xsl:value-of select="name(.)"/>
            <xsl:text/> element will be removed from the TEI on 2022-02-15. 
                 (true() / nonfatal)</xsl:message>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M87"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M87"/>
   <xsl:template match="@*|node()" priority="-2" mode="M87">
      <xsl:apply-templates select="*" mode="M87"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="tei:unicodeName" priority="1000" mode="M88">

		<!--REPORT nonfatal-->
      <xsl:if test="true()">
         <xsl:message>
                  WARNING: use of deprecated element — The <xsl:text/>
            <xsl:value-of select="name(.)"/>
            <xsl:text/> element will be removed from the TEI on 2022-02-15. 
                 (true() / nonfatal)</xsl:message>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M88"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M88"/>
   <xsl:template match="@*|node()" priority="-2" mode="M88">
      <xsl:apply-templates select="*" mode="M88"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="tei:localName" priority="1000" mode="M89">

		<!--REPORT nonfatal-->
      <xsl:if test="true()">
         <xsl:message>
                  WARNING: use of deprecated element — The <xsl:text/>
            <xsl:value-of select="name(.)"/>
            <xsl:text/> element will be removed from the TEI on 2022-02-15. 
                 (true() / nonfatal)</xsl:message>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M89"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M89"/>
   <xsl:template match="@*|node()" priority="-2" mode="M89">
      <xsl:apply-templates select="*" mode="M89"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="tei:glyphName" priority="1000" mode="M90">

		<!--REPORT nonfatal-->
      <xsl:if test="true()">
         <xsl:message>
                  WARNING: use of deprecated element — The <xsl:text/>
            <xsl:value-of select="name(.)"/>
            <xsl:text/> element will be removed from the TEI on 2022-02-15. 
                 (true() / nonfatal)</xsl:message>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M90"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M90"/>
   <xsl:template match="@*|node()" priority="-2" mode="M90">
      <xsl:apply-templates select="*" mode="M90"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="tei:charProp" priority="1000" mode="M91">

		<!--REPORT nonfatal-->
      <xsl:if test="true()">
         <xsl:message>
                  WARNING: use of deprecated element — The <xsl:text/>
            <xsl:value-of select="name(.)"/>
            <xsl:text/> element will be removed from the TEI on 2022-02-15. 
                 (true() / nonfatal)</xsl:message>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M91"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M91"/>
   <xsl:template match="@*|node()" priority="-2" mode="M91">
      <xsl:apply-templates select="*" mode="M91"/>
   </xsl:template>
   <!--PATTERN -->
   <!--RULE -->
   <xsl:template match="tei:charName" priority="1000" mode="M92">

		<!--REPORT nonfatal-->
      <xsl:if test="true()">
         <xsl:message>
                  WARNING: use of deprecated element — The <xsl:text/>
            <xsl:value-of select="name(.)"/>
            <xsl:text/> element will be removed from the TEI on 2022-02-15. 
                 (true() / nonfatal)</xsl:message>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M92"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M92"/>
   <xsl:template match="@*|node()" priority="-2" mode="M92">
      <xsl:apply-templates select="*" mode="M92"/>
   </xsl:template>
   <!--PATTERN teipm-model-paramList-1-->
   <!--RULE -->
   <xsl:template match="tei:param[parent::tei:model/@behaviour='alternate']"
                 priority="1000"
                 mode="M93">

		<!--ASSERT error-->
      <xsl:choose>
         <xsl:when test="@name='default'   or  @name='alternate'"/>
         <xsl:otherwise>
            <xsl:message>
          Parameter name '<xsl:text/>
               <xsl:value-of select="@name"/>
               <xsl:text/>'  (on <xsl:text/>
               <xsl:value-of select="ancestor::tei:elementSpec/@ident"/>
               <xsl:text/>) not allowed.
          Must  be  drawn from the list: default, alternate (@name='default' or @name='alternate' / error)</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M93"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M93"/>
   <xsl:template match="@*|node()" priority="-2" mode="M93">
      <xsl:apply-templates select="*" mode="M93"/>
   </xsl:template>
   <!--PATTERN teipm-model-paramList-2-->
   <!--RULE -->
   <xsl:template match="tei:param[parent::tei:model/@behaviour='anchor']"
                 priority="1000"
                 mode="M94">

		<!--ASSERT error-->
      <xsl:choose>
         <xsl:when test="@name='id'"/>
         <xsl:otherwise>
            <xsl:message>
          Parameter name '<xsl:text/>
               <xsl:value-of select="@name"/>
               <xsl:text/>'  (on <xsl:text/>
               <xsl:value-of select="ancestor::tei:elementSpec/@ident"/>
               <xsl:text/>) not allowed.
          Must  be  drawn from the list: id (@name='id' / error)</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M94"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M94"/>
   <xsl:template match="@*|node()" priority="-2" mode="M94">
      <xsl:apply-templates select="*" mode="M94"/>
   </xsl:template>
   <!--PATTERN teipm-model-paramList-3-->
   <!--RULE -->
   <xsl:template match="tei:param[parent::tei:model/@behaviour='block']"
                 priority="1000"
                 mode="M95">

		<!--ASSERT error-->
      <xsl:choose>
         <xsl:when test="@name='content'"/>
         <xsl:otherwise>
            <xsl:message>
          Parameter name '<xsl:text/>
               <xsl:value-of select="@name"/>
               <xsl:text/>'  (on <xsl:text/>
               <xsl:value-of select="ancestor::tei:elementSpec/@ident"/>
               <xsl:text/>) not allowed.
          Must  be  drawn from the list: content (@name='content' / error)</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M95"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M95"/>
   <xsl:template match="@*|node()" priority="-2" mode="M95">
      <xsl:apply-templates select="*" mode="M95"/>
   </xsl:template>
   <!--PATTERN teipm-model-paramList-4-->
   <!--RULE -->
   <xsl:template match="tei:param[parent::tei:model/@behaviour='body']"
                 priority="1000"
                 mode="M96">

		<!--ASSERT error-->
      <xsl:choose>
         <xsl:when test="@name='content'"/>
         <xsl:otherwise>
            <xsl:message>
          Parameter name '<xsl:text/>
               <xsl:value-of select="@name"/>
               <xsl:text/>'  (on <xsl:text/>
               <xsl:value-of select="ancestor::tei:elementSpec/@ident"/>
               <xsl:text/>) not allowed.
          Must  be  drawn from the list: content (@name='content' / error)</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M96"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M96"/>
   <xsl:template match="@*|node()" priority="-2" mode="M96">
      <xsl:apply-templates select="*" mode="M96"/>
   </xsl:template>
   <!--PATTERN teipm-model-paramList-5-->
   <!--RULE -->
   <xsl:template match="tei:param[parent::tei:model/@behaviour='break']"
                 priority="1000"
                 mode="M97">

		<!--ASSERT error-->
      <xsl:choose>
         <xsl:when test="@name='type'   or  @name='label'"/>
         <xsl:otherwise>
            <xsl:message>
          Parameter name '<xsl:text/>
               <xsl:value-of select="@name"/>
               <xsl:text/>'  (on <xsl:text/>
               <xsl:value-of select="ancestor::tei:elementSpec/@ident"/>
               <xsl:text/>) not allowed.
          Must  be  drawn from the list: type, label (@name='type' or @name='label' / error)</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M97"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M97"/>
   <xsl:template match="@*|node()" priority="-2" mode="M97">
      <xsl:apply-templates select="*" mode="M97"/>
   </xsl:template>
   <!--PATTERN teipm-model-paramList-6-->
   <!--RULE -->
   <xsl:template match="tei:param[parent::tei:model/@behaviour='cell']"
                 priority="1000"
                 mode="M98">

		<!--ASSERT error-->
      <xsl:choose>
         <xsl:when test="@name='content'"/>
         <xsl:otherwise>
            <xsl:message>
          Parameter name '<xsl:text/>
               <xsl:value-of select="@name"/>
               <xsl:text/>'  (on <xsl:text/>
               <xsl:value-of select="ancestor::tei:elementSpec/@ident"/>
               <xsl:text/>) not allowed.
          Must  be  drawn from the list: content (@name='content' / error)</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M98"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M98"/>
   <xsl:template match="@*|node()" priority="-2" mode="M98">
      <xsl:apply-templates select="*" mode="M98"/>
   </xsl:template>
   <!--PATTERN teipm-model-paramList-7-->
   <!--RULE -->
   <xsl:template match="tei:param[parent::tei:model/@behaviour='cit']"
                 priority="1000"
                 mode="M99">

		<!--ASSERT error-->
      <xsl:choose>
         <xsl:when test="@name='content'   or  @name='source'"/>
         <xsl:otherwise>
            <xsl:message>
          Parameter name '<xsl:text/>
               <xsl:value-of select="@name"/>
               <xsl:text/>'  (on <xsl:text/>
               <xsl:value-of select="ancestor::tei:elementSpec/@ident"/>
               <xsl:text/>) not allowed.
          Must  be  drawn from the list: content, source (@name='content' or @name='source' / error)</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M99"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M99"/>
   <xsl:template match="@*|node()" priority="-2" mode="M99">
      <xsl:apply-templates select="*" mode="M99"/>
   </xsl:template>
   <!--PATTERN teipm-model-paramList-8-->
   <!--RULE -->
   <xsl:template match="tei:param[parent::tei:model/@behaviour='document']"
                 priority="1000"
                 mode="M100">

		<!--ASSERT error-->
      <xsl:choose>
         <xsl:when test="@name='content'"/>
         <xsl:otherwise>
            <xsl:message>
          Parameter name '<xsl:text/>
               <xsl:value-of select="@name"/>
               <xsl:text/>'  (on <xsl:text/>
               <xsl:value-of select="ancestor::tei:elementSpec/@ident"/>
               <xsl:text/>) not allowed.
          Must  be  drawn from the list: content (@name='content' / error)</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M100"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M100"/>
   <xsl:template match="@*|node()" priority="-2" mode="M100">
      <xsl:apply-templates select="*" mode="M100"/>
   </xsl:template>
   <!--PATTERN teipm-model-paramList-9-->
   <!--RULE -->
   <xsl:template match="tei:param[parent::tei:model/@behaviour='figure']"
                 priority="1000"
                 mode="M101">

		<!--ASSERT error-->
      <xsl:choose>
         <xsl:when test="@name='title'"/>
         <xsl:otherwise>
            <xsl:message>
          Parameter name '<xsl:text/>
               <xsl:value-of select="@name"/>
               <xsl:text/>'  (on <xsl:text/>
               <xsl:value-of select="ancestor::tei:elementSpec/@ident"/>
               <xsl:text/>) not allowed.
          Must  be  drawn from the list: title (@name='title' / error)</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M101"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M101"/>
   <xsl:template match="@*|node()" priority="-2" mode="M101">
      <xsl:apply-templates select="*" mode="M101"/>
   </xsl:template>
   <!--PATTERN teipm-model-paramList-10-->
   <!--RULE -->
   <xsl:template match="tei:param[parent::tei:model/@behaviour='glyph']"
                 priority="1000"
                 mode="M102">

		<!--ASSERT error-->
      <xsl:choose>
         <xsl:when test="@name='uri'"/>
         <xsl:otherwise>
            <xsl:message>
          Parameter name '<xsl:text/>
               <xsl:value-of select="@name"/>
               <xsl:text/>'  (on <xsl:text/>
               <xsl:value-of select="ancestor::tei:elementSpec/@ident"/>
               <xsl:text/>) not allowed.
          Must  be  drawn from the list: uri (@name='uri' / error)</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M102"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M102"/>
   <xsl:template match="@*|node()" priority="-2" mode="M102">
      <xsl:apply-templates select="*" mode="M102"/>
   </xsl:template>
   <!--PATTERN teipm-model-paramList-11-->
   <!--RULE -->
   <xsl:template match="tei:param[parent::tei:model/@behaviour='graphic']"
                 priority="1000"
                 mode="M103">

		<!--ASSERT error-->
      <xsl:choose>
         <xsl:when test="@name='url'   or  @name='width'   or  @name='height'   or  @name='scale'   or  @name='title'"/>
         <xsl:otherwise>
            <xsl:message>
          Parameter name '<xsl:text/>
               <xsl:value-of select="@name"/>
               <xsl:text/>'  (on <xsl:text/>
               <xsl:value-of select="ancestor::tei:elementSpec/@ident"/>
               <xsl:text/>) not allowed.
          Must  be  drawn from the list: url, width, height, scale, title (@name='url' or @name='width' or @name='height' or @name='scale' or @name='title' / error)</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M103"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M103"/>
   <xsl:template match="@*|node()" priority="-2" mode="M103">
      <xsl:apply-templates select="*" mode="M103"/>
   </xsl:template>
   <!--PATTERN teipm-model-paramList-12-->
   <!--RULE -->
   <xsl:template match="tei:param[parent::tei:model/@behaviour='heading']"
                 priority="1000"
                 mode="M104">

		<!--ASSERT error-->
      <xsl:choose>
         <xsl:when test="@name='content'   or  @name='level'"/>
         <xsl:otherwise>
            <xsl:message>
          Parameter name '<xsl:text/>
               <xsl:value-of select="@name"/>
               <xsl:text/>'  (on <xsl:text/>
               <xsl:value-of select="ancestor::tei:elementSpec/@ident"/>
               <xsl:text/>) not allowed.
          Must  be  drawn from the list: content, level (@name='content' or @name='level' / error)</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M104"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M104"/>
   <xsl:template match="@*|node()" priority="-2" mode="M104">
      <xsl:apply-templates select="*" mode="M104"/>
   </xsl:template>
   <!--PATTERN teipm-model-paramList-13-->
   <!--RULE -->
   <xsl:template match="tei:param[parent::tei:model/@behaviour='index']"
                 priority="1000"
                 mode="M105">

		<!--ASSERT error-->
      <xsl:choose>
         <xsl:when test="@name='type'"/>
         <xsl:otherwise>
            <xsl:message>
          Parameter name '<xsl:text/>
               <xsl:value-of select="@name"/>
               <xsl:text/>'  (on <xsl:text/>
               <xsl:value-of select="ancestor::tei:elementSpec/@ident"/>
               <xsl:text/>) not allowed.
          Must  be  drawn from the list: type (@name='type' / error)</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M105"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M105"/>
   <xsl:template match="@*|node()" priority="-2" mode="M105">
      <xsl:apply-templates select="*" mode="M105"/>
   </xsl:template>
   <!--PATTERN teipm-model-paramList-14-->
   <!--RULE -->
   <xsl:template match="tei:param[parent::tei:model/@behaviour='inline']"
                 priority="1000"
                 mode="M106">

		<!--ASSERT error-->
      <xsl:choose>
         <xsl:when test="@name='content'   or  @name='label'"/>
         <xsl:otherwise>
            <xsl:message>
          Parameter name '<xsl:text/>
               <xsl:value-of select="@name"/>
               <xsl:text/>'  (on <xsl:text/>
               <xsl:value-of select="ancestor::tei:elementSpec/@ident"/>
               <xsl:text/>) not allowed.
          Must  be  drawn from the list: content, label (@name='content' or @name='label' / error)</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M106"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M106"/>
   <xsl:template match="@*|node()" priority="-2" mode="M106">
      <xsl:apply-templates select="*" mode="M106"/>
   </xsl:template>
   <!--PATTERN teipm-model-paramList-15-->
   <!--RULE -->
   <xsl:template match="tei:param[parent::tei:model/@behaviour='link']"
                 priority="1000"
                 mode="M107">

		<!--ASSERT error-->
      <xsl:choose>
         <xsl:when test="@name='content'   or  @name='uri'"/>
         <xsl:otherwise>
            <xsl:message>
          Parameter name '<xsl:text/>
               <xsl:value-of select="@name"/>
               <xsl:text/>'  (on <xsl:text/>
               <xsl:value-of select="ancestor::tei:elementSpec/@ident"/>
               <xsl:text/>) not allowed.
          Must  be  drawn from the list: content, uri (@name='content' or @name='uri' / error)</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M107"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M107"/>
   <xsl:template match="@*|node()" priority="-2" mode="M107">
      <xsl:apply-templates select="*" mode="M107"/>
   </xsl:template>
   <!--PATTERN teipm-model-paramList-16-->
   <!--RULE -->
   <xsl:template match="tei:param[parent::tei:model/@behaviour='list']"
                 priority="1000"
                 mode="M108">

		<!--ASSERT error-->
      <xsl:choose>
         <xsl:when test="@name='content'"/>
         <xsl:otherwise>
            <xsl:message>
          Parameter name '<xsl:text/>
               <xsl:value-of select="@name"/>
               <xsl:text/>'  (on <xsl:text/>
               <xsl:value-of select="ancestor::tei:elementSpec/@ident"/>
               <xsl:text/>) not allowed.
          Must  be  drawn from the list: content (@name='content' / error)</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M108"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M108"/>
   <xsl:template match="@*|node()" priority="-2" mode="M108">
      <xsl:apply-templates select="*" mode="M108"/>
   </xsl:template>
   <!--PATTERN teipm-model-paramList-17-->
   <!--RULE -->
   <xsl:template match="tei:param[parent::tei:model/@behaviour='listItem']"
                 priority="1000"
                 mode="M109">

		<!--ASSERT error-->
      <xsl:choose>
         <xsl:when test="@name='content'"/>
         <xsl:otherwise>
            <xsl:message>
          Parameter name '<xsl:text/>
               <xsl:value-of select="@name"/>
               <xsl:text/>'  (on <xsl:text/>
               <xsl:value-of select="ancestor::tei:elementSpec/@ident"/>
               <xsl:text/>) not allowed.
          Must  be  drawn from the list: content (@name='content' / error)</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M109"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M109"/>
   <xsl:template match="@*|node()" priority="-2" mode="M109">
      <xsl:apply-templates select="*" mode="M109"/>
   </xsl:template>
   <!--PATTERN teipm-model-paramList-18-->
   <!--RULE -->
   <xsl:template match="tei:param[parent::tei:model/@behaviour='metadata']"
                 priority="1000"
                 mode="M110">

		<!--ASSERT error-->
      <xsl:choose>
         <xsl:when test="@name='content'"/>
         <xsl:otherwise>
            <xsl:message>
          Parameter name '<xsl:text/>
               <xsl:value-of select="@name"/>
               <xsl:text/>'  (on <xsl:text/>
               <xsl:value-of select="ancestor::tei:elementSpec/@ident"/>
               <xsl:text/>) not allowed.
          Must  be  drawn from the list: content (@name='content' / error)</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M110"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M110"/>
   <xsl:template match="@*|node()" priority="-2" mode="M110">
      <xsl:apply-templates select="*" mode="M110"/>
   </xsl:template>
   <!--PATTERN teipm-model-paramList-19-->
   <!--RULE -->
   <xsl:template match="tei:param[parent::tei:model/@behaviour='note']"
                 priority="1000"
                 mode="M111">

		<!--ASSERT error-->
      <xsl:choose>
         <xsl:when test="@name='content'   or  @name='place'   or  @name='label'"/>
         <xsl:otherwise>
            <xsl:message>
          Parameter name '<xsl:text/>
               <xsl:value-of select="@name"/>
               <xsl:text/>'  (on <xsl:text/>
               <xsl:value-of select="ancestor::tei:elementSpec/@ident"/>
               <xsl:text/>) not allowed.
          Must  be  drawn from the list: content, place, label (@name='content' or @name='place' or @name='label' / error)</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M111"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M111"/>
   <xsl:template match="@*|node()" priority="-2" mode="M111">
      <xsl:apply-templates select="*" mode="M111"/>
   </xsl:template>
   <!--PATTERN teipm-model-paramList-20-->
   <!--RULE -->
   <xsl:template match="tei:param[parent::tei:model/@behaviour='paragraph']"
                 priority="1000"
                 mode="M112">

		<!--ASSERT error-->
      <xsl:choose>
         <xsl:when test="@name='content'"/>
         <xsl:otherwise>
            <xsl:message>
          Parameter name '<xsl:text/>
               <xsl:value-of select="@name"/>
               <xsl:text/>'  (on <xsl:text/>
               <xsl:value-of select="ancestor::tei:elementSpec/@ident"/>
               <xsl:text/>) not allowed.
          Must  be  drawn from the list: content (@name='content' / error)</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M112"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M112"/>
   <xsl:template match="@*|node()" priority="-2" mode="M112">
      <xsl:apply-templates select="*" mode="M112"/>
   </xsl:template>
   <!--PATTERN teipm-model-paramList-21-->
   <!--RULE -->
   <xsl:template match="tei:param[parent::tei:model/@behaviour='row']"
                 priority="1000"
                 mode="M113">

		<!--ASSERT error-->
      <xsl:choose>
         <xsl:when test="@name='content'"/>
         <xsl:otherwise>
            <xsl:message>
          Parameter name '<xsl:text/>
               <xsl:value-of select="@name"/>
               <xsl:text/>'  (on <xsl:text/>
               <xsl:value-of select="ancestor::tei:elementSpec/@ident"/>
               <xsl:text/>) not allowed.
          Must  be  drawn from the list: content (@name='content' / error)</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M113"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M113"/>
   <xsl:template match="@*|node()" priority="-2" mode="M113">
      <xsl:apply-templates select="*" mode="M113"/>
   </xsl:template>
   <!--PATTERN teipm-model-paramList-22-->
   <!--RULE -->
   <xsl:template match="tei:param[parent::tei:model/@behaviour='section']"
                 priority="1000"
                 mode="M114">

		<!--ASSERT error-->
      <xsl:choose>
         <xsl:when test="@name='content'"/>
         <xsl:otherwise>
            <xsl:message>
          Parameter name '<xsl:text/>
               <xsl:value-of select="@name"/>
               <xsl:text/>'  (on <xsl:text/>
               <xsl:value-of select="ancestor::tei:elementSpec/@ident"/>
               <xsl:text/>) not allowed.
          Must  be  drawn from the list: content (@name='content' / error)</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M114"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M114"/>
   <xsl:template match="@*|node()" priority="-2" mode="M114">
      <xsl:apply-templates select="*" mode="M114"/>
   </xsl:template>
   <!--PATTERN teipm-model-paramList-23-->
   <!--RULE -->
   <xsl:template match="tei:param[parent::tei:model/@behaviour='table']"
                 priority="1000"
                 mode="M115">

		<!--ASSERT error-->
      <xsl:choose>
         <xsl:when test="@name='content'"/>
         <xsl:otherwise>
            <xsl:message>
          Parameter name '<xsl:text/>
               <xsl:value-of select="@name"/>
               <xsl:text/>'  (on <xsl:text/>
               <xsl:value-of select="ancestor::tei:elementSpec/@ident"/>
               <xsl:text/>) not allowed.
          Must  be  drawn from the list: content (@name='content' / error)</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M115"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M115"/>
   <xsl:template match="@*|node()" priority="-2" mode="M115">
      <xsl:apply-templates select="*" mode="M115"/>
   </xsl:template>
   <!--PATTERN teipm-model-paramList-24-->
   <!--RULE -->
   <xsl:template match="tei:param[parent::tei:model/@behaviour='text']"
                 priority="1000"
                 mode="M116">

		<!--ASSERT error-->
      <xsl:choose>
         <xsl:when test="@name='content'"/>
         <xsl:otherwise>
            <xsl:message>
          Parameter name '<xsl:text/>
               <xsl:value-of select="@name"/>
               <xsl:text/>'  (on <xsl:text/>
               <xsl:value-of select="ancestor::tei:elementSpec/@ident"/>
               <xsl:text/>) not allowed.
          Must  be  drawn from the list: content (@name='content' / error)</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M116"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M116"/>
   <xsl:template match="@*|node()" priority="-2" mode="M116">
      <xsl:apply-templates select="*" mode="M116"/>
   </xsl:template>
   <!--PATTERN teipm-model-paramList-25-->
   <!--RULE -->
   <xsl:template match="tei:param[parent::tei:model/@behaviour='title']"
                 priority="1000"
                 mode="M117">

		<!--ASSERT error-->
      <xsl:choose>
         <xsl:when test="@name='content'"/>
         <xsl:otherwise>
            <xsl:message>
          Parameter name '<xsl:text/>
               <xsl:value-of select="@name"/>
               <xsl:text/>'  (on <xsl:text/>
               <xsl:value-of select="ancestor::tei:elementSpec/@ident"/>
               <xsl:text/>) not allowed.
          Must  be  drawn from the list: content (@name='content' / error)</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M117"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M117"/>
   <xsl:template match="@*|node()" priority="-2" mode="M117">
      <xsl:apply-templates select="*" mode="M117"/>
   </xsl:template>
</xsl:stylesheet>
