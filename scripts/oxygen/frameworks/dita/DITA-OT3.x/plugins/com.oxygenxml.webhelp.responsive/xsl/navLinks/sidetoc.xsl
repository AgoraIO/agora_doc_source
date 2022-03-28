<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc" xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xhtml="http://www.w3.org/1999/xhtml"
    xmlns:st="http://www.oxygenxml.com/ns/webhelp/side-toc" 
    exclude-result-prefixes="xs toc st xhtml" version="2.0">

	<!-- It sets how many nodes are visible before and after current node -->
	<xsl:variable name="nodesVisible" select="1000000" as="xs:integer"/>
    
    <xsl:variable name="expandActionID" as="xs:string">button-expand-action</xsl:variable>
    <xsl:variable name="collapseActionID" as="xs:string">button-collapse-action</xsl:variable>
    <xsl:variable name="pendingActionID" as="xs:string">button-pending-action</xsl:variable>
    
    <xsl:template match="/toc:toc" mode="side-toc">
        <xsl:apply-templates mode="side-toc"/>
    </xsl:template>
    
    <!-- 
        Processes the current topic node and generates the Side TOC for it in a temporary file
        next to the refenced topic file.
        
        @param parentHTML The HTML content that has been generated for the parent 
                          node of the current topic.
    -->
    <xsl:template match="toc:topic" mode="side-toc">
        <xsl:param name="parentHTML" tunnel="yes" as="node()*" select="()"/>
        
        <!-- 
            The HTML content for the level of the current node.
            It contains the current node and its siblings in document order. 
        -->
        <xsl:variable name="currentLevelHTML" as="node()*">
            
            <!-- Do not include siblings for the topics on the first level if not all links should be generated. -->
            <xsl:variable name="includeSiblings" as="xs:boolean" >
                <xsl:choose>
                    <xsl:when test="$WEBHELP_SIDE_TOC_LINKS != ''">
                        <xsl:value-of select="($parentHTML and $WEBHELP_SIDE_TOC_LINKS = 'chapter') or $WEBHELP_SIDE_TOC_LINKS = 'all'"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="($parentHTML and $WEBHELP_PUBLICATION_TOC_LINKS = 'chapter') or $WEBHELP_PUBLICATION_TOC_LINKS = 'all'"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>
            
            <xsl:if test="$includeSiblings">
                <!-- 
                    The HTML content for the previous siblings of the current node.
                    Only the top level nodes will be processed. No recursion is done. 
                -->
                <xsl:variable name="countPrecedingSiblings" select="count(preceding-sibling::toc:topic)" as="xs:integer"/>
                <xsl:variable name="vPosition" select="position()" />
                
                <!-- 
                    WH-231
                    Compute the preceding siblings for side-toc compactation
                -->
                <xsl:variable name="more" select="$countPrecedingSiblings - $nodesVisible"/>
                <xsl:if test="($countPrecedingSiblings > $nodesVisible) and ($more > 1)" xml:space="preserve">
                    <li class="dots-before"><span><xsl:value-of select="$more"/> <xsl:call-template name="getWebhelpString"><xsl:with-param name="stringName" select="'more'"/></xsl:call-template></span></li>
                </xsl:if>
                
                <xsl:apply-templates select="preceding-sibling::toc:topic" mode="topic2html">
                    <xsl:with-param name="currentNode" select="false()" tunnel="yes"/>
                    <xsl:with-param name="precedingSiblings" select="$countPrecedingSiblings" tunnel="yes"/>
                </xsl:apply-templates>
            </xsl:if>

            <!-- 
                The HTML content for the current node, which is generated separately because,
                from all the nodes from the current level, only this node will have 
                its direct children generated in the current Side TOC.
            -->
            <xsl:apply-templates select="." mode="topic2html">
                <xsl:with-param name="currentNode" select="true()" tunnel="yes"/>
            </xsl:apply-templates>

            <xsl:if test="$includeSiblings">
                <!-- 
                    The HTML content for the following siblings of the current node.
                    Only the top level nodes will be processed. No recursion is done.
                -->
                <xsl:variable name="countFollowingSiblings" select="count(following-sibling::toc:topic)" as="xs:integer"/>
                <xsl:variable name="xPosition" select="position()" />    
                <xsl:apply-templates select="following-sibling::toc:topic" mode="topic2html">
                    <xsl:with-param name="currentNode" select="false()" tunnel="yes"/>
                    <xsl:with-param name="followingSiblings" select="$countFollowingSiblings" tunnel="yes"/>
                </xsl:apply-templates>
                
                <!-- 
                    WH-231
                    Compute the following siblings for side-toc compactation
                -->
                <xsl:variable name="more" select="$countFollowingSiblings - $nodesVisible"/>
                <xsl:if test="($countFollowingSiblings > $nodesVisible) and ($more > 1)" xml:space="preserve">
                    <li class="dots-after"><span><xsl:value-of select="$more"/> <xsl:call-template name="getWebhelpString"><xsl:with-param name="stringName" select="'more'"/></xsl:call-template></span></li>
                </xsl:if>
            </xsl:if>
        </xsl:variable>
        
        <xsl:variable name="getSideTocValue">
            <xsl:choose>
                <xsl:when test="$WEBHELP_SIDE_TOC_LINKS != ''">
                    <xsl:value-of select="$WEBHELP_SIDE_TOC_LINKS"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$WEBHELP_PUBLICATION_TOC_LINKS"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        
        <!-- 
            Merge the HTML content generated for the current level with 
            the HTML content of the current node's parent.
            
            A copy template from a specific mode will be applied on the parent HTML
            and the HTML of the current level. The current level HTML will be linked in the parent HTML
            when a certain marker attribute is encountered (i.e.: @data-processing-mode=linkPoint).
        -->
        <xsl:variable name="currentLevelHTMLWithParent" as="node()*">
            <xsl:choose>
                <xsl:when test="not(empty($parentHTML)) and $getSideTocValue != 'topic'">
		            <xsl:apply-templates select="$parentHTML" mode="linkInParent">
		                <xsl:with-param name="currentLevelHTML" select="$currentLevelHTML" tunnel="yes"/>
		                <xsl:with-param name="linkCurrentNode" select="true()" tunnel="yes"/>
		            </xsl:apply-templates>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:copy-of select="$currentLevelHTML"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        
        <!-- Generate the HTML content for the direct children of the current node. -->
        <xsl:variable name="childrenHTML" as="node()*">
            <xsl:if test="$WEBHELP_PUBLICATION_TOC_HIDE_CHUNKED_TOPICS = 'no' or not(contains(@chunk, 'to-content'))">
                <xsl:variable name="countChilds" select="count(child::toc:topic)" as="xs:integer"/>
                
                <xsl:apply-templates select="toc:topic" mode="topic2html">
                    <xsl:with-param name="currentNode" select="false()" tunnel="yes"/>
                    <xsl:with-param name="followingSiblings" select="$countChilds" tunnel="yes"/>
                </xsl:apply-templates>
                
                <!-- 
                    WH-231
                    Compute the childrens for side-toc compactation
                -->
                <xsl:variable name="more" select="$countChilds - $nodesVisible"/>
                <xsl:if test="($countChilds > $nodesVisible) and ($more > 1)" xml:space="preserve">
                    <li class="dots-after"><span><xsl:value-of select="$more"/>
                    <xsl:call-template name="getWebhelpString"><xsl:with-param name="stringName" select="'more'"/></xsl:call-template>
                    </span></li>
                </xsl:if>
            </xsl:if>
        </xsl:variable>

        <!--
            Link the HTML of the child nodes in the HTML merged above in order to obtain the Side TOC 
            for the current node.
            
            The SIDE TOC will contain:
                - the ancestors of the current node
                - the ancestors' siblings nodes
                - the siblings of the current node
                - the children of the current node
        -->
        <xsl:variable name="currentNodeSideToc" as="node()*">
            <xsl:apply-templates select="$currentLevelHTMLWithParent" mode="linkInParent">
                <xsl:with-param name="currentLevelHTML" select="$childrenHTML" tunnel="yes"/>
                <xsl:with-param name="linkCurrentNode" select="false()" tunnel="yes"/>
            </xsl:apply-templates>
        </xsl:variable>
        
        <!-- 
            Write the Side TOC for the current node in a temporary file 
            next to file of its referenced target topic. 
        -->
      <xsl:if test="not(@href = $VOID_HREF) and string-length(normalize-space(@href)) != 0 and not(@scope = 'external') and (not(@format) or @format = 'dita')">
            <!-- WH-1469: Handle the case when there are topicrefs with duplicate hrefs without @copy-to. -->
            <xsl:variable name="nodes" select="key('tocHrefs', tokenize(@href, '#')[1])"/>
            <xsl:if test="count($nodes) lt 2 or deep-equal(.,  $nodes[1])">
                <xsl:variable name="outputHref">
                    <xsl:value-of select="$TEMP_DIR_URL"/>
                    <xsl:call-template name="replace-extension">
                        <xsl:with-param name="extension" select="'.sidetoc'"/>
                        <xsl:with-param name="filename" select="@href"/>
                        <xsl:with-param name="ignore-fragment" select="true()"/>
                        <xsl:with-param name="forceReplace" select="true()"/>
                    </xsl:call-template>
                </xsl:variable>
                <xsl:result-document format="html" href="{$outputHref}">
                    <xsl:variable name="publicationToc">
                        <div data-type="temporary">
                            <span class="expand-button-action-labels">
                                <span id="{$expandActionID}" role="button" aria-label="Expand"/>
                                <span id="{$collapseActionID}" role="button" aria-label="Collapse"/>
                                <span id="{$pendingActionID}" role="button" aria-label="Pending"/>
                            </span>   
                            <ul>
                                <xsl:copy-of select="$currentNodeSideToc"/>
                            </ul>
                        </div>
                    </xsl:variable>
                    <xsl:apply-templates select="$publicationToc" mode="toc-accessibility"/>
                </xsl:result-document>
            </xsl:if>
        </xsl:if>
        
        <!-- 
            Recursively generate the Side TOC for the child nodes only if this is not a chunked topic.
            Pass down the HTML content generated for the current node without its children.
        -->
        <xsl:if test="not(contains(@chunk, 'to-content'))">
            <xsl:apply-templates select="toc:topic" mode="side-toc">
                <xsl:with-param name="parentHTML" select="$currentLevelHTMLWithParent" tunnel="yes"/>
            </xsl:apply-templates>
        </xsl:if>
        
    </xsl:template>
    
    <!-- Copy template for 'accesibility' mode. -->
    <xsl:template match="node() | @*" mode="toc-accessibility">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*" mode="toc-accessibility"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="xhtml:ul" mode="toc-accessibility">
        <xsl:copy>
            <xsl:variable name="isRoot" as="xs:boolean" select="exists(parent::node()[@data-type='temporary'])"/>
            <xsl:attribute name="role">
                <xsl:choose>
                    <xsl:when test="$isRoot">
                        <xsl:value-of>tree</xsl:value-of>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of>group</xsl:value-of>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>
            <xsl:apply-templates select="@*" mode="toc-accessibility"/>
            <xsl:if test="$isRoot">
                <xsl:attribute name="aria-label">Table of Contents</xsl:attribute>
            </xsl:if>
            
            <xsl:apply-templates select="node()" mode="toc-accessibility"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="xhtml:li" mode="toc-accessibility">
        <xsl:copy>
            <xsl:variable name="state" select="xhtml:div/@data-state"/>
            <xsl:attribute name="role">treeitem</xsl:attribute>
            <xsl:if test="not($state = 'leaf')">
                <xsl:attribute name="aria-expanded">
                    <xsl:choose>
                        <xsl:when test="$state = 'expanded'">
                            <xsl:value-of>true</xsl:value-of>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of>false</xsl:value-of>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates select="node() | @*" mode="toc-accessibility"/> 
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="xhtml:span[contains(@class, 'wh-expand-btn')]" mode="toc-accessibility">
        <xsl:copy>
            <xsl:variable name="state" select="parent::xhtml:div/@data-state"/>
            <xsl:attribute name="role">button</xsl:attribute>
            <xsl:if test="not($state = 'leaf')">
                <xsl:attribute name="tabindex">0</xsl:attribute>
                <xsl:attribute name="aria-labelledby">
                    <xsl:choose>
                        <xsl:when test="$state = 'expanded'">
                            <xsl:value-of select="$collapseActionID"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$expandActionID"/>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:value-of select="' '"/>
                    <xsl:value-of select="following-sibling::xhtml:div[contains(@class, 'title')]/xhtml:a/@id"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates select="node() | @*" mode="toc-accessibility"/>
        </xsl:copy>
    </xsl:template>
    

    <!-- Copy template. -->
    <xsl:template match="node() | @*" mode="linkInParent">
        <xsl:param name="currentLevelHTML" tunnel="yes" as="node()*"/>
        <xsl:param name="linkCurrentNode" tunnel="yes" as="xs:boolean"/>
        <xsl:copy>
            <xsl:apply-templates select="node() | @*" mode="#current">
                <xsl:with-param name="currentLevelHTML" select="$currentLevelHTML" tunnel="yes"/>
                <xsl:with-param name="linkCurrentNode" select="$linkCurrentNode" tunnel="yes"/>
            </xsl:apply-templates>
        </xsl:copy>
    </xsl:template>

    <!-- 
        Copies the HTML content of the parent tree and inserts the HTML content of the
        current level in the node marked with the '@data-processing-mode=linkPoint' attribute.
    -->    
    <xsl:template match="*[@data-processing-mode = 'linkPoint']" mode="linkInParent">
        <xsl:param name="currentLevelHTML" tunnel="yes" as="node()*"/>
        <xsl:param name="linkCurrentNode" tunnel="yes" as="xs:boolean"/>
        <xsl:copy>
            <xsl:variable name="filteredAtts" as="attribute()*">
                
            </xsl:variable>
            <xsl:choose>
                <xsl:when test="$linkCurrentNode">
                    <xsl:apply-templates select="@* except (@data-processing-mode | @class[contains(., 'active')])" mode="#current"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates select="@* except (@data-processing-mode)" mode="#current"/>
                </xsl:otherwise>
            </xsl:choose>
            
            <xsl:apply-templates select="node()" mode="#current">
                <xsl:with-param name="currentLevelHTML" select="$currentLevelHTML" tunnel="yes"/>
                <xsl:with-param name="linkCurrentNode" select="$linkCurrentNode" tunnel="yes"/>
            </xsl:apply-templates>
            <xsl:if test="$currentLevelHTML">
                <ul class="navbar-nav nav-list">
                    <xsl:copy-of select="$currentLevelHTML"/>
                </ul>
            </xsl:if>
        </xsl:copy>
    </xsl:template>
    
    <!-- Generates the HTML content for the current topic node. -->
    <!-- @param currentNode A boolean value marking the topic which the Side TOC is being generated for. -->
    <xsl:template match="toc:topic" mode="topic2html">
        <xsl:param name="currentNode" as="xs:boolean" tunnel="yes"/>
        <xsl:param name="precedingSiblings" tunnel="yes" as="xs:integer" select="0"/>
        <xsl:param name="followingSiblings" tunnel="yes" as="xs:integer" select="0"/>
        <xsl:variable name="vPosition" select="position()" />
        <xsl:variable name="moreNext" select="$followingSiblings - $nodesVisible"/>
        <xsl:variable name="morePrev" select="$precedingSiblings - $nodesVisible"/>
        
				<!-- 
            WH-231
            Add the css selector for the side-toc compactation
        -->
        <li>
            <xsl:if test="$currentNode"><xsl:attribute name="class" select="'active'"/> </xsl:if>
            <xsl:if test="$followingSiblings and ($vPosition &gt; $nodesVisible) and ($moreNext &gt; 1)"><xsl:attribute name="class" select="'hide-after'"/></xsl:if>
            <xsl:if test="$precedingSiblings and ((($precedingSiblings - $nodesVisible + 1) &gt; $vPosition ) and ($morePrev &gt; 1))"><xsl:attribute name="class" select="'hide-before'"/></xsl:if>
            <xsl:if test="$currentNode">
                <!-- 
                     The HTML content corresponding to the child topics will only be generated
                     if this node is the topic which the Publication TOC is being generated for.
                -->
                <xsl:attribute name="data-processing-mode" select="'linkPoint'"/>
            </xsl:if>
            <div data-tocid="{@wh-toc-id}">
                <xsl:attribute name="class">
                    <xsl:value-of select="'topicref'"/>
                    <xsl:if test="@outputclass">
                        <xsl:value-of select="concat(' ', @outputclass)"/>
                    </xsl:if>
                </xsl:attribute>
                <!-- WH-1820 Copy the Ditaval "pass through" attributes. -->
                <xsl:copy-of select="@*[starts-with(local-name(), 'data-')]"/>
                <xsl:attribute name="data-state">
                    <xsl:variable name="hasChildren" as="xs:boolean">
                        <xsl:choose>
                            <xsl:when test="$WEBHELP_PUBLICATION_TOC_HIDE_CHUNKED_TOPICS = 'yes' and contains(@chunk, 'to-content')">
                                <xsl:value-of select="false()"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="count(toc:topic) > 0"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:variable> 
                    
                    <xsl:choose>
                        <xsl:when test="boolean($hasChildren)">
                            <xsl:choose>
                                <xsl:when test="$currentNode">expanded</xsl:when>
                                <xsl:otherwise>not-ready</xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>
                        <xsl:otherwise>leaf</xsl:otherwise>
                    </xsl:choose>
                </xsl:attribute>
                <xsl:variable name="hrefValue">
                    <xsl:call-template name="computeHrefAttr"/>
                </xsl:variable>
                <span class="wh-expand-btn"/>
                <div class="title">
                    <a href="{$hrefValue}" id="{@wh-toc-id}-link">
                        <xsl:if test="@scope='external'">
                            <!-- Mark the current link as being external to the DITA map. -->
                            <xsl:attribute name="data-scope">external</xsl:attribute>
                        </xsl:if>
                        <xsl:copy-of select="toc:title/node()"/>
                    </a>
                    <xsl:apply-templates select="toc:shortdesc" mode="topic2html"/>
                </div>
            </div>
        </li>
    </xsl:template>
    
    <!-- Compute the href attribute to be used when compute link to topic  -->
    <xsl:template name="computeHrefAttr">
        <xsl:choose>
            <xsl:when test="@href and @href != $VOID_HREF">
                <xsl:value-of select="@href"/>
            </xsl:when>
            <xsl:otherwise>
                <!-- EXM-38925 Select the href of the first descendant topic ref -->
                <xsl:value-of select="descendant::toc:topic[@href and @href != $VOID_HREF][1]/@href"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="toc:shortdesc" mode="topic2html">
        <div class="wh-tooltip">
            <xsl:copy-of select="node()"/>
        </div>
    </xsl:template>
    
	<xsl:template match="text()" mode="side-toc"/>
</xsl:stylesheet>
