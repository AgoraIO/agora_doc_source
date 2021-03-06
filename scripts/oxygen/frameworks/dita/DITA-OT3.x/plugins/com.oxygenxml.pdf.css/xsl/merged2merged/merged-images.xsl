<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:ditaarch="http://dita.oasis-open.org/architecture/2005/"
    xmlns:opentopic-index="http://www.idiominc.com/opentopic/index"
    xmlns:opentopic="http://www.idiominc.com/opentopic"
    xmlns:oxy="http://www.oxygenxml.com/extensions/author"
    xmlns:saxon="http://saxon.sf.net/"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns:ImageInfo="java:com.oxygenxml.dita.xsltextensions.ImageInfo" exclude-result-prefixes="#all">
    <!-- 
    	
        Images.
        
    -->
    <!-- Convert the href from relative (to the DITA map original file - as it is processed by the DITA-OT 
    previous ant targets) to absolute. -->
    <xsl:template match="*[contains(@class, ' topic/image ')]/@href">
        <xsl:attribute name="href">
            <xsl:value-of select="oxy:absolute-href(..)"/>
        </xsl:attribute>
    </xsl:template>

	<!-- Deals with scaling for images not having a width and height specified in the document. -->
    <xsl:template
        match="*[contains(@class, ' topic/image ')][@href][not(@width)][not(@height)]/@scale">
        
        <xsl:variable name="href" select="oxy:absolute-href(..)"/>
        <xsl:variable name="image-size" select="ImageInfo:getImageSize($href)"/>

        <xsl:choose>
            <xsl:when test="not($image-size = '-1,-1')">
                <xsl:variable name="width-in-pixel">
                    <xsl:call-template name="length-to-pixels">
                        <xsl:with-param name="dimen" select="substring-before($image-size, ',')"/>
                    </xsl:call-template>
                </xsl:variable>
                <xsl:variable name="height-in-pixel">
                    <xsl:call-template name="length-to-pixels">
                        <xsl:with-param name="dimen" select="substring-after($image-size, ',')"/>
                    </xsl:call-template>
                </xsl:variable>
                <xsl:variable name="width" select="floor(number($width-in-pixel) * number(.) div 100)"/>
                <xsl:attribute name="width" select="$width"/>
                <xsl:variable name="height" select="floor(number($height-in-pixel) * number(.) div 100)"/>
                <xsl:attribute name="height" select="$height"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:message>Scaling failed for the image <xsl:value-of select="../@href" />.</xsl:message>
            </xsl:otherwise>
        </xsl:choose>

        <!-- Leave the scale attribute in the output. -->
        <xsl:copy/>
    </xsl:template>

    <!-- Fixes the href, converting it from relative (to the DITA map original file) to absolute. -->
    <xsl:function name="oxy:absolute-href" as="xs:string">
        <xsl:param name="elem" as="node()"/>
        
        <xsl:value-of select="if ($elem/@scope = 'external' or oxy:isAbsolute($elem/@href)) 
          then $elem/@href 
     	  else concat($input.dir.url, $elem/@href)"/>
    </xsl:function>
    
     <!-- Test whether URI is absolute -->
	<xsl:function name="oxy:isAbsolute" as="xs:boolean">
	    <xsl:param name="uri" as="xs:anyURI"/>
	    <xsl:sequence select="some $prefix in ('/', 'file:') satisfies starts-with($uri, $prefix) or contains($uri, '://')"/>
	</xsl:function>
</xsl:stylesheet>