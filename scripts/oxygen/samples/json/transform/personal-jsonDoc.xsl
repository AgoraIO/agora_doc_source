<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    Stylesheet used to process a JSON document using json-doc() function
    and generate an HTML output from the JSON content
-->
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:jlib="http://saxonica.com/ns/jsonlib"
    xmlns:map="http://www.w3.org/2005/xpath-functions/map"
    xmlns:array="http://www.w3.org/2005/xpath-functions/array">
    <!-- The input JSON file -->
    <xsl:param name="input" select="'../personal.json'"/>
    
    <!-- The initial template that process the JSON -->
    <xsl:template name="xsl:initial-template">
        <html>
            <head>
                <title>Employees</title>
                <style type="text/css">
                    body {
                        font-family: Helvetica, Arial, sans-serif;
                    }
                    .header {
                        color: #FFFFFF;
                    }
                </style>
            </head>
                
            <xsl:element name="table">
                <xsl:attribute name="border">1</xsl:attribute>
                <tr class="header">
                    <xsl:attribute name="bgcolor">#336666</xsl:attribute>
                    <xsl:attribute name="align">center</xsl:attribute>
                    <td>
                        <font face="Arial" size="3">
                            <b>Name</b>
                        </font>
                    </td>
                    <td>
                        <font face="verdana" size="3">
                            <b>Email</b>
                        </font>
                    </td>
                    <td>
                        <font face="verdana" size="3">
                            <b>Link</b>
                        </font>
                    </td>
                </tr>
                <xsl:apply-templates select="json-doc($input)?personnel?person"/>
            </xsl:element>
        </html>
    </xsl:template>

    <!-- Template that matches map objects -->
    <xsl:template match=".[. instance of map(*)]">
        <xsl:element name="tr">
            <xsl:attribute name="align">center</xsl:attribute>
            <xsl:element name="td">
                <xsl:attribute name="width">120</xsl:attribute>
                <font face="verdana" size="3">
                    <i>
                        <xsl:value-of select="?name?family"/>
                        <xsl:text> </xsl:text>
                        <xsl:value-of select="?name?given"/>
                    </i>
                </font>
            </xsl:element>
            <xsl:element name="td">
                <xsl:attribute name="width">120</xsl:attribute>
                <font face="verdana" size="3">
                    <xsl:value-of select="?email"/>
                </font>
            </xsl:element>
            <xsl:element name="td">
                <font color="black" face="verdana" size="3">
                    <xsl:value-of select="?link?subordinates"/>
                    <xsl:value-of select="?link?manager"/>
                </font>
            </xsl:element>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>
