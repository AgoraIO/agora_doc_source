<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	exclude-result-prefixes="xs xrf xsi oxy"
	xmlns:xrf="http://www.oxygenxml.com/ns/xmlRefactoring/functions"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	version="2.0"
	xmlns:oxy="http://www.oxygenxml.com/oxy">
	
	<xsl:template match="/">
		<xsl:variable name="header" as="xs:string" select="xrf:get-content-before-root()"/>
		<!-- Convert doctypes -->
		<xsl:variable name="header" select="replace($header, '-//OASIS//DTD DITA Topic//EN', '-//OASIS//DTD DITA 2.x Topic//EN')"/>
		<xsl:variable name="header" select="replace($header, '-//OASIS//DTD DITA Task//EN', '-//OASIS//DTD DITA 2.x Task//EN')"/>
		<xsl:variable name="header" select="replace($header, '-//OASIS//DTD DITA Concept//EN', '-//OASIS//DTD DITA 2.x Concept//EN')"/>
		<xsl:variable name="header" select="replace($header, '-//OASIS//DTD DITA Reference//EN', '-//OASIS//DTD DITA 2.x Reference//EN')"/>
		<xsl:variable name="header" select="replace($header, '-//OASIS//DTD DITA Troubleshooting//EN', '-//OASIS//DTD DITA 2.x Troubleshooting//EN')"/>
		
		<xsl:variable name="header" select="replace($header, '-//OASIS//DTD DITA Map//EN', '-//OASIS//DTD DITA 2.x Map//EN')"/>
		<xsl:variable name="header" select="replace($header, '-//OASIS//DTD DITA BookMap//EN', '-//OASIS//DTD DITA 2.x BookMap//EN')"/>
		

		<xsl:variable name="header" select="replace($header, '-//OASIS//DTD DITA 1.3 Topic//EN', '-//OASIS//DTD DITA 2.x Topic//EN')"/>
		<xsl:variable name="header" select="replace($header, '-//OASIS//DTD DITA 1.3 Task//EN', '-//OASIS//DTD DITA 2.x Task//EN')"/>
		<xsl:variable name="header" select="replace($header, '-//OASIS//DTD DITA 1.3 Concept//EN', '-//OASIS//DTD DITA 2.x Concept//EN')"/>
		<xsl:variable name="header" select="replace($header, '-//OASIS//DTD DITA 1.3 Reference//EN', '-//OASIS//DTD DITA 2.x Reference//EN')"/>
		<xsl:variable name="header" select="replace($header, '-//OASIS//DTD DITA 1.3 Troubleshooting//EN', '-//OASIS//DTD DITA 2.x Troubleshooting//EN')"/>
		
		<xsl:variable name="header" select="replace($header, '-//OASIS//DTD DITA 1.3 Map//EN', '-//OASIS//DTD DITA 2.x Map//EN')"/>
		<xsl:variable name="header" select="replace($header, '-//OASIS//DTD DITA 1.3 BookMap//EN', '-//OASIS//DTD DITA 2.x BookMap//EN')"/>

		<!-- Convert RNG model references -->
		<xsl:variable name="header" select="replace($header, '&quot;urn:oasis:names:tc:dita:rng:topic.rng&quot;', '&quot;urn:oasis:names:tc:dita:rng:topic.rng:2.x&quot;')"/>
		<xsl:variable name="header" select="replace($header, '&quot;urn:oasis:names:tc:dita:rng:task.rng&quot;', '&quot;urn:oasis:names:tc:dita:rng:task.rng:2.x&quot;')"/>
		<xsl:variable name="header" select="replace($header, '&quot;urn:oasis:names:tc:dita:rng:concept.rng&quot;', '&quot;urn:oasis:names:tc:dita:rng:concept.rng:2.x&quot;')"/>
		<xsl:variable name="header" select="replace($header, '&quot;urn:oasis:names:tc:dita:rng:reference.rng&quot;', '&quot;urn:oasis:names:tc:dita:rng:reference.rng:2.x&quot;')"/>
		<xsl:variable name="header" select="replace($header, '&quot;urn:oasis:names:tc:dita:rng:map.rng&quot;', '&quot;urn:oasis:names:tc:dita:rng:map.rng:2.x&quot;')"/>
		<xsl:variable name="header" select="replace($header, '&quot;urn:oasis:names:tc:dita:rng:bookmap.rng&quot;', '&quot;urn:oasis:names:tc:dita:rng:bookmap.rng:2.x&quot;')"/>
		
		<!-- Convert XML Schema based topics to DTDs -->
		<xsl:variable name="headerFinal">
			<xsl:choose>
				<xsl:when test="contains(/*/@xsi:noNamespaceSchemaLocation, 'task.xsd')">
					<xsl:value-of select="$header"/><xsl:if test="string-length($header) > 0"><xsl:text>
</xsl:text></xsl:if>&lt;!DOCTYPE task PUBLIC &quot;-//OASIS//DTD DITA 2.x Task//EN&quot; &quot;task.dtd&quot;>
				</xsl:when>
				<xsl:when test="contains(/*/@xsi:noNamespaceSchemaLocation, 'topic.xsd')">
					<xsl:value-of select="$header"/><xsl:if test="string-length($header) > 0"><xsl:text>
</xsl:text></xsl:if>&lt;!DOCTYPE topic PUBLIC &quot;-//OASIS//DTD DITA 2.x Topic//EN&quot; &quot;topic.dtd&quot;>
				</xsl:when>
				<xsl:when test="contains(/*/@xsi:noNamespaceSchemaLocation, 'concept.xsd')">
					<xsl:value-of select="$header"/><xsl:if test="string-length($header) > 0"><xsl:text>
</xsl:text></xsl:if>&lt;!DOCTYPE concept PUBLIC &quot;-//OASIS//DTD DITA 2.x Concept//EN&quot; &quot;concept.dtd&quot;>
				</xsl:when>
				<xsl:when test="contains(/*/@xsi:noNamespaceSchemaLocation, 'reference.xsd')">
					<xsl:value-of select="$header"/><xsl:if test="string-length($header) > 0"><xsl:text>
</xsl:text></xsl:if>&lt;!DOCTYPE reference PUBLIC &quot;-//OASIS//DTD DITA 2.x Reference//EN&quot; &quot;reference.dtd&quot;>
				</xsl:when>
				<xsl:when test="contains(/*/@xsi:noNamespaceSchemaLocation, 'bookmap.xsd')">
					<xsl:value-of select="$header"/><xsl:if test="string-length($header) > 0"><xsl:text>
</xsl:text></xsl:if>&lt;!DOCTYPE bookmap PUBLIC &quot;-//OASIS//DTD DITA 2.x Bookmap//EN&quot; &quot;bookmap.dtd&quot;>
				</xsl:when>
				<xsl:when test="contains(/*/@xsi:noNamespaceSchemaLocation, 'map.xsd')">
					<xsl:value-of select="$header"/><xsl:if test="string-length($header) > 0"><xsl:text>
</xsl:text></xsl:if>&lt;!DOCTYPE map PUBLIC &quot;-//OASIS//DTD DITA 2.x Map//EN&quot; &quot;map.dtd&quot;>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$header"/>
				</xsl:otherwise>
			</xsl:choose>	
		</xsl:variable>
		<!-- TODO what do we do if we have XML Schema based topics and maps? -->
		<xsl:comment>
			<xsl:value-of
				select="xrf:set-content-before-root(string-join($headerFinal, ''))"/>
		</xsl:comment>
		<xsl:apply-templates select="node()"/>
	</xsl:template>
	
	<xsl:template match="@xsi:noNamespaceSchemaLocation">
		<xsl:message>XML Schema based topics and maps are no longer supported</xsl:message>
	</xsl:template>
	
	<!-- Elements removed in DITA 2.0. Unwrap. -->
	<xsl:template match="titlealts|itemgroup|topicset|topicsetref">
		<xsl:message>The element '<xsl:value-of select="name()"/>' is removed in the DITA 2.0 standard.</xsl:message>
		<xsl:apply-templates select="node()"/>
	</xsl:template>
	
	<!-- Elements removed in DITA 2.0. Remove completely. -->
	<xsl:template match="longquoteref|anchor|anchorref
		|hasInstance|hasKind|hasNarrower|hasPart|hasRelated|relatedSubjects
		|subjectRelTable|subjectRelHeader|subjectRel|subjectRole">
		<xsl:message>The element '<xsl:value-of select="name()"/>' is removed in the DITA 2.0 standard.</xsl:message>
	</xsl:template>
	
	<!--Attributes removed in DITA 2.0-->
	<xsl:template match="@mapkeyref|link/@query|hazardsymbol/@longdescref
		|@domains|@xtrf|@xtrc|@copy-to|@lockmeta
		|@locktitle|@navtitle|@spectitle|@specentry">
		<xsl:message>The attribute '<xsl:value-of select="name()"/>' is removed in the DITA 2.0 standard.</xsl:message>
	</xsl:template>
	
	<xsl:function name="oxy:generateResourceID">
		<xsl:param name="context" as="node()"/>
		<resourceid appid-role="deliverable-anchor">
			<xsl:attribute name="appid">
				<!-- Remove any path and extension -->
				<xsl:variable name="simplifiedCopyTo" select="$context/@copy-to"/>
				<xsl:variable name="simplifiedCopyTo" select="tokenize($simplifiedCopyTo, '/')[last()]"/>
				<xsl:variable name="simplifiedCopyTo" select="replace($simplifiedCopyTo, '.xml', '')"/>
				<xsl:variable name="simplifiedCopyTo" select="replace($simplifiedCopyTo, '.dita', '')"/>
				<xsl:value-of select="$simplifiedCopyTo"/>
			</xsl:attribute>
		</resourceid>
	</xsl:function>
	
	<!-- Removed this token value from DITA 2.0 -->
	<xsl:template match="@type[.='fastpath']">
		<xsl:message>The attribute value 'fastpath' for attribute @type is removed in the DITA 2.0 standard.</xsl:message>
	</xsl:template>
	
	<!-- Removed @alt attribute -->
	<xsl:template match="*[@alt]">
		<xsl:copy>
			<xsl:apply-templates select="@* except @alt"/>
			<xsl:element name="alt">
				<xsl:value-of select="@alt"/>
			</xsl:element>
			<xsl:apply-templates select="node()"/>
		</xsl:copy>
	</xsl:template>
	
	<!-- Removed navtitle attribute from topicref, try to add it as child of topicmeta -->
	<!-- Attribute removed in 2.0 standard 
	https://lists.oasis-open.org/archives/dita/202105/msg00001.html-->
	<!-- Replaced copy-to attribute with resourceid element -->
	<xsl:template match="*[@navtitle or @copy-to][not(topicmeta)]">
		<xsl:copy>
			<xsl:apply-templates select="@* except @navtitle"/>
			<xsl:element name="topicmeta">
				<xsl:if test="@navtitle">
					<xsl:element name="navtitle">
						<xsl:value-of select="@navtitle"/>
					</xsl:element>
				</xsl:if>
				<xsl:if test="@copy-to">
					<xsl:copy-of select="oxy:generateResourceID(.)"/>
				</xsl:if>
			</xsl:element>
			<xsl:apply-templates select="node()"/>
		</xsl:copy>
	</xsl:template>
	
	<xsl:template match="*[@navtitle or @copy-to]/topicmeta">
		<xsl:copy>
			<xsl:apply-templates select="@*"/>
			<xsl:if test="parent::*/@navtitle">
				<xsl:element name="navtitle">
					<xsl:value-of select="parent::*/@navtitle"/>
				</xsl:element>
			</xsl:if>
			<xsl:if test="parent::*/@copy-to">
				<xsl:copy-of select="oxy:generateResourceID(parent::*)"/>
			</xsl:if>
			<xsl:apply-templates select="node()"/>
		</xsl:copy>
	</xsl:template>
	
	<!-- Removed in DITA 2.0 -->
	<xsl:template match="*[@title]">
		<xsl:copy>
			<xsl:apply-templates select="@* except @title"/>
			<xsl:element name="title">
				<xsl:value-of select="@title"/>
			</xsl:element>
			<xsl:apply-templates select="node()"/>
		</xsl:copy>
	</xsl:template>
	
	<!-- Removed in DITA 2.0, try to convert to delivery target. -->
	<xsl:template match="@print">
		<xsl:choose>
			<xsl:when test=".='yes'">
				<xsl:attribute name="deliveryTarget" select="'all'"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:attribute name="deliveryTarget" select="'not-in-pdf'"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<!-- Removed task substep -->
	<xsl:template match="substep">
		<xsl:element name="step">
			<xsl:apply-templates select="@* | node()"/>
		</xsl:element>
	</xsl:template>
	
	<!-- Removed task substeps -->
	<xsl:template match="substeps">
		<xsl:element name="steps">
			<xsl:apply-templates select="@* | node()"/>
		</xsl:element>
	</xsl:template>
	
	<!-- Removed in DITA 2.0. Replace it with what? Or issue warning? -->
	<xsl:template match="index-sort-as">
		<xsl:element name="sort-as">
			<xsl:apply-templates select="@* | node()"/>
		</xsl:element>
	</xsl:template>
	
	<!-- Move shortdesc before titlealts before converting it to a prolog -->
	<xsl:template match="*[title][titlealts][shortdesc][not(prolog)]">
		<xsl:copy>
			<xsl:apply-templates select="@*"/>
			<xsl:apply-templates select="node()[following-sibling::titlealts]"/>
			<xsl:apply-templates select="shortdesc"/>
			<xsl:apply-templates select="titlealts"/>
			<xsl:apply-templates select="node()[preceding-sibling::shortdesc]"/>
		</xsl:copy>
	</xsl:template>
	
	<!--Element removed in DITA 2.0, move its contents to the prolog element-->
	<xsl:template match="titlealts[following-sibling::prolog]">
		<xsl:message>The element 'titlealts' is removed in the DITA 2.0 standard. Moving its contents to 'prolog'.</xsl:message>
	</xsl:template>
	<xsl:template match="prolog">
		<xsl:copy>
			<xsl:apply-templates select="@*"/>
			<xsl:if test="preceding-sibling::titlealts">
				<!-- Copy the titlealts content here -->
				<xsl:apply-templates select="preceding-sibling::titlealts/node()"/>
			</xsl:if>
			<xsl:apply-templates select="node()"/>
		</xsl:copy>
	</xsl:template>
	<xsl:template match="titlealts[not(following-sibling::prolog)]">
		<!-- Convert to prolog -->
		<xsl:message>The element 'titlealts' is removed in the DITA 2.0 standard. Converting to 'prolog'.</xsl:message>
		<prolog>
			<xsl:apply-templates select="@* | node()"/>
		</prolog>
	</xsl:template>
	
	<!-- Rename 'linxtext 'to "linktitle" in DITA map topicmeta -->
	<xsl:template match="topicmeta/linktext">
		<xsl:message>The element 'linktext' is removed in the DITA 2.0 standard. Converting to 'linktitle'.</xsl:message>
		<linktitle>
			<xsl:apply-templates select="@* | node()"/>
		</linktitle>
	</xsl:template>
	
	<!-- Rename sectiondiv to div -->
	<xsl:template match="sectiondiv">
		<xsl:message>The element 'sectiondiv' is removed in the DITA 2.0 standard. Converting to 'div'.</xsl:message>
		<div>
			<xsl:apply-templates select="@* | node()"/>
		</div>
	</xsl:template>
	
	<!-- longquoteref was removed, pass attributes to parent lq -->
	<xsl:template match="lq[longquoteref]">
		<xsl:copy>
			<xsl:apply-templates select="@*"/>
			<xsl:apply-templates select="longquoteref/@*"/>
			<xsl:apply-templates select="node()"/>
		</xsl:copy>
	</xsl:template>
	
	<xsl:template match="node() | @*">
		<xsl:copy>
			<xsl:apply-templates select="node() | @*"/>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>