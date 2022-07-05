<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    Stylesheet used to process a JSON document using json-to-xml() function
    and generate an HTML output from the JSON content
-->
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <!-- The input JSON file -->
    <xsl:param name="input" select="'../personal.json'"/>
    
    <!-- The initial template that process the JSON -->
    <xsl:template name="xsl:initial-template">
        <xsl:apply-templates select="json-to-xml(unparsed-text($input))"/>
    </xsl:template>

    <!-- Template that matches root element (of the generated XML) -->
    <xsl:template match="/">
        <html>
            <head>
                <title>Employees</title>
                <style type="text/css">
                    body {
                        font-family: Helvetica, Arial, sans-serif;
                    }
                    
                    .header {
                        color: #FFFFFF;
                    }</style>
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
                <xsl:apply-templates/>
            </xsl:element>
        </html>
    </xsl:template>

    <!-- Template that matches an element with the @key attribute value equals with 'person'-->
    <xsl:template match="*[@key='person']/*">
        <xsl:element name="tr">
            <xsl:attribute name="align">center</xsl:attribute>
            <xsl:element name="td">
                <xsl:attribute name="width">120</xsl:attribute>
                <font face="verdana" size="3">
                    <i>
                        <xsl:value-of select="*[@key='name']/*[@key='family']"/>
                        <xsl:text> </xsl:text>
                        <xsl:value-of select="*[@key='name']/*[@key='given']"/>
                    </i>
                </font>
            </xsl:element>
            <xsl:element name="td">
                <xsl:attribute name="width">120</xsl:attribute>
                <font face="verdana" size="3">
                    <xsl:value-of select="*[@key='email']"/>
                </font>
            </xsl:element>
            <xsl:element name="td">
                <font color="black" face="verdana" size="3">
                    <xsl:value-of select="*[@key='link']/*[@key='subordinates']"/>
                    <xsl:value-of select="*[@key='link']/*[@key='manager']"/>
                </font>
            </xsl:element>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>
