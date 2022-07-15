<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:m="http://www.w3.org/1998/Math/MathML"
	exclude-result-prefixes="m"
	version="2.0">

	<xsl:template match="node() | text() | @*" mode="processMaths">
		<xsl:copy>
			<xsl:apply-templates select="node() | text() | @*"
				mode="processMaths" />
		</xsl:copy>
	</xsl:template>

	<xsl:template match="m:*" mode="processMaths">
		<xsl:element name="mml:{local-name()}" namespace="http://www.w3.org/1998/Math/MathML">
			<xsl:apply-templates select="node()|@*" mode="processMaths" />
		</xsl:element>
	</xsl:template>
</xsl:stylesheet>