<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:ditaarch="http://dita.oasis-open.org/architecture/2005/"
    xmlns:opentopic-index="http://www.idiominc.com/opentopic/index"
    xmlns:opentopic="http://www.idiominc.com/opentopic"
    xmlns:oxy="http://www.oxygenxml.com/extensions/author"
    xmlns:saxon="http://saxon.sf.net/"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    exclude-result-prefixes="#all">

    <xsl:import href="../review/review-pis-to-elements.xsl"/>    

    <xsl:param name="args.draft" select="'no'"/>
    <xsl:param name="args.chapter.layout" select="'BASIC'" />
    <xsl:param name="input.dir.url"/>
    <xsl:param name="transtype" />
    <xsl:param name="figure.title.placement" select="'top'"/>
    <xsl:param name="css.params"/>
    <xsl:param name="hide.frontpage.toc.index.glossary" select="'no'"/>
    <xsl:param name="defaultLanguage" select="'en'"/>
    
    <xsl:variable name="numbering-sections" select="contains($css.params, 'numbering-sections=yes')" as="xs:boolean"/>

    <xsl:include href="merged-namespace-decls.xsl"/>
    <xsl:include href="merged-filtering.xsl"/>    
    <xsl:include href="merged-toc.xsl"/>
    <xsl:include href="merged-map.xsl"/>
    <xsl:include href="merged-chapters.xsl"/>
    <xsl:include href="merged-chapters-minitoc.xsl"/>
    <xsl:include href="merged-images.xsl"/>    
    <xsl:include href="merged-draft-comments.xsl"/>    
    <xsl:include href="merged-index.xsl"/>    
    <xsl:include href="merged-tables.xsl"/>
    <xsl:include href="merged-links.xsl"/>
    <xsl:include href="merged-whitespaces.xsl"/>
    <xsl:include href="merged-topics.xsl"/>
    <xsl:include href="merged-sections.xsl"/>
    <xsl:include href="merged-figures.xsl"/>
    <xsl:include href="merged-titles.xsl"/>
    
    <xsl:include href="merged-flagging.xsl"/>
    <xsl:include href="merged-placeholders.xsl"/>
    <xsl:include href="merged-named-destinations.xsl"/>
    
    <xsl:include href="merged-plugin-svg-syntaxdiagrams.xsl"/>
    
</xsl:stylesheet>
