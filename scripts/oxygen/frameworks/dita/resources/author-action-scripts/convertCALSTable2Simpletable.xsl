<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <!-- Import the stylesheet used in XML Refactoring Convert CALS tables to DITA simple tables. -->
    <xsl:import href="../../refactoring/convertCALSTable2Simpletable.xsl"/>
    
    <!-- This XSLT operation has an external paramerter that tells us if the table is wrapped in a paragraph. -->    
    <xsl:param name="inPara" as="xs:boolean" select="false()"/>
    
    <!-- Override the process title template from imported style sheet. -->
    <xsl:template name="processTableTitle">
        <xsl:apply-templates select="title">
            <xsl:with-param name="isInsidePara" select="$inPara"/>
        </xsl:apply-templates>
    </xsl:template>
    
</xsl:stylesheet>