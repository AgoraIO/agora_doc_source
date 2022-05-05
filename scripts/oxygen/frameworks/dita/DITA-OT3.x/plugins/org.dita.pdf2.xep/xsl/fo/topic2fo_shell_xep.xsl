<?xml version="1.0" encoding="UTF-8"?><!--
This file is part of the DITA Open Toolkit project.

Copyright 2011 Jarno Elovirta

See the accompanying LICENSE file for applicable license.
--><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
  
  <xsl:import href="plugin:org.dita.pdf2:xsl/fo/topic2fo.xsl"/>

  <xsl:import href="plugin:org.dita.pdf2.xep:cfg/fo/attrs/commons-attr_xep.xsl"/>
  <xsl:import href="plugin:org.dita.pdf2.xep:cfg/fo/attrs/layout-masters-attr_xep.xsl"/>
  <xsl:import href="plugin:org.dita.pdf2.xep:xsl/fo/root-processing_xep.xsl"/>
  <xsl:import href="plugin:org.dita.pdf2.xep:cfg/fo/attrs/index-attr_xep.xsl"/>
  <xsl:import href="plugin:org.dita.pdf2.xep:xsl/fo/index_xep.xsl"/>
  <xsl:import href="plugin:org.dita.pdf2.xep:xsl/fo/topic_xep.xsl"/>

  <xsl:import xmlns:dita="http://dita-ot.sourceforge.net" href="plugin:com.oxygenxml.dita-ot.plugin.mathml:pdfMathML.xsl"/><xsl:import href="plugin:com.oxygenxml.editlink:xslfo.xsl"/><xsl:import href="plugin:com.oxygenxml.highlight:pdfHighlight.xsl"/><xsl:import href="plugin:com.oxygenxml.image.float:customFO.xsl"/><xsl:import href="plugin:com.oxygenxml.media:pdfMedia.xsl"/><xsl:import href="plugin:com.oxygenxml.pdf.custom:custom.xsl"/><xsl:import href="plugin:com.oxygenxml.pdf.review:review/review-pis-to-elements-pdf-classic.xsl"/><xsl:import href="plugin:org.dita-community.common.xslt:xsl/commonXsltExtensionSupport.xsl"/><xsl:import href="plugin:org.dita-community.dita13.pdf:xsl/dita13Vocab2Pdf.xsl"/>

  <xsl:import href="cfg:fo/attrs/custom.xsl"/>
  <xsl:import href="cfg:fo/xsl/custom.xsl"/>
  
</xsl:stylesheet>