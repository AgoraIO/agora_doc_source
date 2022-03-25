<?xml version="1.0" encoding="utf-8"?>
<!--
     XLIFF Version 2.1
     Committee Specification Draft 01 / Public Review Draft 01
     14 October 2016
     Copyright (c) OASIS Open 2016. All Rights Reserved.
     Source: http://docs.oasis-open.org/xliff/xliff-core/v2.1/csprd01/schemas/
     Latest version of narrative specification: http://docs.oasis-open.org/xliff/xliff-core/v2.1/xliff-core-v2.1.html
     TC IPR Statement: https://www.oasis-open.org/committees/xliff/ipr.php
     
-->

<!DOCTYPE schematron [
<!-- Entities for XLIFF V2.x publishing.................................... -->
<!--copy all of these to all *.sch files and also to the Oxygen framework for validating Docbook 4.5 if you use Oxygen -->
<!ENTITY name "xliff-core-v2.1">
<!ENTITY pversion "2.0">
<!ENTITY version "2.1">
<!ENTITY bschversion "2.0">
<!ENTITY cschversion "2.1">

<!ENTITY stage "csprd01">
<!ENTITY pstage "N/A">
<!ENTITY standard "Committee Specification Draft 01 / Public Review Draft 01">

<!ENTITY this-loc "http://docs.oasis-open.org/xliff/xliff-core/v&version;/&stage;">
<!ENTITY previous-loc "http://docs.oasis-open.org/xliff/xliff-core/v&version;/&pstage;">
<!ENTITY latest-loc "http://docs.oasis-open.org/xliff/xliff-core/v&version;">
<!ENTITY pubdate "14 October &pubyear;">
<!ENTITY pubyear "2016">
<!ENTITY releaseinfo "Standards Track Work Product">
<!-- End of XLIFF V2.x publishing entities -->
]>


<iso:schema xmlns:its="http://www.w3.org/2005/11/its"  
    xmlns:iso="http://purl.oclc.org/dsdl/schematron"
    xmlns:itsm="urn:oasis:names:tc:xliff:itsm:2.1"
    xmlns:xlf="urn:oasis:names:tc:xliff:document:2.0"
    xmlns:mtc="urn:oasis:names:tc:xliff:matches:2.0"
    xmlns:ctr="urn:oasis:names:tc:xliff:changetracking:2.1"
	xmlns:res="urn:oasis:names:tc:xliff:resourcedata:2.0"
    queryBinding='xslt2' 
    schemaVersion='ISO19757-3'>
    <iso:title>Schematron rules for checking the constraints of the ITS module against XLIFF Version &version;</iso:title>
    <iso:ns prefix="itsm" uri="urn:oasis:names:tc:xliff:itsm:2.1"/>
    <iso:ns prefix="xlf" uri="urn:oasis:names:tc:xliff:document:2.0"/>
    <iso:ns prefix="ctr" uri="urn:oasis:names:tc:xliff:changetracking:2.1"/>
    
    
    <!-- ITS rules for mapping ITS data categories used in XLIFF 2.x. The rules are to be consumed by an ITS 2.0 conformant processor. The rules are ordered following the data category sub sections of the ITS module section in the XLIFF 2.1 specification.-->
    
    <its:rules version="2.0" queryLanguage="xpath">
        
        <!-- Rules for Allowed Characters -->
        <its:allowedCharactersRule selector="//xlf:mrk[@type='itsm:generic' and (@itsm:allowedCharacters)]" allowedCharactersPointer="@itsm:allowedCharacters"/>
        
        <!-- Rules for Domain -->
        <its:domainRule selector="//xlf:mrk[@type='itsm:generic' and (@itsm:domains)]" domainPointer="@itsm:domains"/>
        
        <!-- Rules for Localization Quality Issue: cannot be written since there are not pointer attributes for Localization Quality Issue -->
        
        <!-- Rules for Localization Quality Rating: cannot be written since there is no global rule for Localization Quality Rating -->
        
        <!-- Rules for Text Analysis -->
        <its:textAnalysisRule selector="//xlf:mrk[@type='itsm:generic' and (@itsm:taClassRef or @itsm:taIdentRef)]" taClassRefPointer="@itsm:taClassRef" taIdentRefPointer="@itsm:taIdentRef"/>
        
        <!-- Rules for Localization Note -->
        <its:locNoteRule selector="//xlf:note" localizationNotePointer="self::*" locNoteType="description"/>
        
        <!-- Rules for Preserve Space: cannot be written since there are not pointer attributes for Preserve Space -->
        
        <!-- Rules for Translate -->
        <its:translateRule selector="//xlf:*[@translate='no']" translate='no'/>
        <its:translateRule selector="//xlf:*[@translate='yes']" translate='yes'/>
        
        <!-- Rules for External Resource -->
        <its:externalResourceRefRule selector="//res:source | //res:target" externalResourceRefPointer="@href"/>
        
        <!-- Rules for Language Information -->
        <its:langRule selector="//xlf:*[@xml:lang]" langPointer="@xml:lang"/>
        
        <!-- Rules for MT Confidence: cannot be written since there is not pointer attribute for MT Confidence -->
        
        <!-- Rules for Provenance: cannot be written since there are no pointer attributes for the provenance records written in  XLIFF -->
        
        <!-- Rules for Terminology -->
        <its:termRule selector="//xlf:mrk[@type='term' and @ref]" termInfoRefPointer="@ref"/>
        
        <!-- Rules for Directionality: This data category is not mapped to XLIFF 2.X -->
        
        <!-- Rules for Elements Within Text: This data category is not represented as metadata in XLIFF 2.X -->
        
        <!-- Rules for ID Value: This data category is not represented as metadata in XLIFF 2.X -->
        
        <!-- Rules for Locale Filter: This data category is not represented as metadata in XLIFF 2.X -->
        
        <!-- Rules for Target Pointer -->
        <its:targetPointerRule selector="//xlf:source" targetPointer="../xlf:target"/>
        
        <!-- Rules for storage size: The data category is not covered by the XLIFF 2.1 specification, so no rule is provided. -->
        
    </its:rules>
    
    <iso:pattern>
        <iso:rule context="ctr:revision">
            <iso:report test="@itsm:*[not(name()='itsm:toolRef')][not(name()='itsm:tool')][not(name()='itsm:revToolRef')][not(name()='itsm:revTool')]
                [not(name()='itsm:revPersonRef')][not(name()='itsm:revPerson')][not(name()='itsm:revOrgRef')][not(name()='itsm:revOrg')]
                [not(name()='itsm:org')][not(name()='itsm:provenanceRecordsRef')][not(name()='itsm:personRef')][not(name()='itsm:person')]
                [not(name()='itsm:orgRef')][not(name()='itsm:annotatorsRef')]">
                Invalid 'itsm' attribute used in 'revision'.
            </iso:report>
        </iso:rule>
    </iso:pattern>
    <iso:pattern>
        <iso:rule context="xlf:mrk[@itsm:annotatorsRef] | xlf:sm[@itsm:annotatorsRef]">
            <iso:assert test="not(@type) or @type='itsm:generic'">
                When the 'itsm:annotatorsRef' attribute is used, the optional 'type' attribute must be set to 'itsm:generic' if declared.
            </iso:assert>
        </iso:rule>
    </iso:pattern>
    <iso:pattern>
        <iso:rule context="xlf:mrk[@itsm:locQualityIssuesRef] | xlf:sm[@itsm:locQualityIssuesRef]">
            <iso:assert test="not(@type) or @type='itsm:generic'">
                When used in ITS Localization Quality Issue Annotation, the optional 'type' attribute must be set to 'itsm:generic' if declared.
            </iso:assert>
            <iso:report test="@itsm:locQualityIssueType or @itsm:locQualityIssueComment">
                When the 'itsm:locQualityIssuesRef' attribute is used, the following attributes must be declared: 'itsm:locQualityIssueType' and 'itsm:locQualityIssueComment'.
            </iso:report>
            <iso:report test="@itsm:locQualityIssueSeverity or @itsm:locQualityIssueProfileRef or @itsm:locQualityIssueEnabled">
                When the 'itsm:locQualityIssuesRef' attribute is used, the following attributes must be declared: 'itsm:locQualityIssueSeverity', 'itsm:locQualityIssueProfileRef' and 'itsm:locQualityIssueEnabled'..
            </iso:report>
        </iso:rule>
    </iso:pattern>
    <iso:pattern>
        <iso:rule context="xlf:mrk[@itsm:locQualityIssueSeverity] | xlf:mrk[@itsm:locQualityIssueProfileRef] | 
            xlf:sm[@itsm:locQualityIssueSeverity] | xlf:sm[@itsm:locQualityIssueProfileRef]">
            <iso:report test="@itsm:locQualityIssuesRef">
                When the 'itsm:locQualityIssueSeverity' or 'itsm:locQualityIssueProfileRef' attributes are used, the 'itsm:locQualityIssuesRef' must not be declared.
            </iso:report>
        </iso:rule>
    </iso:pattern>
    <iso:pattern>
        <iso:rule context="xlf:mrk[@itsm:locQualityRatingScore] | xlf:sm[@itsm:locQualityRatingScore]">
            <iso:report test="@itsm:locQualityRatingVote">
                When the 'itsm:locQualityRatingScore' attribute is used, the 'itms:locQualityRatingVote' attribute is not allowed.
            </iso:report>
            <iso:assert test="not(@type) or @type='itsm:generic'">
                When the 'itsm:locQualityRatingScore' attribute is used, the optional 'type' attribute must be set to 'itsm:generic' if declared.
            </iso:assert>
        </iso:rule>
    </iso:pattern>
    <iso:pattern>
        <iso:rule context="xlf:mrk[@itsm:locQualityRatingVote] | xlf:sm[@itsm:locQualityRatingVote]">
            <iso:report test="@itsm:locQualityRatingScore">
                When the 'itsm:locQualityRatingVote' attribute is used, the 'itms:locQualityRatingScore' attribute is not allowed.
            </iso:report>
            <iso:assert test="not(@type) or @type='itsm:generic'">
                When the 'itsm:locQualityRatingVote' attribute is used, the optional 'type' attribute must be set to 'itsm:generic' if declared.
            </iso:assert>
        </iso:rule>
    </iso:pattern>
    <iso:pattern>
        <iso:rule context="xlf:*[@itsm:locQualityRatingScoreThreshold]">
            <iso:assert test="@itsm:locQualityRatingScore or ancestor::xlf:*[@itsm:locQualityRatingScore]">
                The 'itsm:locQualityRatingScoreThreshold' attribute may be set only if 'itsm:locQualityRatingScore' is declared or inherited from upper levels.
            </iso:assert>
        </iso:rule>
    </iso:pattern>
    <iso:pattern>
        <iso:rule context="xlf:*[@itsm:locQualityRatingVoteThreshold]">
            <iso:assert test="@itsm:locQualityRatingVote or ancestor::xlf:*[@itsm:locQualityRatingVote]">
                The 'itsm:locQualityRatingVoteThreshold' attribute may be set only if 'itsm:locQualityRatingVote' is declared or inherited from upper levels.
            </iso:assert>
        </iso:rule>
    </iso:pattern>
    <iso:pattern>
        <iso:rule context="xlf:mrk[@itsm:taIdentRef] | xlf:sm[@itsm:taIdentRef]">
            <iso:report test="@itsm:taSource or @itsm:taIdent">
                When the 'itsm:taIdentRef' attribute is used, the following attributes are not allowed: 'itsm:taSource' and 'itsm:taIdent'.
            </iso:report>
            <iso:assert test="not(@type) or @type='itsm:generic'">
                When the 'itsm:taIdentRef' attribute is used, the optional 'type' attribute must be set to 'itsm:generic' if declared.
            </iso:assert>
        </iso:rule>
    </iso:pattern>
    <iso:pattern>
        <iso:rule context="xlf:mrk[@itsm:taSource] | xlf:sm[@itsm:taSource] |
            xlf:mrk[@itsm:taIdent] | xlf:sm[@itsm:taIdent]">
            <iso:report test="@itsm:taIdentRef">
                When the 'itsm:taSource' or 'itsm:taIdent' attributes are used, the 'itsm:taIdentRef' attribute is not allowed.
            </iso:report>
            <iso:assert test="@itsm:taSource and @itsm:taIdent">
                The pair of 'itsm:taSource' and 'itsm:taIdent'attributes must be present at the same time.
            </iso:assert>
            <iso:assert test="not(@type) or @type='itsm:generic'">
                When the 'itsm:taSource' and 'itsm:taIdent' attributes are used, the optional 'type' attribute must be set to 'itsm:generic' if declared.
            </iso:assert>
        </iso:rule>
    </iso:pattern>
    <iso:pattern>
        <iso:rule context="xlf:mrk[@itsm:taClassRef] | xlf:sm[@itsm:taClassRef]">
            <iso:assert test="not(@type) or @type='itsm:generic'">
                When the 'itsm:taClassRef' attribute is used, the optional 'type' attribute must be set to 'itsm:generic' if declared.
            </iso:assert>
        </iso:rule>
    </iso:pattern>
    <iso:pattern>
        <iso:rule context="xlf:mrk[@itsm:lang] | xlf:sm[@itsm:lang]">
            <iso:assert test="not(@type) or @type='itsm:generic'">
                When the 'itsm:lang' attribute is used, the optional 'type' attribute must be set to 'itsm:generic' if declared.
            </iso:assert>
        </iso:rule>
    </iso:pattern>
    <iso:pattern>
        <iso:rule context="xlf:mrk[@itsm:mtConfidence] | xlf:sm[@itsm:mtConfidence]">
            <iso:assert test="not(@type) or @type='itsm:generic'">
                When the 'itsm:mtConfidence' attribute is used, the optional 'type' attribute must be set to 'itsm:generic' if declared.
            </iso:assert>
        </iso:rule>
    </iso:pattern>
    
    <iso:pattern>
        <iso:rule context="xlf:mrk[@itsm:provenanceRecordsRef] | xlf:sm[@itsm:provenanceRecordsRef]">
            <iso:assert test="not(@type) or @type='itsm:generic'">
                When the 'itsm:provenanceRecordsRef' attribute is used, the optional 'type' attribute must be set to 'itsm:generic' if declared.
            </iso:assert>
            <iso:report test="@itsm:org or @itsm:orgRef or @itsm:person or 
                @itsm:personRef or @itsm:revOrg or @itsm:revOrgRef or 
                @itsm:revPerson or @itsm:revPersonRef or @itsm:revTool or
                @itsm:revToolRef or @itsm:tool or @itsm:toolRef">
                When the 'itsm:provenanceRecordsRef' attribute is used, the following attributes are not allowed: itsm:org, itsm:orgRef, itsm:person, itsm:personRef, itsm:revOrg,
                itsm:revOrgRef, itsm:revPerson, itsm:revPersonRef, itsm:revTool, itsm:revToolRef, itsm:tool and itsm:toolRef.
                
            </iso:report>
        </iso:rule>
    </iso:pattern>
    <iso:pattern>
        <iso:rule context="xlf:mrk[@itsm:allowedCharacters] | xlf:mrk[@itsm:domains] | xlf:mrk[@itsm:localeFilterList] |
            xlf:sm[@itsm:allowedCharacters] | xlf:sm[@itsm:domains] | xlf:sm[@itsm:localeFilterList]">
            <iso:assert test="not(@type) or @type='itsm:generic'">
                When the 'itsm:allowedCharacters', 'itsm:domains' or 'itsm:localeFilterList attributes are used, the value of optional 'type' attribute must be set to 'itsm:generic'.
            </iso:assert>
        </iso:rule>
    </iso:pattern>
    <iso:pattern>
        <iso:rule context="xlf:mrk[@itsm:locQualityIssuesRef] | xlf:sm[@itsm:locQualityIssuesRef]">
            <iso:report test="@itsm:locQualityIssueSeverity or @itsm:locQualityIssueProfileRef or @itsm:locQualityIssueEnabled">
                If the 'itsm:locQualityIssuesRef' attribute is declared, the following attributes are not allowd: itsm:locQualityIssueSeverity, itsm:locQualityIssueProfileRef, and itsm:locQualityIssueEnabled".
            </iso:report>
            <iso:assert test="count(ancestor::xlf:unit//itsm:locQualityIssues[@id=current()/@itsm:locQualityIssuesRef])=1">
                The value of the locQualityIssuesRef attribute must be an NMTOKEN value of one of the id attributes declared on a &lt;locQualityIssues> elements within the same 'unit'.
            </iso:assert>
        </iso:rule>
    </iso:pattern>
    <iso:pattern>
        <iso:rule context="xlf:mrk[@itsm:locQualityIssuesRef] | xlf:sm[@itsm:locQualityIssuesRef]">
            <iso:report test="@itsm:locQualityIssueType or @itsm:locQualityIssueComment">
                When 'itsm:locQualityIssuesRef' is declared, 'itsm:locQualityIssueType' and itsm:locQualityIssueComment are not allowed.
            </iso:report>
        </iso:rule>
    </iso:pattern>
    <iso:pattern>
        <iso:rule context="xlf:mrk[@itsm:locQualityIssueType] | xlf:mrk[@itsm:locQualityIssueComment] |
                           xlf:sm[@itsm:locQualityIssueType] | xlf:sm[@itsm:locQualityIssueComment] ">
            <iso:report test="@itsm:locQualityIssuesRef">
                When 'itsm:locQualityIssueType' or 'itsm:locQualityIssueComment' are declared, 'itsm:locQualityIssuesRef' is not allowed.
            </iso:report>
        </iso:rule>
    </iso:pattern>
   <iso:pattern>
        <iso:rule context="xlf:*[@itsm:annotatorsRef][not(contains(@itsm:annotatorsRef, ' '))]">
            <iso:let name="ref" value="@itsm:annotatorsRef"/>
            <iso:let name="its-dc-id" value="substring-before($ref,'|')"/>
            <iso:report test="$its-dc-id!='allowed-characters' and $its-dc-id!='directionality' and $its-dc-id!='domain' and $its-dc-id!='elements-within-text' and
                $its-dc-id!='external-resource' and $its-dc-id!='id-value' and $its-dc-id!='language-information' and
                $its-dc-id!='locale-filter' and $its-dc-id!='localization-note' and $its-dc-id!='localization-quality-issue' and
                $its-dc-id!='localization-quality-rating' and $its-dc-id!='mt-confidence' and $its-dc-id!='preserve-space' and
                $its-dc-id!='provenance' and $its-dc-id!='storage-size' and $its-dc-id!='target-pointer' and
                $its-dc-id!='terminology' and $its-dc-id!='text-analysis' and $its-dc-id!='translate'">
                Invalid id used for the ITS datacategory <iso:value-of select="$its-dc-id"/>. Please see the Specification for guidelines on the value of this attribute.
            </iso:report>
        </iso:rule>
    </iso:pattern>
    <iso:pattern>
        <iso:rule context="xlf:*[@itsm:annotatorsRef][(contains(@itsm:annotatorsRef, ' '))]">
            <iso:let name="ids-string" value=" replace(@itsm:annotatorsRef, '\|\w+','')"/>
            <iso:let name="ids-tokens" value="tokenize($ids-string, ' ')"/>
            <iso:report test="count($ids-tokens)!=count(distinct-values($ids-tokens))">
                Each ITS data category identifier must not be used more than once.
            </iso:report>
            <iso:assert test="matches($ids-string, '^(allowed-characters)?\s*(directionality)?\s*(domain)?\s*(elements-within-text)?\s*(external-resource)?\s*(id-value)?\s*(language-information)?\s*(locale-filter)?\s*(localization-note)?\s*(localization-quality-issue)?\s*(localization-quality-rating)?\s*(mt-confidence)?\s*(preserve-space)?\s*(provenance)?\s*(storage-size)?\s*(target-pointer)?\s*(terminology)?\s*(text-analysis)?\s*(translate)?$')">
                The space separated triples are not ordered alphabetically as per the ITS Data category identifier or contain iligal value. Please see the Specification for guidelines on the value of this attribute.
            </iso:assert>
         </iso:rule>
    </iso:pattern>
    <iso:pattern>
        <iso:rule context="itsm:locQualityIssue">
            <iso:assert test="@locQualityIssueType or @locQualityIssueComment">
                At least one of the attributes locQualityIssueType or locQualityIssueComment must be set.
            </iso:assert>
        </iso:rule>
    </iso:pattern>
    <iso:pattern>
        <iso:rule context="itsm:provenanceRecord">
            <iso:assert test="@itsm:org or @itsm:orgRef or @itsm:person or 
                @itsm:personRef or @itsm:revOrg or @itsm:revOrgRef or 
                @itsm:revPerson or @itsm:revPersonRef or @itsm:revTool or
                @itsm:revToolRef or @itsm:tool or @itsm:toolRef">
                At least one of the followings must be set: itsm:org, itsm:orgRef, itsm:person, itsm:personRef, itsm:revOrg,
                itsm:revOrgRef, itsm:revPerson, itsm:revPersonRef, itsm:revTool, itsm:revToolRef, itsm:tool and itsm:toolRef.
            </iso:assert>
        </iso:rule>
    </iso:pattern>
    <iso:pattern>
        <iso:rule context="itsm:locQualityIssues | itsm:provenanceRecords[ancestor::xlf:unit]">
            <iso:let name="id" value="@id"/>
            <iso:let name="counter" value="count(ancestor::xlf:unit//itsm:locQualityIssues[@id=$id] | ancestor::xlf:unit//itsm:provenanceRecords[@id=$id])"/>
            <iso:assert test="$counter=1">
                Value of 'id' must be unique among all of  &lt;locQualityIssues> and &lt;provenanceRecords> elements within the enclosing 'unit'.
            </iso:assert>
        </iso:rule>
    </iso:pattern>
    <iso:pattern>
        <iso:rule context="itsm:provenanceRecords[ancestor::xlf:group][not(ancestor::xlf:unit)]">
            <iso:let name="id" value="@id"/>
            <iso:let name="counter" value="count(ancestor::xlf:group[1]//itsm:provenanceRecords[@id=$id][not(ancestor::xlf:unit)])"/>
            <iso:assert test="$counter=1">
                Value of 'id' must be unique among all of  &lt;provenanceRecords> elements within the enclosing 'group'.
            </iso:assert>
        </iso:rule>
    </iso:pattern>
    <iso:pattern>
        <iso:rule context="itsm:provenanceRecords[ancestor::xlf:file][not(ancestor::xlf:unit)][not(ancestor::xlf:group)]">
            <iso:let name="id" value="@id"/>
            <iso:let name="counter" value="count(ancestor::xlf:file//itsm:provenanceRecords[@id=$id][not(ancestor::xlf:group)][not(ancestor::xlf:unit)])"/>
            <iso:assert test="$counter=1">
                Value of 'id' must be unique among all of  &lt;provenanceRecords> elements within the enclosing 'file'.
            </iso:assert>
        </iso:rule>
    </iso:pattern>
    <iso:pattern>
        <iso:rule context="xlf:*[@itsm:locQualityIssuesRef]">
            <iso:assert test="not(@itsm:locQualityIssueSeverity)">
                If 'itsm:locQualityIssuesRef' attribute is declared, the 'itsm:locQualityIssueSeverity' must not be used. 
            </iso:assert>
            <iso:assert test="not (@itsm:locQualityIssueProfileRef) ">
                If 'itsm:locQualityIssuesRef' attribute is declared, the 'itsm:locQualityIssueProfileRef' must not be used. 
            </iso:assert>
            <iso:assert test="not(@itsm:locQualityIssueEnabled)">
                If 'itsm:locQualityIssuesRef' attribute is declared, the 'itsm:locQualityIssueEnabled' must not be used. 
            </iso:assert>
        </iso:rule>        
    </iso:pattern>
</iso:schema>
