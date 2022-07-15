<!-- 
  Copyright 2001-2012 Syncro Soft SRL. All rights reserved.
 -->
<xsl:stylesheet version="3.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xhtml="http://www.w3.org/1999/xhtml"
    xmlns:e="http://www.oxygenxml.com/xsl/conversion-elements"
    xmlns:f="http://www.oxygenxml.com/xsl/functions"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xsl xhtml e f xs">
    
    <xsl:import href="cleanUp.xsl"/>
    <xsl:import href="filterNodes.xsl"/>
    <xsl:import href="convertToCode.xsl"/>
    <xsl:import href="mergeCodeSiblings.xsl"/>
    <xsl:import href="breakLines.xsl"/>
    <xsl:import href="wrapGlobalInlineNodesInPara.xsl"/>
    <xsl:import href="nestedSections.xsl"/>
    <xsl:import href="nestedLists.xsl"/>
    <xsl:import href="processInTableContext.xsl"/>
    <xsl:import href="setNamespace.xsl"/>
    <xsl:import href="handleComments.xsl"/>
    <xsl:import href="handleMath.xsl"/>
    <xsl:include href="xhtml2dita.xsl"/>
    <xsl:include href="xhtml2task.xsl"/>
    <xsl:include href="xhtml2reference.xsl"/>
    
    <xsl:output method="xml" indent="no" omit-xml-declaration="yes"/>
    
    <xsl:param name="folderOfPasteTargetXml"/>

     <!-- 
         Set it to non-zero if you want to paste a table 
         as a Properties table in a DITA Reference file. 
         If it is zero only CALS tables are pasted in a DITA reference.
     -->
    <xsl:param name="dita.reference.properties.table" select="0"/>
    <!-- 
         Set it to non-zero if you want to paste table cell contents with paragraphs inserted inside them. 
     -->
    <xsl:param name="dita.prefer.paragraphs.in.table.cells" select="0"/>
    
    <!-- 
         Set it to non-zero if you want to paste list item contents with paragraphs inserted inside them. 
     -->
    <xsl:param name="dita.prefer.paragraphs.in.list.items" select="0"/>
  
    <!-- 
        The item separator.
     -->
    <xsl:param name="context.item.separator" select="','"/>
    
    <!-- 
      The context where the generated fragment will be inserted. 
      This parameter lists the local names, starting with the root up to the context element. 
     -->   
    <xsl:param name="context.path.names" select="''"/>
    <xsl:param name="context.path.names.sequence" 
                        select="tokenize($context.path.names, $context.item.separator)"/>
    
    <!-- 
      The context where the generated fragment will be inserted. 
      This parameter lists the namespaces, starting with the root up to the context element. 
     -->   
    <xsl:param name="context.path.uris" select="''"/>
    <xsl:param name="context.path.uris.sequence" 
                        select="tokenize($context.path.uris, $context.item.separator)"/>
    
    <!-- Helper variables. -->
    <xsl:variable name="context.path.last.name" select="tokenize($context.path.names, $context.item.separator)[last()]"/>
    <xsl:variable name="context.path.last.uri" select="tokenize($context.path.uris, $context.item.separator)[last()]"/>
    
    
    <!-- true if we are pasting in a table context (between rows for example or having various table cells selected.
    If so, we'll paste only table rows.
    -->
    <xsl:param name="inTableContext"/>
    
    <!-- 
        TRUE if we want to copy image resources.
    -->
    <xsl:param name="copy.word.image.resources" as="xs:boolean" select="false()"/>
    
    <!-- true if we want to replace all content in document..might replace the root node -->
    <xsl:param name="replace.entire.root.contents" as="xs:boolean" select="false()"/>
    
     <!-- true if we want to wrap multiple sections in a root element -->
    <xsl:param name="wrapMultipleSectionsInARoot" as="xs:boolean" select="false()"/>
    
    <!-- true if we want to wrap element before heading in a section -->
    <xsl:param name="wrapElementsBeforeHeadingInSection" as="xs:boolean" select="false()"/>
    
    <!-- true if we want to update the extension of the refered html local file to ".dita" and remove the file path.
    This is used by Batch Documents Converter add-on (EXM-46221) -->
    <xsl:param name="updateExtensionAndPathOfLocalFileReferences" as="xs:boolean" select="false()"/>
    
    <!-- The default title. This is used in case that title of the document cannot be determined from content. -->
    <xsl:param name="defaultDocumentTitle" select="''" as="xs:string"/>
    
    <!-- true if we want to convert all class atribute to outputclass.
    This is used by Batch Documents Converter add-on (EXM-48982) -->
    <xsl:param name="convertClassToOutputClass" as="xs:boolean" select="false()"/>
    
    <!-- The maximum heading level that allows nested topics. (EXM-47739)-->
    <xsl:param name="maxHeadingLevelForNestedTopics" select="1"/>

    <xsl:template match="/">
        <!--
        <xsl:message>======== folderOfPasteTargetXml: <xsl:value-of select="$folderOfPasteTargetXml"/></xsl:message>
        <xsl:message>======== context.path.names: <xsl:value-of select="$context.path.names"/></xsl:message>
        <xsl:message>======== context.path.uris: <xsl:value-of select="$context.path.uris"/></xsl:message>
        <xsl:message>======== context.item.separator: <xsl:value-of select="$context.item.separator"/></xsl:message>
        -->
        
        <!-- Convert all spans with Courier New font to "code" elements-->
        <xsl:variable name="codeWrap">
            <xsl:apply-templates mode="code"/>
        </xsl:variable>
<!--        <xsl:message> CODE WRAP <xsl:copy-of select="$codeWrap"/></xsl:message>        -->
        
        <!-- Merge siblings "code"s. -->
        <xsl:variable name="mergeCodeSiblings">
            <xsl:apply-templates select="$codeWrap" mode="merge"/>
        </xsl:variable>
<!--        <xsl:message> CODE MERGE <xsl:copy-of select="$mergeCodeSiblings"/></xsl:message>-->
        
        <!-- Remove the unwanted bold elements added by Browsers when text is copied from google docs. -->
        <xsl:variable name="cleanCode">
            <xsl:apply-templates select="$mergeCodeSiblings" mode="cleanUp"/>
        </xsl:variable>
        
        <!-- Filter unused tags, transform MS Word titles to H1 elements. -->
        <xsl:variable name="processedFilterNodes">
            <xsl:apply-templates select="$cleanCode" mode="filterNodes"/>
        </xsl:variable>
        <!--
        <xsl:message>111111111  <xsl:copy-of select="$processedFilterNodes"/></xsl:message>
        <xsl:result-document href="output-filterNodes-1.xml">
            <xsl:copy-of select="$processedFilterNodes"/>
                </xsl:result-document>
        -->
        
        <!-- Breask lines at <br/> elements. -->
        <xsl:variable name="processedBreakLines">
            <xsl:apply-templates select="$processedFilterNodes" mode="breakLines"/>
        </xsl:variable>
        <!--
        <xsl:message>222222222  <xsl:copy-of select="$processedBreakLines"/></xsl:message>
        <xsl:result-document href="output-breakLines-2.xml">
            <xsl:copy-of select="$processedBreakLines"/>
        </xsl:result-document>
        -->
        
        <!-- Wrap inline nodes at global level (xhtml:body) in xhtml:p elements. -->
        <xsl:variable name="processedWrapGlobalText">
            <xsl:apply-templates select="$processedBreakLines" mode="wrapGlobalText"/>
        </xsl:variable>
        <!--
        <xsl:message>333333333  <xsl:copy-of select="$processedWrapGlobalText"/></xsl:message>
        <xsl:result-document href="output-wrapGlobalText-3.xml">
            <xsl:copy-of select="$processedWrapGlobalText"/>
        </xsl:result-document>
        -->
        
        <!-- Transform list of header and para elements to nested sections. -->
        <xsl:variable name="processedSections">
            <xsl:apply-templates select="$processedWrapGlobalText" mode="nestedSections"/>
        </xsl:variable>
        <!--
        <xsl:message>444444444  <xsl:copy-of select="$processedSections"/></xsl:message>
        <xsl:result-document href="output-sections-4.xml">
            <xsl:copy-of select="$processedSections"/>
        </xsl:result-document>
        -->
        
        <!-- Transform list of para elements from MS Word to nested lists.-->
        <xsl:variable name="processedLists">
            <xsl:apply-templates select="$processedSections" mode="nestedLists"/>
        </xsl:variable>
        <!--
        <xsl:message>555555555   <xsl:copy-of select="$processedLists"/></xsl:message>
        <xsl:result-document href="output-lists-5.xml">
            <xsl:copy-of select="$processedLists"/>
        </xsl:result-document>
        -->

        <xsl:variable name="processedNamespace">
            <xsl:apply-templates select="$processedLists" mode="setNamespace"/>
        </xsl:variable>
        <!--
        <xsl:message>666666666 <xsl:copy-of select="$processedNamespace"/></xsl:message>
        <xsl:result-document href="output-namespace-6.xml">
            <xsl:copy-of select="$processedNamespace"/>
        </xsl:result-document>
        -->
        
        <xsl:variable name="processedMaths">
            <xsl:apply-templates select="$processedNamespace" mode="processMaths"/>
        </xsl:variable>
     <!--   <xsl:message>7777777 <xsl:copy-of select="$processedMaths"/></xsl:message>
        <xsl:result-document href="output-namespace-6.xml">
            <xsl:copy-of select="$processedMaths"/>
        </xsl:result-document>
                -->
        <xsl:variable name="processedComments">
            <xsl:apply-templates select="$processedMaths" mode="processComments"/>
        </xsl:variable>
      <!-- 
        <xsl:message>8888888 <xsl:copy-of select="$processedComments"/></xsl:message>
        <xsl:result-document href="output-comments-7.xml">
            <xsl:copy-of select="$processedComments"/>
        </xsl:result-document>-->
         
        
        <!-- Generate content for current Author framework. -->
        <xsl:variable name="processed">
            <xsl:apply-templates select="$processedComments/*"/>
        </xsl:variable>
        
        <!-- 
        <xsl:message>999999 <xsl:copy-of select="$processed"/></xsl:message> 
        -->
        
        <!-- If we are inside a table and pasting there, unwrap the table structure above the rows. -->
        <xsl:apply-templates select="$processed" mode="processInTableContext"/>
        
<!--        <xsl:message>10-10-10-10 <xsl:copy-of select="$processed"/></xsl:message>-->
        
    </xsl:template>
    
    <xsl:template match="comment()">
        <xsl:copy></xsl:copy>
    </xsl:template>
    
</xsl:stylesheet>