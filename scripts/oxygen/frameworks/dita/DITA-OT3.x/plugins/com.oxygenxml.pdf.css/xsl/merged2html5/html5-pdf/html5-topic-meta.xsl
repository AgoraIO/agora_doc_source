<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:opentopic="http://www.idiominc.com/opentopic"
    xmlns:oxy="http://www.oxygenxml.com/extensions/author"
    xmlns:opentopic-index="http://www.idiominc.com/opentopic/index"
    xmlns:ot-placeholder="http://suite-sol.com/namespaces/ot-placeholder"
    
    exclude-result-prefixes="#all"
    version="2.0">
  	
  	<!-- The prolog may contain metadata that is needed in the print, 
  	     for instance data elements that may be picked up in the headers, 
  	     or the indexterms. -->
  	
    <xsl:template match="*[contains(@class, ' topic/prolog ')]">
      <xsl:apply-templates select="." mode="div-it"/>
    </xsl:template>
    
</xsl:stylesheet>