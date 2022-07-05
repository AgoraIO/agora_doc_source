<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:opentopic="http://www.idiominc.com/opentopic"
	xmlns:oxy="http://www.oxygenxml.com/extensions/author"
	xmlns:opentopic-index="http://www.idiominc.com/opentopic/index"
	xmlns:ot-placeholder="http://suite-sol.com/namespaces/ot-placeholder"
	exclude-result-prefixes="#all" version="2.0">

	<!-- Put markup around the entire tm element, and add some other markup around the trademark symbols. -->
	<xsl:template match="*[contains(@class, ' topic/tm ')]" priority="2">
		<xsl:param name="skip-wrapping" select="false()" tunnel="yes"/>

		<!-- The tm template from the HTML stylesheets removes the markup arount 
			   the text. We prefer keeping it, so one can style it. -->
		<span>
			<xsl:call-template name="commonattributes"/>

			<xsl:choose>
				
				<xsl:when test="$skip-wrapping">
					<!-- The top most tm template will deal with wrapping the spans. -->
					<xsl:next-match/>
				</xsl:when>
				
				<xsl:otherwise>
					
					<!-- Process the content, this is the top most tm. -->
					<xsl:variable name="content">
						<xsl:next-match>
							<xsl:with-param name="skip-wrapping" select="true()" tunnel="yes"/>
						</xsl:next-match>
					</xsl:variable>
	
					<xsl:apply-templates select="$content" mode="wrap-tm-marks-with-span"/>
				</xsl:otherwise>
			</xsl:choose>

		</span>
	</xsl:template>
	
	<!-- 
		Process the TM tag, always add the symbol. 
		This is different form the original template from plugins/org.dita.html5/xsl/topic.xsl 
	-->
	<xsl:template match="*[contains(@class, ' topic/tm ')]" name="topic.tm">
		<xsl:apply-templates select="*[contains(@class, ' ditaot-d/ditaval-startprop ')]" mode="out-of-line"/>
		<xsl:apply-templates/> <!-- output the TM content -->
		
		<xsl:choose>  <!-- ignore @tmtype=service or anything else -->
			<xsl:when test="@tmtype = 'tm'">&#x2122;</xsl:when>
			<xsl:when test="@tmtype = 'reg'">&#174;</xsl:when>
			<xsl:when test="@tmtype = 'service'">&#8480;</xsl:when>
			<xsl:otherwise/>
		</xsl:choose>
		
		<xsl:apply-templates select="*[contains(@class, ' ditaot-d/ditaval-endprop ')]" mode="out-of-line"/>
	</xsl:template>

	<!-- Copy template -->
	<xsl:template match="node() | @*" mode="wrap-tm-marks-with-span">
		<xsl:copy>
			<xsl:apply-templates select="node() | @*" mode="wrap-tm-marks-with-span"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="text()" mode="wrap-tm-marks-with-span" priority="2">
		<xsl:analyze-string select="." regex="&#x2122;|&#174;|&#8480;">
			<xsl:matching-substring>
				<span class="- topic/tmmark tmmark ">
					<xsl:value-of select="."/>
				</span>
			</xsl:matching-substring>
			<xsl:non-matching-substring>
				<xsl:value-of select="."/>
			</xsl:non-matching-substring>
		</xsl:analyze-string>
	</xsl:template>

</xsl:stylesheet>
