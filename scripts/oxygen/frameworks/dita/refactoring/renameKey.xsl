<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:local="http://oxygenxml.com/ns/local"
    exclude-result-prefixes="xs xd"
    version="2.0">
    
    <xsl:param name="pass.to.dialog.current.key.name"/>
    <xsl:param name="new.key.name"/>
    
    <xd:doc>
        <xd:desc>Correct entities.</xd:desc>
    </xd:doc>
    <xsl:variable name="correctedKeyName">
        <xsl:value-of select="replace($new.key.name, '&amp;', '&amp;amp;')"/>
    </xsl:variable>
    
    
    <xd:doc>
        <xd:desc>Default copy template.</xd:desc>
    </xd:doc>
    <xsl:template match="node()|@*">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xd:doc>
        <xd:desc>Rename entire "keyref" value.</xd:desc>
    </xd:doc>
    <xsl:template match="@keyref[. = $pass.to.dialog.current.key.name]">
        <xsl:attribute name="keyref">
            <xsl:value-of select="$correctedKeyName"/>
        </xsl:attribute>
    </xsl:template>
    
    <xd:doc>
        <xd:desc>Rename entire or a part of "keys" value.</xd:desc>
    </xd:doc>
    <xsl:template match="@keys[contains(., $pass.to.dialog.current.key.name)]">
        <xsl:choose>
            <xsl:when test=". = $pass.to.dialog.current.key.name">
                <xsl:attribute name="keys">
                    <xsl:value-of select="$correctedKeyName"/>
                </xsl:attribute>
            </xsl:when>
            <xsl:otherwise>
               <!-- Tokenize -->
                <xsl:call-template name="tokenizeKeys">
                    <xsl:with-param name="keyValue" select="."/>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xd:doc>
        <xd:desc>Rename entire "conkeyref" value.</xd:desc>
    </xd:doc>
    <xsl:template match="@conkeyref[. = $pass.to.dialog.current.key.name]">
        <xsl:attribute name="conkeyref">
            <xsl:value-of select="$correctedKeyName"/>
        </xsl:attribute>
    </xsl:template>
    
    <xd:doc>
        <xd:desc>Match the "conkeyref" attribute whitch referres a resourece using a key and ID.</xd:desc>
    </xd:doc>
    <xsl:template match="@conkeyref[starts-with(., concat($pass.to.dialog.current.key.name, '/'))]">
        <xsl:call-template name="matchKey">
            <xsl:with-param name="keyName" select="'conkeyref'"/>
            <xsl:with-param name="keyValue" select="."/>
        </xsl:call-template>
    </xsl:template>
    
    <xd:doc>
        <xd:desc>Match the "keyref" attribute whitch referres a resourece using a key and ID.</xd:desc>
    </xd:doc>
    <xsl:template match="@keyref[starts-with(., concat($pass.to.dialog.current.key.name, '/'))]">
        <xsl:call-template name="matchKey">
            <xsl:with-param name="keyName" select="'keyref'"/>
            <xsl:with-param name="keyValue" select="."/>
        </xsl:call-template>
    </xsl:template>
    
    <xd:doc>
        <xd:desc> Template that matches an attribute and replace updates its value.</xd:desc>
        <xd:param name="keyName">More like key type: "conkeyref" or "keyref"</xd:param>
        <xd:param name="keyValue">The value if the key attribute.</xd:param>
    </xd:doc>
    <xsl:template name="matchKey">
        <xsl:param name="keyName"></xsl:param>
        <xsl:param name="keyValue"></xsl:param>
        <xsl:attribute name="{$keyName}"> 
            <xsl:variable name="replace"
                select="replace($keyValue, concat($pass.to.dialog.current.key.name, '/'), concat($correctedKeyName, '/'))"/>
            <xsl:value-of select="$replace"/>
        </xsl:attribute>
    </xsl:template>

    <xd:doc>
        <xd:desc> Template that matches the "keys" attribute and tokenizes and updates the attribute's value.</xd:desc>
        <xd:param name="keyValue">The value of the "keys" attribute.</xd:param>
    </xd:doc>
    <xsl:template name="tokenizeKeys">
        <xsl:param name="keyValue"/>
        <xsl:choose>
            <xsl:when test="contains($keyValue, ' ')">
                <!-- Tokenize -->
                <xsl:attribute name="keys">
                    <xsl:for-each select="tokenize(., '\s')">
                        <xsl:choose>
                            <xsl:when test=". = $pass.to.dialog.current.key.name">
                                <!-- Add the new key -->
                                <xsl:value-of select="$correctedKeyName"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <!--  Add the current key -->
                                <xsl:value-of select="."/>
                            </xsl:otherwise>
                        </xsl:choose>
                        <!-- Add space -->
                        <xsl:if test="position() != last()">
                            <xsl:text> </xsl:text>
                        </xsl:if>
                    </xsl:for-each>
                </xsl:attribute>
            </xsl:when>
            <xsl:otherwise>
                <xsl:attribute name="keys" select="$keyValue"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>
