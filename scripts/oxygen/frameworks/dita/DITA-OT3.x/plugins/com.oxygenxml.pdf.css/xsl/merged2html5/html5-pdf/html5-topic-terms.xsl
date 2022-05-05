<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:opentopic="http://www.idiominc.com/opentopic"
	xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">

	<!-- 
		The default HTML5 templates are not taking into account the fact
		that the "opentopic:map" structure can contain short descriptions.
		
		If a short description uses an acronym, it "consumes" the glossary
		surface form, so the first occurences in the content will be left with the abbreviation.
		
		We are checking again in this template if it is indeed the first occurence or not.
		
		-->	
	<xsl:key 
		name="terms-in-content-only" 
		xmlns:opentopic="http://www.idiominc.com/opentopic"
		match="*[contains(@class, ' topic/term ')][not(ancestor::opentopic:map)]" use="@keyref"/>
	
	<xsl:template match="*" mode="getMatchingAcronym">
		<xsl:param name="m_matched-target" as="element()?"/>
		<xsl:param name="m_keys"/>
	
		<xsl:variable name="first-occurence-in-content" select="
			generate-id(.) = 
			generate-id(key('terms-in-content-only', @keyref)[1])"/>
		
		<xsl:choose>
			<xsl:when test="$first-occurence-in-content">
				<!-- Use the default implementation getMatchingSurfaceForm -->
				<xsl:apply-templates select="." mode="getMatchingSurfaceForm">
					<xsl:with-param name="m_matched-target" select="$m_matched-target"/>
					<xsl:with-param name="m_keys" select="$m_keys"/>
				</xsl:apply-templates>
			</xsl:when>
			<xsl:otherwise>
				<!-- Use the default implementation getMatchingAcronym -->
				<xsl:next-match>
					<xsl:with-param name="m_matched-target" select="$m_matched-target"/>
					<xsl:with-param name="m_keys" select="$m_keys"/>					
				</xsl:next-match>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
