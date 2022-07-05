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
            <xd:p>Computes the possible values for the operationID field of an author action.
            Currently, only Oxygen built-in operations are presented.</xd:p>
        </xd:desc>
    </xd:doc>
    
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
        <items>
            <xsl:for-each select="defaultExtensions:DEFAULT_OPERATIONS()">
                <item value="{hf:getValue(.)}" annotation="{hf:buildAnnotation(.)}"></item>
            </xsl:for-each>
        </items>
    </xsl:template>
    
    <xd:doc xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl">
        <xd:desc>
            <xd:p>Obtains the name of the operation. One of the possible values for 
            the operationID field.</xd:p>
        </xd:desc>
        <xd:param name="operation">The java.lang.Class of the author operation.</xd:param>
    </xd:doc>
    <xsl:function name="hf:getValue">
        <xsl:param name="operation" />
        
        <xsl:variable name="className" select="class:getName($operation)"/>
        
        <xsl:choose>
            <xsl:when test="starts-with($className, 'ro.sync.ecss.extensions.commons.operations.')">
                <xsl:value-of select="substring-after($className, 'ro.sync.ecss.extensions.commons.operations.')"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$className"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>

    <xd:doc xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl">
        <xd:desc>
            <xd:p>Builds an annotation for a proposal.</xd:p>
        </xd:desc>
        <xd:param name="class">java.lang.Class identifying an author operation.</xd:param>
    </xd:doc>
    <xsl:function name="hf:buildAnnotation">
        <xsl:param name="class"/>
        
        <xsl:variable name="constructor" select="class:getConstructors($class)[0]"/>
        <xsl:variable name="obj" select="class:newInstance($class)"/>
      
        <xsl:value-of select="authOp:getDescription($obj)"/>
        
        <xsl:text>&#xa;</xsl:text>
        <xsl:text>&#xa;</xsl:text>
      
        <xsl:variable name="arguments" select="authOp:getArguments($obj)"/>
        
        <xsl:if test="count($arguments) > 0">
            <xsl:text>Arguments:&#xa;&#xa;</xsl:text>
        </xsl:if>
        
        <xsl:for-each select="$arguments">
            <xsl:copy-of select="oxy:writeArgName(.)"/>
            <xsl:value-of select="hf:writeType(.)"/>
            <xsl:value-of select="hf:writeDescription(.)"/>
            <xsl:value-of select="hf:writeValues(.)"/>
            
            <xsl:text>&#xa;</xsl:text>
            <xsl:text>&#xa;</xsl:text>
        </xsl:for-each>
    </xsl:function>
    
    
    <xd:doc xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl">
        <xd:desc>
            <xd:p>Writes the name of the argument.</xd:p>
        </xd:desc>
        <xd:param name="argument">A ro.sync.ecss.extensions.api.ArgumentDescriptor instance.</xd:param>
    </xd:doc>
    <xsl:function name="oxy:writeArgName">
        <xsl:param name="argument"/>
        <xsl:text>Name: </xsl:text>
        <xsl:value-of select="argDescr:getName($argument)"/>
        <xsl:text>&#xa;</xsl:text>
    </xsl:function>
    
    <xd:doc xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl">
        <xd:desc>
            <xd:p>Writes the type of the argument.</xd:p>
        </xd:desc>
        <xd:param name="argument">A ro.sync.ecss.extensions.api.ArgumentDescriptor instance.</xd:param>
    </xd:doc>
    <xsl:function name="hf:writeType">
        <xsl:param name="argument"/>
        
        <xsl:text>Type: </xsl:text>
        <xsl:variable name="type" select="argDescr:getType($argument)"/>
        
        <xsl:value-of select="argDescr:decodeType($type)"/>
        <xsl:text>&#xa;</xsl:text>
        
    </xsl:function>
    
    <xd:doc xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl">
        <xd:desc>
            <xd:p>Writes the description of the argument.</xd:p>
        </xd:desc>
        <xd:param name="argument">A ro.sync.ecss.extensions.api.ArgumentDescriptor instance.</xd:param>
    </xd:doc>
    <xsl:function name="hf:writeDescription">
        <xsl:param name="argument"/>
        
        <xsl:text>Description: &#xa;</xsl:text>
            <xsl:value-of select="argDescr:getDescription($argument)"/>
        <xsl:text>&#xa;</xsl:text>
        
    </xsl:function>
    
    <xd:doc xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl">
        <xd:desc>
            <xd:p>Writes the allowed values of the argument.</xd:p>
        </xd:desc>
        <xd:param name="argument">A ro.sync.ecss.extensions.api.ArgumentDescriptor instance.</xd:param>
    </xd:doc>
    <xsl:function name="hf:writeValues">
        <xsl:param name="argument"/>
        
        <xsl:variable name="values" select="argDescr:getAllowedValues($argument)"/>
        <xsl:if test="not(empty($values))">
            <xsl:text>Values: </xsl:text>
            
            <xsl:value-of select="string-join($values, ', ')"/>
            
            <xsl:text>&#xa;</xsl:text>
        </xsl:if>
    </xsl:function>
    
</xsl:stylesheet>