<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:nd="http://www.oxygenxml.com/css2fo/named-destinations"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <!-- The DLENTRY ID is copied to all the DT (the definition terms),
         there is no need to duplicate it on each DT, only on the first one. 
         
         The duplication occurs because the commonattributes template we changed now 
         copies all attributes to the element. The commonattributes template is
         called from the org.dita.html5/xsl/topic.xsl for both DD and DT 
         with the context of the parent DLENTRY element.
     -->
    <xsl:template match="*[contains(@class, ' topic/dt ')]" mode="output-dt">
        <xsl:choose>
            <xsl:when test="@id">
                <!-- There is an @id set directly on the DT -->
                <xsl:next-match/>
            </xsl:when>
            <xsl:when test="count(./preceding-sibling::*[contains(@class, ' topic/dt ')]) &lt; 1">
                <!-- 
                    The @id may come from commonattributes applied to the parent DLENTRY. 
                    This has to be kept, it is the first DT. 
                -->
                <xsl:next-match/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:variable name="result">
                    <root>
                        <!-- 
                            The @id may come from commonattributes applied to the parent DLENTRY. 
                            This has to be removed, it is already set on the first DT. 
                        -->                
                        <xsl:next-match/>
                    </root>
                </xsl:variable>
                <xsl:apply-templates select="$result" mode="remove-id"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- The DLENTRY ID is copied to the DT (the definition term),
         so there is no need to duplicate it on the DD. 
         
         The duplication occurs because the commonattributes template we changed now 
         copies all attributes to the element. The commonattributes template is
         called from the org.dita.html5/xsl/topic.xsl for both DD and DT 
         with the context of the parent DLENTRY element.
     -->
    <xsl:template match="*[contains(@class, ' topic/dd ')]" name="topic.dd">
        <xsl:choose>
            <xsl:when test="@id">
                <!-- There is an @id set directly on the DD -->
                <xsl:next-match/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:variable name="result">
                    <root>
                      <!-- 
                          The @id may come from commonattributes applied to the parent DLENTRY. 
                          This has to be removed, is already set on the DT. 
                      -->                
                      <xsl:next-match/>
                    </root>
                </xsl:variable>
                <xsl:apply-templates select="$result" mode="remove-id"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="node() | @*" mode="remove-id">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*" mode="#current"/>
        </xsl:copy>
    </xsl:template>    
    <xsl:template match="root/*/@id" mode="remove-id"/>
    <xsl:template match="root/*/@nd:nd-id" mode="remove-id"/>
    <xsl:template match="root" mode="remove-id">
        <xsl:apply-templates select="node() | @*" mode="#current"/>
    </xsl:template>
    
</xsl:stylesheet>