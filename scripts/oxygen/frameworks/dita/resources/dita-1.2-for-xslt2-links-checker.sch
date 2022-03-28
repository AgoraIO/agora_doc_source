<?xml version="1.0" encoding="UTF-8"?>
<!--
  Copyright (c) 2018 Syncro Soft SRL - All Rights Reserved.

  This file contains proprietary and confidential source code.
  Unauthorized copying of this file, via any medium, is strictly prohibited.
  
  Check broken <xref> or <link> links.
-->
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
  <pattern id="chekReference">
    <!-- xref of link to DITA resource without "#"-->
    <rule
      context="*[contains(@class, ' topic/xref ') or contains(@class, ' topic/link ')][@href][not(contains(@href, '#'))][not(@scope = 'external')][not(@type) or @type='dita']">
      <assert test="doc-available(resolve-uri(@href, base-uri(.)))">The document pointed by
          <value-of select="local-name()"/> "<value-of select="@href"/>" does not exist!</assert>
    </rule>
    <!-- xref of link to DITA resource with "#"-->
    <rule
      context="*[contains(@class, ' topic/xref ') or contains(@class, ' topic/link ')][@href][contains(@href, '#')][not(@scope = 'external')][not(@type) or @type='dita']">
      <let name="file" value="substring-before(@href, '#')"/>
      <let name="idPart" value="substring-after(@href, '#')"/>
      <let name="topicId"
        value="if (contains($idPart, '/')) then substring-before($idPart, '/') else $idPart"/>
      <let name="id" value="substring-after($idPart, '/')"/>
      <assert test="document($file, .)//*[@id=$topicId]"> Invalid topic id "<value-of
          select="$topicId"/>" </assert>
      <assert test="$id ='' or document($file, .)//*[@id=$id]"> No such id "<value-of select="$id"
        />" is defined! </assert>
      <assert
        test="$id='' or 
        document($file, .)//*[@id=$id][ancestor::*[contains(@class, ' topic/topic ')][1][@id=$topicId]]"
        > The id "<value-of select="$id"/>" is not in the scope of the referred topic id "<value-of
          select="$topicId"/>". </assert>
    </rule>
  </pattern>
</schema>
