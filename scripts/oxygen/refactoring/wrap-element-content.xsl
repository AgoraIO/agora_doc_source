<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    xmlns:xr="http://www.oxygenxml.com/ns/xmlRefactoring"
    version="3.0"
    xmlns:saxon="http://saxon.sf.net/"
    xpath-default-namespace="http://www.oxygenxml.com/ns/samples/personal">
            
    <!-- The XPath identyfing the target elements -->        
    <xsl:param name="element_xpath" as="xs:string" required="yes"/>
  
    <!-- The name of the element to wrap the content -->        
    <xsl:param name="wrapper_element_local_name" as="xs:string" required="yes"/>
  
    <!-- The namespace of the element to wrap the content -->        
    <xsl:param name="wrapper_element_namespace_uri" as="xs:string" required="yes"/>
    
    <!-- Identify the affected elements  -->
    <xsl:variable name="elements" as="element()*">
        <xsl:evaluate xpath="$element_xpath" as="element()*" context-item="/"/>
    </xsl:variable>
    
    <xsl:variable name="element_ln" select="distinct-values($elements/local-name())"/>
    
    <xsl:template match="*[local-name() = $element_ln][. = $elements]">
      <xsl:copy>
        <xsl:apply-templates select="@*"/>
          <xsl:element name="{$wrapper_element_local_name}" namespace="{$wrapper_element_namespace_uri}">
            <xsl:apply-templates select="node()"/>
          </xsl:element>
      </xsl:copy>        
    </xsl:template>
    
    <xsl:template match="* | text() | comment() | processing-instruction() | @*">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*"/>
        </xsl:copy>
    </xsl:template>
    
</xsl:stylesheet>