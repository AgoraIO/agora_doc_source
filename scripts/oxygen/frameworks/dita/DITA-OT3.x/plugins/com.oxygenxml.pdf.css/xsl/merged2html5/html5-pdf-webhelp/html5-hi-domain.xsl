<?xml version="1.0" encoding="UTF-8" ?>
<!--
This file is part of the DITA Open Toolkit project.

Copyright 2004, 2005 IBM Corporation

See the accompanying LICENSE file for applicable license.
-->
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
    <xsl:template match="*[contains(@class,' hi-d/tt ')]" name="topic.hi-d.tt">
      <span>
        <xsl:call-template name="commonattributes"/>
        <xsl:call-template name="setidaname"/>
        <xsl:apply-templates/>
      </span>
    </xsl:template>

</xsl:stylesheet>
