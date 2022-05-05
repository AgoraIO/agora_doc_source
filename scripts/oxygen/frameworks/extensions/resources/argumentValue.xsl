<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:saxon="http://saxon.sf.net/"
    exclude-result-prefixes="xs"
    xmlns:defaultExtensions="java:ro.sync.ecss.extensions.commons.operations.DefaultExtensions"
    xmlns:authOp="java:ro.sync.ecss.extensions.api.AuthorOperation"
    xmlns:argDescr="java:ro.sync.ecss.extensions.api.ArgumentDescriptor"
    xmlns:class="java:java.lang.Class"
    xmlns:hf="oxygen::helper::functions"
    version="2.0"
    xmlns:oxy="http://www.oxygenxml.com/oxy">
    <xd:doc xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Mar 26, 2020</xd:p>
            <xd:p><xd:b>Author:</xd:b> alex_jitianu</xd:p>
            <xd:p>Computes the possible values for an operartion argument.
                Currently, only Oxygen built-in operations are presented.</xd:p>
        </xd:desc>
    </xd:doc>
    
    <xsl:include href="utils.xsl" />
    
    <xd:doc xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl">
        <xd:desc>
            <xd:p>System ID of author action.</xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:param name="documentSystemID" as="xs:string"></xsl:param>
    
    <xd:doc xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl">
        <xd:desc>
            <xd:p>An XPath expression indetifying the context in which proposals were requested.</xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:param name="contextElementXPathExpression" as="xs:string"></xsl:param>
    
    <xd:doc xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl">
        <xd:desc>
            <xd:p>Entry template.</xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:template name="start">
        <xsl:apply-templates select="doc($documentSystemID)"/>
    </xsl:template>
    
    <xsl:template match="/">
        <xsl:variable name="argument" 
            select="saxon:eval(saxon:expression($contextElementXPathExpression, ./*))"/>
        
        <xsl:variable name="opID" select="$argument/ancestor::*:operation/@id"/>
        
        <xsl:variable name="operationClassName" select="hf:getClassQName($opID)"/>
        
        <xsl:variable name="values" select="hf:getArgValues($operationClassName, xs:string($argument/@name))"/>
        
        <xsl:if test="not(empty($values))">
            <items>
                <xsl:for-each select="$values">
                    <item value="{.}"></item>
                </xsl:for-each>
            </items>
        </xsl:if>
    </xsl:template>
    
</xsl:stylesheet>