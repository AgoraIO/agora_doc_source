<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	exclude-result-prefixes="xs"
	version="2.0">
	
	<xsl:param name="sort.and.group.glossentries" select="'no'"/>
	
	<xsl:template match="*[contains(@class,' topic/topic ')][child::*[contains(@class, ' glossentry/glossentry ')]]">
		<xsl:choose>
			<xsl:when test="$sort.and.group.glossentries = 'yes'">
				<xsl:variable name="result">
					<xsl:next-match/>
				</xsl:variable>
				<xsl:apply-templates select="$result" mode="sort-and-group"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:next-match/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template match="node() | @*" mode="sort-and-group">
		<xsl:copy>
			<xsl:apply-templates select="node() | @*" mode="#current"/>
		</xsl:copy>
	</xsl:template>
	
	<xsl:template match="*[contains(@class,' topic/topic ')][child::*[contains(@class, ' glossentry/glossentry ')]]" mode="sort-and-group">
		<xsl:copy>
			<xsl:copy-of select="@*"/>
			<!-- Copy all children except glossentries -->
			<xsl:copy-of select="child::node()[not(contains(@class, 
				' glossentry/glossentry '))]"/>
			<!-- Group glossentries by glossterm first letter alphabetically -->
			<xsl:for-each-group select="*[contains(@class, ' glossentry/glossentry ')]" 
				group-by="upper-case(substring(normalize-space(string-join(*[contains(@class, 
				' glossentry/glossterm ')]//text())), 1, 1))">
				<!-- Sort glossentries by glossterm first letter -->
				<xsl:sort select="current-grouping-key()" data-type="text" order="ascending"/>
				<!-- Add div to display first letter -->
				<div class="- glossgroup/label label">
					<xsl:value-of select="current-grouping-key()"/>
				</div>
				<xsl:for-each select="current-group()">
					<!-- Sort glossentries from the same group by glossterm alphabetically -->
					<xsl:sort select="upper-case(normalize-space(string-join(*[contains(@class, 
						' glossentry/glossterm ')]//text())))" data-type="text" order="ascending"/>
					<!-- Copy glossentry and its children -->
					<xsl:copy>
						<xsl:copy-of select="@*"/>
						<xsl:copy-of select="child::node()"/>
					</xsl:copy>
				</xsl:for-each>
			</xsl:for-each-group>
		</xsl:copy>
	</xsl:template>
	
</xsl:stylesheet>