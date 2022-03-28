<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<xsl:stylesheet xmlns:eg="http://www.tei-c.org/ns/Examples"
                xmlns:iso="http://purl.oclc.org/dsdl/schematron"
                xmlns:rng="http://relaxng.org/ns/structure/1.0"
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
   <xsl:key name="idrefs"
            match="@target[starts-with(normalize-space(.), '#')]|@rendition[starts-with(normalize-space(.), '#')]"
            use="for $i in tokenize(., '\s+') return substring-after($i, '#')"/>
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
   </xsl:template>
   <!--SCHEMATRON PATTERNS-->
   <!--PATTERN schematron-constraint-tei_jtei-att.datable.w3c-att-datable-w3c-when-1-->
   <!--RULE -->
   <xsl:template match="tei:*[@when]" priority="1000" mode="M10">

		<!--REPORT nonfatal-->
      <xsl:if test="@notBefore|@notAfter|@from|@to">
         <xsl:message>The @when attribute cannot be used with any other att.datable.w3c attributes. (@notBefore|@notAfter|@from|@to / nonfatal)</xsl:message>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M10"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M10"/>
   <xsl:template match="@*|node()" priority="-2" mode="M10">
      <xsl:apply-templates select="*" mode="M10"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_jtei-att.datable.w3c-att-datable-w3c-from-2-->
   <!--RULE -->
   <xsl:template match="tei:*[@from]" priority="1000" mode="M11">

		<!--REPORT nonfatal-->
      <xsl:if test="@notBefore">
         <xsl:message>The @from and @notBefore attributes cannot be used together. (@notBefore / nonfatal)</xsl:message>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M11"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M11"/>
   <xsl:template match="@*|node()" priority="-2" mode="M11">
      <xsl:apply-templates select="*" mode="M11"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_jtei-att.datable.w3c-att-datable-w3c-to-3-->
   <!--RULE -->
   <xsl:template match="tei:*[@to]" priority="1000" mode="M12">

		<!--REPORT nonfatal-->
      <xsl:if test="@notAfter">
         <xsl:message>The @to and @notAfter attributes cannot be used together. (@notAfter / nonfatal)</xsl:message>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M12"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M12"/>
   <xsl:template match="@*|node()" priority="-2" mode="M12">
      <xsl:apply-templates select="*" mode="M12"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_jtei-att.typed-subtypeTyped-4-->
   <!--RULE -->
   <xsl:template match="tei:*[@subtype]" priority="1000" mode="M13">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="@type"/>
         <xsl:otherwise>
            <xsl:message>The <xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/> element should not be categorized in detail with @subtype unless also categorized in general with @type (@type)</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M13"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M13"/>
   <xsl:template match="@*|node()" priority="-2" mode="M13">
      <xsl:apply-templates select="*" mode="M13"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_jtei-p-abstractModel-structure-p-5-->
   <!--RULE -->
   <xsl:template match="tei:p" priority="1000" mode="M14">

		<!--REPORT -->
      <xsl:if test="not(ancestor::tei:floatingText) and (ancestor::tei:p or ancestor::tei:ab)          and not(parent::tei:exemplum                |parent::tei:item                |parent::tei:note                |parent::tei:q                |parent::tei:quote                |parent::tei:remarks                |parent::tei:said                |parent::tei:sp                |parent::tei:stage                |parent::tei:cell                |parent::tei:figure                )">
         <xsl:message>
        Abstract model violation: Paragraphs may not occur inside other paragraphs or ab elements.
       (not(ancestor::tei:floatingText) and (ancestor::tei:p or ancestor::tei:ab) and not(parent::tei:exemplum |parent::tei:item |parent::tei:note |parent::tei:q |parent::tei:quote |parent::tei:remarks |parent::tei:said |parent::tei:sp |parent::tei:stage |parent::tei:cell |parent::tei:figure ))</xsl:message>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M14"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M14"/>
   <xsl:template match="@*|node()" priority="-2" mode="M14">
      <xsl:apply-templates select="*" mode="M14"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_jtei-p-abstractModel-structure-l-6-->
   <!--RULE -->
   <xsl:template match="tei:p" priority="1000" mode="M15">

		<!--REPORT -->
      <xsl:if test="(ancestor::tei:l or ancestor::tei:lg) and not(parent::tei:figure or parent::tei:note or ancestor::tei:floatingText)">
         <xsl:message>
        Abstract model violation: Lines may not contain higher-level structural elements such as div, p, or ab, unless p is a child of figure or note, or is a descendant of floatingText.
       ((ancestor::tei:l or ancestor::tei:lg) and not(parent::tei:figure or parent::tei:note or ancestor::tei:floatingText))</xsl:message>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M15"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M15"/>
   <xsl:template match="@*|node()" priority="-2" mode="M15">
      <xsl:apply-templates select="*" mode="M15"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_jtei-quote-jtei.sch-core-7-->
   <!--RULE -->
   <xsl:template match="tei:quote" priority="1000" mode="M16">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="id(substring-after(@source, '#'))/(self::tei:ref[@type eq 'bibl']|self::tei:bibl[ancestor::tei:body])"/>
         <xsl:otherwise>
            <xsl:message>
               <xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/> must have a @source that points to the @xml:id of either a
                    ref[type='bibl'], or a &lt;bibl&gt; in the &lt;body&gt;.  (id(substring-after(@source, '#'))/(self::tei:ref[@type eq 'bibl']|self::tei:bibl[ancestor::tei:body]))</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M16"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M16"/>
   <xsl:template match="@*|node()" priority="-2" mode="M16">
      <xsl:apply-templates select="*" mode="M16"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_jtei-cit-jtei.sch-cit-8-->
   <!--RULE -->
   <xsl:template match="tei:cit" priority="1000" mode="M17">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="tei:ref"/>
         <xsl:otherwise>
            <xsl:message>
               <xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/> is normally expected to have a bibliographic reference (ref[@type="bibl"]). Please make sure you intended not to add one here.
                   (tei:ref)</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M17"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M17"/>
   <xsl:template match="@*|node()" priority="-2" mode="M17">
      <xsl:apply-templates select="*" mode="M17"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_jtei-desc-deprecationInfo-only-in-deprecated-9-->
   <!--RULE -->
   <xsl:template match="tei:desc[ @type eq 'deprecationInfo']"
                 priority="1000"
                 mode="M18">

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
      <xsl:apply-templates select="*" mode="M18"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M18"/>
   <xsl:template match="@*|node()" priority="-2" mode="M18">
      <xsl:apply-templates select="*" mode="M18"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_jtei-gap-jtei.sch-gap-10-->
   <!--RULE -->
   <xsl:template match="tei:gap" priority="1000" mode="M19">

		<!--REPORT -->
      <xsl:if test="following-sibling::node()[1][self::text()] and starts-with(following-sibling::node()[1], '.')">
         <xsl:message>
                    A <xsl:text/>
            <xsl:value-of select="name(.)"/>
            <xsl:text/> element should follow a period rather than precede it when an ellipsis follows the end of a sentence.
                   (following-sibling::node()[1][self::text()] and starts-with(following-sibling::node()[1], '.'))</xsl:message>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M19"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M19"/>
   <xsl:template match="@*|node()" priority="-2" mode="M19">
      <xsl:apply-templates select="*" mode="M19"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_jtei-gap-jtei.sch-gap-ws-11-->
   <!--RULE -->
   <xsl:template match="tei:gap" priority="1000" mode="M20">

		<!--REPORT -->
      <xsl:if test="preceding-sibling::node()[1][self::text()][matches(., '\.\s+$')]">
         <xsl:message>
                    A <xsl:text/>
            <xsl:value-of select="name(.)"/>
            <xsl:text/> should follow a period directly, without preceding whitespace.
                   (preceding-sibling::node()[1][self::text()][matches(., '\.\s+$')])</xsl:message>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M20"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M20"/>
   <xsl:template match="@*|node()" priority="-2" mode="M20">
      <xsl:apply-templates select="*" mode="M20"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_jtei-ptr-jtei.sch-ptr-multipleTargets-12-->
   <!--RULE -->
   <xsl:template match="tei:ptr[not(@type='crossref')]" priority="1000" mode="M21">

		<!--REPORT -->
      <xsl:if test="count(tokenize(normalize-space(@target), '\s+')) &gt; 1">
         <xsl:message> Multiple
                    values in @target are only allowed for <xsl:text/>
            <xsl:value-of select="name(.)"/>
            <xsl:text/>[@type='crossref'].
                   (count(tokenize(normalize-space(@target), '\s+')) &gt; 1)</xsl:message>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M21"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M21"/>
   <xsl:template match="@*|node()" priority="-2" mode="M21">
      <xsl:apply-templates select="*" mode="M21"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_jtei-ptr-ptrAtts-13-->
   <!--RULE -->
   <xsl:template match="tei:ptr" priority="1000" mode="M22">

		<!--REPORT -->
      <xsl:if test="@target and @cRef">
         <xsl:message>Only one of the
attributes @target and @cRef may be supplied on <xsl:text/>
            <xsl:value-of select="name(.)"/>
            <xsl:text/>. (@target and @cRef)</xsl:message>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M22"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M22"/>
   <xsl:template match="@*|node()" priority="-2" mode="M22">
      <xsl:apply-templates select="*" mode="M22"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_jtei-ref-jtei.sch-ref-multipleTargets-14-->
   <!--RULE -->
   <xsl:template match="tei:ref" priority="1000" mode="M23">

		<!--REPORT -->
      <xsl:if test="count(tokenize(normalize-space(@target), '\s+')) &gt; 1">
         <xsl:message>
            <xsl:text/>
            <xsl:value-of select="name(.)"/>
            <xsl:text/> with multiple values for @target is not supported.  (count(tokenize(normalize-space(@target), '\s+')) &gt; 1)</xsl:message>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M23"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M23"/>
   <xsl:template match="@*|node()" priority="-2" mode="M23">
      <xsl:apply-templates select="*" mode="M23"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_jtei-ref-jtei.sch-biblref-parentheses-15-->
   <!--RULE -->
   <xsl:template match="tei:ref[@type eq 'bibl']" priority="1000" mode="M24">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="not(matches(., '^\(.*\)$'))"/>
         <xsl:otherwise>
            <xsl:message>
                    Parentheses are not part of bibliographic references. Please move them out of <xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/>.
                   (not(matches(., '^\(.*\)$')))</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M24"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M24"/>
   <xsl:template match="@*|node()" priority="-2" mode="M24">
      <xsl:apply-templates select="*" mode="M24"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_jtei-ref-jtei.sch-biblref-target-16-->
   <!--RULE -->
   <xsl:template match="tei:ref[@type eq 'bibl']" priority="1000" mode="M25">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="id(substring-after(@target, '#'))/(self::tei:bibl|self::tei:person[ancestor::tei:particDesc/parent::tei:profileDesc])"/>
         <xsl:otherwise>
            <xsl:message> A bibliographic reference must point with a @target to the @xml:id of an entry in the div[@type="bibliography"].
                   (id(substring-after(@target, '#'))/(self::tei:bibl|self::tei:person[ancestor::tei:particDesc/parent::tei:profileDesc]))</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M25"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M25"/>
   <xsl:template match="@*|node()" priority="-2" mode="M25">
      <xsl:apply-templates select="*" mode="M25"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_jtei-ref-jtei.sch-biblref-type-17-->
   <!--RULE -->
   <xsl:template match="tei:ref[id(substring-after(@target, '#'))/self::tei:bibl]"
                 priority="1000"
                 mode="M26">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="@type eq 'bibl'"/>
         <xsl:otherwise>
            <xsl:message>
                    A bibliographic reference must be typed as @type="bibl".
                   (@type eq 'bibl')</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M26"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M26"/>
   <xsl:template match="@*|node()" priority="-2" mode="M26">
      <xsl:apply-templates select="*" mode="M26"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_jtei-ref-refAtts-18-->
   <!--RULE -->
   <xsl:template match="tei:ref" priority="1000" mode="M27">

		<!--REPORT -->
      <xsl:if test="@target and @cRef">
         <xsl:message>Only one of the
	attributes @target' and @cRef' may be supplied on <xsl:text/>
            <xsl:value-of select="name(.)"/>
            <xsl:text/>
          (@target and @cRef)</xsl:message>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M27"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M27"/>
   <xsl:template match="@*|node()" priority="-2" mode="M27">
      <xsl:apply-templates select="*" mode="M27"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_jtei-list-gloss-list-must-have-labels-19-->
   <!--RULE -->
   <xsl:template match="tei:list[@type='gloss']" priority="1000" mode="M28">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="tei:label"/>
         <xsl:otherwise>
            <xsl:message>The content of a "gloss" list should include a sequence of one or more pairs of a label element followed by an item element (tei:label)</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M28"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M28"/>
   <xsl:template match="@*|node()" priority="-2" mode="M28">
      <xsl:apply-templates select="*" mode="M28"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_jtei-head-jtei.sch-head-number-20-->
   <!--RULE -->
   <xsl:template match="tei:head" priority="1000" mode="M29">

		<!--REPORT -->
      <xsl:if test="matches(., '^\s*(((figure|fig\.|table|example|ex\.|section) )\d|\d+\.\d?)', 'i')">
         <xsl:message>
                    Headings are numbered and labeled automatically, please remove the hard-coded label from the text.
                   (matches(., '^\s*(((figure|fig\.|table|example|ex\.|section) )\d|\d+\.\d?)', 'i'))</xsl:message>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M29"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M29"/>
   <xsl:template match="@*|node()" priority="-2" mode="M29">
      <xsl:apply-templates select="*" mode="M29"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_jtei-head-jtei.sch-figure-head-21-->
   <!--RULE -->
   <xsl:template match="tei:figure/tei:head" priority="1000" mode="M30">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="@type = ('legend', 'license')"/>
         <xsl:otherwise>
            <xsl:message> Figure titles (&lt;head&gt;) must have a type
                    'legend' or 'license'.  (@type = ('legend', 'license'))</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M30"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M30"/>
   <xsl:template match="@*|node()" priority="-2" mode="M30">
      <xsl:apply-templates select="*" mode="M30"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_jtei-note-jtei.sch-note-punctuation-22-->
   <!--RULE -->
   <xsl:template match="tei:note" priority="1003" mode="M31">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="not(following::text()[not(ancestor::tei:note)][1][matches(., '^[,\.:;!?\]]')])"/>
         <xsl:otherwise>
            <xsl:message>
                    Footnotes should follow punctuation marks, not precede them. Place 
                    your &lt;<xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/>&gt; element after the punctuation mark.
                   (not(following::text()[not(ancestor::tei:note)][1][matches(., '^[,\.:;!?\]]')]))</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M31"/>
   </xsl:template>
   <!--RULE -->
   <xsl:template match="tei:note" priority="1002" mode="M31">

		<!--REPORT -->
      <xsl:if test="preceding::text()[not(ancestor::tei:note)][1][matches(., '—$')]">
         <xsl:message>
                    Footnotes should precede the dash, not follow it. Place 
                    your &lt;<xsl:text/>
            <xsl:value-of select="name(.)"/>
            <xsl:text/>&gt; element before the dash.
                   (preceding::text()[not(ancestor::tei:note)][1][matches(., '—$')])</xsl:message>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M31"/>
   </xsl:template>
   <!--RULE -->
   <xsl:template match="tei:note" priority="1001" mode="M31">

		<!--REPORT -->
      <xsl:if test="following::text()[not(ancestor::tei:note)][1][matches(normalize-space(), '^\)')]">
         <xsl:message>
                    Footnotes may be placed before closing parentheses, though this is
                    exceptional. Please check if this note's placement is correct.
                    Otherwise, move it after the closing parenthesis.
                   (following::text()[not(ancestor::tei:note)][1][matches(normalize-space(), '^\)')])</xsl:message>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M31"/>
   </xsl:template>
   <!--RULE -->
   <xsl:template match="tei:note" priority="1000" mode="M31">

		<!--REPORT -->
      <xsl:if test="descendant::node()[last()][                   not(matches(normalize-space(), '(^|[^.?!:;,])[.?!]$')) or                   preceding-sibling::node()[1]/descendant-or-self::*[last()]                       [matches(normalize-space(), '[.?!:;,]$')]                       ]">
         <xsl:message>
                  A footnote should end a with a single closing punctuation character.
                   (descendant::node()[last()][ not(matches(normalize-space(), '(^|[^.?!:;,])[.?!]$')) or preceding-sibling::node()[1]/descendant-or-self::*[last()] [matches(normalize-space(), '[.?!:;,]$')] ])</xsl:message>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M31"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M31"/>
   <xsl:template match="@*|node()" priority="-2" mode="M31">
      <xsl:apply-templates select="*" mode="M31"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_jtei-note-jtei.sch-note-blocks-23-->
   <!--RULE -->
   <xsl:template match="tei:note" priority="1000" mode="M32">

		<!--REPORT -->
      <xsl:if test=".//(tei:cit|tei:table|tei:list[not(tokenize(@rend, '\s+')[. eq 'inline'])]|tei:figure|eg:egXML|tei:eg)">
         <xsl:message> No block-level elements (&lt;cit&gt;, &lt;table&gt;, &lt;figure&gt;, &lt;egXML&gt;, &lt;eg&gt;, &lt;list&gt; which do not have the value inline for @rend) are allowed inside <xsl:text/>
            <xsl:value-of select="name(.)"/>
            <xsl:text/>.  (.//(tei:cit|tei:table|tei:list[not(tokenize(@rend, '\s+')[. eq 'inline'])]|tei:figure|eg:egXML|tei:eg))</xsl:message>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M32"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M32"/>
   <xsl:template match="@*|node()" priority="-2" mode="M32">
      <xsl:apply-templates select="*" mode="M32"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_jtei-graphic-jtei.sch-graphic-dimensions-24-->
   <!--RULE -->
   <xsl:template match="tei:graphic" priority="1000" mode="M33">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="matches(@width, '\d+px') and matches(@height, '\d+px')"/>
         <xsl:otherwise>
            <xsl:message>
                    Width and height in pixels must be specified for any <xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/>.
                   (matches(@width, '\d+px') and matches(@height, '\d+px'))</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M33"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M33"/>
   <xsl:template match="@*|node()" priority="-2" mode="M33">
      <xsl:apply-templates select="*" mode="M33"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_jtei-graphic-jtei.sch-graphic-context-25-->
   <!--RULE -->
   <xsl:template match="tei:graphic" priority="1000" mode="M34">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="parent::tei:figure"/>
         <xsl:otherwise>
            <xsl:message>
               <xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/> may only occur inside &lt;figure&gt;.  (parent::tei:figure)</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M34"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M34"/>
   <xsl:template match="@*|node()" priority="-2" mode="M34">
      <xsl:apply-templates select="*" mode="M34"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_jtei-author-jtei.sch-author-26-->
   <!--RULE -->
   <xsl:template match="tei:titleStmt/tei:author" priority="1000" mode="M35">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="tei:name and tei:affiliation and tei:email"/>
         <xsl:otherwise>
            <xsl:message>
                    Author information in the &lt;titleStmt&gt; must include &lt;name&gt;, &lt;affiliation&gt; and &lt;email&gt;.
                   (tei:name and tei:affiliation and tei:email)</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M35"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M35"/>
   <xsl:template match="@*|node()" priority="-2" mode="M35">
      <xsl:apply-templates select="*" mode="M35"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_jtei-respStmt-jtei.sch-respSmt-27-->
   <!--RULE -->
   <xsl:template match="tei:respStmt" priority="1000" mode="M36">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="ancestor::tei:sourceDesc"/>
         <xsl:otherwise>
            <xsl:message>
               <xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/> can only be used in the context of sourceDesc.
                   (ancestor::tei:sourceDesc)</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M36"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M36"/>
   <xsl:template match="@*|node()" priority="-2" mode="M36">
      <xsl:apply-templates select="*" mode="M36"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_jtei-bibl-jtei.sch-bibl-id-28-->
   <!--RULE -->
   <xsl:template match="tei:back/tei:div[@type eq 'bibliography']//tei:bibl"
                 priority="1000"
                 mode="M37">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="@xml:id"/>
         <xsl:otherwise>
            <xsl:message>
                    A bibliographic entry should have a unique value for @xml:id.
                   (@xml:id)</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M37"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M37"/>
   <xsl:template match="@*|node()" priority="-2" mode="M37">
      <xsl:apply-templates select="*" mode="M37"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_jtei-bibl-jtei.sch-bibl-orphan-29-->
   <!--RULE -->
   <xsl:template match="tei:back/tei:div[@type eq 'bibliography']//tei:bibl"
                 priority="1000"
                 mode="M38">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="key('idrefs', @xml:id)/parent::tei:ref[@type='bibl']"/>
         <xsl:otherwise>
            <xsl:message>
                    This bibliographic entry is an orphan: no ref[@type="bibl"] references to it occur in the text.
                   (key('idrefs', @xml:id)/parent::tei:ref[@type='bibl'])</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M38"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M38"/>
   <xsl:template match="@*|node()" priority="-2" mode="M38">
      <xsl:apply-templates select="*" mode="M38"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_jtei-bibl-jtei.sch-bibl-endpunctuation-30-->
   <!--RULE -->
   <xsl:template match="tei:back/tei:div[@type eq 'bibliography']//tei:bibl"
                 priority="1000"
                 mode="M39">

		<!--REPORT -->
      <xsl:if test="descendant::node()[last()][                     not(matches(normalize-space(), '(^|[^.?!:;,])\.$')) or                     preceding-sibling::node()[1]/descendant-or-self::*[last()]                       [matches(normalize-space(), '[.?!:;,]$')]                     ]">
         <xsl:message>
                    A bibliographic entry should end with a single period.
                   (descendant::node()[last()][ not(matches(normalize-space(), '(^|[^.?!:;,])\.$')) or preceding-sibling::node()[1]/descendant-or-self::*[last()] [matches(normalize-space(), '[.?!:;,]$')] ])</xsl:message>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M39"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M39"/>
   <xsl:template match="@*|node()" priority="-2" mode="M39">
      <xsl:apply-templates select="*" mode="M39"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_jtei-bibl-jtei.sch-title-journal-CMOS-31-->
   <!--RULE -->
   <xsl:template match="tei:bibl/tei:title[@level='j']" priority="1000" mode="M40">

		<!--REPORT -->
      <xsl:if test="self::*[preceding-sibling::*[1]/self::tei:title[@level='a']]                     [not(preceding-sibling::node()[normalize-space()][1][matches(normalize-space(), '[.,!?]$')])]                     ">
         <xsl:message>
                    An analytic title and a journal title in a bibliographic entry should only be separated by a comma or a period (or the end punctuation of the analytic title). 
                   (self::*[preceding-sibling::*[1]/self::tei:title[@level='a']] [not(preceding-sibling::node()[normalize-space()][1][matches(normalize-space(), '[.,!?]$')])])</xsl:message>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M40"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M40"/>
   <xsl:template match="@*|node()" priority="-2" mode="M40">
      <xsl:apply-templates select="*" mode="M40"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_jtei-table-jtei.sch-table-32-->
   <!--RULE -->
   <xsl:template match="tei:table" priority="1000" mode="M41">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="not(ancestor::tei:list)"/>
         <xsl:otherwise>
            <xsl:message> No tables are allowed inside
                    lists.  (not(ancestor::tei:list))</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M41"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M41"/>
   <xsl:template match="@*|node()" priority="-2" mode="M41">
      <xsl:apply-templates select="*" mode="M41"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_jtei-titleStmt-jtei.sch-title-33-->
   <!--RULE -->
   <xsl:template match="tei:titleStmt" priority="1000" mode="M42">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="tei:title[@type = 'main']"/>
         <xsl:otherwise>
            <xsl:message>
                    A title of type "main" is required in <xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/>.
                   (tei:title[@type = 'main'])</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M42"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M42"/>
   <xsl:template match="@*|node()" priority="-2" mode="M42">
      <xsl:apply-templates select="*" mode="M42"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_jtei-idno-jtei.sch-doi-order-34-->
   <!--RULE -->
   <xsl:template match="tei:back/tei:div[@type eq 'bibliography']//tei:idno[@type eq 'doi']"
                 priority="1000"
                 mode="M43">

		<!--REPORT -->
      <xsl:if test="following-sibling::tei:ref">
         <xsl:message>
                    If a bibliographic entry has a formal DOI code, it should be placed at the very end of the bibliographic description.
                   (following-sibling::tei:ref)</xsl:message>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M43"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M43"/>
   <xsl:template match="@*|node()" priority="-2" mode="M43">
      <xsl:apply-templates select="*" mode="M43"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_jtei-rendition-jtei.sch-rendition-35-->
   <!--RULE -->
   <xsl:template match="tei:rendition" priority="1000" mode="M44">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="key('idrefs', @xml:id) instance of attribute(rendition)"/>
         <xsl:otherwise>
            <xsl:message>
                    Please remove all <xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/> definitions that aren't actually being used in the article.
                   (key('idrefs', @xml:id) instance of attribute(rendition))</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M44"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M44"/>
   <xsl:template match="@*|node()" priority="-2" mode="M44">
      <xsl:apply-templates select="*" mode="M44"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_jtei-att-jtei.sch-att-36-->
   <!--RULE -->
   <xsl:template match="tei:att" priority="1000" mode="M45">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="not(matches(., '^@'))"/>
         <xsl:otherwise>
            <xsl:message>
                    Attribute delimiters are not allowed for <xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/>: they are completed at processing time via XSLT.
                   (not(matches(., '^@')))</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M45"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M45"/>
   <xsl:template match="@*|node()" priority="-2" mode="M45">
      <xsl:apply-templates select="*" mode="M45"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_jtei-tag-jtei.sch-tag-37-->
   <!--RULE -->
   <xsl:template match="tei:tag" priority="1000" mode="M46">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="not(matches(., '^[&lt;!?-]|[&gt;/?\-]$'))"/>
         <xsl:otherwise>
            <xsl:message>
                    Tag delimiters such as angle brackets and tag-closing slashes are not allowed for <xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/>: they are completed at processing time via XSLT.
                   (not(matches(., '^[&lt;!?-]|[&gt;/?\-]$')))</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M46"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M46"/>
   <xsl:template match="@*|node()" priority="-2" mode="M46">
      <xsl:apply-templates select="*" mode="M46"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_jtei-val-jtei.sch-att-38-->
   <!--RULE -->
   <xsl:template match="tei:val" priority="1000" mode="M47">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="not(matches(., concat('^', $quotes, '|', $quotes, '$')))"/>
         <xsl:otherwise>
            <xsl:message>
                    Attribute value delimiters are not allowed for <xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/>: they are completed at processing time via XSLT.
                   (not(matches(., concat('^', $quotes, '|', $quotes, '$'))))</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M47"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M47"/>
   <xsl:template match="@*|node()" priority="-2" mode="M47">
      <xsl:apply-templates select="*" mode="M47"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_jtei-text-jtei.sch-article-keywords-41-->
   <!--RULE -->
   <xsl:template match="tei:text[not(tei:body/tei:div[@type = ('editorialIntroduction')])]"
                 priority="1000"
                 mode="M48">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="parent::tei:TEI/tei:teiHeader/tei:profileDesc/tei:textClass/tei:keywords"/>
         <xsl:otherwise>
            <xsl:message>
                    An article must have a keyword list in the header. This should be a list of &lt;term&gt; elements in TEI/teiHeader/profileDesc/textClass/keywords  (parent::tei:TEI/tei:teiHeader/tei:profileDesc/tei:textClass/tei:keywords)</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M48"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M48"/>
   <xsl:template match="@*|node()" priority="-2" mode="M48">
      <xsl:apply-templates select="*" mode="M48"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_jtei-text-jtei.sch-article-abstract-42-->
   <!--RULE -->
   <xsl:template match="tei:text[not(tei:body/tei:div[@type = ('editorialIntroduction')])]"
                 priority="1000"
                 mode="M49">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="tei:front/tei:div[@type='abstract']"/>
         <xsl:otherwise>
            <xsl:message> An article must have a
                    front section with an abstract (div[@type='abstract']).  (tei:front/tei:div[@type='abstract'])</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M49"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M49"/>
   <xsl:template match="@*|node()" priority="-2" mode="M49">
      <xsl:apply-templates select="*" mode="M49"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_jtei-text-jtei.sch-article-back-43-->
   <!--RULE -->
   <xsl:template match="tei:text[not(tei:body/tei:div[@type = ('editorialIntroduction')])]"
                 priority="1000"
                 mode="M50">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="tei:back/tei:div[@type='bibliography']/tei:listBibl"/>
         <xsl:otherwise>
            <xsl:message> An article
                    must have a back section with a bibliography (div[@type='bibliography']).  (tei:back/tei:div[@type='bibliography']/tei:listBibl)</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M50"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M50"/>
   <xsl:template match="@*|node()" priority="-2" mode="M50">
      <xsl:apply-templates select="*" mode="M50"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_jtei-body-jtei.sch-body-44-->
   <!--RULE -->
   <xsl:template match="tei:body[child::tei:div[not(@type=('editorialIntroduction'))]]"
                 priority="1000"
                 mode="M51">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="count(child::tei:div) gt 1"/>
         <xsl:otherwise>
            <xsl:message>
                    If <xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/> contains a div, and that div is not an editorial introduction, then there should be 
                    more than one div. Rather than using only a single div, you may place the content directly
                    in the <xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/> element.
                   (count(child::tei:div) gt 1)</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M51"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M51"/>
   <xsl:template match="@*|node()" priority="-2" mode="M51">
      <xsl:apply-templates select="*" mode="M51"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_jtei-div-jtei.sch-divtypes-front-45-->
   <!--RULE -->
   <xsl:template match="tei:div[@type = $div.types.front]"
                 priority="1000"
                 mode="M52">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="parent::tei:front"/>
         <xsl:otherwise>
            <xsl:message>
                    A text division of type <xsl:text/>
               <xsl:value-of select="@type"/>
               <xsl:text/> may only occur inside &lt;front&gt;.  (parent::tei:front)</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M52"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M52"/>
   <xsl:template match="@*|node()" priority="-2" mode="M52">
      <xsl:apply-templates select="*" mode="M52"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_jtei-div-jtei.sch-divtypes-front2-46-->
   <!--RULE -->
   <xsl:template match="tei:front/tei:div" priority="1000" mode="M53">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="@type = $div.types.front"/>
         <xsl:otherwise>
            <xsl:message>
                    Only text divisions of type <xsl:text/>
               <xsl:value-of select="string-join(for $i in $div.types.front return concat(if (index-of($div.types.front, $i) = count($div.types.front)) then 'or ' else (), '&#34;', $i, '&#34;'), ', ')"/>
               <xsl:text/> may appear in the &lt;front&gt;.
                   (@type = $div.types.front)</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M53"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M53"/>
   <xsl:template match="@*|node()" priority="-2" mode="M53">
      <xsl:apply-templates select="*" mode="M53"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_jtei-div-jtei.sch-divtypes-back-47-->
   <!--RULE -->
   <xsl:template match="tei:div[@type = ('bibliography', 'appendix')]"
                 priority="1000"
                 mode="M54">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="parent::tei:back"/>
         <xsl:otherwise>
            <xsl:message>
                    Bibliography (<xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/>[@type="bibliography"]) and appendices (<xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/>[@type="appendix"]) may only occur inside &lt;back&gt;.  (parent::tei:back)</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M54"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M54"/>
   <xsl:template match="@*|node()" priority="-2" mode="M54">
      <xsl:apply-templates select="*" mode="M54"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_jtei-div-jtei.sch-divtypes-body-48-->
   <!--RULE -->
   <xsl:template match="tei:div[@type = ('editorialIntroduction')]"
                 priority="1000"
                 mode="M55">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="parent::tei:body"/>
         <xsl:otherwise>
            <xsl:message>
                    An editorial introduction (<xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/>[@type="editorialIntroduction"]) may only occur inside &lt;body&gt;.
                   (parent::tei:body)</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M55"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M55"/>
   <xsl:template match="@*|node()" priority="-2" mode="M55">
      <xsl:apply-templates select="*" mode="M55"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_jtei-div-jtei.sch-div-head-49-->
   <!--RULE -->
   <xsl:template match="tei:body//tei:div[not(@type = ('editorialIntroduction'))]"
                 priority="1000"
                 mode="M56">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="tei:head"/>
         <xsl:otherwise>
            <xsl:message>
                    A <xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/> must contain a &lt;head&gt;.  (tei:head)</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M56"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M56"/>
   <xsl:template match="@*|node()" priority="-2" mode="M56">
      <xsl:apply-templates select="*" mode="M56"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_jtei-div-abstractModel-structure-l-50-->
   <!--RULE -->
   <xsl:template match="tei:div" priority="1000" mode="M57">

		<!--REPORT -->
      <xsl:if test="(ancestor::tei:l or ancestor::tei:lg) and not(ancestor::tei:floatingText)">
         <xsl:message>
        Abstract model violation: Lines may not contain higher-level structural elements such as div, unless div is a descendant of floatingText.
       ((ancestor::tei:l or ancestor::tei:lg) and not(ancestor::tei:floatingText))</xsl:message>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M57"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M57"/>
   <xsl:template match="@*|node()" priority="-2" mode="M57">
      <xsl:apply-templates select="*" mode="M57"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_jtei-div-abstractModel-structure-p-51-->
   <!--RULE -->
   <xsl:template match="tei:div" priority="1000" mode="M58">

		<!--REPORT -->
      <xsl:if test="(ancestor::tei:p or ancestor::tei:ab) and not(ancestor::tei:floatingText)">
         <xsl:message>
        Abstract model violation: p and ab may not contain higher-level structural elements such as div, unless div is a descendant of floatingText.
       ((ancestor::tei:p or ancestor::tei:ab) and not(ancestor::tei:floatingText))</xsl:message>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M58"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M58"/>
   <xsl:template match="@*|node()" priority="-2" mode="M58">
      <xsl:apply-templates select="*" mode="M58"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_jtei-front-jtei.sch-front-abstract-52-->
   <!--RULE -->
   <xsl:template match="tei:front" priority="1000" mode="M59">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="tei:div[@type='abstract']"/>
         <xsl:otherwise>
            <xsl:message>
               <xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/> must have an abstract (div[@type='abstract']).
                   (tei:div[@type='abstract'])</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M59"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M59"/>
   <xsl:template match="@*|node()" priority="-2" mode="M59">
      <xsl:apply-templates select="*" mode="M59"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_jtei-back-jtei.sch-back-53-->
   <!--RULE -->
   <xsl:template match="tei:back" priority="1000" mode="M60">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="tei:div[@type='bibliography']/tei:listBibl"/>
         <xsl:otherwise>
            <xsl:message>
               <xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/> must have a bibliography (div[@type="bibliography"]), which must be
                    organized inside a &lt;listBibl&gt; element.  (tei:div[@type='bibliography']/tei:listBibl)</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M60"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M60"/>
   <xsl:template match="@*|node()" priority="-2" mode="M60">
      <xsl:apply-templates select="*" mode="M60"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_jtei-supplied-jtei.sch-supplied-54-->
   <!--RULE -->
   <xsl:template match="tei:supplied" priority="1000" mode="M61">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="not(matches(., '^\[|\]$'))"/>
         <xsl:otherwise>
            <xsl:message>
                    Please remove square brackets from <xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/>: they are completed at processing time via XSLT.
                   (not(matches(., '^\[|\]$')))</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M61"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M61"/>
   <xsl:template match="@*|node()" priority="-2" mode="M61">
      <xsl:apply-templates select="*" mode="M61"/>
   </xsl:template>
   <!--PATTERN -->
   <xsl:variable name="double.quotes" select="'[&#34;“”]'"/>
   <xsl:variable name="apos.typographic" select="'[‘’]'"/>
   <xsl:variable name="apos.straight" select="''''"/>
   <xsl:variable name="quotes" select="concat('[', $apos.straight, '&#34;]')"/>
   <xsl:variable name="div.types.front"
                 select="('abstract', 'acknowledgements', 'authorNotes', 'editorNotes', 'corrections', 'dedication')"/>
   <xsl:variable name="tei.version.url"
                 select="'https://jenkins.tei-c.org/job/TEIP5/lastStableBuild/artifact/P5/release/doc/tei-p5-doc/VERSION'"/>
   <xsl:variable name="tei.version"
                 select="if (unparsed-text-available($tei.version.url)) then normalize-space(unparsed-text($tei.version.url)) else ()"/>
   <xsl:template match="text()" priority="-1" mode="M62"/>
   <xsl:template match="@*|node()" priority="-2" mode="M62">
      <xsl:apply-templates select="*" mode="M62"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_jtei-jtei.sch-straightApos-57-->
   <!--RULE -->
   <xsl:template match="text()[not(ancestor::tei:eg|ancestor::eg:egXML|ancestor::tei:code|ancestor::tei:tag|ancestor::tei:mentioned)]"
                 priority="1000"
                 mode="M63">

		<!--REPORT -->
      <xsl:if test="matches(., $apos.straight)">
         <xsl:message>
                  "Straight apostrophe" characters are not permitted. Please use the
                  Right Single Quotation Mark (U+2019 or ’) character instead. On the other hand, if the straight 
                  apostrophe characters function as quotation marks, please replace them with appropriate mark-up 
                  that will ensure the appropriate quotation marks will be generated consistently.
                 (matches(., $apos.straight))</xsl:message>
      </xsl:if>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M63"/>
   <xsl:template match="@*|node()" priority="-2" mode="M63">
      <xsl:apply-templates select="*" mode="M63"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_jtei-jtei.sch-LRquotes-58-->
   <!--RULE -->
   <xsl:template match="text()[not(ancestor::tei:eg|ancestor::eg:egXML|ancestor::tei:code|ancestor::tei:tag)][matches(., $apos.typographic)]"
                 priority="1000"
                 mode="M64">

		<!--REPORT -->
      <xsl:if test="matches(., '\W[’]\D') or matches(., '[‘](\W|$)') or matches(., '\w[‘]\w')">
         <xsl:message>
                  Left and Right Single Quotation Marks should be used in the right place. Please check their placement in this text node.

                 (matches(., '\W[’]\D') or matches(., '[‘](\W|$)') or matches(., '\w[‘]\w'))</xsl:message>
      </xsl:if>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M64"/>
   <xsl:template match="@*|node()" priority="-2" mode="M64">
      <xsl:apply-templates select="*" mode="M64"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_jtei-jtei.sch-quotationMarks-59-->
   <!--RULE -->
   <xsl:template match="text()[not(ancestor::tei:eg|ancestor::eg:egXML|ancestor::tei:code|ancestor::tei:tag)]"
                 priority="1000"
                 mode="M65">

		<!--REPORT -->
      <xsl:if test="matches(., $double.quotes) or matches(., '(^|\W)[‘][^‘’]+[’](\W|$)')">
         <xsl:message>
                  Quotation marks are not permitted in plain text. Please use appropriate mark-up that will ensure the appropriate quotation marks will be generated consistently.
                 (matches(., $double.quotes) or matches(., '(^|\W)[‘][^‘’]+[’](\W|$)'))</xsl:message>
      </xsl:if>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M65"/>
   <xsl:template match="@*|node()" priority="-2" mode="M65">
      <xsl:apply-templates select="*" mode="M65"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_jtei-jtei.sch-doubleHyphens-60-->
   <!--RULE -->
   <xsl:template match="text()[not(ancestor::tei:eg|ancestor::eg:egXML|ancestor::tei:code|ancestor::tei:tag|ancestor::tei:ref)]"
                 priority="1000"
                 mode="M66">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="not(contains(., '--'))"/>
         <xsl:otherwise>
            <xsl:message>
                  Double hyphens should not be used for dashes. Please use 
                  the EM Dash (U+2014 or —) instead.
                 (not(contains(., '--')))</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M66"/>
   <xsl:template match="@*|node()" priority="-2" mode="M66">
      <xsl:apply-templates select="*" mode="M66"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_jtei-jtei.sch-rangeHyphen-61-->
   <!--RULE -->
   <xsl:template match="text()[not(ancestor::tei:eg|ancestor::eg:egXML|ancestor::tei:code|ancestor::tei:tag|ancestor::tei:idno|ancestor::tei:date)]"
                 priority="1000"
                 mode="M67">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="not(matches(., '(^|[\W-[-]])\d+-\d+([\W-[-]]|$)'))"/>
         <xsl:otherwise>
            <xsl:message>
                  Numeric ranges should not be indicated with a hyphen. Please use 
                  the EN Dash (U+2013 or –) character instead.
                 (not(matches(., '(^|[\W-[-]])\d+-\d+([\W-[-]]|$)')))</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M67"/>
   <xsl:template match="@*|node()" priority="-2" mode="M67">
      <xsl:apply-templates select="*" mode="M67"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_jtei-jtei.sch-ieEg-62-->
   <!--RULE -->
   <xsl:template match="text()[not(ancestor::tei:eg|ancestor::eg:egXML|ancestor::tei:code|ancestor::tei:tag)]"
                 priority="1000"
                 mode="M68">

		<!--REPORT -->
      <xsl:if test="matches(., '(i\.e\.|e\.g\.)[^,]', 'i')">
         <xsl:message>
                  You should put a comma after "i.e." and "e.g.". 
                 (matches(., '(i\.e\.|e\.g\.)[^,]', 'i'))</xsl:message>
      </xsl:if>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M68"/>
   <xsl:template match="@*|node()" priority="-2" mode="M68">
      <xsl:apply-templates select="*" mode="M68"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_jtei-jtei.sch-nonbreakingspace-63-->
   <!--RULE -->
   <xsl:template match="text()[not(ancestor::tei:eg|ancestor::eg:egXML|ancestor::tei:code|ancestor::tei:tag)]"
                 priority="1000"
                 mode="M69">

		<!--REPORT -->
      <xsl:if test="matches(., ' ')">
         <xsl:message>
                  This text contains a non-breaking space character. Please consider changing this to a normal space character.
                 (matches(., ' '))</xsl:message>
      </xsl:if>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M69"/>
   <xsl:template match="@*|node()" priority="-2" mode="M69">
      <xsl:apply-templates select="*" mode="M69"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_jtei-jtei.sch-localLinkTarget-64-->
   <!--RULE -->
   <xsl:template match="@*[self::attribute(corresp)|self::attribute(target)|self::attribute(from)|self::attribute(to)|self::attribute(ref)|self::attribute(rendition)|self::attribute(resp)|self::attribute(source)][not(ancestor::eg:egXML)][some $i in tokenize(., '\s+') satisfies starts-with($i, '#')]"
                 priority="1000"
                 mode="M70">
      <xsl:variable name="orphan.pointers"
                    select="for $p in tokenize(., '\s+')[starts-with(., '#')] return if (not(id(substring-after($p, '#')))) then $p else ()"/>
      <!--REPORT -->
      <xsl:if test="exists($orphan.pointers)">
         <xsl:message>
                  There's no local target for <xsl:text/>
            <xsl:value-of select="if (count($orphan.pointers) &gt; 1) then 'these pointers' else 'this pointer'"/>
            <xsl:text/>: <xsl:text/>
            <xsl:value-of select="string-join($orphan.pointers, ', ')"/>
            <xsl:text/>. Please make sure you're referring to an existing @xml:id value.
                 (exists($orphan.pointers))</xsl:message>
      </xsl:if>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M70"/>
   <xsl:template match="@*|node()" priority="-2" mode="M70">
      <xsl:apply-templates select="*" mode="M70"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_jtei-jtei.sch-renditionTarget-65-->
   <!--RULE -->
   <xsl:template match="@rendition" priority="1000" mode="M71">
      <xsl:variable name="orphan.pointers"
                    select="for $p in tokenize(., '\s+')[starts-with(., '#')] return for $id in id(substring-after($p, '#'))[not(self::tei:rendition)] return $p"/>
      <!--REPORT -->
      <xsl:if test="exists($orphan.pointers)">
         <xsl:message>
            <xsl:text/>
            <xsl:value-of select="if (count($orphan.pointers) &gt; 1) then 'These pointers don''t' else 'This pointer doesn''t'"/>
            <xsl:text/> point to a &lt;rendition&gt; target: <xsl:text/>
            <xsl:value-of select="string-join($orphan.pointers, ', ')"/>
            <xsl:text/>.
                 (exists($orphan.pointers))</xsl:message>
      </xsl:if>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M71"/>
   <xsl:template match="@*|node()" priority="-2" mode="M71">
      <xsl:apply-templates select="*" mode="M71"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_jtei-jtei.sch-quoteDelim-66-->
   <!--RULE -->
   <xsl:template match="tei:title[@level eq 'a']|tei:mentioned|tei:soCalled|tei:quote|tei:q"
                 priority="1000"
                 mode="M72">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="not(matches(., concat('^', $double.quotes, '|', $double.quotes, '$')))"/>
         <xsl:otherwise>
            <xsl:message>
                  Quotation mark delimiters are not allowed for <xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/>: they are completed at processing time via XSLT.
                 (not(matches(., concat('^', $double.quotes, '|', $double.quotes, '$'))))</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M72"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M72"/>
   <xsl:template match="@*|node()" priority="-2" mode="M72">
      <xsl:apply-templates select="*" mode="M72"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_jtei-jtei.sch-crossref-id-67-->
   <!--RULE -->
   <xsl:template match="tei:body//tei:div[not(@type='editorialIntroduction')]|tei:figure|tei:table"
                 priority="1000"
                 mode="M73">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="@xml:id"/>
         <xsl:otherwise>
            <xsl:message>
                  You're strongly advised to add an @xml:id attribute to <xsl:text/>
               <xsl:value-of select="name(.)"/>
               <xsl:text/> to ease formal cross-referencing 
                  with (ptr|ref)[@type='crossref']
                 (@xml:id)</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*" mode="M73"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M73"/>
   <xsl:template match="@*|node()" priority="-2" mode="M73">
      <xsl:apply-templates select="*" mode="M73"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_jtei-jtei.sch-formalCrossref-68-->
   <!--RULE -->
   <xsl:template match="text()[not(ancestor::tei:eg|ancestor::eg:egXML|ancestor::tei:code|ancestor::tei:tag|ancestor::tei:ref[not(@type='crossref')])]"
                 priority="1000"
                 mode="M74">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="not(matches(., '(table|figure|example|section) \d+([.,]\d+)* ((above)|(below))', 'i'))"/>
         <xsl:otherwise>
            <xsl:message>
                  Please replace literal references to tables, figures, examples, and sections with a formal crosslink:
                  (ptr|ref)[@type="crossref"]
                 (not(matches(., '(table|figure|example|section) \d+([.,]\d+)* ((above)|(below))', 'i')))</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M74"/>
   <xsl:template match="@*|node()" priority="-2" mode="M74">
      <xsl:apply-templates select="*" mode="M74"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_jtei-jtei.sch-crossrefTargetType-69-->
   <!--RULE -->
   <xsl:template match="tei:ptr[@type='crossref']|tei:ref[@type='crossref']"
                 priority="1000"
                 mode="M75">
      <xsl:variable name="orphan.pointers"
                    select="for $p in tokenize(@target, '\s+')[starts-with(., '#')] return for $id in id(substring-after($p, '#'))[not(self::tei:div or self::tei:figure or self::tei:table or self::tei:note)] return $p"/>
      <!--REPORT -->
      <xsl:if test="exists($orphan.pointers)">
         <xsl:message>
                  Cross-links (<xsl:text/>
            <xsl:value-of select="name(.)"/>
            <xsl:text/>[@type="crossref"]) should be targeted at &lt;div&gt;, &lt;figure&gt;, &lt;table&gt;, or &lt;note&gt;
                  elements. The target of <xsl:text/>
            <xsl:value-of select="if (count($orphan.pointers) &gt; 1) then 'these pointers' else 'this pointer'"/>
            <xsl:text/> doesn't satisfy this condition: <xsl:text/>
            <xsl:value-of select="string-join($orphan.pointers, ', ')"/>
            <xsl:text/>.
                 (exists($orphan.pointers))</xsl:message>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M75"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M75"/>
   <xsl:template match="@*|node()" priority="-2" mode="M75">
      <xsl:apply-templates select="*" mode="M75"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_jtei-jtei.sch-crossrefType-70-->
   <!--RULE -->
   <xsl:template match="tei:ptr[not(@type='crossref')]|tei:ref[not(@type='crossref')]"
                 priority="1000"
                 mode="M76">

		<!--REPORT -->
      <xsl:if test="id(substring-after(@target, '#'))/(self::tei:div|self::tei:figure|self::tei:table)">
         <xsl:message>
                  Please type internal cross-references as 'crossref' (<xsl:text/>
            <xsl:value-of select="name(.)"/>
            <xsl:text/>[@type="crossref"]).
                 (id(substring-after(@target, '#'))/(self::tei:div|self::tei:figure|self::tei:table))</xsl:message>
      </xsl:if>
      <xsl:apply-templates select="*" mode="M76"/>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M76"/>
   <xsl:template match="@*|node()" priority="-2" mode="M76">
      <xsl:apply-templates select="*" mode="M76"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_jtei-jtei.sch-centuries-71-->
   <!--RULE -->
   <xsl:template match="text()[not(ancestor::tei:quote or ancestor::tei:title)]"
                 priority="1000"
                 mode="M77">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="not(matches(., '\d\d?((th)|(st)|(rd)|(nd))[- ]centur((y)|(ies))', 'i'))"/>
         <xsl:otherwise>
            <xsl:message>
                  Centuries such as "the nineteenth century" should be spelled out, not written with digits.
                 (not(matches(., '\d\d?((th)|(st)|(rd)|(nd))[- ]centur((y)|(ies))', 'i')))</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M77"/>
   <xsl:template match="@*|node()" priority="-2" mode="M77">
      <xsl:apply-templates select="*" mode="M77"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_jtei-jtei.sch-teiVersion-72-->
   <!--RULE -->
   <xsl:template match="@target[matches(., '^https?://(www\.)?tei-c\.org/release/doc/tei-p5-doc')]"
                 priority="1000"
                 mode="M78">

		<!--ASSERT -->
      <xsl:choose>
         <xsl:when test="false()"/>
         <xsl:otherwise>
            <xsl:message>
                  Please refer to the exact version of the TEI Guidelines<xsl:text/>
               <xsl:value-of select="if (normalize-space($tei.version)) then concat(' (currently at version ', $tei.version, ')') else ()"/>
               <xsl:text/>, and link to the version that can be found in the Vault section. For an overview of all archived versions, see https://www.tei-c.org/Vault/P5/.
                  
                  If you're referring to the English version, the correct URL will likely take the form of https://www.tei-c.org/Vault/P5/{$version-number}/doc/tei-p5-doc/en/html/.
                 (false())</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M78"/>
   <xsl:template match="@*|node()" priority="-2" mode="M78">
      <xsl:apply-templates select="*" mode="M78"/>
   </xsl:template>
   <!--PATTERN schematron-constraint-tei_jtei-jtei.jtei-url-73-->
   <!--RULE -->
   <xsl:template match="@target[matches(., '^https?://(www\.)?jtei\.revues\.org/?')]"
                 priority="1000"
                 mode="M79">
      <xsl:variable name="URL.fixed"
                    select="replace(., '^https?://(www\.)?jtei\.revues\.org/?', 'https://journals.openedition.org/jtei/')"/>
      <!--ASSERT -->
      <xsl:choose>
         <xsl:when test="false()"/>
         <xsl:otherwise>
            <xsl:message>
                  Please refer to the correct jTEI URL: <xsl:text/>
               <xsl:value-of select="$URL.fixed"/>
               <xsl:text/>.
                 (false())</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="text()" priority="-1" mode="M79"/>
   <xsl:template match="@*|node()" priority="-2" mode="M79">
      <xsl:apply-templates select="*" mode="M79"/>
   </xsl:template>
</xsl:stylesheet>
