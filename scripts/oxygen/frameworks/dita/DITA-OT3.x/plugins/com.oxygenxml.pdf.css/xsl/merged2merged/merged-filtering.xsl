<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:ditaarch="http://dita.oasis-open.org/architecture/2005/"
    xmlns:opentopic-index="http://www.idiominc.com/opentopic/index"
    xmlns:opentopic="http://www.idiominc.com/opentopic"
    xmlns:oxy="http://www.oxygenxml.com/extensions/author"
    xmlns:saxon="http://saxon.sf.net/"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    exclude-result-prefixes="#all">
    <!-- 
                
        General filtering. 
    
    -->

    <!-- Some attributes are not relevant to our output. -->
    <xsl:template match="@xtrf"/>
    <xsl:template match="@xtrc"/>
    <xsl:template match="@ditaarch:DITAArchVersion"/>
    <xsl:template match="@domains"/>
    <xsl:template match="@ohref"/>
    <xsl:template match="@collection-type"/>
    <xsl:template match="@chunk"/>
    <xsl:template match="@resourceid"/>
    <xsl:template match="@first_topic_id"/>
    <xsl:template match="@locktitle"/>


</xsl:stylesheet>