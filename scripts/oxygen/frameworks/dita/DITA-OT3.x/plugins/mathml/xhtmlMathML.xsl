<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="1.0" xmlns:ditaarch="http://dita.oasis-open.org/architecture/2005/">
      <!-- Add for "Support foreign content vocabularies such as 
    MathML and SVG with <unknown> (#35) " in DITA 1.1 -->
  <xsl:template match="*[contains(@class,' math-d/math ') 
    or (contains(@class, ' mathml-d/mathml ') and ancestor::*[@ditaarch:DITAArchVersion='1.2'])]" >
    <!-- Handle multiple forms of the class attribute for the mathml elements.-->
    <!-- Show in the XHTML output the embeded MathML formulas.-->
    <xsl:apply-templates select="mml:math" xmlns:mml="http://www.w3.org/1998/Math/MathML" mode="copyMathML"/>
    <xsl:apply-templates select="*[contains(@class,' topic/object ')][@type='DITA-foreign']"/>
  </xsl:template>
  
  <xsl:template match="*[namespace-uri()='http://www.w3.org/1998/Math/MathML']" mode="copyMathML">
    <xsl:element name="{local-name()}" namespace="http://www.w3.org/1998/Math/MathML">
      <xsl:apply-templates select="node() | @*" mode="copyMathML"/>
    </xsl:element>
  </xsl:template>
  
  <xsl:template match="node() | @*" mode="copyMathML">
    <xsl:copy>
      <xsl:apply-templates select="node() | @*" mode="copyMathML"/>
    </xsl:copy>
  </xsl:template>
  
</xsl:stylesheet>