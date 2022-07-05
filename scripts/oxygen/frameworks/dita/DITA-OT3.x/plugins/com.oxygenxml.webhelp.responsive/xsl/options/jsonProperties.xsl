<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:fn="http://www.w3.org/2005/xpath-functions"
    exclude-result-prefixes="xs" version="2.0">
    <xsl:output method="text" omit-xml-declaration="yes"></xsl:output>

    <xsl:variable name="allowed-webhelp-options"
        select="(
            'webhelp.topic.collapsible.elements.initial.state',
            'webhelp.search.ranking',
            'webhelp.top.menu.depth',
            'webhelp.show.main.page.tiles',
            'webhelp.show.main.page.toc',
            'webhelp.show.breadcrumb',
            'webhelp.show.navigation.links',
            'webhelp.show.print.link',
            'webhelp.show.expand.collapse.sections',
            'webhelp.show.indexterms.link',
            'webhelp.show.publication.toc',
            'webhelp.publication.toc.links',
            'webhelp.show.top.menu',
            'webhelp.top.menu.activated.on.click',
            'webhelp.show.related.links',
            'webhelp.merge.nested.topics.related.links',
            'webhelp.show.child.links',
            'webhelp.show.toggle.highlights',
            'webhelp.enable.search.autocomplete',
            'webhelp.enable.sticky.header',
            'webhelp.enable.sticky.publication.toc',
            'webhelp.enable.sticky.topic.toc',
            'webhelp.publication.toc.tooltip.position',
            'webhelp.search.enable.pagination',
            'webhelp.search.page.numberOfItems',
            'webhelp.custom.search.engine.enabled',
            'webhelp.default.collection.type.sequence',
            'args.hide.parent.link',
            'use.stemming',
            'webhelp.sitemap.priority',
            'webhelp.sitemap.change.frequency',
            'default.language',
            'webhelp.show.changes.and.comments',
            'webhelp.enable.template.js.module.loading',
            (: Property computed in the build file. (This is not a scenario parameter) :)
            'webhelp.language',
            (: Property set by the publishing template task. (This is not a scenario parameter) :)
            'webhelp.js.module.rel.path',
            'webhelp.show.full.size.image',
            'webhelp.enable.search.kuromoji.js'
            )"/>

    <xsl:template match="/properties">
        <xsl:variable name="jsonXml">
            <xsl:apply-templates mode="jsonXml" select="."/>
        </xsl:variable>
        <xsl:variable name="json" select="fn:xml-to-json($jsonXml, map{'indent':true()})"/>
        <xsl:value-of select="fn:concat('define(', $json, ');')"/>
    </xsl:template>
    <xsl:template match="properties" mode="jsonXml">
        <fn:map>
            <xsl:apply-templates mode="#current"/>
        </fn:map>
    </xsl:template>
    <xsl:template match="property[@name = $allowed-webhelp-options]" mode="jsonXml">
        <fn:string key="{@name}"><xsl:value-of select="@value"/></fn:string>
    </xsl:template>
    <xsl:template match="text()" mode="properties"></xsl:template>
</xsl:stylesheet>
