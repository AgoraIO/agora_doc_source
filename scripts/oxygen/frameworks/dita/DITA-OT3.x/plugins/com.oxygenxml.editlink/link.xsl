<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:editlink="http://oxygenxml.com/xslt/editlink/"
    xmlns:local="urn:localfunctions"
    exclude-result-prefixes="editlink xs local"  
    >
  
  <!-- Computes the link to be opened for a given topic in the context of a given map. -->
  <xsl:function name="editlink:compute" as="xs:string">
    <!-- The URL of the DITA map, as required by Web Author. -->
    <xsl:param name="remote.ditamap.url" as="xs:string"/>
    <!-- The semi encoded path to the local copy of the DITA  map. Semi encoded means that all characters but ":", "/" and "\" are encoded. -->
    <xsl:param name="local.ditamap.path" as="xs:string"/>
    <!-- The file:// URL of the local copy of the topic. -->
    <xsl:param name="local.topic.file.url" as="xs:string"/>
    <!-- The URL of the Web Author deployment. -->
    <xsl:param name="web.author.url" as="xs:string"/>
    <!-- The path of the DITAVAL file. -->
    <xsl:param name="local.ditaval.path" as="xs:string"/>
    <!-- The URL of DITA map opened in Web Auhtor or Content Fusion. -->
    <xsl:param name="ditamap.edit.url" as="xs:string"/>
    <!-- The additional query parameters to be appended at the computed URL. E.g: &showDitaMapView=true -->
    <xsl:param name="additional.query.parameters" as="xs:string"/>
    
    <xsl:variable name="local.ditamap.path.semi.encoded" 
      select="replace(replace(replace(encode-for-uri($local.ditamap.path), '%3A', ':'), '%2F', '/'), '%5C', '/')"/>

    <xsl:choose>
      <xsl:when test="$ditamap.edit.url">
        <xsl:value-of select="
          editlink:compute-new(
            $local.ditamap.path.semi.encoded,
            $local.topic.file.url,
            $ditamap.edit.url,
            $additional.query.parameters)"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="
          editlink:compute-old(
            $remote.ditamap.url,
            $local.ditamap.path,
            $local.topic.file.url,
            $web.author.url,
            $local.ditaval.path)"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>
  
    <!-- Computes the URL to be opened in Web Author or Conten Fusion. -->
    <xsl:function name="editlink:compute-new" as="xs:string">
      <!-- The semi encoded path to the local copy of the DITA  map. Semi encoded means that all characters but ":", "/" and "\" are encoded. -->
      <xsl:param name="local.ditamap.path.semi.encoded" as="xs:string"/>
      <!-- The file:// URL of the local copy of the topic. -->
      <xsl:param name="local.topic.file.url" as="xs:string"/>
      <!-- The URL of DITA map opened in Web Auhtor or Content Fusion. -->
      <xsl:param name="ditamap.edit.url" as="xs:string"/>
      <!-- The additional query parameters to be appended at the computed URL. E.g: &showDitaMapView=true -->
      <xsl:param name="additional.query.parameters" as="xs:string"/>

      <xsl:choose>
        <xsl:when test="contains($ditamap.edit.url,'url=')">
          <xsl:value-of select="
            editlink:compute-new-web-author(
            $local.ditamap.path.semi.encoded,
            $local.topic.file.url,
            $ditamap.edit.url,
            $additional.query.parameters)"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="
            editlink:compute-new-fusion(
            $local.ditamap.path.semi.encoded,
            $local.topic.file.url,
            $ditamap.edit.url)"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:function>
  
    <!-- Computes the Content Fusion link to be opened for a given topic in the context of a given map. -->
    <xsl:function name="editlink:compute-new-fusion" as="xs:string">
      <!-- The semi encoded path to the local copy of the DITA  map. Semi encoded means that all characters but ":", "/" and "\" are encoded. -->
      <xsl:param name="local.ditamap.path.semi.encoded" as="xs:string"/>
      <!-- The file:// URL of the local copy of the topic. -->
      <xsl:param name="local.topic.file.url" as="xs:string"/>
      <!-- The URL of DITA map opened in Content Fusion. -->
      <xsl:param name="ditamap.edit.url" as="xs:string"/>

<!--
      <xsl:message select="concat('local.ditamap.path.semi.encoded: ', $local.ditamap.path.semi.encoded)"></xsl:message>
      <xsl:message select="concat('local.topic.file.url: ', $local.topic.file.url)"></xsl:message>
      <xsl:message select="concat('ditamap.edit.url: ', $ditamap.edit.url)"></xsl:message>-->
      

      <xsl:variable name="fusion-edit-root-url" select='replace($ditamap.edit.url, "(^.*/tasks/[^/]+/edit/).+", "$1")'/>
      <xsl:variable name="ditamap-relative-path" select='replace($ditamap.edit.url, "^.*/tasks/[^/]+/edit/(.+)", "$1")'/>
      <xsl:variable name="common-ancestor-path-length" select='string-length($local.ditamap.path.semi.encoded) - string-length($ditamap-relative-path)'/>
      <xsl:variable name="common-ancestor-path" select="concat(substring($local.ditamap.path.semi.encoded, 0, $common-ancestor-path-length), '/')"/>
      
    <!--  <xsl:message select="concat('fusion-edit-root-url: ', $fusion-edit-root-url)"></xsl:message>
      <xsl:message select="concat('ditamap-relative-path: ', $ditamap-relative-path)"></xsl:message>
      <xsl:message select="concat('common-ancestor-path-length: ', $common-ancestor-path-length)"></xsl:message>
      <xsl:message select="concat('common-ancestor-path: ', $common-ancestor-path)"></xsl:message>-->
      
      <xsl:variable name="file.rel.path">
        <xsl:value-of select="editlink:makeRelative(editlink:toUrl(escape-html-uri($common-ancestor-path)), escape-html-uri($local.topic.file.url))"/>
      </xsl:variable>

      <!--<xsl:message select="concat('file.rel.path: ', $file.rel.path)"></xsl:message>-->

      <xsl:value-of select="concat($fusion-edit-root-url, $file.rel.path)"/>
      
      <!--<xsl:message select="concat('resulting: ', $fusion-edit-root-url, $file.rel.path)"/>-->
    </xsl:function>

    <!-- Computes the Web Author link to be opened for a given topic in the context of a given map. -->
    <xsl:function name="editlink:compute-new-web-author" as="xs:string">
      <!-- The semi encoded path to the local copy of the DITA  map. Semi encoded means that all characters but ":", "/" and "\" are encoded. -->
      <xsl:param name="local.ditamap.path.semi.encoded" as="xs:string"/>
      <!-- The file:// URL of the local copy of the topic. -->
      <xsl:param name="local.topic.file.url" as="xs:string"/>
      <!-- The URL of DITA map opened in Web Auhtor. -->
      <xsl:param name="ditamap.edit.url" as="xs:string"/> 
      <!-- The additional query parameters to be appended at the computed URL. E.g: &showDitaMapView=true -->
      <xsl:param name="additional.query.parameters" as="xs:string"/>
      
      <xsl:variable name="web-author-url-before-parameters" select='replace($ditamap.edit.url, "(^[^?]+).*", "$1")'/>
      <xsl:variable name="web-author-ditamap-url-param-value" select="editlink:extractParameterValue('url', $ditamap.edit.url)"/>
      <xsl:variable name="web-author-ditaval-url-param-value" select="editlink:extractParameterValue('dita.val.url', $ditamap.edit.url)"/>
      
      <xsl:variable name="ditamap-semi-decoded-url" select="replace(replace($web-author-ditamap-url-param-value, '%2F', '/'), '%3A', ':')"/>
      <xsl:variable name="local.ditamap.url.semi.encoded" select="editlink:toUrl($local.ditamap.path.semi.encoded)"/>

      <xsl:variable name="file.rel.path">
        <xsl:value-of select="editlink:makeRelative(editlink:toUrl(escape-html-uri($local.ditamap.path.semi.encoded)), escape-html-uri($local.topic.file.url))"/>
      </xsl:variable>
      <xsl:variable name="edit-file-url" select="resolve-uri($file.rel.path, $ditamap-semi-decoded-url)"/>
      <xsl:variable name="edit-file-url-encoded" select="replace(replace($edit-file-url, '/', '%2F'), ':', '%3A')"/>
      
      <xsl:variable name="ditaval.query.param">
        <xsl:if test="$web-author-ditaval-url-param-value != ''">
          <xsl:value-of select="concat('&amp;dita.val.url=', $web-author-ditaval-url-param-value)"/>
        </xsl:if>
      </xsl:variable>
      
      <xsl:value-of select="concat($web-author-url-before-parameters, '?url=', $edit-file-url-encoded, '&amp;', 'ditamap=', $web-author-ditamap-url-param-value, $ditaval.query.param, $additional.query.parameters)"/>
    </xsl:function>

    <!-- (deprecated) Computes the Web Author link to be opened for a given topic in the context of a given map. -->
    <xsl:function name="editlink:compute-old" as="xs:string">
        <!-- The URL of the DITA map, as required by Web Author. -->
        <xsl:param name="remote.ditamap.url" as="xs:string"/>
        <!-- The semi encoded path to the local copy of the DITA map. Semi encoded means that all characters but ":", "/" and "\" are encoded. -->
        <xsl:param name="local.ditamap.path" as="xs:string"/>
        <!-- The file:// URL of the local copy of the topic. -->
        <xsl:param name="local.topic.file.url" as="xs:string"/>
        <!-- The URL of the Web Author deployment. -->
        <xsl:param name="web.author.url" as="xs:string"/>
        <!-- The path of the DITAVAL file. -->
        <xsl:param name="local.ditaval.path" as="xs:string"/>
      
        <!-- Use a default value for the Web Author deployment.-->
        <xsl:variable name="web.author.url.nonull">
          <xsl:value-of select="if ($web.author.url != '') then $web.author.url else 'https://www.oxygenxml.com/oxygen-xml-web-author/'"/>
        </xsl:variable>

        <xsl:variable name="ditamap.url.encoded">
            <xsl:value-of select="encode-for-uri($remote.ditamap.url)"/>
        </xsl:variable>
        
        <!-- Compute the URL params for the edit url -->
        <xsl:variable name="file.rel.path">
            <xsl:value-of select="editlink:makeRelative(editlink:toUrl($local.ditamap.path), $local.topic.file.url)"/>
        </xsl:variable>
        <xsl:variable name="file.url.encoded">
            <xsl:value-of select="encode-for-uri(resolve-uri($file.rel.path, $remote.ditamap.url))"/>
        </xsl:variable>
        <xsl:variable name="ditaval.query.param">
            <xsl:if test="$local.ditaval.path != ''">
                <xsl:variable name="ditaval.rel.path">
                    <xsl:value-of select="editlink:makeRelative(editlink:toUrl($local.ditamap.path), editlink:toUrl($local.ditaval.path))"/>
                </xsl:variable>
                <xsl:variable name="ditaval.url.encoded">
                    <xsl:value-of select="encode-for-uri(resolve-uri($ditaval.rel.path, $remote.ditamap.url))"/>
                </xsl:variable>
                <xsl:value-of select="concat('&amp;dita.val.url=', $ditaval.url.encoded)"/>
            </xsl:if>
        </xsl:variable>
        
      <xsl:value-of select="concat($web.author.url.nonull, 'app/oxygen.html?url=', $file.url.encoded, '&amp;ditamap=', $ditamap.url.encoded, $ditaval.query.param)"/>
    </xsl:function>
    
    <!-- Makes the topic URL relative to the map URL. -->
    <xsl:function name="editlink:makeRelative" as="xs:string">
        <xsl:param name="map" as="xs:string"/>
        <xsl:param name="topic" as="xs:string"/>

        <xsl:variable name="normalizedMap" as="xs:string">
            <xsl:value-of select="tokenize($map, '/')[.!='' and .!='.' and position()!=last()]" separator="/" />
        </xsl:variable>
        <xsl:variable name="mapBase" as="xs:string" select="concat($normalizedMap, '/')"/>
        <xsl:variable name="normalizedTopic" as="xs:string">
            <xsl:value-of select="tokenize($topic, '/')[.!='' and .!='.']" separator="/" />
        </xsl:variable>

        <xsl:choose>
            <xsl:when test="$map=''"><xsl:value-of select="''"/></xsl:when>
            <xsl:when test="starts-with($normalizedTopic, $mapBase)">
                <xsl:value-of select="substring-after($normalizedTopic, $mapBase)"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:variable name="x" select="editlink:makeRelative($normalizedMap, $normalizedTopic)"/>
                <xsl:choose>
                    <xsl:when test="$x=''">
                        <xsl:value-of select="''"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="concat('../', $x)"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    
    <!-- Translates a file path to a file:// URL. -->
    <xsl:function name="editlink:toUrl" as="xs:string">
        <xsl:param name="filepath" as="xs:string"/>
        <xsl:variable name="url" as="xs:string"
            select="if (contains($filepath, '\'))
            then translate($filepath, '\', '/')
            else $filepath
            "
        />
        <xsl:variable name="fileUrl" as="xs:string"
            select="
            if (matches($url, '^[a-zA-Z]:'))
            then concat('file:/', $url)
            else if (starts-with($url, '/')) 
            then concat('file:', $url) 
            else $url
            "
        />
        <xsl:variable name="escapedUrl" 
            select="replace($fileUrl, ' ', '%20')"
        />
        <xsl:sequence select="$escapedUrl"/>
    </xsl:function>

     <!-- Extract an URL parameter from a given URL. -->
     <xsl:function name="editlink:extractParameterValue"  as="xs:string">
       <xsl:param name="parameter.name"></xsl:param>
       <xsl:param name="url"></xsl:param>
       
       <xsl:variable name="regexp" select="concat('.*[?&amp;]', $parameter.name, '=([^&amp;]+).*')"/>
       <xsl:choose>
         <xsl:when test="matches($url, $regexp)">
           <xsl:value-of select="replace($url, $regexp, '$1')"/>
         </xsl:when>
         <xsl:otherwise>
           <xsl:value-of select="''"/>
         </xsl:otherwise>
       </xsl:choose>
     </xsl:function>

    <!-- Attributes used for FO links -->
    <xsl:attribute-set name="fo-link-attrs">
        <xsl:attribute name="text-align">right</xsl:attribute>
        <xsl:attribute name="white-space">nowrap</xsl:attribute>
        <xsl:attribute name="text-decoration">underline</xsl:attribute>
        <xsl:attribute name="color">navy</xsl:attribute>
        <xsl:attribute name="font-size">8pt</xsl:attribute>
        <xsl:attribute name="font-weight">normal</xsl:attribute>
        <xsl:attribute name="width">80pt</xsl:attribute>
        <xsl:attribute name="font-style"> normal</xsl:attribute>
    </xsl:attribute-set>
</xsl:stylesheet>

