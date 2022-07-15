<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0"
    xmlns:t="http://www.oxygenxml.com/ns/webhelp/toc">
    
    <xsl:import href="../util/jsonUtil.xsl"/>
    
    <xsl:variable name="EXT" select="'js'" as="xs:string"/>
    
    <xsl:template match="t:toc" mode="nav-json">
        <xsl:apply-templates select="." mode="output-json"/>
    </xsl:template>
    
    <xsl:template match="t:toc" mode="output-json">
        <xsl:result-document href="{$JSON_OUTPUT_DIR_URI}/nav-links.{$EXT}" format="json">
            <xsl:variable name="jsonXml">
                <xsl:call-template name="object-property">
                    <xsl:with-param name="value">
                        <xsl:apply-templates select="t:title" mode="build-json"/>
                        <xsl:call-template name="array-property">
                            <xsl:with-param name="name">topics</xsl:with-param>
                            <xsl:with-param name="value">
                                <xsl:apply-templates select="t:topic" mode="build-json"/>
                            </xsl:with-param>
                        </xsl:call-template>
                    </xsl:with-param>
                </xsl:call-template>
            </xsl:variable>
            <xsl:variable name="json">
                <xsl:call-template name="xml2Json">
                    <xsl:with-param name="jsonXml" select="$jsonXml"/>
                </xsl:call-template>
            </xsl:variable>
            <xsl:value-of select="concat('define(', $json, ');')"/>
        </xsl:result-document>
        <xsl:apply-templates select="t:topic" mode="output-json"/>
    </xsl:template>
    
    <xsl:template match="t:title" mode="build-json">
        <xsl:call-template name="string-property">
            <xsl:with-param name="name">title</xsl:with-param>
            <xsl:with-param name="value" select="node()"/>
        </xsl:call-template>
    </xsl:template>
    
    <xsl:template match="t:shortdesc" mode="build-json">
        <xsl:call-template name="string-property">
            <xsl:with-param name="name">shortdesc</xsl:with-param>
            <xsl:with-param name="value" select="node()"/>
        </xsl:call-template>
    </xsl:template>
    
    <xsl:template match="t:topic" mode="output-json">
        <xsl:if test="count(t:topic) > 0">
            <xsl:variable name="tocID" select="@wh-toc-id"/>
            <xsl:result-document href="{$JSON_OUTPUT_DIR_URI}/{$tocID}.{$EXT}" format="json">
                <xsl:variable name="jsonXml">
                    <xsl:call-template name="object-property">
                        <xsl:with-param name="value">
                            <xsl:call-template name="array-property">
                                <xsl:with-param name="name">topics</xsl:with-param>
                                <xsl:with-param name="value">
                                    <xsl:apply-templates select="t:topic" mode="build-json"/>
                                </xsl:with-param>
                            </xsl:call-template>
                        </xsl:with-param>
                    </xsl:call-template>
                </xsl:variable>
                <xsl:variable name="json">
                    <xsl:call-template name="xml2Json">
                        <xsl:with-param name="jsonXml" select="$jsonXml"/>
                    </xsl:call-template>
                </xsl:variable>
                <xsl:value-of select="concat('define(', $json, ');')"/>
            </xsl:result-document>
            <xsl:apply-templates select="t:topic" mode="output-json"/>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="t:topic" mode="build-json">
        <xsl:call-template name="object-property">
            <xsl:with-param name="value">
                
                <xsl:apply-templates select="t:title" mode="build-json"/>
                <xsl:apply-templates select="t:shortdesc" mode="build-json"/>
                
                <xsl:choose>
                    <xsl:when test="@href = $VOID_HREF">
                        <!-- WH-1781 Select the @href & @scope of the first descendant topic ref -->
                        <xsl:variable name="topicRefDescendant" select="descendant::t:topic[@href and @href != $VOID_HREF][1]"/>
                        <xsl:call-template name="string-property">
                            <xsl:with-param name="name">href</xsl:with-param>
                            <xsl:with-param name="value">
                                <xsl:choose>
                                    <xsl:when test="$topicRefDescendant/@href">
                                        <xsl:value-of select="$topicRefDescendant/@href"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of select="@href"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:with-param>
                        </xsl:call-template>
                        <xsl:if test="$topicRefDescendant/@scope">
                            <xsl:call-template name="string-property">
                                <xsl:with-param name="name">scope</xsl:with-param>
                                <xsl:with-param name="value" select="$topicRefDescendant/@scope"/>
                            </xsl:call-template>
                        </xsl:if>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:call-template name="string-property">
                            <xsl:with-param name="name">href</xsl:with-param>
                            <xsl:with-param name="value" select="@href"/>
                        </xsl:call-template>
                        <xsl:if test="@scope">
                            <xsl:call-template name="string-property">
                                <xsl:with-param name="name">scope</xsl:with-param>
                                <xsl:with-param name="value" select="@scope"/>
                            </xsl:call-template>
                        </xsl:if>
                    </xsl:otherwise>
                </xsl:choose>
                
                <xsl:if test="@outputclass">
                    <xsl:call-template name="string-property">
                        <xsl:with-param name="name">outputclass</xsl:with-param>
                        <xsl:with-param name="value" select="@outputclass"/>
                    </xsl:call-template>
                </xsl:if>
                
                <!-- WH-1820 Copy the Ditaval "pass through" attributes. -->
                <xsl:variable name="dataAtts" select="@*[starts-with(local-name(), 'data-')]"/>
                <xsl:if test="$dataAtts">
                    <xsl:call-template name="object-property">
                        <xsl:with-param name="name">attributes</xsl:with-param>
                        <xsl:with-param name="value">
                            <xsl:for-each select="$dataAtts">
                                <xsl:call-template name="string-property">
                                    <xsl:with-param name="name" select="local-name()"></xsl:with-param>
                                    <xsl:with-param name="value" select="."/>
                                </xsl:call-template>
                            </xsl:for-each>
                        </xsl:with-param>
                    </xsl:call-template>
                </xsl:if>
                
                <xsl:call-template name="object-property">
                    <xsl:with-param name="name">menu</xsl:with-param>
                    <xsl:with-param name="value">
                        <xsl:variable name="menuChildCount" 
                            select="count(t:topic[not(t:topicmeta/t:data[@name='wh-menu']/t:data[@name='hide'][@value='yes'])])"/>
                        
                        <xsl:variable name="currentDepth" select="count(ancestor-or-self::t:topic)"/>
                        <xsl:variable name="maxDepth" select="number($WEBHELP_TOP_MENU_DEPTH)"/>
                        
                        <!-- Decide if this topic has children for the menu component. -->
                        <xsl:variable name="hasChildren" select="$menuChildCount > 0 and ($maxDepth le 0 or $maxDepth > $currentDepth)"/>
                        
                        <xsl:call-template name="boolean-property">
                            <xsl:with-param name="name">hasChildren</xsl:with-param>
                            <xsl:with-param name="value" select="$hasChildren"/>
                        </xsl:call-template>
                        <xsl:apply-templates select="t:topicmeta/t:data[@name='wh-menu']" mode="build-json"/>
                    </xsl:with-param>
                </xsl:call-template>
                
                <xsl:variable name="tocID" select="@wh-toc-id"/>
                
                <xsl:call-template name="string-property">
                    <xsl:with-param name="name">tocID</xsl:with-param>
                    <xsl:with-param name="value" select="$tocID"/>
                </xsl:call-template>
                
                <xsl:choose>
                    <xsl:when test="count(t:topic) = 0">
                        <xsl:call-template name="array-property">
                            <xsl:with-param name="name">topics</xsl:with-param>
                        </xsl:call-template>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:call-template name="string-property">
                            <xsl:with-param name="name">next</xsl:with-param>
                            <xsl:with-param name="value" select="$tocID"/>
                        </xsl:call-template>
                        
                        
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:with-param>
        </xsl:call-template>
    </xsl:template>
    
    <xsl:template match="t:topicmeta/t:data[@name='wh-menu']" mode="build-json">
        <xsl:if test="t:data[@name='image'][@href]">
            <xsl:call-template name="object-property">
                <xsl:with-param name="name">image</xsl:with-param>
                <xsl:with-param name="value">
                    <xsl:apply-templates select="t:data[@name='image'][@href]" mode="build-json"/>
                </xsl:with-param>
            </xsl:call-template>
        </xsl:if>
        <xsl:if test="t:data[@name='hide'][@value='yes']">
            <xsl:call-template name="boolean-property">
                <xsl:with-param name="name">isHidden</xsl:with-param>
                <xsl:with-param name="value" select="true()"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="t:data[@name='image'][@href]" mode="build-json">
        <xsl:call-template name="string-property">
            <xsl:with-param name="name">href</xsl:with-param>
            <xsl:with-param name="value" select="@href"/>
        </xsl:call-template> 
        
        <xsl:if test="@scope">
            <xsl:call-template name="string-property">
                <xsl:with-param name="name">scope</xsl:with-param>
                <xsl:with-param name="value" select="@scope"/>
            </xsl:call-template>
        </xsl:if>
        
        <xsl:variable name="attrWidth" select="t:data[@name = 'attr-width'][@value]"/>
        <xsl:if test="$attrWidth">
            <xsl:call-template name="string-property">
                <xsl:with-param name="name">width</xsl:with-param>
                <xsl:with-param name="value" select="$attrWidth/@value"/>
            </xsl:call-template>
        </xsl:if>
        
        <xsl:variable name="attrHeight" select="t:data[@name = 'attr-height'][@value]"/>
        <xsl:if test="$attrHeight">
            <xsl:call-template name="string-property">
                <xsl:with-param name="name">height</xsl:with-param>
                <xsl:with-param name="value" select="$attrHeight/@value"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="text()"  mode="build-json output-json nav-json"/>
</xsl:stylesheet>