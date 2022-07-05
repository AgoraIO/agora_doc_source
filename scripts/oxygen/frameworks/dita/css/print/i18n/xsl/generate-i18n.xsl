<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0"
	xmlns:oxy="http://www.oxygenxml.com/oxy">
	<xsl:output method="text"/>
	<!-- 
		This stylesheet regenerates the i18n CSS by parsing the i18n dictionary files 
		from DITA-OT.
		
		It should apply on plugins/org.dita.base/xsl/common/strings.xml
	-->
	
	<xsl:variable name="generated-files">
		<generated-files/>
	</xsl:variable>
	
	<xsl:function name="oxy:lang-paths">
		<xsl:param name="strings-common-base" as="xs:string"/>
		<xsl:param name="lang" as="xs:string"/>
		<xsl:param name="filename" as="xs:string"/>
		
		<xsl:variable name="path-base-for-lang" select="concat($strings-common-base, $filename)"/>
		
		<xsl:variable name="filename-pdf-for-lang"
			select="document(concat($strings-common-base, '../../../org.dita.pdf2/cfg/common/vars/strings.xml'))//lang[@xml:lang = $lang]/@filename"/>
		<xsl:variable name="path-pdf-for-lang" select="concat($strings-common-base, '../../../org.dita.pdf2/cfg/common/vars/', $filename-pdf-for-lang)"/>
		<!-- Map zh to zh_cn, if the PDF plugin does not contain the mapping -->
		<xsl:variable name="path-pdf-for-lang">
			<xsl:choose>
				<xsl:when test="$lang='zh' and not(doc-available($path-pdf-for-lang))">
					<xsl:value-of select="concat($strings-common-base, '../../../org.dita.pdf2/cfg/common/vars/', 'zh_CN.xml')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$path-pdf-for-lang"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		
		<xsl:variable name="path-pdf-css-for-lang" select="concat($strings-common-base, '../../../com.oxygenxml.pdf.css/resources/localization/', $filename)"/>
		
		<paths base="{$path-base-for-lang}" pdf="{$path-pdf-for-lang}" pdf-css="{$path-pdf-css-for-lang}"/>
	</xsl:function>
	
	
	<xsl:template match="/">
		<xsl:variable name="strings-common-base" select="substring-before(base-uri(.), 'strings.xml')"/>
        <xsl:message>Collecting string files from base, pdf2 and pdf-css plugins only.</xsl:message>
		<xsl:variable name="langs"
			select="
				//langlist/lang
				[starts-with(@filename, 'strings-')]
				[string-length(@xml:lang) > 0]
				"/>
		
		<!-- Generates each of the i18n CSS.-->
		<xsl:for-each select="$langs">
			<xsl:variable name="lang" select="@xml:lang"/>
			<xsl:variable name="paths" select="oxy:lang-paths($strings-common-base, $lang, @filename)"/>
			
			<xsl:variable name="path-base-for-lang" select="$paths/@base"/>
			<xsl:variable name="path-pdf-for-lang" select="$paths/@pdf"/>
			<xsl:variable name="path-pdf-css-for-lang" select="$paths/@pdf-css"/>
			
			<xsl:if test="doc-available($path-base-for-lang) and doc-available($path-pdf-for-lang)">
				<xsl:message>Generating CSS file for <xsl:value-of select="$lang"/></xsl:message>
				
				<xsl:variable name="db" select="document($path-base-for-lang)"/>
				<xsl:variable name="db-pdf" select="document($path-pdf-for-lang)"/>
				<xsl:result-document method="text" encoding="UTF-8" xml:space="preserve" href="../p-i18n-{$lang}.css">@charset "UTF-8";
	  			<!-- Strings collected from the common database -->
	  			<xsl:for-each select="$db">
	  				<xsl:call-template name="common">
	  					<xsl:with-param name="lang" select="$lang"/>
	  				</xsl:call-template>
	  			</xsl:for-each>
	  			<!-- Strings collected from the PDF database -->
	  			<xsl:for-each select="$db-pdf">
	  				<xsl:call-template name="pdf">
	  					<xsl:with-param name="lang" select="$lang"/>
	  				</xsl:call-template>
	  			</xsl:for-each>
				  <!-- Strings collected from the PDF-CSS database -->
				  <xsl:choose>
				  	<xsl:when test="not(doc-available($path-pdf-css-for-lang))">
					  	<xsl:call-template name="pdf-css">
		  					<xsl:with-param name="lang" select="$lang"/>
		  				</xsl:call-template>
			  		</xsl:when>
				  	<xsl:otherwise>
				  		<xsl:variable name="db-pdf-css" select="document($path-pdf-css-for-lang)"/>
			  			<xsl:for-each select="$db-pdf-css">
			  				<xsl:call-template name="pdf-css">
			  					<xsl:with-param name="lang" select="$lang"/>
			  				</xsl:call-template>
			  			</xsl:for-each>
			  		</xsl:otherwise>
			  	</xsl:choose>
	  		</xsl:result-document>
			</xsl:if>
		</xsl:for-each>
		<!-- Generates the main i18n CSS.-->
		<xsl:result-document method="text" encoding="UTF-8" href="../p-i18n.css">
			<xsl:for-each select="$langs">
				<xsl:variable name="lang" select="@xml:lang"/>
				<xsl:variable name="paths" select="oxy:lang-paths($strings-common-base, $lang, @filename)"/>
				
				<xsl:variable name="path-base-for-lang" select="$paths/@base"/>
				<xsl:variable name="path-pdf-for-lang" select="$paths/@pdf"/>
				<xsl:variable name="path-pdf-css-for-lang" select="$paths/@pdf-css"/>
			
				<xsl:if test="doc-available($path-base-for-lang) 
					and doc-available($path-pdf-for-lang)" xml:space="preserve">@import 'p-i18n-<xsl:value-of select="@xml:lang"/>.css';
</xsl:if>
			</xsl:for-each>
		</xsl:result-document>
	</xsl:template>
	
	
<xsl:template name="common" xml:space="preserve"><xsl:param name="lang"/>
	<xsl:variable name="lang-cond" select="
		if ($lang != 'en') then
		concat(':lang(', $lang, ')')
		else
		''"/>
/*

I18N file for <xsl:value-of select="$lang"/>    	

*/

/* Title in the Index page */
*[class ~= "index/groups"]<xsl:value-of select="$lang-cond"/>:before {
  content: "<xsl:value-of select="//*[@id = 'Index']"/>";
}
*[class ~= "index/groups"]<xsl:value-of select="$lang-cond"/> {
  bookmark-label:"<xsl:value-of select="//*[@id = 'Index']"/>";  
  -ah-bookmark-label:"<xsl:value-of select="//*[@id = 'Index']"/>";  
}
</xsl:template>

<xsl:template name="pdf-css" xml:space="preserve"><xsl:param name="lang"/>
	<xsl:variable name="lang-cond" select="
		if ($lang != 'en') then
		concat(':lang(', $lang, ')')
		else
		''"/>
*[class~="topic/table"] > *[class~="topic/title"][data-is-repeated]<xsl:value-of select="$lang-cond"/>:after(2) {
    content: " " "<xsl:value-of select="//str[@name = 'Continued']"/>";
}
</xsl:template>
	

<xsl:template name="pdf" xml:space="preserve"><xsl:param name="lang"/>  	
	<xsl:variable name="lang-cond" select="
		if ($lang != 'en') then
		concat(':lang(', $lang, ')')
		else
		''"/>

/* Title of the TOC page */
*[class ~= "toc/title"][empty]<xsl:value-of select="$lang-cond"/>:before {
	content: "<xsl:value-of select="//*[@id = 'Table of Contents']"/>";
}

/* This string is used in the TOC page header. */
*[class ~= "toc/title"]<xsl:value-of select="$lang-cond"/> {
  string-set: toc-header "<xsl:value-of select="//*[@id = 'Table of Contents']"/>";
}
  	
/* Titles in the TOC. */
*[class ~= "map/topicref"][is-part] > *[class ~= "map/topicmeta"] > *[class ~= "topic/navtitle"]<xsl:value-of select="$lang-cond"/>:before{
  content: "<xsl:call-template name="get-string">  	
  	<xsl:with-param name="id">Part with number</xsl:with-param>
  	<xsl:with-param name="param">
  		<number>" counter(toc-part, upper-roman) "</number>
  	</xsl:with-param>  	
  </xsl:call-template>" ". ";
}

*[class ~= "map/topicref"][is-chapter]:not([is-part]) > *[class ~= "map/topicmeta"] > *[class ~= "topic/navtitle"]<xsl:value-of select="$lang-cond"/>:before{
  content: "<xsl:call-template name="get-string">  	
  	<xsl:with-param name="id">Chapter with number</xsl:with-param>
  	<xsl:with-param name="param">
  		<number>" counter(toc-chapter) "</number>
  	</xsl:with-param>  	
  </xsl:call-template>" ". ";
}
*[class ~= "bookmap/appendices"] > *[class ~= "map/topicmeta"] > *[class ~= "topic/navtitle"]<xsl:value-of select="$lang-cond"/>:before,
*[class ~= "bookmap/appendix"][is-part] > *[class ~= "map/topicmeta"] > *[class ~= "topic/navtitle"]<xsl:value-of select="$lang-cond"/>:before{
  content: none !important;
}
*[class ~= "bookmap/appendix"][is-chapter]:not([is-part]) > *[class ~= "map/topicmeta"] > *[class ~= "topic/navtitle"]<xsl:value-of select="$lang-cond"/>:before{
  content: "<xsl:call-template name="get-string">  	
  	<xsl:with-param name="id">Appendix with number</xsl:with-param>
  	<xsl:with-param name="param">
  		<number>" counter(toc-chapter, upper-latin) "</number>
  	</xsl:with-param>  	
  </xsl:call-template>" ". ";
}

/* Titles in the content. */
*[class ~= "topic/topic"][is-part] > *[class ~= "topic/title"]<xsl:value-of select="$lang-cond"/>:before {
 content: "<xsl:call-template name="get-string">  	
  	<xsl:with-param name="id">Part with number</xsl:with-param>
  	<xsl:with-param name="param">
  		<number>" counter(part, upper-roman) "</number>
  	</xsl:with-param>  	
  </xsl:call-template>" ". ";
}
*[class ~= "topic/topic"][is-chapter]:not([is-part]) > *[class ~= "topic/title"]<xsl:value-of select="$lang-cond"/>:before {
  content: "<xsl:call-template name="get-string">  	
  	<xsl:with-param name="id">Chapter with number</xsl:with-param>
  	<xsl:with-param name="param">
  		<number>" counter(chapter) "</number>
  	</xsl:with-param>  	
  </xsl:call-template>" ". ";
}
*[class ~= "topic/topic"][is-part][topicrefclass ~= "bookmap/appendices"] > *[class ~= "topic/title"]<xsl:value-of select="$lang-cond"/>:before,
*[class ~= "topic/topic"][is-chapter]:not([is-part])[topicrefclass ~= "bookmap/appendices"] > *[class ~= "topic/title"]<xsl:value-of select="$lang-cond"/>:before,
*[class ~= "topic/topic"][is-part][topicrefclass ~= "bookmap/appendix"] > *[class ~= "topic/title"]<xsl:value-of select="$lang-cond"/>:before {
  content: none;
}
*[class ~= "topic/topic"][is-chapter][topicrefclass ~= "bookmap/appendix"]:not([is-part]) > *[class ~= "topic/title"]<xsl:value-of select="$lang-cond"/>:before {
  content: "<xsl:call-template name="get-string">  	
  	<xsl:with-param name="id">Appendix with number</xsl:with-param>
  	<xsl:with-param name="param">
  		<number>" counter(chapter, upper-latin) "</number>
  	</xsl:with-param>  	
  </xsl:call-template>" ". ";
}

/* Figures */  
*[class ~= "topic/fig"] > *[class ~= "topic/title"]<xsl:value-of select="$lang-cond"/>:before {
  content: "<xsl:call-template name="get-string">  	
  	<xsl:with-param name="id">Figure Number</xsl:with-param>
  	<xsl:with-param name="param">
  		<number>" counter(figcount) "</number>
  	</xsl:with-param>  	
  </xsl:call-template>" ": ";
}

/* Tables */
*[class ~= "topic/table"] > *[class ~= "topic/title"]<xsl:value-of select="$lang-cond"/>:before {
  content: "<xsl:call-template name="get-string">  	
  	<xsl:with-param name="id">Table Number</xsl:with-param>
  	<xsl:with-param name="param">
  		<number>" counter(tablecount) "</number>
  	</xsl:with-param>  	
  </xsl:call-template>" ": ";
}

/* Links. */
*[class ~= "map/map"] *[class ~= "topic/xref"][href]<xsl:value-of select="$lang-cond"/>:after,
*[class ~= "map/map"] *[class ~= "topic/link"][href]<xsl:value-of select="$lang-cond"/>:after {
  content: " (<xsl:value-of select="normalize-space(//*[@id = 'On the page'])"/> " target-counter(attr(href), page) ")";
}

/* Links when having chapter scope numbering */
*[class ~= "map/map"][numbering='deep-chapter-scope'] *[class ~= "topic/xref"][href]<xsl:value-of select="$lang-cond"/>:after,
*[class ~= "map/map"][numbering='deep-chapter-scope'] *[class ~= "topic/link"][href]<xsl:value-of select="$lang-cond"/>:after {
  content: " (<xsl:value-of select="normalize-space(//*[@id = 'On the page'])"/> " target-counter(attr(href), chapter) "." target-counter(attr(href), page) ")";
}
</xsl:template>
	
	<xsl:template name="get-string">
		<xsl:param name="id"/>
		<xsl:param name="param"/>
		
		<xsl:apply-templates select="//*[@id=$id]" mode="expand-number-param">
			<xsl:with-param name="param" select="$param" tunnel="yes"/>
		</xsl:apply-templates>
	</xsl:template>
	
	<xsl:template match="*:param" mode="expand-number-param">
		<xsl:param name="param" tunnel="yes"/>
		<xsl:variable name="refname" select="@ref-name"/>
		<xsl:value-of select="$param/*[local-name() = $refname]"/>		
	</xsl:template>

	<xsl:template match="text()" mode="expand-number-param" priority="2">
		<xsl:value-of select="."/>		
	</xsl:template>
	
	<xsl:template match="node() | @*" mode="expand-number-param">
		<xsl:copy>
			<xsl:apply-templates select="node() | @*" mode="expand-number-param"/>
		</xsl:copy>
	</xsl:template>
	
</xsl:stylesheet>
