<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xra="http://www.oxygenxml.com/ns/xmlRefactoring/additional_attributes"
    xmlns:f="http://www.oxygenxml.com/xsl/functions"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xrf="http://www.oxygenxml.com/ns/xmlRefactoring/functions"
    version="3.0" 
    exclude-result-prefixes="xra xs f xd xrf">
    
    <!-- true if we want to prefix the topics file name with the input file name. -->
    <xsl:param name="add.file.name.as.prefix" as="xs:boolean" select="true()"/>
    
    <xsl:param name="matchElement" 
        select="$topicElement"/>
    <xsl:import href="xslt-convert-inner-elements-to-topics.xsl"/>
    
    <xsl:variable name="RNG_MODEL_REGEX_PATTERN" select="'&lt;\?xml-model\s+(.*?)schematypens=&quot;http://relaxng.org/ns/structure/1.0&quot;(.*?)\?&gt;'"/>
    <!--
        i = case insensitive
        s = Enables “dotall” mode, that allows a dot . to match newline character 
        // not needed for current use-case
        m = multiline; treat beginning and end characters (^ and $) as working over multiple lines
    --> 
    <xsl:variable name="REGEX_FLAGS" select="'ism'"/>
    
    <xd:doc>
        <xd:desc>Entry point. Match topic and generate new files for them.</xd:desc>
    </xd:doc>
    <xsl:template match="/*">
        <!-- Write to new files all descendents that match the extraction creteria. -->
        <xsl:apply-templates mode="emit" select=".//*[f:match4extraction(.)]"/>
        
        <!-- Copy the other ones. -->
        <xsl:copy>
            <xsl:apply-templates select="(node() except node()[f:match4extraction(.)]) | @*"/>
        </xsl:copy>
    </xsl:template>
    
    <xd:doc>
        <xd:desc>Match topics and call the template that creates new files.</xd:desc>
    </xd:doc>
    <xsl:template match="*[f:match4extraction(.)]" mode="emit">
        <xsl:variable name="proposalName" select="f:generateOutputFileName(., base-uri())"/>
        <xsl:variable name="name" select="resolve-uri($proposalName, base-uri())"/>
        <xsl:call-template name="write-topic" >
            <xsl:with-param name="newDocumentName" select="$name"/>
        </xsl:call-template>
    </xsl:template>
    
    <xd:doc>
        <xd:desc>The template that generates new documents from topics.</xd:desc>
        <xd:param name="newDocumentName">New file name.</xd:param>
    </xd:doc>
    <xsl:template name="write-topic">
        <xsl:param name="newDocumentName" as="xs:string"/>
        
        <xsl:variable name="contentToWrite">
            <xsl:choose>
                <xsl:when test="local-name(.) = 'section'">
                    <topic>
                        <xsl:call-template name="copyAttributes"/>
                        <xsl:copy-of select="$newline"/><xsl:apply-templates select="title" mode="write-sect"/><xsl:copy-of select="$newline"/>
                        <body>
                            <xsl:apply-templates select="node() except title" mode="write-sect"/>
                        </body><xsl:copy-of select="$newline"/>
                    </topic>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:copy>
                        <xsl:call-template name="copyAttributes"/>
                        <xsl:apply-templates select="node() except (*[f:match4extraction(.)])" mode="write-sect"/>
                    </xsl:copy>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        
        <xsl:call-template name="writeContent">
            <xsl:with-param name="newDocumentName" select="$newDocumentName"/>
            <xsl:with-param name="contentToWrite" select="$contentToWrite"/>
        </xsl:call-template>
    </xsl:template>
    
    <xd:doc>
        <xd:desc>The template that write content for new documents.</xd:desc>
        <xd:param name="newDocumentName">New file name.</xd:param>
        <xd:param name="contentToWrite">Content to write.</xd:param>
    </xd:doc>
    <xsl:template name="writeContent" use-when="function-available('xrf:get-content-before-root')">
        <xsl:param name="newDocumentName"/>
        <xsl:param name="contentToWrite"/>
        <!-- Get the DOCTYPE or Schema -->
        <xsl:variable name="header" as="xs:string" select="xrf:get-content-before-root()"/>
        <xsl:variable name="hasRNGSchemaReferences" select="f:hasRNGSchemaAssociated($header)"/>
        <xsl:choose>
            <xsl:when test="xs:boolean($hasRNGSchemaReferences)">
                <xsl:result-document href="{$newDocumentName}" indent="no">
                    <xsl:copy-of select="$newline"/>
                    <xsl:processing-instruction name="xml-model">
                        <xsl:value-of select="concat('href=', '&quot;', $DEFAULT_RNG_FORMATS($contentToWrite/*/local-name()), '&quot;', ' ', 'schematypens=&quot;http://relaxng.org/ns/structure/1.0&quot;')"/>
                    </xsl:processing-instruction>
                    <xsl:copy-of select="$newline"/>
                    <xsl:copy-of select="$contentToWrite"/>
                </xsl:result-document>
              
            </xsl:when>
            <xsl:otherwise>
                <!-- If no schema or doctype is found, fallback to doctype-->
                <xsl:variable name="outputFormat">
                    <xsl:choose>
                        <xsl:when test="local-name(.) = 'section'">
                            <xsl:value-of select="'topic'"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="local-name(.)"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <xsl:result-document href="{$newDocumentName}" format="{$outputFormat}" indent="no">
                    <xsl:copy-of select="$contentToWrite"/>
                </xsl:result-document>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xd:doc>
        <xd:desc>The template that write content for new documents.</xd:desc>
        <xd:param name="newDocumentName">New file name.</xd:param>
        <xd:param name="contentToWrite">Content to write.</xd:param>
    </xd:doc>
    <xsl:template name="writeContent" use-when="not(function-available('xrf:get-content-before-root'))">
        <xsl:param name="newDocumentName"/>
        <xsl:param name="contentToWrite"/>
        <!-- Get the DOCTYPE or Schema -->
        <!-- If no schema or doctype is found, fallback to doctype-->
        <xsl:variable name="outputFormat">
            <xsl:choose>
                <xsl:when test="local-name(.) = 'section'">
                    <xsl:value-of select="'topic'"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="local-name(.)"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:result-document href="{$newDocumentName}" format="{$outputFormat}" indent="no">
            <xsl:copy-of select="$contentToWrite"/>
        </xsl:result-document>
    </xsl:template>
    
    <xd:doc>
        <xd:desc>Determines if the document has a RNG schema associated.</xd:desc>
        <xd:param name="docHeader">Document's header: the content before root.</xd:param>
        <xd:return>true if the current document has schema</xd:return>
    </xd:doc>
    <xsl:function name="f:hasRNGSchemaAssociated">
        <xsl:param name="docHeader" as="xs:string"/>
        <xsl:value-of select="matches($docHeader, $RNG_MODEL_REGEX_PATTERN, $REGEX_FLAGS)"/>
    </xsl:function>
    
    <xd:doc>
        <xd:desc>Copies all atributes. If an @id doesn't exist, it generates one.</xd:desc>
    </xd:doc>
    <xsl:template name="copyAttributes">
        <xsl:apply-templates select="@*" mode="write-sect"/>

        <xsl:if test="not(@id)">
           <xsl:attribute name="id" select="f:correctId(replace(f:generateOutputFileName(., base-uri()), $extension, ''))"/>
        </xsl:if>
    </xsl:template>
    
</xsl:stylesheet>
