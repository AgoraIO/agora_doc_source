<?xml version="1.0" encoding="UTF-8"?>
<!-- 

  This stylesheet changes the choicetables structure.

-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="2.0">

  <!-- 
    Clean the choicetable, there are generated lots of deprecated attributes and style attributes. 
  -->
  <xsl:template match="*[contains(@class,' task/choicetable ')]" name="topic.task.choicetable">
    <xsl:variable name="generated">
      <xsl:next-match/>
    </xsl:variable>
  
    <xsl:apply-templates select="$generated" mode="clean-choicetable"/>
  </xsl:template>
    
  <xsl:template match="node() | @*" mode="clean-choicetable">
    <xsl:copy>
      <xsl:apply-templates select="node() | @*" mode="#current"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="@border" mode="clean-choicetable"/>
  <xsl:template match="@frame" mode="clean-choicetable"/>
  <xsl:template match="@rules" mode="clean-choicetable"/>
  <xsl:template match="@cellpadding" mode="clean-choicetable"/>
  <xsl:template match="@cellspacing" mode="clean-choicetable"/>
  <xsl:template match="@summary" mode="clean-choicetable"/>

  <!-- Leave the styling only on the col element, so it can create proportional columns. -->
  <xsl:template match="@style[not(../local-name()='col')]" mode="clean-choicetable"/>
  
</xsl:stylesheet>
