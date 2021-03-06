<?xml version='1.0'?>

<!-- Oxygen add-on for EXM-11363, show in the PDF output the embeded MathML formulas-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    version="1.0"
    xmlns:ditaarch="http://dita.oasis-open.org/architecture/2005/">

  <xsl:template match="*[contains(@class,' math-d/math ') 
    or (contains(@class, ' mathml-d/mathml ') and ancestor::*[@ditaarch:DITAArchVersion='1.2'])]">
    <!-- Handle multiple forms of the class attribute for the mathml elements.-->
      <fo:instream-foreign-object>
        <xsl:copy-of select="child::mml:math" xmlns:mml="http://www.w3.org/1998/Math/MathML"/>
      </fo:instream-foreign-object>
    </xsl:template>

</xsl:stylesheet>