<?xml version="1.0" encoding="UTF-8"?>
<!--
    
Oxygen WebHelp Plugin
Copyright (c) 1998-2022 Syncro Soft SRL, Romania.  All rights reserved.

-->

<!--
  Contains a set of patches that are applied over the generated HTML. 
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:xhtml="http://www.w3.org/1999/xhtml"
  exclude-result-prefixes="xs xhtml"
  version="2.0">

  <!--EXM-32868 Allow data- attributes to pass through -->
  <xsl:template match="@*[starts-with(name(), 'data-')]" mode="add-xhtml-ns" priority="20">
    <xsl:copy/>
  </xsl:template>
    
</xsl:stylesheet>