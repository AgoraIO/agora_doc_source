<?xml version="1.0" encoding="UTF-8"?><!--
This file is part of the DITA Open Toolkit project.

Copyright 2016 Jarno Elovirta

See the accompanying LICENSE file for applicable license.
--><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">

  <xsl:import href="plugin:org.dita.base:xsl/common/output-message.xsl"/>
  <xsl:import href="plugin:org.dita.base:xsl/common/dita-utilities.xsl"/>
  <xsl:import href="plugin:org.dita.base:xsl/common/related-links.xsl"/>
  <xsl:import href="plugin:org.dita.base:xsl/common/dita-textonly.xsl"/>
  
  <xsl:import href="plugin:org.dita.html5:xsl/topic.xsl"/>
  <xsl:import href="plugin:org.dita.html5:xsl/concept.xsl"/>
  <xsl:import href="plugin:org.dita.html5:xsl/glossdisplay.xsl"/>
  <xsl:import href="plugin:org.dita.html5:xsl/task.xsl"/>
  <xsl:import href="plugin:org.dita.html5:xsl/reference.xsl"/>
  <xsl:import href="plugin:org.dita.html5:xsl/ut-d.xsl"/>
  <xsl:import href="plugin:org.dita.html5:xsl/sw-d.xsl"/>
  <xsl:import href="plugin:org.dita.html5:xsl/pr-d.xsl"/>
  <xsl:import href="plugin:org.dita.html5:xsl/ui-d.xsl"/>
  <xsl:import href="plugin:org.dita.html5:xsl/hi-d.xsl"/>
  <xsl:import href="plugin:org.dita.html5:xsl/abbrev-d.xsl"/>
  <xsl:import href="plugin:org.dita.html5:xsl/markup-d.xsl"/>
  <xsl:import href="plugin:org.dita.html5:xsl/xml-d.xsl"/>
  <xsl:import href="plugin:org.dita.html5:xsl/svg-d.xsl"/>
  <xsl:import href="plugin:org.dita.html5:xsl/hazard-d.xsl"/>

  <xsl:import href="plugin:org.dita.html5:xsl/nav.xsl"/>
  
  <xsl:import href="plugin:org.dita.html5:xsl/htmlflag.xsl"/>
    
  <xsl:import xmlns:dita="http://dita-ot.sourceforge.net" href="plugin:com.oxygenxml.dita-ot.plugin.mathml:xhtmlMathML.xsl"/><xsl:import href="plugin:com.oxygenxml.editlink:xhtml.xsl"/><xsl:import href="plugin:com.oxygenxml.highlight:xhtmlHighlight.xsl"/><xsl:import href="plugin:com.oxygenxml.html.embed:xhtmlEmbed.xsl"/><xsl:import href="plugin:com.oxygenxml.image.float:customXHTML.xsl"/><xsl:import href="plugin:com.oxygenxml.media:xhtmlMedia.xsl"/><xsl:import href="plugin:org.dita-community.dita13.html:xsl/dita13Vocab2Html.xsl"/><xsl:import href="plugin:org.dita.html5.dublin-core:xsl/dublin-core.xsl"/>

  <!-- root rule -->
  <xsl:template match="/">
    <xsl:apply-templates/>
  </xsl:template>
  
</xsl:stylesheet>