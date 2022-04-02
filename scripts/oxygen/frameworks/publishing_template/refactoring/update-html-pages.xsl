<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:html="http://www.w3.org/1999/xhtml"
    xmlns:xr="http://www.oxygenxml.com/ns/xmlRefactoring"
    xmlns:whc="http://www.oxygenxml.com/webhelp/components"
    xmlns:saxon="http://saxon.sf.net/"
    exclude-result-prefixes="xs xr saxon"
    xpath-default-namespace="http://www.w3.org/1999/xhtml"
    version="3.0">
    
    <xsl:variable name="MAIN-PAGE" select="'wt_index.html'"/>
    <xsl:variable name="TOPIC-PAGE" select="'wt_topic.html'"/>
    <xsl:variable name="SEARCH-PAGE" select="'wt_search.html'"/>
    <xsl:variable name="TERMS-PAGE" select="'wt_terms.html'"/>
    
    <xsl:variable name="pageFileName" select="tokenize(document-uri(/), '/')[last()]"/>

    <!-- CSS -->
    <xsl:template match="link">
       <xsl:choose>
           <xsl:when test="
               (: Main page :)
               contains(@href, 'webhelp_responsive_topic.css') 
               or contains(@href, 'p-side-notes.css')    
               or contains(@href, 'nav-links.css')
               (: Topic page :)
               or contains(@href, 'commonltr.css')
               or contains(@href, 'wt_expand.css')
               or contains(@href, 'nav-links.css')
               or contains(@href, 'tooltip.css')
               ">
               <!-- Drop -->
           </xsl:when>
           <xsl:when test="contains(@href, 'bootstrap.min.css')">
               <xsl:copy>
                   <xsl:copy-of select="@* except @href"/>
                   <xsl:attribute name="href">${oxygen-webhelp-assets-dir}/lib/bootstrap/css/bootstrap.min.css</xsl:attribute>
               </xsl:copy>
           </xsl:when>
           <xsl:when test="contains(@href, 'bootstrap-theme.min.css')">
               <xsl:copy>
                   <xsl:copy-of select="@* except @href"/>
                   <xsl:attribute name="href">${oxygen-webhelp-assets-dir}/lib/bootstrap/css/bootstrap-theme.min.css</xsl:attribute>
               </xsl:copy>
           </xsl:when>
           <xsl:when test="contains(@href, 'jquery-ui.min.css')">
               <xsl:copy>
                   <xsl:copy-of select="@* except @href"/>
                   <xsl:attribute name="href">${oxygen-webhelp-assets-dir}/lib/jquery-ui/jquery-ui.min.css</xsl:attribute>
               </xsl:copy>
           </xsl:when>
           <xsl:when test="contains(@href, 'wt_default.css')">
               <!-- Template default styles  -->
               <xsl:copy>
                   <xsl:copy-of select="@* except @href"/>
                   <xsl:attribute name="href">
                       <xsl:choose>
                           <xsl:when test="$pageFileName = $MAIN-PAGE">
                               <xsl:value-of>${oxygen-webhelp-assets-dir}/app/main-page.css?buildId=${oxygen-webhelp-build-number}</xsl:value-of>
                           </xsl:when>
                           <xsl:when test="$pageFileName = $TOPIC-PAGE">
                               <xsl:value-of>${oxygen-webhelp-assets-dir}/app/topic-page.css?buildId=${oxygen-webhelp-build-number}</xsl:value-of>
                           </xsl:when>
                           <xsl:when test="$pageFileName = $SEARCH-PAGE">
                               <xsl:value-of>${oxygen-webhelp-assets-dir}/app/search-page.css?buildId=${oxygen-webhelp-build-number}</xsl:value-of>
                           </xsl:when>
                           <xsl:when test="$pageFileName = $TERMS-PAGE">
                               <xsl:value-of>${oxygen-webhelp-assets-dir}/app/indexterms-page.css?buildId=${oxygen-webhelp-build-number}</xsl:value-of>
                           </xsl:when>
                       </xsl:choose>
                   </xsl:attribute>
               </xsl:copy>
           </xsl:when>
           <xsl:otherwise>
               <xsl:copy-of select="."/>
           </xsl:otherwise>
       </xsl:choose>
    </xsl:template>

    <!-- JavaScript -->
    <xsl:template match="script">
        <xsl:choose>
            <xsl:when test="
                (: Main page:)
                contains(@src, 'strings.js') 
                or contains(@src, 'localization.js')    
                or contains(@src, 'parseuri.js')    
                or contains(@src, 'jquery.cookie.js')    
                or contains(@src, 'jquery-ui.min.js')    
                or contains(@src, 'jquery.highlight-3.js')    
                or contains(@src, 'wt_default.js')    
                or contains(@src, 'keywords.js')    
                or contains(@src, 'searchAutocomplete.js')    
                or contains(@src, 'searchHistoryItems.js')    
                or contains(@src, 'searchOptions.js')    
                or contains(@src, 'require.js')    
                (: Topic page :)
                or contains(@src, 'wt_expand.js')    
                (: Search page :)
                or contains(@src, 'jquery.bootpag.min.js')    
                ">
                <!-- Drop -->
            </xsl:when>
            <xsl:when test="contains(@src, 'jquery-3.1.1.min.js')">
                <xsl:copy>
                    <xsl:copy-of select="@* except @src"/>
                    <xsl:attribute name="src">${oxygen-webhelp-assets-dir}/lib/jquery/jquery-3.1.1.min.js</xsl:attribute>
                </xsl:copy>
            </xsl:when>
            <xsl:when test="contains(@src, 'bootstrap.min.js')">
                <xsl:copy>
                    <xsl:copy-of select="@* except @src"/>
                    <xsl:attribute name="src">${oxygen-webhelp-assets-dir}/lib/bootstrap/js/bootstrap.min.js</xsl:attribute>
                </xsl:copy>
            </xsl:when>
            <xsl:otherwise>
                <xsl:copy-of select="."/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="whc:webhelp_skin_resources">
        <xsl:element name="script" namespace="http://www.w3.org/1999/xhtml">
            <xsl:attribute name="data-main">
                <xsl:choose>
                    <xsl:when test="$pageFileName = $MAIN-PAGE">
                        <xsl:value-of>${oxygen-webhelp-assets-dir}/app/main-page.js</xsl:value-of>
                    </xsl:when>
                    <xsl:when test="$pageFileName = $TOPIC-PAGE">
                        <xsl:value-of>${oxygen-webhelp-assets-dir}/app/topic-page.js</xsl:value-of>
                    </xsl:when>
                    <xsl:when test="$pageFileName = $SEARCH-PAGE">
                        <xsl:value-of>${oxygen-webhelp-assets-dir}/app/search-page.js</xsl:value-of>
                    </xsl:when>
                    <xsl:when test="$pageFileName = $TERMS-PAGE">
                        <xsl:value-of>${oxygen-webhelp-assets-dir}/app/indexterms-page.js</xsl:value-of>
                    </xsl:when>
                </xsl:choose>
            </xsl:attribute>
            <xsl:attribute name="src">${oxygen-webhelp-assets-dir}/lib/requirejs/require.js</xsl:attribute>
        </xsl:element>
        <xsl:comment> Skin resources </xsl:comment>
        <xsl:copy>
            <xsl:apply-templates select="node() | @*"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="comment()">
        <xsl:choose>
            <xsl:when test="
                contains(., 'Skin resources')
                or contains(., 'Top Menu')
                or contains(., 'Expand-collapse')
                or contains(., 'Expand/collapse support')
                or contains(., 'Changes and comments')
                or contains(., 'Search autocomplete')
                or contains(., 'Localization')
                or contains(., 'Placeholder for search scripts')
                ">
                <!-- Drop -->
            </xsl:when>
            <xsl:otherwise>
                <xsl:copy-of select="."/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="whc:webhelp_search_scripts">
        <!-- Drop -->
    </xsl:template>
   
    <!-- Convert nav/webhelp_side_toc to wh_publication_toc/nav/component_content -->
    <xsl:template match="nav[whc:webhelp_side_toc]">
        <xsl:element name="whc:webhelp_publication_toc">
            <xsl:copy-of select="whc:webhelp_side_toc/@*"/>
            <xsl:copy>
                <xsl:attribute name="id">wh_publication_toc</xsl:attribute>
                <xsl:apply-templates select="node() | @* except @id"/>
            </xsl:copy>
        </xsl:element>
    </xsl:template>
    <xsl:template match="nav/whc:webhelp_side_toc[not(descendant::whc:component_content)]" priority="10">
        <xsl:element name="whc:component_content"/>
    </xsl:template>
    <xsl:template match="nav/whc:webhelp_side_toc[descendant::whc:component_content]" priority="11">
        <xsl:apply-templates select="node() except @*"/>
    </xsl:template>
    <xsl:template match="* | text() | processing-instruction() | @*">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*"/>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>