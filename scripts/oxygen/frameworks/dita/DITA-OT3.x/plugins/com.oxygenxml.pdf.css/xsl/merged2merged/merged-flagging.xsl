<?xml version="1.0" encoding="UTF-8"?>

<!--
    Stylesheet used to convert DITA-OT flagging elements in a structure that is more easier to match from CSS.  
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <!--
        Copy attributes from ditaval-startprop/prop and ditaval-startprop/revprop elements
    -->
    <xsl:template
        match="*[ditaval-startprop[position() = 1]][ditaval-endprop[position() = last()]]" priority="6">
        
        <xsl:variable name="result">
          <xsl:next-match/>
        </xsl:variable>
        
        <xsl:variable name="ditaval-startprop" select="ditaval-startprop[position() = 1]"/>                        
        
        <xsl:apply-templates select="$result" mode="copy-ditaval-attrs">
            <xsl:with-param name="prop" select="$ditaval-startprop/prop"/>
            <xsl:with-param name="revprop" select="$ditaval-startprop/revprop"/>            
        </xsl:apply-templates>                       
    </xsl:template>
    
    <!--
        A copy template that injects the attributes 
        of ditaval prop and revprop elements in the 
        top level element. 
    -->
    <xsl:template match="*" mode="copy-ditaval-attrs">
        <xsl:param name="prop"/>
        <xsl:param name="revprop"/>

        <xsl:copy>
            <!-- Copy attributes -->
            <xsl:copy-of select="@*"/>            
            <xsl:if test="$prop or $revprop">
                
                <xsl:for-each select="$prop/@*">
                    <xsl:attribute name="data-ditaval-{local-name()}" select="."/>
                </xsl:for-each>
                
                <xsl:for-each select="$revprop/@*">
                    <xsl:choose>
                        <!--
                            Tokenize the changebar attribute to emit separate attributes like:
                            data-ditaval-change-bar-color, data-ditaval-change-bar-style.
                            
                            changebar="color:red;style:solid;width:1pt;offset:1.25mm;placement:start" 
                        -->
                        <xsl:when test="local-name(.) = 'changebar'">
                            <xsl:variable name="changebarToken" select="tokenize(., ';')"/>
                            <xsl:for-each select="$changebarToken">
                                <xsl:variable name="propTokens" select="tokenize(., ':')"/>
                                <xsl:if test="count($propTokens) = 2">
                                    <xsl:attribute 
                                        name="data-ditaval-change-bar-{$propTokens[1]}" 
                                        select="$propTokens[2]"/>
                                </xsl:if>
                            </xsl:for-each>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:attribute name="data-ditaval-{local-name()}" select="."/>        
                        </xsl:otherwise>
                    </xsl:choose>                
                </xsl:for-each>
            </xsl:if>
            
            <xsl:apply-templates mode="copy-ditaval-attrs"/>
        </xsl:copy>
    </xsl:template>
    
    <!--
      The flagging images are relative to the topic, not the merged map.
      Solving them to the closest topic location.
    -->
    <xsl:template match="startflag/@imageref |
                        endflag/@imageref">
        <xsl:choose>
            <xsl:when test="contains(., ':')">
                <!-- Absolute -->
                <xsl:next-match/>
            </xsl:when>
            <xsl:otherwise>
                <!-- Relative -->
                <xsl:variable name="base" select="(ancestor-or-self::*[@xtrf]/@xtrf)[last()]"/>
                <xsl:attribute name="{local-name()}" select="resolve-uri(.,$base)"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
</xsl:stylesheet>