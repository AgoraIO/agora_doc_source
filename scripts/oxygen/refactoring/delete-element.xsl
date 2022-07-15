<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    xmlns:xr="http://www.oxygenxml.com/ns/xmlRefactoring"
    version="3.0"
    xmlns:saxon="http://saxon.sf.net/"
    xpath-default-namespace="http://www.oxygenxml.com/ns/samples/personal">
            
    <!-- The XPath identyfing the elements to be deleted -->        
    <xsl:param name="element_xpath" as="xs:string" required="yes"/>
    
    <!-- Identify the elements to be deleted -->
    <xsl:variable name="elements" as="element()*">
        <xsl:evaluate xpath="$element_xpath" as="element()*" context-item="/"/>
    </xsl:variable>
    
    <xsl:template match="*">
        <!-- Copy only those elements that were not matched by the '$element_xpath' XPath expression -->
        <xsl:variable name="intersection" select=". intersect $elements"/>
        <xsl:choose>
            <xsl:when test="empty($intersection)">
                <xsl:copy>
                    <xsl:apply-templates select="@*"/>
                    <xsl:apply-templates select="node()"/>
                </xsl:copy>
            </xsl:when>
        </xsl:choose>        
    </xsl:template>
    
    <xsl:template match="text() | comment() | processing-instruction() | @*">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*"/>
        </xsl:copy>
    </xsl:template>
    
</xsl:stylesheet>