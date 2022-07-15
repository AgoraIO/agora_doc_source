<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:f="http://oxygenxml.com/ns/xslt/functions"
  xmlns:dp="https://www.dita-ot.org/project"
  exclude-result-prefixes="xs"
  version="3.0">
  
  <xsl:function name="f:getContexts" as="item()*">
    <xsl:param name="projectDoc" as="document-node()?"/>
    <xsl:sequence select="$projectDoc//dp:context/@id, $projectDoc//dp:include[@href!='']/f:getContexts(if (doc-available(resolve-uri(@href, base-uri()))) then document(@href) else ())"></xsl:sequence>
  </xsl:function>
  
  <xsl:function name="f:getPublications" as="item()*">
    <xsl:param name="projectDoc" as="document-node()"/>
    <xsl:sequence select="$projectDoc//dp:publication/@id, $projectDoc//dp:include[@href!='']/f:getPublications(if (doc-available(resolve-uri(@href, base-uri()))) then document(@href) else ())"></xsl:sequence>
  </xsl:function>
  
  
  <xsl:function name="f:getParams">
    <xsl:param name="transtype" as="xs:string"></xsl:param>
    <xsl:param name="plugins" as="node()"></xsl:param>
    <xsl:variable name="t" as="node()*" select="$plugins//transtype[@name=$transtype]"/>
    <xsl:for-each select="$t">
      <xsl:for-each select="param">
        <xsl:copy-of select="."/>
      </xsl:for-each>
      <xsl:choose>
        <xsl:when test="$t/@extends !=''">
          <xsl:copy-of select="f:getParams($t/@extends, $plugins)"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:if test="not($transtype='base')">
            <xsl:copy-of select="f:getParams('base', $plugins)"/>
          </xsl:if>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>    
  </xsl:function>
  
  <xsl:function name="f:getTranstypeParameters" as="map(xs:string, node()*)">
    <xsl:param name="plugins" as="node()"/>
    <xsl:map>
      <xsl:for-each select="distinct-values($plugins//transtype/@name)">
        <xsl:map-entry key="string(.)">
          <xsl:copy-of select="f:getParams(., $plugins)"/>
        </xsl:map-entry>
      </xsl:for-each>
    </xsl:map>    
  </xsl:function>
  
</xsl:stylesheet>