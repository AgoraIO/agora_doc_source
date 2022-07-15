<?xml version="1.0" encoding="UTF-8"?>
<!--
    
Oxygen Webhelp plugin
Copyright (c) 1998-2022 Syncro Soft SRL, Romania.  All rights reserved.

-->

<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:relpath="http://dita2indesign/functions/relpath"
  xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc"
  xmlns:oxygen="http://www.oxygenxml.com/functions"
  exclude-result-prefixes="#all"
  version="2.0">
  
  <xsl:import href="plugin:org.dita.html5:xsl/dita2html5Impl.xsl"/>

  <xsl:import href="../util/dita-utilities-extra.xsl"/>
  
  <xsl:import href="html5-pdf-webhelp/html5-pdf-webhelp.xsl"/>
  <xsl:import href="html5-webhelp/html5-webhelp.xsl"/>

  <xsl:import href="../review/review-elements-to-html.xsl"/>
  
  <!-- Apply selected template -->
  <xsl:import href="../template/topicComponentsExpander.xsl"/>
  <xsl:import href="../util/functions.xsl"/>
  
  <xsl:output 
            method="xhtml" 
            html-version="5.0"
            encoding="UTF-8"
            indent="no"
            omit-xml-declaration="yes"
            include-content-type="no"/>

  <!-- Enable debugging from here. --> 
  <xsl:param name="WEBHELP_DEBUG" select="false()"/>
  
  <!-- 
    Current oXygen build number. 
  -->
  <xsl:param name="WEBHELP_BUILD_NUMBER"/>
  
  <xsl:param name="genAddDiv" select="true()"/>
  
  <!-- The path of toc.xml -->
  <xsl:param name="TOC_XML_FILEPATH" select="'in/toc.xml'"/>
  
  <xsl:variable name="toc" select="document(oxygen:makeURL($TOC_XML_FILEPATH), .)/toc:toc"/>
  
  <!-- 
    The URL of the Webhelp template. 
    It is used to define which components will be displayed in Webhelp and also it defines the Webhelp layout. 
  -->
  <xsl:param name="WEBHELP_TEMPLATE_URL"/>
  
  <xsl:variable name="WEBHELP_IS_RESPONSIVE" select="true()"/>
  
  <!-- Google Custom Search code set by param webhelp.search.script -->
  <xsl:param name="WEBHELP_SEARCH_SCRIPT" select="''"/>
  
  <!-- Google Custom Search code set by param webhelp.search.results -->
  <xsl:param name="WEBHELP_SEARCH_RESULT" select="''"/>
  
  <!-- File path of image with the company logo. -->
  <xsl:param name="WEBHELP_LOGO_IMAGE" select="''"/>
  
  <!-- URL that will be opened when the logo image set with 
         the webhelp.logo.image parameter is clicked in the Webhelp page. -->
  <xsl:param name="WEBHELP_LOGO_IMAGE_TARGET_URL" select="''"/>
  
  <xsl:param name="WEBHELP_DEBUG_DITA_OT_OUTPUT" select="'no'"/>
  
  <xsl:param name="WEBHELP_DITAMAP_URL"/>
  
  <!-- WebHelp favicon -->
  <xsl:param name="WEBHELP_FAVICON"/>
  
  <xsl:param name="WEBHELP_PARAMETERS_URL" />
  
  <xsl:param name="WEBHELP_TRIAL_LICENSE" select="'no'"/>
  
  <xsl:param name="BASEDIR"/>
  <xsl:param name="OUTPUTDIR"/>
  <xsl:param name="LANGUAGE" select="'en-us'"/>
  
  <!-- Elements to generate data-ofbid attribute. -->
  <xsl:param name="DATA_OFBID_ELEMENTS"/>
  
  <!-- Elements that will not have the data-ofbid attribute generated. -->
  <xsl:param name="DATA_OFBID_ELEMENTS_TO_EXCLUDE"/>
  
  <!-- The path of index.xml -->
  <xsl:param name="INDEX_XML_FILEPATH" select="'in/index.xml'"/>
  
  <!-- Namespace in which to output TOC links -->
  <xsl:param name="namespace" select="'http://www.w3.org/1999/xhtml'"/>
  
  
  <!-- the path back to the project. Used for c.gif, delta.gif, css to allow user's to have
     these files in 1 location. -->
  <xsl:param name="PATH2PROJ">
    <!-- OXYGEN PATCH START  EXM-30937 -->
    <xsl:choose>
      <xsl:when test="/processing-instruction('path2project-uri')">        
        <xsl:apply-templates select="/processing-instruction('path2project-uri')[1]" mode="get-path2project"/>
      </xsl:when>
      <!-- WH-2358 - For the case when 'copy-to' and chunk='to-content' features are used. -->
      <xsl:when test="/dita/processing-instruction('path2project-uri')">        
        <xsl:apply-templates select="/dita/processing-instruction('path2project-uri')[1]" mode="get-path2project"/>
      </xsl:when>
      <xsl:when test="/processing-instruction('path2project')">
        <xsl:apply-templates select="/processing-instruction('path2project')[1]" mode="get-path2project"/>
      </xsl:when>
    </xsl:choose>
    <!-- OXYGEN PATCH END  EXM-30937 -->
  </xsl:param>
  
  
  <!-- Normal Webhelp transformation, filtered. -->
  <xsl:template match="/">
    <xsl:variable name="template_base_uri" select="base-uri()"/>
    
    <xsl:variable name="topicContent">
      <xsl:apply-imports/>
    </xsl:variable>    
    
    <xsl:choose>
      <xsl:when test="$WEBHELP_DEBUG">
        <!-- This generates Invalid HTML, but is OK for debugging. -->
        <html>
          <xsl:apply-templates select="$topicContent" mode="fixup"/>                 
          <hr/>
          <h1>Original content:</h1>
          <xsl:copy-of select="$topicContent"/>                
        </html>
      </xsl:when>
      <xsl:otherwise>
        <!-- Write to a separate file the content emited by DITA-OT -->
        <xsl:if test="$WEBHELP_DEBUG_DITA_OT_OUTPUT = 'yes'">
          <xsl:variable name="fileName" select="substring-before($FILENAME, '.')"/>
          <xsl:variable name="dita_ot_res" select="concat($OUTPUTDIR, '/', $FILEDIR, '/', $fileName, '_dita.html')"/>
          <xsl:variable name="dita_ot_res_url" select="relpath:toUrl($dita_ot_res)"/>
          <xsl:result-document href="{$dita_ot_res_url}">
              <xsl:copy-of select="$topicContent"/>
          </xsl:result-document>
        </xsl:if>
          
          
        <!-- Make small fixes over the DITA-OT HTML content -->
        <xsl:variable name="topicContent">
          <xsl:apply-templates select="$topicContent" mode="fixup"/>        
        </xsl:variable>
        
        <!-- Make sure that every node from document has HTML namespace-->
        <xsl:variable name="topicContent">
          <xsl:apply-templates select="$topicContent" mode="fixup_XHTML_NS"/>
        </xsl:variable>
        
        <!-- Apply the current selected template -->
        <xsl:variable name="wh_template_doc" select="doc($WEBHELP_TEMPLATE_URL)"/>
        
        <xsl:apply-templates select="$wh_template_doc" mode="copy_template">
          <xsl:with-param name="ditaot_topicContent" select="$topicContent" tunnel="yes"/>
          <!-- EXM-36737 - Context node used for messages localization -->
          <xsl:with-param name="i18n_context" select="/*" tunnel="yes" as="element()"/>
          
          <xsl:with-param name="template_base_uri" select="$WEBHELP_TEMPLATE_URL" tunnel="yes"/>
        </xsl:apply-templates>          
      </xsl:otherwise>
    </xsl:choose>    
  </xsl:template>
  
</xsl:stylesheet>