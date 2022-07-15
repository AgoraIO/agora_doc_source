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

    
    <xsl:function name="hf:getOperationArguments">
        <xsl:param name="operationClassName" as="xs:string"></xsl:param>
        
        <xsl:try>
            <xsl:variable name="operationClassObj" select="class:forName($operationClassName)"/>
            <xsl:variable name="operationObj" select="class:newInstance($operationClassObj)"/>
            <xsl:variable name="arguments" select="authOp:getArguments($operationObj)"/>
            
            <xsl:sequence select="$arguments"></xsl:sequence>
            <xsl:catch>
                <xsl:sequence select="()"/>
            </xsl:catch>
        </xsl:try>            
        
        
    </xsl:function>
    
    <xsl:function name="hf:getArgValues">
        <xsl:param name="operationClassName" as="xs:string"/>
        <xsl:param name="argumentName" as="xs:string"/>
        
        <xsl:variable name="argumentObj" select="hf:getOperationArguments($operationClassName)"/>
        <xsl:if test="not(empty($argumentObj))">
            <xsl:sequence select="argDescr:getAllowedValues($argumentObj[argDescr:getName(.) = $argumentName])"/>
        </xsl:if>
    </xsl:function>
    
    <xsl:function name="hf:getClassQName">
        <xsl:param name="operationClassName" as="xs:string"/>
        
        <xsl:choose>
            <xsl:when test="contains($operationClassName, '.')">
                <!-- It's probably already a qname -->
                <xsl:value-of select="$operationClassName"/>
            </xsl:when>
            <xsl:otherwise>
                <!-- Probably a short form for the builtin operations. -->
                <xsl:value-of select="concat('ro.sync.ecss.extensions.commons.operations.', $operationClassName)"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    
</xsl:stylesheet>