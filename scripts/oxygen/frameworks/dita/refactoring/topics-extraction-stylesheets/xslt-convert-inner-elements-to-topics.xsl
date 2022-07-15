<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:f="http://www.oxygenxml.com/xsl/functions"
    xmlns:map="http://www.w3.org/2005/xpath-functions/map"
    exclude-result-prefixes="xs xd f map"
    version="3.0">
    
    <!-- IMPORT THE CHAR MAP -->
    <xsl:import href="character-map.xsl"/>
    <xsl:import href="dita-formats.xsl"/>
    
    <!-- true if we want to prefix the topics file name with the input file name. -->
    <xsl:param name="add.file.name.as.prefix" as="xs:boolean" select="true()"/>
    
    <xsl:param name="matchElement" as="xs:string*"/>
    <xsl:param name="topicElement" 
        select="('topic', 'task', 'glossentry', 'concept', 'glossgroup', 'reference', 'troubleshooting')"></xsl:param>
    <xsl:variable name='newline'><xsl:text>
</xsl:text></xsl:variable>
    
    <xd:doc>
        <xd:desc>Verifies if the current node is a topic(or specialization).</xd:desc>
        <xd:param name="node">Current node to check.</xd:param>
    </xd:doc>
    <xsl:function name="f:match4extraction" as="xs:boolean">
        <xsl:param name="node" as="node()"/>
        <xsl:sequence select="local-name($node) = $matchElement"/>
    </xsl:function>
    
    <xsl:variable name="extension" select="concat('.', tokenize(base-uri(), '[.]')[last()])"/>
    <xsl:variable name="timeStamp" select="( current-dateTime() - xs:dateTime('1970-01-01T00:00:00')) div xs:dayTimeDuration('PT1S') * 1000"/>
    
    <xd:doc>
        <xd:desc>DEFAULT COPY TEMPLATE</xd:desc>
    </xd:doc>
    <xsl:template match="node()[not(f:match4extraction(.))] | @*">
        <xsl:copy>
            <xsl:apply-templates select="node()[not(f:match4extraction(.))] | @*"/>
        </xsl:copy>
    </xsl:template>    
    
    <xd:doc>
        <xd:desc>Attributes copy template of generated documents. Cleanup: Skip oXygen attributes.</xd:desc>
    </xd:doc>
    <xsl:template match="@*" mode="write-sect">
        <xsl:if
            test="not(namespace-uri() = 'http://www.oxygenxml.com/ns/xmlRefactoring/additional_attributes')">
            <xsl:copy/>
        </xsl:if>
    </xsl:template>
    
    <xd:doc>
        <xd:desc> Update the href attributes for cross references.</xd:desc>
    </xd:doc>
    <xsl:template match="@href[starts-with(., '#')]" mode="write-sect">
        <xsl:attribute name="href">
            <xsl:value-of select="f:updateHrefValue(., /, base-uri())"/>
        </xsl:attribute>
    </xsl:template>
    
    <xd:doc>
        <xd:desc> Update the href attributes for cross references.</xd:desc>
    </xd:doc>
    <xsl:template match="@href[starts-with(., '#')]">
        <xsl:attribute name="href">
            <xsl:value-of select="f:updateHrefValue(., /,  base-uri())"/>
        </xsl:attribute>
    </xsl:template>
    
    <xd:doc>
        <xd:desc>Update the value of the given href attribute.</xd:desc>
        <xd:param name="href">The attribute to update</xd:param>
        <xd:param name="root">The root node</xd:param>
        <xd:param name="baseURI">System ID of the current file.</xd:param>
        <xd:return>The value (new or the same) for the href attribute.</xd:return>
    </xd:doc>
    <xsl:function name="f:updateHrefValue" as="xs:string">
        <xsl:param name="href" as="attribute()"></xsl:param>
        <xsl:param name="root" as="node()"></xsl:param>
        <xsl:param name="baseURI" as="xs:string"/>
        <xsl:variable name="targetId" select="substring($href, 2)"/>
        <xsl:choose>
            <xsl:when test="contains($href, '/')">
                <!-- #topicId/elementId -->
                <xsl:variable name="topicId" select=" normalize-space(substring-before($targetId, '/'))"/>
                <xsl:variable name="elementId" select="substring-after($targetId, '/')"/>
                <xsl:choose>
                    <xsl:when test="$topicId = '.' or not(empty($href/ancestor::*[@id = $topicId]))">
                        <!-- topicId is the parent topic -->
                        <xsl:variable name="parentTopicNode" >
                            <xsl:choose>
                                <xsl:when test="$topicId = '.'">
                                    <xsl:sequence select="($href/ancestor::*[@id and local-name() = $topicElement])[last()]"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:sequence select="($href/ancestor::*[@id = $topicId])[last()]"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:variable>
                        <xsl:variable name="elementNode" select="($parentTopicNode/descendant::*[@id = $elementId])[1]"/>
                        <xsl:choose>
                            <xsl:when test="$elementNode and f:match4extraction($elementNode)">
                                <!-- referred element will match for extraction -->
                                <xsl:value-of select="concat(f:generateOutputFileName($elementNode, $baseURI), '#', $elementId)"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:variable name="parentNodeMatchExtraction" select="($elementNode/ancestor::*[f:match4extraction(.)])[last()]"/>
                                <xsl:choose>
                                    <xsl:when test="$parentNodeMatchExtraction and ($parentNodeMatchExtraction != $parentTopicNode)">
                                        <!-- referred element is in a section that will match for extraction -->
                                        <xsl:value-of select="concat(f:generateOutputFileName($parentNodeMatchExtraction, $baseURI), '#', $parentNodeMatchExtraction/@id, '/', $elementId)"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of select="$href"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:otherwise>
                        <!-- topicId is not the parent topic -->
                        <xsl:variable name="topicNode" select="($root/descendant::*[@id = $topicId])[1]"/>
                        <xsl:variable name="elementNode" select="($topicNode/descendant::*[@id = $elementId])[1]"/>
                        <xsl:choose>
                            <xsl:when test="$elementNode and f:match4extraction($elementNode)">
                                <!-- referred element will match for extraction -->
                                <xsl:value-of select="concat(f:generateOutputFileName($elementNode, $baseURI), '#', $elementId)"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:choose>
                                    <xsl:when test="$topicNode and f:match4extraction($topicNode)">
                                        <!-- referred topic will match for extraction -->
                                        <xsl:value-of select="concat(f:generateOutputFileName($topicNode, $baseURI), $href)"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:choose>
                                            <xsl:when test="not(empty($href/ancestor::*[f:match4extraction(.)]))">
                                                <!-- This href is from a section that will be extracted, but the target topic will not be moved. -->
                                                <xsl:variable name="fileName" select="(tokenize($baseURI,'/'))[last()]"/>
                                                <xsl:value-of select="concat($fileName, $href)"/>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:value-of select="$href"/>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <!-- #elementId -->
                <xsl:variable name="topicTargetElementNode" select="($root/descendant::*[@id = $targetId])[1]"/>
                <xsl:choose>
                    <xsl:when test="$topicTargetElementNode and f:match4extraction($topicTargetElementNode)">
                        <xsl:value-of select="concat(f:generateOutputFileName($topicTargetElementNode, $baseURI), $href)"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:choose>
                            <xsl:when test="not(empty($href/ancestor::*[f:match4extraction(.)]))">
                                <!-- This href is from a section that will be extracted, but the target topic will not be moved. -->
                                <xsl:variable name="fileName" select="(tokenize($baseURI,'/'))[last()]"/>
                                <xsl:value-of select="concat($fileName, $href)"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="$href"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    
    <xd:doc>
        <xd:desc>Node copy template of generated documents. </xd:desc>
    </xd:doc>
    <xsl:template match="node()[not(f:match4extraction(.))]" mode="write-sect">
        <xsl:copy>
            <xsl:apply-templates select="node()[not(f:match4extraction(.))] | @*[not(namespace-uri() = 'http://www.oxygenxml.com/ns/xmlRefactoring/additional_attributes')]" mode="write-sect"/>
        </xsl:copy>
    </xsl:template>
    
    <!--EXM-49339: We use this map as a cache because the "f:generateUniqueFileName" can be called several times for a node. -->
    <xsl:variable name="topicToFileNameMap" as="map(xs:string, xs:string)">
        <xsl:map>
            <xsl:for-each select="//*[f:match4extraction(.)]">
                <xsl:variable name="uniqueFileName" select="f:generateUniqueFileName(.)"/>
                <xsl:map-entry key="generate-id(.)" select="xs:string($uniqueFileName)"></xsl:map-entry>
            </xsl:for-each>
        </xsl:map>
    </xsl:variable>
    
    <xd:doc>
        <xd:desc>Generate names for newly created files. Try to use topic's title, if any. If this fails 
            topic's ID is used. If this also fails generate a random name.</xd:desc>
        <xd:param name="node">Current node</xd:param>
        <xd:param name="baseURI">System ID of the current file.</xd:param>
        <xd:return>A name for refactored file.</xd:return>
    </xd:doc>
    <xsl:function name="f:generateOutputFileName" as="xs:string">
        <xsl:param name="node" as="node()"></xsl:param>
        <xsl:param name="baseURI" as="xs:string"/>
        <xsl:variable name="currentFileNameToUseAsPrefix" select="f:extractPrefixFromRefactoredFile($baseURI)"/>
        
        <xsl:variable name="nodeId" select="generate-id($node)"/>
        <xsl:variable name="uniqueFileName">
            <xsl:choose>
                <xsl:when test="map:contains($topicToFileNameMap, $nodeId)">
                    <xsl:value-of select="map:get($topicToFileNameMap, $nodeId)"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="f:generateUniqueFileName($node)"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        
        <xsl:variable name="fileNameCandidate">
            <xsl:choose>
                <xsl:when test="$add.file.name.as.prefix">
                    <xsl:value-of select="concat($currentFileNameToUseAsPrefix, '_', $uniqueFileName)"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$uniqueFileName"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        
        <!-- check if file exists on file system -->
        <xsl:variable name="generatedFileSystemID" select="resolve-uri($fileNameCandidate, $baseURI)"/>
        
        <xsl:choose>
            <xsl:when test="doc-available($generatedFileSystemID)">
                <!-- NEW FILE -->
                <xsl:value-of select="concat(substring-before($fileNameCandidate, $extension), '_', $timeStamp, $extension)"/>
            </xsl:when>
            <xsl:otherwise>
                <!-- save that file -->
                <xsl:value-of select="$fileNameCandidate"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    
    <xd:doc>
        <xd:desc>Corrects id of a topic such as it will NCName.
         Moreover it eliminates "%20".</xd:desc>
        <xd:param name="text">Text to be corrected</xd:param>
        <xd:return>The corrected text which can be used as id</xd:return>
    </xd:doc>
    <xsl:function name="f:correctId" as="xs:string">
        <xsl:param name="text" as="xs:string"/>
        <xsl:variable name="tempId" select="replace(lower-case(xs:string($text)), '%20', '_')"/>
        <xsl:variable name="tempId2" select="replace($tempId, '[^\w_-]|[+]', '')"/>
        <xsl:variable name="tempId3" select="replace($tempId2,'[_]+', '_')"/>
		<xsl:value-of select="replace($tempId3, '^[0-9.-]+', '')"/>
    </xsl:function>
    <xd:doc>
        <xd:desc>Generate a file name for each element. Does not guarantees the propsals are unique.</xd:desc>
        <xd:param name="node">Current node</xd:param>
    </xd:doc>
    <xsl:function name="f:generateFileName">
        <xsl:param name="node" as="node()"/>
        
        <!-- NODE TITLE -->
        <xsl:variable name="titleVal" select="$node/title"/>
        <!-- NODE ID -->
        <xsl:variable name="nodeID" select="$node/@id"/> 
        
        <xsl:variable name="fileName">
        <xsl:choose>
            <!-- First should try the title.-->
            <xsl:when test="$titleVal and $titleVal != ''">
                <xsl:value-of select="$titleVal"/>
            </xsl:when>
            <xsl:otherwise>
                <!-- No title; use sectionID. -->
                <xsl:choose>
                    <xsl:when test="$nodeID">
                        <xsl:value-of select="$nodeID"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="generate-id($node)"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
        </xsl:variable>   
        <xsl:variable name="normalizedName">
            <xsl:value-of select="replace(lower-case(normalize-space(xs:string($fileName))), ' ', '_')"/>
        </xsl:variable>
        
        <xsl:variable name="tempCorrectedName">
            <xsl:call-template name="correctFilenames">
                <xsl:with-param name="fileName" select="$normalizedName"></xsl:with-param>
            </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="correctedName" select="replace($tempCorrectedName, '[_]+', '_')"/>
        
        <xsl:value-of select="translate($correctedName, '\/:*&lt;&gt;&quot;|;&amp;!@#$%^?[]{}()', '')"/>
    </xsl:function>
    
    <xd:doc>
        <xd:desc>Corrects the names of the generate files replacing non ASCII characters and any
            special symbols with their ASCII equivalent (if exists) or underline symbol "_".</xd:desc>
        <xd:param name="fileName">Name of the generated file to correct.</xd:param>
    </xd:doc>
    <xsl:template  name="correctFilenames">
        <xsl:param name="fileName" as="xs:string"/>
        <xsl:variable name="corrected">
            <xsl:analyze-string select="$fileName" regex=".">
                <xsl:matching-substring>
                    <xsl:choose>
                        <xsl:when test="$char-map(.)">
                            <xsl:value-of select="replace(., ., $char-map(.))"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="."/>
                        </xsl:otherwise>
                    </xsl:choose>
                    
                </xsl:matching-substring>
            </xsl:analyze-string>
        </xsl:variable>
        <xsl:value-of select="$corrected"/>
    </xsl:template>
    
    <xd:doc>
        <xd:desc>Generates an unique name for each topic.</xd:desc>
        <xd:param name="node">Current node</xd:param>
    </xd:doc>
    <xsl:function name="f:generateUniqueFileName">
        <xsl:param name="node" as="node()"/>
        <xsl:variable name="proposedFileName" select="f:generateFileName($node)"/>
        <xsl:variable name="uniqueNumber">            
            <xsl:value-of select="count($node/(preceding::* | ancestor:: *)[f:match4extraction(.)][f:generateFileName(.) = $proposedFileName])"/>
        </xsl:variable>
        <xsl:variable name="uniqueNumberSufix">
            <xsl:if test="$uniqueNumber > 0"><xsl:value-of select="$uniqueNumber"/></xsl:if>
        </xsl:variable>
        <xsl:value-of select="concat($proposedFileName, $uniqueNumberSufix, $extension)"/>        
    </xsl:function>
    
    <xd:doc>
        <xd:desc>Returns the name of the refactored files. Each new generated file will use this filename as prefix.</xd:desc>
        <xd:param name="baseURI">System ID of refactored file.</xd:param>
        <xd:return>Current file name without extension.</xd:return>
    </xd:doc>
    <xsl:function name="f:extractPrefixFromRefactoredFile">
        <xsl:param name="baseURI" as="xs:string"/>
        <xsl:variable name="fileName" select="(tokenize($baseURI,'/'))[last()]"/>
        <xsl:variable name="currentExtension" select="(tokenize($fileName, '\.'))[last()]"/>
        
        <xsl:value-of select="replace(substring-before($fileName, concat('.', $currentExtension)), '[_]+', '_')"/>
    </xsl:function>
    
</xsl:stylesheet>