<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:f="http://oxygenxml.com/custom-function"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    version="2.0">
    
    <!-- List of PI data 'attributes' that should not be modified -->
    <xsl:variable name="skippableAttributes" select="('timestamp', 'id', 'parentID', 'mid')"/>
    
    <xsl:variable name="lorem" select="
        tokenize(normalize-space(
        'Lorem ipsum dolor sit amet consectetur adipisicing elit sed do eiusmod tempor incididunt ut 
        labore et dolore magna aliqua Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut 
        aliquip ex ea commodo consequat Duis aute irure dolor in reprehenderit in voluptate velit esse cillum 
        dolore eu fugiat nulla pariatur Excepteur sint occaecat cupidatat non proident sunt in culpa qui
        officia deserunt mollit anim id est laborum'), '\s')"/>
    
    <xsl:template match="node() | @*">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*"/>
        </xsl:copy>
    </xsl:template>
    
    <!-- Default template -->
    <xsl:template match="text()" priority="10">
        <xsl:value-of select="f:randomizeContent(.)"/>
    </xsl:template>
    
    <!-- template that matches processing instructions and randomizes pi's data content -->
    <xsl:template match="processing-instruction()[starts-with(name(), 'oxy_')]">
        <xsl:variable name="piName" select="name()"/>
        <xsl:variable name="piData">
            <xsl:value-of select="."/>
        </xsl:variable>
        <?oxy_delete author="radu_coravu" timestamp="20210427T103137+0300" content="&lt;xref keyref=&quot;perennial&quot; format=&quot;dita&quot;&gt;perennial&lt;/xref&gt; "?>
        <?oxy_bla a="value" b="value2"?>
        <xsl:processing-instruction name="{$piName}">
            <xsl:analyze-string select="." regex='(\S)*="(.*?|(\s|\S)*)"'>
                <xsl:matching-substring>
                    <xsl:call-template name="handlePiDataPairsInternal">
                        <xsl:with-param name="pair" select="."/>
                    </xsl:call-template>
                </xsl:matching-substring>
                <xsl:non-matching-substring>
                    <xsl:value-of select="."/>
                </xsl:non-matching-substring>
            </xsl:analyze-string>
        </xsl:processing-instruction>
    </xsl:template>
    
    <!-- takes the PI data paits something="something else" and randomizes content-->
    <xsl:template name="handlePiDataPairsInternal">
        <xsl:param name="pair"/>
        <!-- split dupa =" -->
        <xsl:variable name="split" select="tokenize($pair, '=&quot;')"/>
        
        <xsl:variable name="piAttrName" select="$split[1]"/>
        <xsl:variable name="piAttrVal">
            <xsl:value-of select="replace($split[2], '&quot;$', '')"/>
        </xsl:variable>
        
       <xsl:variable name="randomizedPiData">
           <xsl:choose>
               <!-- do not randomize some values -->
               <xsl:when test="$skippableAttributes = $piAttrName">
                   <xsl:value-of select="$piAttrVal"/>
               </xsl:when>
               <xsl:when test="$piAttrName = 'author'">
                   <xsl:variable name="cp" select="string-to-codepoints($piAttrVal)"/>
                   <xsl:variable name="authorNameHash" select="sum($cp)"/>
                   <xsl:variable name="candidate" select="$lorem[$authorNameHash mod count($lorem)]"/>
                   <xsl:value-of select="$candidate"/>
               </xsl:when>
               <xsl:otherwise>
                   <!-- expanded element <a>some text</a> -->
                   <xsl:analyze-string select="$piAttrVal" regex="(&amp;amp;lt;(.*?)&amp;amp;gt;)(.*?)(&amp;amp;lt;(.*?)&amp;amp;gt;)">
                       <xsl:matching-substring>
                           <!-- element start with attributes -->
                           <xsl:value-of select="regex-group(1)"/>
                           <!-- element content -->
                           <xsl:value-of select="f:randomizeContent(regex-group(3))"/>
                           <!-- element end -->
                           <xsl:value-of select="regex-group(4)"/>
                       </xsl:matching-substring>
                       <xsl:non-matching-substring>
                           <!-- empty element <a attr=val /> -->
                           <xsl:analyze-string select="$piAttrVal" regex="(&amp;amp;lt;(.*?)[\\/]&amp;amp;gt;)">
                               <xsl:matching-substring>
                                   <xsl:value-of select="regex-group(1)"/>
                               </xsl:matching-substring>
                               <xsl:non-matching-substring>
                                   <xsl:value-of select="f:randomizeContent(.)"/>
                               </xsl:non-matching-substring>
                           </xsl:analyze-string>
                       </xsl:non-matching-substring>
                   </xsl:analyze-string>
               </xsl:otherwise>
           </xsl:choose>
        </xsl:variable>
        <!-- the new PI data with random content-->
        <xsl:variable name="newPiData">
            <xsl:value-of select="concat($piAttrName, '=', '&quot;', $randomizedPiData, '&quot;')"/>
        </xsl:variable>
        
        <xsl:value-of select="$newPiData"/>
    </xsl:template>
    
    
    <!-- Function to randomize the text -->
    <xsl:function name="f:randomizeContent">
        <xsl:param name="content"></xsl:param>
        <xsl:analyze-string select="$content" regex="\s">
            <xsl:matching-substring><xsl:value-of select="."/></xsl:matching-substring>
            <xsl:non-matching-substring>
                <xsl:variable name="pos" select="position()"/>
                <xsl:value-of select="$lorem[$pos mod count($lorem)]"/></xsl:non-matching-substring>
        </xsl:analyze-string>
    </xsl:function>
    
</xsl:stylesheet> 