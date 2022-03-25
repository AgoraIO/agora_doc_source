<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt3"
  xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
  xmlns:f="http://oxygenxml.com/ns/xslt/functions"
  xmlns:map="http://www.w3.org/2005/xpath-functions/map"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <sch:ns uri="https://www.dita-ot.org/project" prefix="dp"/>
  <sch:ns uri="http://oxygenxml.com/ns/xslt/functions" prefix="f"/>
  <sch:ns uri="http://www.w3.org/2005/xpath-functions/map" prefix="map"/>
  
  <xsl:include href="functions.xsl"/>
  <sch:let name="contexts" value="f:getContexts(/)"/>
  <sch:let name="publications" value="f:getPublications(/)"/>
  <sch:let name="plugins" value="doc('platform:config/plugins.xml')"/>
  <sch:let name="transtypeParameters" value="f:getTranstypeParameters($plugins)"/>
  
  <!-- Top level context and publication should have IDs, otherwise they cannot be referred -->
  
  <sch:pattern id="topLevelID" abstract="true">
    <sch:rule context="/dp:project/dp:$element">
      <sch:assert test="@id" role="warning" sqf:fix="addID">
        A top level $element should have an 'id' attribute defined, otherwise it cannot be referred.
      </sch:assert>
      <sqf:fix id="addID">
        <sqf:description>
          <sqf:title>Add an id attribute</sqf:title>
        </sqf:description>
        <sqf:add target="id" select="concat('$element', '-', generate-id())" node-type="attribute"/>
      </sqf:fix>
    </sch:rule>
  </sch:pattern>
  
  <sch:pattern is-a="topLevelID">
    <sch:param name="element" value="context"/>
  </sch:pattern>  
  
  <sch:pattern is-a="topLevelID">
    <sch:param name="element" value="publication"/>
  </sch:pattern>  
  
  
  
  <!-- Check references for context and publication  -->
  
  
  <!-- Check context reference -->
  <sch:pattern>
    <sch:rule context="dp:context[@idref]">
      <sch:assert test="@idref = $contexts" sqf:fix="selectExistingContext addContext">
        Context with ID <sch:value-of select="@idref"/> does not exist!
      </sch:assert>
      <sqf:fix id="selectExistingContext" use-when="$contexts!=''" use-for-each="$contexts">
        <sqf:description>
          <sqf:title>Select existing context <sch:value-of select="$sqf:current"/></sqf:title>
        </sqf:description>
        <sqf:add node-type="attribute" target="idref" select="string($sqf:current)"/>
      </sqf:fix>
      <sqf:fix id="addContext" use-when="@idref!=''">
        <sch:let name="cid" value="@idref"/>
        <sqf:description>
          <sqf:title>Create new context with the ID <sch:value-of select="@idref"/></sqf:title>
        </sqf:description>
        <sqf:add match="ancestor-or-self::*[parent::dp:project]" position="before">
          <context xmlns="https://www.dita-ot.org/project" id="{$cid}" name="{$cid}">
            <xsl:text>&#10;</xsl:text>
            <input href=""/>
            <xsl:text>&#10;</xsl:text>
            <profile>
              <xsl:text>&#10;</xsl:text>
              <ditaval href=""/>
              <xsl:text>&#10;</xsl:text>
            </profile>
            <xsl:text>&#10;</xsl:text>
          </context>
          <xsl:text>&#10;</xsl:text>
        </sqf:add>
      </sqf:fix>
    </sch:rule>
  </sch:pattern>
  
  
  <!-- Check publication reference -->
  <sch:pattern>
    <sch:rule context="dp:publication[@idref]">
      <sch:assert test="@idref = $publications" sqf:fix="selectExistingPublication addPublication">
        Publication with ID <sch:value-of select="@idref"/> does not exist!
      </sch:assert>
      <sqf:fix id="selectExistingPublication" use-when="$publications!=''" use-for-each="$publications">
        <sqf:description>
          <sqf:title>Select existing publication <sch:value-of select="$sqf:current"/></sqf:title>
        </sqf:description>
        <sqf:add node-type="attribute" target="idref" select="string($sqf:current)"/>
      </sqf:fix>
      <sqf:fix id="addPublication" use-when="@idref!=''">
        <sch:let name="pid" value="@idref"/>
        <sqf:description>
          <sqf:title>Create new publication with the ID <sch:value-of select="@idref"/></sqf:title>
        </sqf:description>
        <sqf:add match="ancestor-or-self::*[parent::dp:project]" position="before">
          <publication xmlns="https://www.dita-ot.org/project" id="{$pid}" transtype="HTML">
            <xsl:text>&#10;</xsl:text>
          </publication>
          <xsl:text>&#10;</xsl:text>
        </sqf:add>
      </sqf:fix>
    </sch:rule>
  </sch:pattern>
  
  <!-- Check for empty references -->
  <sch:pattern>
    <sch:rule context="dp:include">
      <sch:report test="not(doc-available(resolve-uri(@href, base-uri())))">The referenced document does not exist or is not well-formed.</sch:report>
      <sch:report test="@href=''" role="warning" sqf:fix="addHref">The 'href' needs to be set to point to a project file.</sch:report>
      <sqf:fix id="addHref">
        <sqf:description>
          <sqf:title>Set the 'href' URL to point to a project file</sqf:title>
        </sqf:description>
        <sqf:user-entry name="projectFile" type="xs:anyURI">
          <sqf:description>
            <sqf:title>Enter a reference to a DITA project file</sqf:title>
          </sqf:description>
        </sqf:user-entry>
        <sqf:add node-type="attribute" target="href" select="$projectFile"/>
      </sqf:fix>
    </sch:rule>
  </sch:pattern>
  
  
  <sch:pattern>
    <sch:rule context="dp:publication[@transtype]">
      <sch:let name="transtype" value="@transtype"/>
      <sch:assert test="$transtype = map:keys($transtypeParameters)" role="warn" sqf:fix="setTranstype">
        The transtype <sch:value-of select="$transtype"/> does not appear in the default DITA-OT installation.
      </sch:assert>
      <sqf:fix id="setTranstype" use-for-each="map:keys($transtypeParameters)">
        <sqf:description>
          <sqf:title>Set transtype to <sch:value-of select="$sqf:current"/></sqf:title>
        </sqf:description>
        <sqf:add node-type="attribute" select="string($sqf:current)" target="transtype"/> 
      </sqf:fix>
    </sch:rule>
  </sch:pattern>
  
  
  <sch:pattern>
    <sch:rule context="dp:param[@name]">
      <sch:let name="pname" value="@name"/>
      <sch:let name="params" value="$transtypeParameters?(../@transtype)"/>
      <sch:assert test="not($params) or $params/@name=$pname" role="warn" sqf:fix="setParamName">
        The parameter <sch:value-of select="$pname"/> is not defined for the
        transtype <sch:value-of select="../@transtype"/>
      </sch:assert>
      
      <sch:assert test="not($params[@name=$pname]) or ($params[@name=$pname]/@type!='enum' or @value=$params[@name=$pname]/val)" role="warn" sqf:fix="setParamValue">
        The parameter <sch:value-of select="$pname"/> value is not one of the enumerated values for this 
        parameter [<sch:value-of select="distinct-values($params[@name=$pname]/val)"/>]
      </sch:assert>
      
      <sqf:fix id="setParamValue" use-for-each="distinct-values($params[@name=$pname]/val)">
        <sqf:description>
          <sqf:title>Set param value to <sch:value-of select="$sqf:current"/></sqf:title>
        </sqf:description>
        <sqf:add node-type="attribute" select="string($sqf:current)" target="value"/> 
      </sqf:fix>
      
      <sqf:fix id="setParamName" use-for-each="$params">
        <sqf:description>
          <sqf:title>Set param name to <sch:value-of select="$sqf:current/@name"/></sqf:title>
          <sqf:p><sch:value-of select="$sqf:current/@desc"/></sqf:p>
          <sqf:p>Type <sch:value-of select="$sqf:current/@type"/></sqf:p>
          <sqf:p><sch:value-of select="$sqf:current/val"/></sqf:p>
        </sqf:description>
        <sqf:add node-type="attribute" select="string($sqf:current/@name)" target="name"/> 
      </sqf:fix>
    </sch:rule>
  </sch:pattern>
  
  <!-- Recommend adding a name for context. -->
  <sch:pattern>
    <sch:rule context="dp:context[not(@idref)]">
      <sch:assert test="@name" role="information" sqf:fix="addName addNameFromID">It is recommended
        to provide a name for the context element. That identifies a deliverable irrespective of the
        actual publishing format, and it is useful for presenting the context information during
        content creation, if the writer want to focus on a specific deliverable and see what is
        included or excluded by profiling, or what values specific keys have.</sch:assert>
      <sqf:fix id="addName">
        <sqf:description>
          <sqf:title>Add a name attribute</sqf:title>
        </sqf:description>
        <sqf:user-entry name="contextName">
          <sqf:description>
            <sqf:title>Enter the context name</sqf:title>
          </sqf:description>
        </sqf:user-entry>
        <sqf:add node-type="attribute" target="name" select="$contextName"/>
      </sqf:fix>
      <sqf:fix id="addNameFromID" use-when="@id != ''">
        <sqf:description>
          <sqf:title>Add a name attribute with the same value as the context ID</sqf:title>
        </sqf:description>
        <sqf:add node-type="attribute" target="name" select="string(@id)"/>
      </sqf:fix>
    </sch:rule>
  </sch:pattern>
  
</sch:schema>
