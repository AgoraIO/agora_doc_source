<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xr="http://www.oxygenxml.com/ns/xmlRefactoring"
    xmlns:whc="http://www.oxygenxml.com/webhelp/components"
    xmlns:saxon="http://saxon.sf.net/"
    exclude-result-prefixes="xs xr saxon"
    xpath-default-namespace="http://www.w3.org/1999/xhtml"
    version="3.0">
    
    <!-- Change whc:version attribute value -->
    <xsl:template match="@whc:version" mode="#default migrate-23.1 migrate-23.0">
        <xsl:attribute name="whc:version">24.0</xsl:attribute>
    </xsl:template>
    
    <xsl:template match="footer/@whc:version" mode="#default migrate-23.1 migrate-23.0">
        <!-- Drop -->
    </xsl:template>
    
    <xsl:template match="header/@whc:version" mode="#default migrate-23.1 migrate-23.0">
        <!-- Drop -->
    </xsl:template>
    
    <xsl:template match="html">
        <xsl:variable name="currentPage">
            <xsl:choose>
                <xsl:when test="head/whc:page_libraries[@page='main']">
                    <xsl:value-of select="'main'"/>
                </xsl:when>
                <xsl:when test="head/whc:page_libraries[@page='search']">
                    <xsl:value-of select="'search'"/>
                </xsl:when>
                <xsl:when test="head/whc:page_libraries[@page='indexterms']">
                    <xsl:value-of select="'terms'"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="'topic'"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="head/whc:include_html[@href='${args.hdf}']/comment()[contains(., 'Deprecated')]">
                <xsl:copy>
                    <xsl:apply-templates select="node() | @*" mode="migrate-23.1"/>
                </xsl:copy>
            </xsl:when>
            <xsl:otherwise>
                <xsl:copy>
                    <xsl:apply-templates select="node() | @*" mode="migrate-23.0">
                        <xsl:with-param name="page" select="$currentPage" tunnel="yes"/>
                    </xsl:apply-templates>
                </xsl:copy>
            </xsl:otherwise>
        </xsl:choose>    
        
    </xsl:template>
    
    <xsl:template match="head/comment()[contains(., 'EXM-36950')]" mode="migrate-23.0">
        <!-- Drop -->
    </xsl:template>
    
    <xsl:template match="body/comment()[contains(., 'EXM-36950')]" mode="migrate-23.0">
        <!-- Drop -->
    </xsl:template>
    
    <xsl:template match="body//comment()[contains(., 'This is the placeholder for the main page entries')]" mode="migrate-23.0">
        <!-- Drop -->
    </xsl:template>
    
    <xsl:template match="head/whc:include_html[@href='${args.hdf}']" mode="migrate-23.0">
        <whc:include_html>
            <xsl:attribute name="href">${args.hdf}</xsl:attribute>
            <xsl:text>&#xa;</xsl:text>
            <xsl:comment> @Deprecated: use webhelp.fragment.head </xsl:comment>
            <xsl:text>&#xa;</xsl:text>
            <xsl:comment> EXM-36950 - Expand the args.hdf parameter here </xsl:comment>
            <xsl:text>&#xa;</xsl:text>
        </whc:include_html>
    </xsl:template>
    
    <xsl:template match="head/whc:include_html[@href='${webhelp.fragment.head}']" mode="migrate-23.0">
        <xsl:param name="page" tunnel="yes"/>
        <xsl:copy>
            <xsl:apply-templates select="node() | @*" mode="#current"/>
        </xsl:copy>
        <xsl:text>&#xa;</xsl:text>
        <whc:include_html>
            <xsl:attribute name="href">
                <xsl:value-of select="concat('${webhelp.fragment.head.', $page ,'.page}')"/>
            </xsl:attribute>
        </whc:include_html>
    </xsl:template>
    
    <xsl:template match="body/whc:include_html[@href='${args.hdr}']" mode="migrate-23.0">
        <whc:include_html>
            <xsl:attribute name="href">${args.hdr}</xsl:attribute>
            <xsl:text>&#xa;</xsl:text>
            <xsl:comment> @Deprecated: use webhelp.fragment.before.body </xsl:comment>
            <xsl:text>&#xa;</xsl:text>
            <xsl:comment> EXM-36950 - Expand the args.hdr parameter here </xsl:comment>
            <xsl:text>&#xa;</xsl:text>
        </whc:include_html>
    </xsl:template>
    
    <xsl:template match="body/whc:include_html[@href='${webhelp.fragment.before.body}']" mode="migrate-23.0">
        <xsl:param name="page" tunnel="yes"/>
        <xsl:copy>
            <xsl:apply-templates select="node() | @*" mode="#current"/>
        </xsl:copy>
        <xsl:text>&#xa;</xsl:text>
        <whc:include_html>
            <xsl:attribute name="href">
                <xsl:value-of select="concat('${webhelp.fragment.before.body.', $page ,'.page}')"/>
            </xsl:attribute>
        </whc:include_html>
    </xsl:template>
    
    <xsl:template match="whc:include_html[@href='${webhelp.fragment.header}']" mode="migrate-23.0">
        <xsl:param name="page" tunnel="yes"/>
        <xsl:copy>
            <xsl:apply-templates select="node() | @*" mode="#current"/>
        </xsl:copy>
        <xsl:text>&#xa;</xsl:text>
        <whc:include_html>
            <xsl:attribute name="href">${webhelp.fragment.after.header}</xsl:attribute>
        </whc:include_html>
        <xsl:text>&#xa;</xsl:text>
        <whc:include_html>
            <xsl:attribute name="href">
                <xsl:value-of select="concat('${webhelp.fragment.after.header.', $page ,'.page}')"/>
            </xsl:attribute>
        </whc:include_html>
    </xsl:template>
    
    <xsl:template match="whc:webhelp_search_input" mode="migrate-23.0">
        <xsl:param name="page" tunnel="yes"/>
        <whc:webhelp_search_input>
            <xsl:attribute name="class">
                <xsl:value-of select="concat('navbar-form wh_', $page ,'_page_search search')"/>
            </xsl:attribute>
            <xsl:attribute name="role">form</xsl:attribute>
            <xsl:choose>
                <xsl:when test="$page = 'main'">
                    <xsl:apply-templates mode="search-component-main-page"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>&#xa;</xsl:text>
                    <whc:include_html>
                        <xsl:attribute name="href">${webhelp.fragment.before.search.input}</xsl:attribute>
                    </whc:include_html>
                    <xsl:text>&#xa;</xsl:text>
                    <whc:include_html>
                        <xsl:attribute name="href">
                            <xsl:value-of select="concat('${webhelp.fragment.before.search.input.', $page ,'.page}')"/>
                        </xsl:attribute>
                    </whc:include_html>
                    <xsl:text>&#xa;</xsl:text>
                    
                    <whc:component_content/>
                    <xsl:text>&#xa;</xsl:text>
                    
                    <whc:include_html>
                        <xsl:attribute name="href">${webhelp.fragment.after.search.input}</xsl:attribute>
                    </whc:include_html>
                    <xsl:text>&#xa;</xsl:text>
                    <whc:include_html>
                        <xsl:attribute name="href">
                            <xsl:value-of select="concat('${webhelp.fragment.after.search.input.', $page ,'.page}')"/>
                        </xsl:attribute>
                    </whc:include_html>
                </xsl:otherwise>
            </xsl:choose>    
        </whc:webhelp_search_input>
    </xsl:template>
    
    <xsl:template match="* | text() | processing-instruction() | comment() | @*" mode="search-component-main-page">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*" mode="#current"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="whc:include_html[@href='${webhelp.fragment.before.main.page.search}']" mode="search-component-main-page">
        <whc:include_html>
            <xsl:attribute name="href">${webhelp.fragment.before.search.input}</xsl:attribute>
        </whc:include_html>
        <xsl:text>&#xa;</xsl:text>
        <whc:include_html>
            <xsl:attribute name="href">${webhelp.fragment.before.search.input.main.page}</xsl:attribute>
        </whc:include_html>
        <xsl:text>&#xa;</xsl:text>
        <xsl:copy>
            <xsl:apply-templates select="node() | @*" mode="#current"/>
            <xsl:text>&#xa;</xsl:text>
            <xsl:comment>
                @Deprecated: Use webhelp.fragment.before.search.input.main.page
            </xsl:comment>
            <xsl:text>&#xa;</xsl:text>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="whc:include_html[@href='${webhelp.fragment.after.main.page.search}']" mode="search-component-main-page">
        <whc:include_html>
            <xsl:attribute name="href">${webhelp.fragment.after.search.input}</xsl:attribute>
        </whc:include_html>
        <xsl:text>&#xa;</xsl:text>
        <whc:include_html>
            <xsl:attribute name="href">${webhelp.fragment.after.search.input.main.page}</xsl:attribute>
        </whc:include_html>
        <xsl:text>&#xa;</xsl:text>
        <xsl:copy>
            <xsl:apply-templates select="node() | @*" mode="#current"/>
            <xsl:text>&#xa;</xsl:text>
            <xsl:comment>
                @Deprecated: Use webhelp.fragment.after.search.input.main.page
            </xsl:comment>
            <xsl:text>&#xa;</xsl:text>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="div[contains(@class, 'wh_content_area')] | div[@id='content']" mode="migrate-23.0">
        <xsl:param name="page" tunnel="yes"/>
        <whc:include_html>
            <xsl:attribute name="href">${webhelp.fragment.before.main.content.area}</xsl:attribute>
        </whc:include_html>
        <xsl:text>&#xa;</xsl:text>
        <whc:include_html>
            <xsl:attribute name="href">
                <xsl:value-of select="concat('${webhelp.fragment.before.main.content.area.', $page ,'.page}')"/>
            </xsl:attribute>
        </whc:include_html>
        <xsl:text>&#xa;</xsl:text>
        <xsl:copy>
            <xsl:apply-templates select="@*" mode="#current"/>
            <xsl:if test="@id='content' and $page='terms'">
                <xsl:attribute name="class">container-fluid wh_content_area</xsl:attribute>
            </xsl:if>
            <xsl:apply-templates select="node()" mode="#current"/>
        </xsl:copy>
        <xsl:text>&#xa;</xsl:text>
        <whc:include_html>
            <xsl:attribute name="href">${webhelp.fragment.after.main.content.area}</xsl:attribute>
        </whc:include_html>
        <xsl:text>&#xa;</xsl:text>
        <whc:include_html>
            <xsl:attribute name="href">
                <xsl:value-of select="concat('${webhelp.fragment.after.main.content.area.', $page ,'.page}')"/>
            </xsl:attribute>
        </whc:include_html>
    </xsl:template>
    
    <xsl:template match="whc:webhelp_breadcrumb" mode="migrate-23.0">
        <whc:include_html>
            <xsl:attribute name="href">${webhelp.fragment.before.topic.breadcrumb}</xsl:attribute>
        </whc:include_html>
        <xsl:text>&#xa;</xsl:text>
        <xsl:copy>
            <xsl:apply-templates select="node() | @*" mode="#current"/>
        </xsl:copy>
        <xsl:text>&#xa;</xsl:text>
        <whc:include_html>
            <xsl:attribute name="href">${webhelp.fragment.after.topic.breadcrumb}</xsl:attribute>
        </whc:include_html>
        <xsl:text>&#xa;</xsl:text>
    </xsl:template>
    
    <xsl:template match="whc:webhelp_publication_toc" mode="migrate-23.0">
        <xsl:copy>
            <xsl:apply-templates select="@*" mode="#current" />
            <xsl:text>&#xa;</xsl:text>
            <whc:include_html>
                <xsl:attribute name="href">${webhelp.fragment.before.publication.toc}</xsl:attribute>
            </whc:include_html>
            <xsl:text>&#xa;</xsl:text>
            <xsl:apply-templates select="node()" mode="#current"/>
            <xsl:text>&#xa;</xsl:text>
            <whc:include_html>
                <xsl:attribute name="href">${webhelp.fragment.after.publication.toc}</xsl:attribute>
            </whc:include_html>
            <xsl:text>&#xa;</xsl:text>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="div[@class='wh_right_tools']" mode="migrate-23.0">
        <whc:include_html>
            <xsl:attribute name="href">${webhelp.fragment.before.topic.toolbar}</xsl:attribute>
        </whc:include_html>
        <xsl:text>&#xa;</xsl:text>
        <xsl:copy>
            <xsl:apply-templates select="node() | @*" mode="#current"/>
        </xsl:copy>
        <xsl:text>&#xa;</xsl:text>
        <whc:include_html>
            <xsl:attribute name="href">${webhelp.fragment.after.topic.toolbar}</xsl:attribute>
        </whc:include_html>
    </xsl:template>
    
    <xsl:template match="whc:webhelp_navigation_links" mode="migrate-23.0">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*" mode="#current"/>
        </xsl:copy>
        <xsl:text>&#xa;</xsl:text>
        <xsl:comment>External resource link</xsl:comment>
        <xsl:text>&#xa;</xsl:text>
        <whc:external_resourse_link>
            <xsl:attribute name="href">${param(webhelp.pdf.link.url)}</xsl:attribute>
            <xsl:attribute name="title">${param(webhelp.pdf.link.text)}</xsl:attribute>
            <xsl:attribute name="image">${param(webhelp.pdf.link.icon.path)}</xsl:attribute>
            <xsl:attribute name="type">pdf_link</xsl:attribute>
        </whc:external_resourse_link>
    </xsl:template>
    
    <xsl:template match="whc:webhelp_topic_content" mode="migrate-23.0">
        <whc:include_html>
            <xsl:attribute name="href">${webhelp.fragment.before.topic.content}</xsl:attribute>
        </whc:include_html>
        <xsl:text>&#xa;</xsl:text>
        <xsl:copy>
            <xsl:apply-templates select="node() | @*" mode="#current"/>
        </xsl:copy>
        <xsl:text>&#xa;</xsl:text>
        <whc:include_html>
            <xsl:attribute name="href">${webhelp.fragment.after.topic.content}</xsl:attribute>
        </whc:include_html>
    </xsl:template>
    
    <xsl:template match="whc:webhelp_feedback" mode="migrate-23.0">
        <whc:include_html>
            <xsl:attribute name="href">${webhelp.fragment.before.feedback}</xsl:attribute>
        </whc:include_html>
        <xsl:text>&#xa;</xsl:text>
    </xsl:template>
    
    <xsl:template match="whc:include_html[@href='${webhelp.fragment.feedback}']" mode="migrate-23.0">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*" mode="#current"/>
        </xsl:copy>
        <xsl:text>&#xa;</xsl:text>
        <whc:include_html>
            <xsl:attribute name="href">${webhelp.fragment.after.feedback}</xsl:attribute>
        </whc:include_html>
    </xsl:template>
    
    <xsl:template match="whc:webhelp_topic_toc" mode="migrate-23.0">
        <xsl:copy>
            <xsl:apply-templates select="@*" mode="#current"/>
            <xsl:text>&#xa;</xsl:text>
            <whc:include_html>
                <xsl:attribute name="href">${webhelp.fragment.before.topic.toc}</xsl:attribute>
            </whc:include_html>
            <xsl:text>&#xa;</xsl:text>
            <xsl:apply-templates select="node()" mode="#current"/>
            <xsl:text>&#xa;</xsl:text>
            <whc:include_html>
                <xsl:attribute name="href">${webhelp.fragment.after.topic.toc}</xsl:attribute>
            </whc:include_html>
            <xsl:text>&#xa;</xsl:text>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="whc:include_html[@href='${webhelp.fragment.after.body}']" mode="migrate-23.0">
        <xsl:param name="page" tunnel="yes"/>
        <xsl:copy>
            <xsl:apply-templates select="node() | @*" mode="#current"/>
        </xsl:copy>
        <xsl:text>&#xa;</xsl:text>
        <whc:include_html>
            <xsl:attribute name="href">
                <xsl:value-of select="concat('${webhelp.fragment.after.body.', $page ,'.page}')"/>
            </xsl:attribute>
        </whc:include_html>
    </xsl:template>
    
    <xsl:template match="whc:webhelp_search_results" mode="migrate-23.0">
        <whc:webhelp_search_results />
    </xsl:template>
    
    <xsl:template match="whc:webhelp_main_page_toc" mode="migrate-23.0">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*" mode="#current"/>
            <xsl:text>&#xa;</xsl:text>
            <xsl:comment>
                This is the placeholder for the main page entries
                presented in a tree-like fashion.
            </xsl:comment>
            <xsl:text>&#xa;</xsl:text>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="div[@id='wh-search-pagination']" mode="migrate-23.0">
        <!-- Drop -->
    </xsl:template>
    
    <xsl:template match="whc:webhelp_feedback" mode="migrate-23.1">
        <!-- Drop -->
    </xsl:template>
    
    <xsl:template match="head[whc:page_libraries[@page='topic']]/whc:include_html[@href='${webhelp.fragment.head}']" mode="migrate-23.1">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*" mode="#current"/>
        </xsl:copy>
        <xsl:text>&#xa;</xsl:text>
        <whc:include_html>
            <xsl:attribute name="href">${webhelp.fragment.head.topic.page}</xsl:attribute>
        </whc:include_html>
    </xsl:template>
    
    <!-- Update meta's attribute content for @http-equiv='X-UA-Compatible -->
    <xsl:template match="head/meta[@http-equiv='X-UA-Compatible']" mode="migrate-23.1 migrate-23.0">
        <xsl:copy>
            <xsl:attribute name="content">IE=edge</xsl:attribute>
            <xsl:apply-templates select="node() | @* except @content"/>
        </xsl:copy>
    </xsl:template>
    
    <!-- Updated the nav classes for publication toc.  -->
    <xsl:template match="nav[@id='wh_publication_toc']" mode="migrate-23.1 migrate-23.0" >
        <xsl:copy>
            <xsl:attribute name="class">col-lg-3 col-md-3 col-sm-12 d-md-block d-sm-none d-print-none</xsl:attribute>
            <xsl:apply-templates select="node() | @* except @class"/>
        </xsl:copy>
    </xsl:template>
    
    <!-- Add the button to close the publication toc and topic toc. -->
    <xsl:template match="div[@id='wh_topic_body']" mode="migrate-23.1 migrate-23.0">
        <xsl:copy>
            <xsl:apply-templates select="@*" mode="#current"/>
            <xsl:text>&#xa;</xsl:text>
            <button id="wh_close_publication_toc_button" class="close-toc-button d-none" aria-label="Toggle publishing table of content" aria-controls="wh_publication_toc" aria-expanded="true" >
                <span class="close-toc-icon-container">
                    <span class="close-toc-icon"></span>
                </span>
            </button>
            <button id="wh_close_topic_toc_button" class="close-toc-button d-none" aria-label="Toggle topic table of content" aria-controls="wh_topic_toc" aria-expanded="true">
                <span class="close-toc-icon-container">
                    <span class="close-toc-icon"></span>
                </span>
            </button>
            <xsl:text>&#xa;</xsl:text>
            <xsl:apply-templates select="node()" mode="#current"/>
        </xsl:copy>
    </xsl:template>
    
    <!-- Change the img element to a div -->
    <xsl:template match="img[@id='modal-img']" mode="migrate-23.1 migrate-23.0">
        <xsl:element name="div"> 
            <xsl:attribute name="id">modal_img_container</xsl:attribute>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="footer/@whc:version" mode="migrate-23.1 migrate-23.0">
        <!-- Drop -->
    </xsl:template>
    
    <xsl:template match="header/@whc:version" mode="migrate-23.1 migrate-23.0">
        <!-- Drop -->
    </xsl:template>
    
    <xsl:template match="//button[@id='wh_toc_button']/(@data-target | @data-toggle)" mode="migrate-23.1 migrate-23.0">
        <!-- Drop -->
    </xsl:template>

    <xsl:template match="* | text() | processing-instruction() | comment() | @*" mode="#default migrate-23.1 migrate-23.0">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*" mode="#current"/>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>