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
    
    <xsl:template match="/*[not(@whc:version)]" priority="100">
        <xsl:copy>
        	<!-- 
        		Cristi: Do not change this version automatically at release. 
        	-->
            <xsl:attribute name="whc:version">21.0</xsl:attribute>
            <xsl:apply-templates select="node() | @*" mode="migrate-21"/>
        </xsl:copy>
    </xsl:template>

    <!-- + <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" /> -->
    <xsl:template match="head[not(meta[@http-equiv='X-UA-Compatible'])]/meta[2]" mode="migrate-21">
        <xsl:copy-of select="."/>
        <html:meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    </xsl:template>
    
    <!-- Remove inline script with JS file reference -->
    <xsl:template match="script[contains(text(), '.wh_indexterms_link')]" mode="migrate-21">
        <!-- Drop -->
    </xsl:template>
    
    <!-- Replace inline script with JS file reference -->
    <xsl:template match="script[contains(text(), 'var actualLocation')]" mode="migrate-21">
        <html:script type="text/javascript" src="${{oxygen-webhelp-assets-dir}}/app/core/redirect.js" />
    </xsl:template>


    <!-- 
        #wh_publication_toc: hidden-xs navbar hidden-print -> d-none d-md-block d-print-none
    -->
    <xsl:template match="*[@id='wh_publication_toc']/@class" mode="migrate-21">
        <xsl:variable name="classes" select="tokenize(string(.), ' ')"/>
        <xsl:attribute name="class">
            <xsl:for-each select="$classes">
                <xsl:if test="not(. = ('hidden-xs', 'navbar', 'hidden-print', 'col-sm-3'))">
                    <xsl:value-of select="."/>
                    <xsl:value-of select="' '"/>
                </xsl:if>
            </xsl:for-each>
            <xsl:value-of select="'d-none d-md-block d-print-none'"/>
        </xsl:attribute>
    </xsl:template>
    
    <!-- 
        whc:webhelp_logo: 
            hidden-xs -> d-none d-sm-block
    -->
    <xsl:template match="whc:webhelp_logo/@class" mode="migrate-21">
        <xsl:variable name="classes" select="tokenize(string(.), ' ')"/>
        <xsl:attribute name="class">
            <xsl:for-each select="$classes">
                <xsl:if test="not(. = ('hidden-xs'))">
                    <xsl:value-of select="."/>
                    <xsl:value-of select="' '"/>
                </xsl:if>
            </xsl:for-each>
            <xsl:value-of select="'d-none d-sm-block'"/>
        </xsl:attribute>
    </xsl:template>
    
    <!-- .footer-container:  .text-center -> .mx-auto -->
    <xsl:template match="*[contains(@class, 'footer-container')]/@class" mode="migrate-21">
        <xsl:variable name="classes" select="tokenize(string(.), ' ')"/>
        <xsl:attribute name="class">
            <xsl:for-each select="$classes">
                <xsl:if test="not(. = 'text-center')">
                    <xsl:value-of select="."/>
                    <xsl:value-of select="' '"/>
                </xsl:if>
            </xsl:for-each>
            <xsl:value-of select="'mx-auto'"/>
        </xsl:attribute>
    </xsl:template>
    
    <!-- 
        #wh_menu_mobile_button:
            navbar-toggle collapsed -> navbar-toggler collapsed
            + aria-controls="wh_top_menu_and_indexterms_link"
    -->
    <xsl:template match="*[@id='wh_menu_mobile_button']/@class" mode="migrate-21">
        <xsl:variable name="classes" select="tokenize(string(.), ' ')"/>
        <xsl:attribute name="class">
            <xsl:value-of select="'navbar-toggler'"/>
            <xsl:for-each select="$classes">
                <xsl:if test="not(. = 'navbar-toggle')">
                    <xsl:value-of select="' '"/>
                    <xsl:value-of select="."/>
                </xsl:if>
            </xsl:for-each>
        </xsl:attribute>
        <xsl:attribute name="aria-controls">wh_top_menu_and_indexterms_link</xsl:attribute>
    </xsl:template>
    
    <!-- 
        - span.icon-bar[1] -> span.navbar-toggler-icon
        - remove other span.icon-bar 
    -->
    <xsl:template match="span[contains(@class, 'icon-bar')][1]" priority="100" mode="migrate-21">
        <xsl:copy>
            <xsl:attribute name="class">navbar-toggler-icon</xsl:attribute>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="span[contains(@class, 'icon-bar')]" mode="migrate-21">
        <!-- Drop -->
    </xsl:template>
    
    
    <!-- 
        .wh_header_flex_container: 
            wh_header_flex_container -> wh_header_flex_container navbar-nav navbar-expand-md navbar-dark
    -->
    <xsl:template match="*[contains(@class, 'wh_header_flex_container')]/@class" mode="migrate-21">
        <xsl:attribute name="class">
            <xsl:value-of select="."/>
            <xsl:value-of select="' navbar-nav navbar-expand-md navbar-dark'"/>
        </xsl:attribute>
    </xsl:template>
    
    <!-- 
        .wh_tools: hidden-print -> d-print-none
    -->
    <xsl:template match="*[contains(@class, 'wh_tools')]/@class" mode="migrate-21">
        <xsl:variable name="classes" select="tokenize(string(.), ' ')"/>
        <xsl:attribute name="class">
            <xsl:for-each select="$classes">
                <xsl:if test="not(. = 'hidden-print')">
                    <xsl:value-of select="."/>
                    <xsl:value-of select="' '"/>
                </xsl:if>
            </xsl:for-each>
            <xsl:value-of select="'d-print-none'"/>
        </xsl:attribute>
    </xsl:template>
    
    <!-- 
        .wh_right_tools: reorder navigation links
    -->
    <xsl:template match="*[contains(@class, 'wh_right_tools')]" mode="migrate-21">
        <xsl:copy>
            <xsl:apply-templates select="@*" mode="migrate-21"/>
            <xsl:apply-templates select="whc:webhelp_toggle_highlight"  mode="migrate-21"/>
            <xsl:apply-templates select="whc:webhelp_expand_collapse_sections" mode="migrate-21"/>
            <xsl:apply-templates select="whc:webhelp_navigation_links" mode="migrate-21"/>
            <xsl:apply-templates select="whc:webhelp_print_link" mode="migrate-21"/>
            <xsl:apply-templates 
                select="node() except (whc:webhelp_toggle_highlight | whc:webhelp_expand_collapse_sections | whc:webhelp_navigation_links | whc:webhelp_print_link)"
                mode="migrate-21"
            />
        </xsl:copy>
    </xsl:template>
    
    <!-- 
        .wh_right_tools: Remove hidden-sm hidden-xs 
    -->
    <xsl:template match="*[contains(@class, 'wh_right_tools')]/@class" mode="migrate-21">
        <xsl:variable name="classes" select="tokenize(string(.), ' ')"/>
        <xsl:attribute name="class">
            <xsl:for-each select="$classes">
                <xsl:if test="not(. = ('hidden-sm', 'hidden-xs'))">
                    <xsl:value-of select="."/>
                    <xsl:value-of select="' '"/>
                </xsl:if>
            </xsl:for-each>
        </xsl:attribute>
    </xsl:template>
    
    <!-- 
        .wh_right_tools: hidden-sm hidden-xs -> d-none d-md-block
    -->
    <xsl:template match="whc:webhelp_print_link/@class" mode="migrate-21">
        <xsl:attribute name="class">
            <xsl:value-of select="."/>
            <xsl:value-of select="' '"/>
            <xsl:value-of select="'d-none d-md-inline-block'"/>
        </xsl:attribute>
    </xsl:template>
    
    <!-- 
        #wh_topic_body: col-sm-9 col-xs-12 -> col-sm-12
    -->
    <xsl:template match="*[@id='wh_topic_body']/@class" mode="migrate-21">
        <xsl:variable name="classes" select="tokenize(string(.), ' ')"/>
        <xsl:attribute name="class">
            <xsl:for-each select="$classes">
                <xsl:if test="not(. = ('col-sm-9', 'col-xs-12'))">
                    <xsl:value-of select="."/>
                    <xsl:value-of select="' '"/>
                </xsl:if>
            </xsl:for-each>
            <xsl:value-of select="'col-sm-12'"/>
        </xsl:attribute>
    </xsl:template>
    
    <!-- 
        #wh_topic_toc:
            hidden-md hidden-sm hidden-xs navbar hidden-print -> d-none d-lg-block navbar d-print-none
    -->
    <xsl:template match="*[@id='wh_topic_toc']/@class" mode="migrate-21">
        <xsl:variable name="classes" select="tokenize(string(.), ' ')"/>
        <xsl:attribute name="class">
            <xsl:for-each select="$classes">
                <xsl:if test="not(. = ('hidden-md', 'hidden-sm', 'hidden-xs', 'navbar', 'hidden-print'))">
                    <xsl:value-of select="."/>
                    <xsl:value-of select="' '"/>
                </xsl:if>
            </xsl:for-each>
            <xsl:value-of select="'d-none d-lg-block navbar d-print-none'"/>
        </xsl:attribute>
    </xsl:template>

    <xsl:template match="script[contains(@src, 'bootstrap.min.js')]" mode="migrate-21">
        <!-- Drop -->
    </xsl:template>
    
    <xsl:template match="link[contains(@href, 'bootstrap-theme.min.css')]" mode="migrate-21">
        <!-- Drop -->
    </xsl:template>
    
    <!-- Add Oxygen Feedback Fragment placeholder -->
    <xsl:template match="whc:webhelp_feedback" mode="migrate-21">
        <xsl:copy-of select="."/>
        <whc:include_html
            href="${{webhelp.fragment.feedback}}"/>
    </xsl:template>

    <!-- Replace glyphicons -->
    <xsl:template match="*[@id='modal_img_large']/*[contains(@class, 'glyphicon-remove')]" mode="migrate-21">
        <html:span class="close oxy-icon oxy-icon-remove"></html:span>
    </xsl:template>
    <xsl:template match="*[@id='go2top']/*[contains(@class, 'glyphicon-chevron-up')]" mode="migrate-21">
        <html:span class="oxy-icon oxy-icon-up"></html:span>
    </xsl:template>

    <xsl:template match="* | text() | processing-instruction() | comment() | @*" mode="migrate-21 #default">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*" mode="#current"/>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>