<?xml version="1.0" encoding="UTF-8"?>
<!-- 
  Copyright 2001-2012 Syncro Soft SRL. All rights reserved.
 -->
<xsl:stylesheet version="2.0" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:e="http://www.oxygenxml.com/xsl/conversion-elements"
                xmlns:f="http://www.oxygenxml.com/xsl/functions"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:m="http://www.w3.org/1998/Math/MathML"
                xmlns:URL="java:java.net.URL"
                exclude-result-prefixes="xsl e f xs m URL">
  
  <xsl:template match="e:h1[ancestor::e:dl]
                     | e:h1[ancestor::e:section] 
                     | e:h2[ancestor::e:dl] 
                     | e:h2[ancestor::e:section] 
                     | e:h3[ancestor::e:dl] 
                     | e:h3[ancestor::e:section] 
                     | e:h4[ancestor::e:dl] 
                     | e:h4[ancestor::e:section] 
                     | e:h5[ancestor::e:dl]
                     | e:h5[ancestor::e:section]
                     | e:h6[ancestor::e:dl]
                     | e:h6[ancestor::e:section]">
      <b>
       <xsl:apply-templates select="@* | node()"/>
    </b>
  </xsl:template>

  <xsl:template match="m:math">
    <xsl:element name="mathml">
      <xsl:copy-of select="." copy-namespaces="no"/>
    </xsl:element>
  </xsl:template>
  
  <xsl:template match="e:p">
      <xsl:choose>
          <xsl:when test="(parent::e:td | parent::e:th) and count(parent::*[1]/*) = 1">
               <xsl:apply-templates select="@* | node()"/>
          </xsl:when>
          <xsl:when test="parent::e:ul | parent::e:ol">
              <!-- EXM-27834  Workaround for bug in OpenOffice/LibreOffice -->
              <li>
                  <p>
                      <xsl:call-template name="keepDirection"/>
                      <xsl:apply-templates select="@* | node()"/>
                  </p>
              </li>
          </xsl:when>
          <xsl:otherwise>
              <p>
                  <xsl:call-template name="keepDirection"/>
                  <xsl:apply-templates select="@* | node()"/>
              </p>
          </xsl:otherwise>
      </xsl:choose>
  </xsl:template>
    
  <xsl:template match="e:p[f:isNotePara(.)]">
    <!-- These footnotes are copied in content -->
  </xsl:template>  
    
  <xsl:function name="f:isNotePara" as="xs:boolean">
    <xsl:param name="param" as="node()?"/>
    <xsl:sequence select="starts-with($param/@class,'sdfootnote') 
      or starts-with($param/@class,'MsoFootnoteText') or f:isEndnotePara($param)"/>
  </xsl:function>
    
  <xsl:function name="f:isEndnotePara" as="xs:boolean">
    <xsl:param name="param" as="node()?"/>
    <xsl:sequence select="starts-with($param/@class,'sdendnote') 
                          or starts-with($param/@class,'MsoEndnoteText')"/>
  </xsl:function>
 
  <xsl:template match="e:sub">
    <sub>
      <xsl:apply-templates/>
    </sub>
  </xsl:template>  
  
  <xsl:template match="e:sup">
    <sup>
      <xsl:apply-templates/>
    </sup>
  </xsl:template>  
    
  <xsl:template match="e:span[@class = 'indexTerm']" priority="0.6">
    <indexterm>
      <xsl:apply-templates/>
    </indexterm>
  </xsl:template>
  
  <xsl:template match="e:span[@class = 'indexSee']" priority="0.6">
    <index-see>
      <xsl:apply-templates/>
    </index-see>
  </xsl:template>
    
  <xsl:template match="e:span[preceding-sibling::e:p and not(following-sibling::*)]">
     <p>
        <xsl:call-template name="keepDirection"/>
        <xsl:apply-templates select="@* | node()"/>
     </p>
  </xsl:template>
     
  <xsl:template match="e:pre">
    <xsl:choose>
      <xsl:when test="($context.path.last.name = 'codeblock' or $context.path.last.name = 'pre') and $context.path.last.uri = ''">
         <xsl:apply-templates select="@* | node()"/>
      </xsl:when>
      <xsl:otherwise>
        <pre>
          <xsl:call-template name="keepDirection"/>
          <xsl:apply-templates select="@* | node()"/>
        </pre>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="e:code">
    <xsl:choose>
      <xsl:when test="($context.path.last.name = 'codeblock' or $context.path.last.name = 'pre') and $context.path.last.uri = ''">
           <xsl:apply-templates select="@* | node()"/>
      </xsl:when>
      <xsl:otherwise>
        <!-- Multimple lines content, insert codeblock. -->
        <xsl:choose>
          <xsl:when test="contains(string-join(text(), ' '), '&#10;')">
            <codeblock>
              <xsl:call-template name="keepDirection"/>
              <xsl:apply-templates select="@* | node()"/>
            </codeblock>
          </xsl:when>
          <xsl:otherwise>
            <!-- For inline content use codeph. -->
            <codeph>
              <xsl:call-template name="keepDirection"/>
              <xsl:apply-templates select="@* | node()"/>
            </codeph>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:function name="f:isExternalReference" as="xs:boolean">
    <xsl:param name="refValue"/>
    <xsl:sequence select="starts-with($refValue, 'https://') 
                          or starts-with($refValue,'http://') 
                          or starts-with($refValue,'ftp://')
                          or starts-with($refValue,'mailto:')"/>
  </xsl:function>
   
  
  <!-- Hyperlinks -->
  <xsl:template match="e:a[f:isExternalReference(@href)]" 
                          priority="1.5">
       <xsl:variable name="xref">
            <xref>
              <xsl:attribute name="href">
                <xsl:value-of select="normalize-space(@href)"/>
              </xsl:attribute>
              <xsl:attribute name="format">html</xsl:attribute>
              <xsl:attribute name="scope">external</xsl:attribute>
              <xsl:call-template name="keepDirection"/>
              <xsl:apply-templates select="@* | * | text()"/>
           </xref>
       </xsl:variable>
       <xsl:call-template name="insertParaInSection">
           <xsl:with-param name="childOfPara" select="$xref"/>
       </xsl:call-template>
  </xsl:template>
  
  <xsl:template match="e:a[starts-with(@href,'#')]" priority="0.7">
    <xsl:variable name="currentHref" select="@href"/>
    <xsl:variable name="currentId" select="normalize-space(substring(@href, 2))"/>
    <xsl:variable name="elementWithId" select="(//*[@id = $currentId or (@name and f:correctId(@name) = $currentId)])[1]"/>
    
    <xsl:variable name="isNoteRef" select="f:isNotePara($elementWithId/parent::*)"/>
    <xsl:variable name="isOnlyOneNoteRef" select="count(//*[@href = $currentHref] ) = 1"/> 
    <xsl:variable name="isFirstNootRet" select="not(./preceding::*[@href = $currentHref] | ./ancestor::*[@href = $currentHref])"/>
    
    <xsl:if test="$isNoteRef and $isFirstNootRet">
      <fn>
        <xsl:if test="f:isEndnotePara($elementWithId/parent::*)">
          <xsl:attribute name="outputclass">endnote</xsl:attribute>
        </xsl:if>
        <xsl:if test="not($isOnlyOneNoteRef)">
          <xsl:attribute name="id">
            <xsl:value-of select="$currentId"/>
          </xsl:attribute>
        </xsl:if>
        <xsl:apply-templates select=" $elementWithId/parent::*[1]/node()[not(local-name() = 'a' and (./@id = $currentId or (./@name and f:correctId(@name) = $currentId)))]"/>
      </fn>
    </xsl:if>
    
    <xsl:if test="not($isNoteRef and $isOnlyOneNoteRef)">
      <xsl:variable name="xref">
        <xref>
          <xsl:attribute name="href">
            <xsl:choose>
              <xsl:when test="not(empty($elementWithId))">
                <xsl:choose>
                  <xsl:when test="local-name($elementWithId) = 'section' and f:shouldConvertSectionToTopic($elementWithId)">
                    <xsl:value-of select="concat('#', $currentId)"/>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:variable name="parentTopic" select="$elementWithId/ancestor::e:section[f:shouldConvertSectionToTopic(.)][1]"></xsl:variable>
                    <xsl:choose>
                      <xsl:when test="$parentTopic/@id">
                        <xsl:value-of select="concat('#', $parentTopic/@id, '/', $currentId)"/>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:value-of select="concat('#./', $currentId)"/>
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="concat('#./', $currentId)"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:attribute>
          
          <xsl:if test="$isNoteRef">
            <xsl:attribute name="type">fn</xsl:attribute>
          </xsl:if>
          
          <xsl:call-template name="keepDirection"/>
          <xsl:apply-templates select="@* | * | text()"/>
        </xref>
      </xsl:variable>
      <xsl:call-template name="insertParaInSection">
        <xsl:with-param name="childOfPara" select="$xref"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
  
  <xsl:template match="e:a[@name != '']" priority="0.6">
    <ph>
      <xsl:attribute name="id" select="f:correctId(f:makeID(normalize-space(@name)))"/>
      <xsl:call-template name="keepDirection"/>
      <xsl:apply-templates select="@* | * | text()"/>
    </ph>
  </xsl:template>
  
  <xsl:template match="e:a[@href != '']">
    <xsl:variable name="xref">
      <xref>
        <xsl:variable name="hrefValue" select="normalize-space(@href)"/>
        <xsl:variable name="location" select="f:makeID($hrefValue)"/>
        <xsl:variable name="fileName" select="f:getFilename($hrefValue)"/>
        <xsl:variable name="fileExtension" select="substring-after($fileName, '.')"/>
        
        <xsl:choose>
          <xsl:when test="$updateExtensionAndPathOfLocalFileReferences and
                          (starts-with($fileExtension, 'htm') or starts-with($fileExtension, 'xhtml'))">
            <xsl:attribute name="href" select="concat(substring-before($fileName,'.'), '.dita')"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="href" select="$hrefValue"/>
            
            <xsl:variable name="extractedFormat" select="f:extractFormat($location)"/>
            <xsl:if test="$extractedFormat != ''">
              <xsl:attribute name="format" select="$extractedFormat"/>
            </xsl:if>
            
            <xsl:if test="not(contains($location, '#'))">
              <xsl:attribute name="scope" select="'external'"/>
            </xsl:if>
          </xsl:otherwise>
        </xsl:choose>
        
        <xsl:call-template name="keepDirection"/>
        <xsl:apply-templates select="@* | * | text()"/>
      </xref>
    </xsl:variable>
    <xsl:call-template name="insertParaInSection">
      <xsl:with-param name="childOfPara" select="$xref"/>
    </xsl:call-template>
  </xsl:template>
  
  <xd:doc xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl">
    <xd:desc> Search and returns the value after the last occurrence of a token
    </xd:desc>
    <xd:param name="whereToSearch"/>
    <xd:param name="whatYouSearch"/>
  </xd:doc>
  <xsl:template name="substring-after-last">
    <xsl:param name="whereToSearch" select="''" />
    <xsl:param name="whatYouSearch" select="''" />
    
    <xsl:if test="$whereToSearch != '' and $whatYouSearch != ''">
      <xsl:variable name="head" select="substring-before($whereToSearch, $whatYouSearch)" />
      <xsl:variable name="tail" select="substring-after($whereToSearch, $whatYouSearch)" />
      <xsl:value-of select="$tail" />
      <xsl:if test="contains($tail, $whatYouSearch)">
        <xsl:value-of select="$whatYouSearch" />
        <xsl:call-template name="substring-after-last">
          <xsl:with-param name="whereToSearch" select="$tail" />
          <xsl:with-param name="whatYouSearch" select="$whatYouSearch" />
        </xsl:call-template>
      </xsl:if>
    </xsl:if>
  </xsl:template>
  
  <!-- Function for making an ID using the given text. The parameter can also be a file path.-->
  <xsl:function name="f:makeID">
    <xsl:param name="string"/>
    <xsl:value-of select="f:getFilename(translate($string,' \()','_/_'))"/>
  </xsl:function>
  
  <!-- Function for extracting the format from the given file name parameter.-->
  <xsl:function name="f:extractFormat">
    <xsl:param name="fileName"/>
    <xsl:variable name="withoutQuery">
      <xsl:choose>
        <xsl:when test="contains($fileName, '?') ">
          <xsl:value-of select="substring-before($fileName, '?')" />
        </xsl:when>
        <xsl:otherwise> 
          <xsl:value-of select="$fileName"/>            
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="withoutAnchor">
      <xsl:choose>
        <xsl:when test="contains($withoutQuery, '#') ">
          <xsl:value-of select="substring-before($withoutQuery, '#')" />
        </xsl:when>
        <xsl:otherwise> 
          <xsl:value-of select="$withoutQuery" />            
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
    <xsl:call-template name="substring-after-last">
      <xsl:with-param name="whereToSearch" select="$withoutAnchor" />
      <xsl:with-param name="whatYouSearch" select="'.'" />
    </xsl:call-template>
  </xsl:function>
  
  <xsl:template name="string.subst">
   <xsl:param name="string" select="''"/>
   <xsl:param name="substitute" select="''"/>
   <xsl:param name="with" select="''"/>
   <xsl:choose>
    <xsl:when test="contains($string,$substitute)">
     <xsl:variable name="pre" select="substring-before($string,$substitute)"/>
     <xsl:variable name="post" select="substring-after($string,$substitute)"/>
     <xsl:call-template name="string.subst">
      <xsl:with-param name="string" select="concat($pre,$with,$post)"/>
      <xsl:with-param name="substitute" select="$substitute"/>
      <xsl:with-param name="with" select="$with"/>
     </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
     <xsl:value-of select="$string"/>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:template>
  
  <!-- Images -->
  <xsl:template match="e:img" use-when="function-available('URL:getPath')">
    <xsl:variable name="pastedImageURL"
              xmlns:URLUtil="java:ro.sync.util.URLUtil"
              xmlns:UUID="java:java.util.UUID">
      <xsl:choose>
        <xsl:when test="(namespace-uri-for-prefix('o', .) = 'urn:schemas-microsoft-com:office:office') and $copy.word.image.resources">
          <!-- Copy from MS Office. Copy the image from user temp folder to folder of XML document
            that is the paste target. -->
          <xsl:variable name="imageFilename">
            <xsl:variable name="fullPath" select="URL:getPath(URL:new(translate(@src, '\', '/')))"/>
            <xsl:variable name="srcFile">
              <xsl:choose>
                <xsl:when test="contains($fullPath, ':')">
                  <xsl:value-of select="substring($fullPath, 2)"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="$fullPath"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:variable>
            <xsl:value-of select="f:getFilename(string($srcFile))"/>
          </xsl:variable>
          <xsl:variable name="stringImageFilename" select="string($imageFilename)"/>
          <xsl:variable name="uid" select="UUID:hashCode(UUID:randomUUID())"/>
          <xsl:variable name="uniqueTargetFilename" select="concat(substring-before($stringImageFilename, '.'), '_', $uid, '.', substring-after($stringImageFilename, '.'))"/>
          <xsl:variable name="sourceURL" select="URL:new(translate(@src, '\', '/'))"/>
          <xsl:variable name="correctedSourceFile">
            <xsl:choose>
              <xsl:when test="contains(URL:getPath($sourceURL), ':')">
                <xsl:value-of select="substring-after(URL:getPath($sourceURL), '/')"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="URL:getPath($sourceURL)"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:variable>
          <xsl:variable name="sourceFile" select="URLUtil:uncorrect($correctedSourceFile)"/>
          <xsl:variable name="targetURL" select="URL:new(concat($folderOfPasteTargetXml, '/', $uniqueTargetFilename))"/>
          <xsl:value-of select="substring-after(string($targetURL),
                substring-before(string(URLUtil:copyURL($sourceURL, $targetURL)), $uniqueTargetFilename))"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="@src"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
    <xsl:call-template name="addImage">
      <xsl:with-param name="imageURL" select="$pastedImageURL"/>
    </xsl:call-template>
  </xsl:template>
  
  <xsl:template match="e:img" use-when="not(function-available('URL:getPath'))">
    <xsl:call-template name="addImage">
      <xsl:with-param name="imageURL" select="@src"/>
    </xsl:call-template>
  </xsl:template>
  
  <xsl:template name="addImage">
    <xsl:param name="imageURL"/>
    <image href="{$imageURL}">
      <xsl:if test="@height != ''">
        <xsl:attribute name="height">
          <xsl:value-of select="@height"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@width != ''">
        <xsl:attribute name="width">
          <xsl:value-of select="@width"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="f:isExternalReference($imageURL)">
        <xsl:attribute name="scope">external</xsl:attribute>
      </xsl:if>
      <xsl:if test="@alt != ''">
        <alt>
          <xsl:value-of select="@alt"/>
        </alt>
      </xsl:if>
    </image>
  </xsl:template>
  
  <!-- Function for getting the file name from the given path-->
  <xsl:function name="f:getFilename">
    <xsl:param name="path"/>
    <xsl:choose>
      <xsl:when test="contains($path,'/')">
        <xsl:value-of select="f:getFilename(substring-after($path,'/'))"/>
      </xsl:when>
      <xsl:when test="contains($path,'\')">
        <xsl:value-of select="f:getFilename(substring-after($path,'\'))"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$path"/>
      </xsl:otherwise>
    </xsl:choose>    
  </xsl:function>

  <!-- Convert HTML audio, video and iframe elements to DITA object -->
  <xsl:template match="e:audio | e:video | e:iframe">
	<object>
	  <xsl:choose>
		<xsl:when test="@src">
		  <xsl:attribute name="data" select="@src" />
		</xsl:when>
		<xsl:otherwise>
		  <xsl:if test="e:source[@src]">
			<xsl:attribute name="data" select="e:source[@src][1]/@src" />
			<!-- Copy the @type attribute from the HTML source to the DITA object -->
			<xsl:copy-of select="e:source[@src][1]/@type" />
		  </xsl:if>
		</xsl:otherwise>
	  </xsl:choose>
	  <xsl:copy-of select="./@width" />
	  <xsl:copy-of select="./@height" />
	  <xsl:attribute name="outputclass" select="local-name()" />
	  <xsl:if test="node() except (e:source)">
		  <desc>
		    <xsl:apply-templates select="node() except (e:source)" />
		  </desc>
	  </xsl:if>
	  <xsl:apply-templates select="@* except (@src, @width, @height, @type)" mode="convertAttributesToParams" />
	</object>
  </xsl:template>
	
  <!-- Creates a param element for the given attribute -->
  <xsl:template match="@*" mode="convertAttributesToParams">
    <param>
      <xsl:attribute name="name" select="name()"/>
      <xsl:attribute name="value">
        <xsl:choose>
          <xsl:when test="string-length(normalize-space(.)) > 0">
            <xsl:value-of select="." />
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="'true'"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
    </param>
  </xsl:template>

  <xsl:template match="e:object">
	<object>
	  <xsl:copy-of select="@*" />
	  <xsl:apply-templates select="node()"></xsl:apply-templates>
	</object>
  </xsl:template>

  <xsl:template match="e:object/e:param">
	<param>
	  <xsl:copy-of select="@*" />
	</param>
  </xsl:template>

  <xsl:template match="e:picture">
	<xsl:apply-templates select="e:img" />
  </xsl:template>
  
  <xsl:template match="e:ul">
    <xsl:choose>
      <xsl:when test="(count(e:li) = count(e:li[e:a[starts-with(@class, 'msocomoff')]])) and (count(e:li) > 0)">
        <!-- ignore comments when the ul has only li comments -->
      </xsl:when>
      <xsl:otherwise>
          <ul>
            <xsl:apply-templates select="@* | node()"/>
          </ul>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
    
  <!-- Ignore comments -->
  <xsl:template match="e:li[e:a[starts-with(@class, 'msocomoff')]]"/>
  
  <xsl:template match="e:ol">
    <ol>
      <xsl:apply-templates select="@* | node()"/>
    </ol>
  </xsl:template>
  
  <xsl:template match="e:p[starts-with(@class, 'MsoCommentText')]"  priority="1.0">
    <!-- Ignore the comments -->
  </xsl:template>  
  <xsl:template match="e:a[starts-with(@class, 'msocomanchor')]" priority="1.0">
    <!-- Ignore the comments -->
  </xsl:template>  

  <xsl:template match="e:kbd">
    <userinput>
      <xsl:call-template name="keepDirection"/>
      <xsl:apply-templates select="@* | node()"/>
    </userinput>
  </xsl:template>
  
  <xsl:template match="e:samp">
    <systemoutput>
      <xsl:call-template name="keepDirection"/>
      <xsl:apply-templates select="@* | node()"/>
    </systemoutput>
  </xsl:template>
  
  <xsl:template match="e:blockquote">
    <lq>
        <xsl:call-template name="keepDirection"/>
        <xsl:apply-templates select="@* | node()"/>
    </lq>
  </xsl:template>
  
  <xsl:template match="e:q">
    <q>
        <xsl:call-template name="keepDirection"/>
        <xsl:apply-templates select="@* | node()"/>
    </q>
  </xsl:template>
  
  <xsl:template match="e:dl">
    <dl>
    	<xsl:apply-templates select="@*"/>
    	<xsl:variable name="dataBeforeTitle" select="e:dd[empty(preceding-sibling::e:dt)]"/>
    	<xsl:if test="not(empty($dataBeforeTitle))">
    		<dlentry>
    			<dt/>
    			<xsl:for-each select="$dataBeforeTitle">
    				<xsl:apply-templates select="."/>
    			</xsl:for-each>
    		</dlentry>
    	</xsl:if>
    	<xsl:for-each select="e:dt">
    		<dlentry>
    			<xsl:apply-templates select="."/>
    			<xsl:apply-templates select="following-sibling::e:dd[current() is preceding-sibling::e:dt[1]]"/>
    		</dlentry>
    	</xsl:for-each>
    </dl>
  </xsl:template>
  
  <xsl:template match="e:dt">
    <dt>
        <xsl:call-template name="keepDirection"/>
        <xsl:apply-templates select="@* | node()"/>
    </dt>
  </xsl:template>
  
  <xsl:template match="e:dd">
    <dd>
        <xsl:call-template name="keepDirection"/>
        <xsl:apply-templates select="@* | node()"/>
    </dd>
  </xsl:template>
    
  <xsl:template match="e:li">
      <li>
          <xsl:call-template name="keepDirection"/>
          <xsl:apply-templates select="@*"/>
          <xsl:choose>
            <xsl:when test="($dita.prefer.paragraphs.in.list.items = 1) and (count(*[local-name() = 'p']) = 0)">
              <p>
                <xsl:apply-templates select="node()"/>        
              </p>
            </xsl:when>
            <xsl:otherwise>
              <xsl:apply-templates select="node()"/>
            </xsl:otherwise>
          </xsl:choose>
      </li>
  </xsl:template>
          
  <xsl:template match="@id"> 
    <xsl:attribute name="id">
      <xsl:value-of select="."/>
    </xsl:attribute>
  </xsl:template>
  
  <xsl:template match="@name"> 
    <xsl:if test="not(parent::node()/@id)">
      <xsl:attribute name="id" select="f:correctId(f:makeID(normalize-space(.)))"/>
    </xsl:if>
  </xsl:template>
  
  <xsl:template match="@dir">
    <xsl:attribute name="dir">
      <xsl:value-of select="lower-case(.)"/>
    </xsl:attribute>
  </xsl:template>
    
  <xsl:template match="@*">
    <!--<xsl:message>No template for attribute <xsl:value-of select="name()"/></xsl:message>-->
  </xsl:template>
  
  <!-- Inline formatting -->
  <xsl:template match="e:b | e:strong">
      <xsl:variable name="bold">
          <b><xsl:apply-templates select="@* | node()"/></b>
      </xsl:variable>
      <xsl:if test="string-length(normalize-space($bold)) > 0">
          <xsl:call-template name="insertParaInSection">
              <xsl:with-param name="childOfPara" select="$bold"/>
          </xsl:call-template>
      </xsl:if>
  </xsl:template>
    
  <xsl:template match="e:i | e:em | e:cite">
      <xsl:variable name="italic">
          <i><xsl:apply-templates select="@* | node()"/></i>
      </xsl:variable>
      <xsl:if test="string-length(normalize-space($italic)) > 0">
          <xsl:call-template name="insertParaInSection">
              <xsl:with-param name="childOfPara" select="$italic"/>
          </xsl:call-template>
      </xsl:if>
  </xsl:template>
    
  <xsl:template match="e:u">
      <xsl:variable name="underline">
          <u><xsl:apply-templates select="@* | node()"/></u>
      </xsl:variable>
      <xsl:if test="string-length(normalize-space($underline)) > 0">
          <xsl:call-template name="insertParaInSection">
              <xsl:with-param name="childOfPara" select="$underline"/>
          </xsl:call-template>
      </xsl:if>
  </xsl:template>
          
  <!-- Ignored elements -->
  <xsl:template match="e:hr"/>
  <xsl:template match="e:meta"/>
  <xsl:template match="e:style"/>
  <xsl:template match="e:script"/>
  <xsl:template match="e:p[normalize-space() = '' and count(*) = 0][not(@id)]" priority="0.6">
    <xsl:apply-templates select="comment()"/>
  </xsl:template>
  <xsl:template match="text()">
   <xsl:choose>
    <xsl:when test="normalize-space(.) = ''"><xsl:text> </xsl:text></xsl:when>
    <xsl:otherwise><xsl:value-of select="translate(., '&#xA0;', ' ')"/></xsl:otherwise>
   </xsl:choose>
  </xsl:template>
  
  
  <!-- Table conversion -->
    
  <xsl:template match="e:table">
    <xsl:choose>
      <xsl:when test="not(empty(parent::e:td))">
        <p>
          <xsl:call-template name="table"/>
        </p>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="table"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template name="table">
    <table>
      <xsl:apply-templates select="@*"/>
      <xsl:if test="e:caption">
        <title>
          <xsl:call-template name="keepDirection"/>
          <xsl:apply-templates select="e:caption/node()"/>
        </title>
      </xsl:if>
      <tgroup>
        <xsl:variable name="columnCount">
          <xsl:for-each select="e:tr | e:tbody/e:tr | e:thead/e:tr">
            <xsl:sort
              select="sum(*[@colspan castable as xs:integer]/@colspan) + count(e:td[not(@colspan castable as xs:integer)] | e:th[not(@colspan castable as xs:integer)])"
              data-type="number" order="descending"/>
            <xsl:if test="position() = 1">
              <xsl:value-of
                select="sum(*[@colspan castable as xs:integer]/@colspan) + count(e:td[not(@colspan castable as xs:integer)] | e:th[not(@colspan castable as xs:integer)])"
              />
            </xsl:if>
          </xsl:for-each>
        </xsl:variable>
        <xsl:attribute name="cols">
          <xsl:value-of select="$columnCount"/>
        </xsl:attribute>
        <xsl:if
          test="
            e:tr/e:td/@rowspan
            | e:tr/e:td/@colspan
            | e:tbody/e:tr/e:td/@rowspan
            | e:tbody/e:tr/e:td/@colspan
            | e:thead/e:tr/e:th/@rowspan
            | e:thead/e:tr/e:th/@colspan
            | e:tfoot/e:tr/e:td/@rowspan
            | e:tfoot/e:tr/e:td/@colspan
            | e:tfoot/e:tr/e:th/@rowspan
            | e:tfoot/e:tr/e:th/@colspan
            | e:colgroup/e:col/@width
            | e:col/@width
            | e:tr/e:td/@width
            | e:tbody/e:tr/e:td/@width">
          
         <xsl:call-template name="generateColspecs">
           <xsl:with-param name="count" select="number($columnCount)"/>
           <xsl:with-param name="widthElementsArray" select="e:col | e:colgroup/e:col | e:tr/e:td | e:tbody/e:tr/e:td">
           </xsl:with-param>
         </xsl:call-template>
        </xsl:if>
        <xsl:apply-templates select="e:thead"/>
        <tbody>
          <xsl:apply-templates
            select="e:tr | e:tbody/e:tr | text() | e:b | e:strong | e:i | e:em | e:u, e:tfoot/e:tr"
          />
        </tbody>
      </tgroup>
    </table>
  </xsl:template>
  
  <xsl:template match="e:thead">
    <thead>
       <xsl:apply-templates select="@* | node()"/>
    </thead>
  </xsl:template>
  
  <xsl:template match="e:tr">
    <row>
       <xsl:apply-templates select="@* | node()"/>
    </row>
  </xsl:template>
  
  <xsl:function name="f:getRowIndex" as="xs:integer">
    <xsl:param name="cell" as="node()"/>
    <xsl:variable name="precedingRows" select="$cell/parent::e:tr/preceding-sibling::e:tr"/>
    <xsl:variable name="currentRowIndex" select="count($precedingRows) + 1"/>
    <xsl:value-of select="$currentRowIndex"/>
  </xsl:function>
  
  <xsl:function name="f:getColIndex" as="xs:integer">
    <xsl:param name="cell" as="node()"/>
    <xsl:sequence select="count($cell/preceding-sibling::e:td) + count($cell/preceding-sibling::e:th)"/>
  </xsl:function>
    
  <xsl:template match="e:th | e:td">
    <xsl:variable name="position" select="count(preceding-sibling::*) + 1"/>
    <xsl:variable name="addCodeElement" select=".[f:hasFontStyle(@style, $stylesPropMap('monospaced'), $stylesValMap('monospaced'))][not(child::e:code)]"/>
    <entry>
      <xsl:if test="(@colspan castable as xs:integer) and (@colspan > 1)">
        <!-- Current row and column index -->
        <xsl:variable name="currentRowIndex" select="f:getRowIndex(.)"/>
        <xsl:variable name="currentColIndex" select="f:getColIndex(.)"/>
        <!-- Set of preceding rows -->
        <xsl:variable name="precedingRows" select="parent::e:tr/preceding-sibling::e:tr[position() &lt; $currentRowIndex]"/>
        <!-- Preceding cells in column which have row spans over the current row. -->
        <xsl:variable name="previousCellsWithRowSpans" select="
          ancestor::e:table//(e:th | e:td)[@rowspan castable as xs:integer][@rowspan][f:getRowIndex(.) &lt; $currentRowIndex][f:getColIndex(.) &lt;= $currentColIndex][number(@rowspan) + number(f:getRowIndex(.)) - number($currentRowIndex) &gt; 0]"/>
        <!-- Namestart and name end must be shifted with this shift offset. -->
        <xsl:variable name="shiftColNumber" as="xs:integer" select="count($previousCellsWithRowSpans)"/>
        <!-- The current cell might be pushed to the right by previous cells that span over multiple columns.  -->
        <xsl:variable name="previousCellsWithColSpan" select="preceding-sibling::*[(@colspan castable as xs:integer) and (@colspan > 1)]"/>
        <!-- Compute how many additional columns are occupied by the cells located to the left of the current cell. -->
        <xsl:variable name="colspanShift" select="sum(($previousCellsWithRowSpans, $previousCellsWithColSpan)/(@colspan - 1))"/>    
        
        <xsl:attribute name="namest">
          <xsl:value-of select="concat('col', $position + $shiftColNumber + $colspanShift)"/>
        </xsl:attribute>
        <xsl:attribute name="nameend">
          <xsl:value-of select="concat('col', $position + number(@colspan) - 1 + $shiftColNumber + $colspanShift)"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@rowspan castable as xs:integer and @rowspan > 1">
        <xsl:attribute name="morerows">
          <xsl:value-of select="number(@rowspan) - 1"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:call-template name="keepDirection"/>
      
      
      <xsl:choose>
        <xsl:when test="$addCodeElement">
          <xsl:element name="codeph">
            <xsl:apply-templates select="@* | node()"/>
          </xsl:element>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates select="@*"/>
          <xsl:choose>
            <xsl:when test="($dita.prefer.paragraphs.in.table.cells = 1) and (count(*[local-name()='p']) = 0)">
              <p>
                <xsl:apply-templates select="node()"/>      
              </p>
            </xsl:when>
            <xsl:otherwise>
              <xsl:apply-templates select="node()"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:otherwise>
      </xsl:choose>
      
    </entry>
  </xsl:template>
  
  
  <xsl:template name="generateColspecs">
    <xsl:param name="count" select="0"/>
    <xsl:param name="number" select="1"/>
    <xsl:param name="widthElementsArray"/>
    <xsl:choose>
      <xsl:when test="$count &lt; $number"/>
      <xsl:otherwise>
        <colspec>
          <xsl:attribute name="colnum">
            <xsl:value-of select="$number"/>
          </xsl:attribute>
          
          <xsl:choose>
            <xsl:when test="(count($widthElementsArray) &gt; $number - 1) and $widthElementsArray[$number]/@width">
              <xsl:attribute name="colwidth">
                <xsl:value-of select="$widthElementsArray[$number]/@width"/>
              </xsl:attribute>
            </xsl:when>
          </xsl:choose>
          
          <xsl:attribute name="colname">
            <xsl:value-of select="concat('col', $number)"/>
          </xsl:attribute>
        </colspec>
        <xsl:call-template name="generateColspecs">
          <xsl:with-param name="count" select="$count"/>
          <xsl:with-param name="number" select="$number + 1"/>
          <xsl:with-param name="widthElementsArray" select="$widthElementsArray"/>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  
  <xsl:template match="e:section">
    <xsl:choose>
      <xsl:when test="e:title">
        <xsl:choose>
          <!-- EXM-40042 When the title is followed by some block element type create a section -->
          <xsl:when test="e:title/following-sibling::e:p">
            <section>
              <xsl:copy-of select="@id"/>
              <xsl:apply-templates select="@class" mode="convertOutputClass"/>
              <title>
                <xsl:apply-templates select="e:title"/>
              </title>        
              <!-- And add the other sections, taking care not to imbricate them. -->
              <xsl:apply-templates 
                select="node()[local-name() != 'title' and local-name() != 'section']"/>
            </section>
            <xsl:apply-templates select="e:section"/>
          </xsl:when>
          <xsl:otherwise>
            <!-- Create a bold element  -->
            <xsl:choose>
              <xsl:when test="$context.path.last.name = 'body'">
                <p><b><xsl:apply-templates select="e:title"/></b></p>
              </xsl:when>
              <xsl:otherwise>
                <b><xsl:apply-templates select="e:title"/></b>
              </xsl:otherwise>
            </xsl:choose>
            <!-- And add the other sections, taking care not to imbricate them. -->
            <xsl:apply-templates 
              select="node()[local-name() != 'title' and local-name() != 'section']"/>
            <xsl:apply-templates select="e:section"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <!-- Add my content and add the other sections, taking care not to imbricate them. -->
        <xsl:apply-templates select="node()[local-name() != 'section']"/>
        <xsl:apply-templates select="e:section"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  
  <xsl:template match="e:section[f:shouldConvertSectionToTopic(.)]">
    <xsl:element name="topic">
      <xsl:copy-of select="@id"/>
      <xsl:apply-templates select="@class" mode="convertOutputClass"/>
      <title>
        <xsl:if test="$defaultDocumentTitle and empty(e:title/text()) and empty(preceding::e:section[1]) and empty(ancestor::e:section[1])">
          <xsl:value-of select="$defaultDocumentTitle"/>
        </xsl:if>
        <xsl:apply-templates select="e:title"/>
      </title>
      
      <xsl:if test="e:div[@id='oxy_prolog']">
        <prolog>
          <author>
            <xsl:value-of select="e:div[@id='oxy_prolog']/e:div[@id='oxy_prolog_author']"/>
          </author>
          <critdates>
            <created>
              <xsl:attribute name="date">
                <xsl:value-of select="e:div[@id='oxy_prolog']/e:div[@id='oxy_prolog_created']"/>
              </xsl:attribute>
            </created>
          </critdates>
        </prolog>   
      </xsl:if>
      
      <body>
            <xsl:for-each select="node()">
              <xsl:choose>
                <!-- These e:sections will not be converted to sections. Add them inside the body element-->
                <xsl:when test=".[self::e:section][not(f:levelAllowsNestedTopic(./@level))]">
                  <xsl:apply-templates select="."/>
                </xsl:when>
                <xsl:when test=".[not(self::e:section)][not(self::e:title)]">
                   <xsl:apply-templates select="."/>
                </xsl:when>
              </xsl:choose>
            </xsl:for-each>
      </body>
      
      <!-- The next e:sections will be converted to topics. Add them outside the body element-->
      <xsl:for-each select="node()[self::e:section][f:levelAllowsNestedTopic(./@level)]">
        <xsl:apply-templates select="."/>
      </xsl:for-each>
    </xsl:element>
  </xsl:template>
  
  <xsl:template match="e:div[@id='oxy_prolog']">
    <!-- this was used as prolog in topic -->
  </xsl:template>
  
  <xsl:function name="f:shouldConvertSectionToTopic" as="xs:boolean">
    <xsl:param name="n" as="node()"/>
    <xsl:sequence select="xs:boolean($replace.entire.root.contents and $context.path.last.name = 'topic' and $n/e:title and (f:levelAllowsNestedTopic($n/@level) or empty($n/parent::e:section)))"/>
  </xsl:function>
  
  <xsl:function name="f:levelAllowsNestedTopic" as="xs:boolean">
    <xsl:param name="level" as="xs:double?"/>
    <xsl:sequence select="$level and $level &lt;= $maxHeadingLevelForNestedTopics"/>
  </xsl:function>
  
  <xsl:template match="e:section[e:title][parent::e:section][$replace.entire.root.contents][$context.path.last.name = 'topic'][not(f:levelAllowsNestedTopic(./@level))]">
   <section>
      <xsl:copy-of select="@id"/>
      <xsl:apply-templates select="@class" mode="convertOutputClass"/>
      <title><xsl:apply-templates select="e:title"/></title>
      <xsl:apply-templates 
        select="node()[local-name() != 'title' and local-name() != 'section']"/>
    </section>
    <xsl:apply-templates select="node()[local-name() = 'section']"/>
  </xsl:template>
  
   <!-- EXM-43546 Wrap in a 'dita' root element -->
  <xsl:template match="e:body[$replace.entire.root.contents][$wrapMultipleSectionsInARoot][count(e:section) > 1]">
    <dita>
      <xsl:apply-templates/>
    </dita>
  </xsl:template>
  
  <!-- EXM-40763 root replace at paste -->
  <xsl:template match="e:body[$replace.entire.root.contents][not(child::node() = e:section)]">
    <xsl:choose>
      <xsl:when test="$context.path.names = 'topic'">
        <topic>
          <title>
            <xsl:if test="$defaultDocumentTitle">
              <xsl:value-of select="$defaultDocumentTitle"/>
            </xsl:if>
          </title>
          <body>
            <xsl:apply-templates select="node()"/>
          </body>
        </topic>
      </xsl:when>
      <xsl:when test="$context.path.names = 'task'">
        <task>
          <title>
            <xsl:if test="$defaultDocumentTitle">
              <xsl:value-of select="$defaultDocumentTitle"/>
            </xsl:if>
          </title>
          <taskbody>
            <context>
              <xsl:apply-templates select="node()"/>
            </context>
          </taskbody>
        </task>
      </xsl:when>
      <xsl:when test="$context.path.names = 'concept'">
        <concept>
          <title>
            <xsl:if test="$defaultDocumentTitle">
              <xsl:value-of select="$defaultDocumentTitle"/>
            </xsl:if>
          </title>
          <conbody>
            <xsl:apply-templates select="node()"/>
          </conbody>
        </concept>
      </xsl:when>
      <xsl:otherwise>
          <xsl:apply-templates select="node()"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
    
   <xsl:template match="@class">
     <xsl:apply-templates select="." mode="convertOutputClass"/>
   </xsl:template>  
    
  <xsl:template match="@class" mode="convertOutputClass">
    <xsl:if test="$convertClassToOutputClass">
      <xsl:attribute name="outputclass">
        <xsl:value-of select="."/>
      </xsl:attribute>
    </xsl:if>
  </xsl:template> 
    
    <xsl:template name="insertParaInSection">
        <xsl:param name="childOfPara"/>
        <!--<xsl:choose>
            <xsl:when test="parent::e:section">
                <p><xsl:copy-of select="$childOfPara"/></p>
            </xsl:when>
            <xsl:otherwise>
                <xsl:copy-of select="$childOfPara"/>
            </xsl:otherwise>
        </xsl:choose>-->
      <xsl:copy-of select="$childOfPara"/>
    </xsl:template>
    
    <xsl:template name="keepDirection">
        <xsl:choose>
            <xsl:when test="@dir">
                <xsl:attribute name="dir">
                    <xsl:value-of select="lower-case(@dir)"/>
                </xsl:attribute>
            </xsl:when>
            <xsl:when test="@DIR">
                <xsl:attribute name="dir">
                    <xsl:value-of select="lower-case(@DIR)"/>
                </xsl:attribute>
            </xsl:when>
            <xsl:when test="count(e:span[@dir]|e:span[@DIR]) = 1">
                <xsl:attribute name="dir">
                    <xsl:value-of select="lower-case((e:span/@dir|e:span/@DIR)[1])"/>
                </xsl:attribute>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
  
</xsl:stylesheet>