<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="2.0">
    
    <xsl:template match="node() | @*">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="simpletable[not(@conref) and not(@conkeyref)]">
        <table>
            <xsl:apply-templates select="@*"/>
            <tgroup>
                <!-- When the simple table has column widths, we need to add them in the CALS table.-->
                <xsl:if test="@relcolwidth">
                    <xsl:attribute name="cols" select="count(tokenize(@relcolwidth, '\s'))"/>
                    <xsl:analyze-string select="@relcolwidth" regex="\s">
                        <xsl:non-matching-substring>
                            <colspec colname="c{(position()+1) div 2}" colwidth="{.}"/>
                        </xsl:non-matching-substring>
                    </xsl:analyze-string>
                </xsl:if>
                
                <!-- Process elements before table header, including processing instructions. -->
                <xsl:apply-templates select="sthead/preceding-sibling::node()"/>
                
                <!-- Process table header. -->
                <xsl:apply-templates select="sthead"/>
                
                <!-- It's possible to match track changes processing instruction that ends before the current row. 
                    (Example: table header was inserted with track changes so the header of the CALS table should be generated beteen the track changes tags.)-->
                <xsl:variable name="piEndBeforeStRow" select="(sthead/following-sibling::processing-instruction(oxy_insert_end)) except (strow/following-sibling::node())"/>
                <xsl:apply-templates select="$piEndBeforeStRow"/>
                
                <!-- Generate the body.-->
                <tbody>
                    <xsl:apply-templates select="sthead/following-sibling::node() except $piEndBeforeStRow"/>
                </tbody>
            </tgroup>
        </table>
    </xsl:template>
    
    <xsl:template match="sthead">
        <thead>
            <row>
                <xsl:apply-templates/>
            </row>
        </thead>
    </xsl:template>
    
    <xsl:template match="strow">
        <row>
            <xsl:apply-templates/>
        </row>
    </xsl:template>
    
    <xsl:template match="stentry">
        <entry>
            <xsl:apply-templates/>
        </entry>
    </xsl:template>
    <xsl:template match="@keycol"/>
    <xsl:template match="@refcol"/>
    <xsl:template match="@relcolwidth"/>
    <xsl:template match="@class"/>
</xsl:stylesheet> 