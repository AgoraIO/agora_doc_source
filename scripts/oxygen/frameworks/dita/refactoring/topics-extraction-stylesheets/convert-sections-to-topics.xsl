<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xra="http://www.oxygenxml.com/ns/xmlRefactoring/additional_attributes"
    xmlns:f="http://www.oxygenxml.com/xsl/functions"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" version="3.0" exclude-result-prefixes="xra xs f">

    <xsl:param name="matchElement" select="('section')"></xsl:param>
    <xsl:import href="convert-nested-topics-to-new-topic.xsl"/>
    
</xsl:stylesheet>
