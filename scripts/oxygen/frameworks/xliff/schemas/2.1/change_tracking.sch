<?xml version="1.0" encoding="UTF-8"?>
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


<iso:schema xmlns="http://purl.oclc.org/dsdl/schematron" 
    xmlns:iso="http://purl.oclc.org/dsdl/schematron"
    xmlns:ctr="urn:oasis:names:tc:xliff:changetracking:2.1"
    queryBinding='xslt2' 
    schemaVersion='ISO19757-3'>
    <iso:title>Schematron rules for checking the constraints of the Change Tracking module against the XLIFF &version; spec</iso:title>
    <iso:ns prefix="ctr" uri="urn:oasis:names:tc:xliff:changetracking:2.1"/>
    <iso:ns prefix="xlf" uri="urn:oasis:names:tc:xliff:document:2.0"/>

    <iso:pattern>
        <iso:rule context="ctr:revisions[@appliesTo='source'] | ctr:revisions[@appliesTo='target']">
            <!-- source-counter represents the number of source elements within the same unit, which are children of segment or ignorable -->
            <iso:let name="source-counter" value="count(ancestor::xlf:unit//xlf:source[parent::xlf:*])"/>
            <!-- An error will be raised if more than one source is present in the unit and @ref is missing-->
            <iso:report test="$source-counter>1 and not(@ref)">
                The 'appliesTo' attribute is set to 'source' or 'target' and the 'unit' ancestor contains more than one 'source'/'target', but the 'ref' attribute is missing in &lt;revisions&gt;.
            </iso:report>
            <!-- An error will be raised if more than one source is present in the unit and the number of segment/ignorable elements matchin @ref is not 1 -->
            <iso:report test="$source-counter>1 and count(ancestor::xlf:unit//xlf:segment[@id=current()/@ref] | ancestor::xlf:unit//xlf:ignorable[@id=@ref])!=1">
                The corresponding 'segment' or 'ignorable' element with id='<iso:value-of select="@ref"/>', to which 'ref' is pointing was not found within the 'unit'.
            </iso:report>
        </iso:rule>
    </iso:pattern>
    <iso:pattern>
        <!-- Select only those revisions elements which specify @ref-->
        <iso:rule context="ctr:revisions[@ref]">
            <iso:let name="xlf-element" value="@appliesTo"/>
            <iso:let name="ref" value="@ref"/>
            <!-- reference-counter represents the number of xlf element, which have the same name as @appliesTo and the same @id as the @ref of revisions-->
            <iso:let name="reference-counter" value="count(ancestor::xlf:unit//xlf:*[name()=$xlf-element][@id=$ref])"/>
            <!-- 'source' and 'target' cases are excluded, but for other elements there must be exactly 1 match-->
            <iso:report test="$xlf-element!='source' and $xlf-element!='target' and $reference-counter!=1">
                The corresponding <iso:value-of select="$xlf-element"/> with id='<iso:value-of select="$ref"/>', to which 'ref' is pointing was not found within the 'unit'.
            </iso:report>
        </iso:rule>
    </iso:pattern>
    <iso:pattern>
        <!-- Select item and simpleItem elements with @property other than 'content' -->
        <iso:rule context="ctr:item[@property!='content'] | ctr:simpleItem[@property!='content']">
            <iso:let name="xlf-element" value="ancestor::ctr:revisions/@appliesTo"/>
            <iso:let name="attribute" value="@property"/>
            <!-- Allow type D excluding xlf elements; text only -->
            <report test="child::*">
                When the 'property' attribute is not set to 'content', the <iso:value-of select="name()"/> element can contain text only.
            </report>
            <!-- Restriction on @property value, if @appliesTo='unit'- only 'unit' attributes -->
            <report test="$xlf-element='unit' and ($attribute !='id' and  $attribute!='name'  and $attribute!='canResegment'and $attribute!='translate' and
                 $attribute!='srcDir' and $attribute!='trgDir' and $attribute!='xml:space' and $attribute!='type')">
                When the 'appliesTo' attribute of the ancestor 'revisions' is set to 'unit', only the following values ('unit' attributes) are allowed for 'property':
                id, name, canResegment, translate, srcDir, trgDir, xml:space and type.
            </report>
            <!-- Restriction on @property value, if @appliesTo='segment'- only 'segment' attributes -->
            <report test="$xlf-element='segment' and ($attribute !='id' and  $attribute!='canResegment'and $attribute!='state' and
                $attribute!='subState')">
                When the 'appliesTo' attribute of the ancestor 'revisions' is set to 'segment', only the following values ('segment' attributes) are allowed for 'property':
                id, canResegment, state and subState.
            </report>
            <!-- Restriction on @property value, if @appliesTo='ignorable'- only 'ignorable' attributes -->
            <report test="$xlf-element='ignorable' and $attribute !='id'">
                When the 'appliesTo' attribute of the ancestor 'revisions' is set to 'ignorable', only the following values ('ignorable' attributes) are allowed for 'property':
                id.
            </report>
            <!-- Restriction on @property value, if @appliesTo='source'- only 'source' attributes -->
            <report test="$xlf-element='source' and ($attribute !='xml:lang' and $attribute!='xml:space')">
                When the 'appliesTo' attribute of the ancestor 'revisions' is set to 'source', only the following values ('source' attributes) are allowed for 'property':
                xml:lang and xml:space.
            </report>
            <!-- Restriction on @property value, if @appliesTo='target'- only 'target' attributes -->
            <report test="$xlf-element='target' and ($attribute !='xml:lang' and $attribute!='xml:space' and $attribute!='order')">
                When the 'appliesTo' attribute of the ancestor 'revisions' is set to 'target', only the following values ('target' attributes) are allowed for 'property':
                xml:lang and xml:space.
            </report>
        </iso:rule>
    </iso:pattern>
    <iso:pattern>
        <!-- Select 'item' elements with @property='content' -->
        <iso:rule context="ctr:item[@property='content']">
            <iso:let name="xlf-element" value="ancestor::ctr:revisions/@appliesTo"/>
            <!-- If @appliesTo='unit', the 'item' must be of type A: only 'segment' and 'ignorable' -->
            <iso:report test="$xlf-element='unit' and count(child::*)!=count(child::xlf:segment | child::xlf:ignorable)">
                When the 'property' attribute is set to 'content' and the 'appliesTo' attribute of ancestor 'revisions' points to 'unit', the content of 
                'item' element must be of type A: only 'segment' and 'ignorables' in any order.
            </iso:report>
            <!-- If @appliesTo='segment' or 'ignorable', the 'item' must be of type B or C: only one 'source' followed by at most one 'target' or only one 'target' -->
            <iso:report test="(($xlf-element='segment' or $xlf-element='ignorable') and count(child::*)=1 and (not(child::xlf:source) and not(child::xlf:target))) or
                              (($xlf-element='segment' or $xlf-element='ignorable') and count(child::*)=2 and not(child::xlf:source[1]) and not(child::xlf:target[2]))"> 
               When the 'property' attribute is set to 'content' and the 'appliesTo' attribute of ancestor 'revisions' points to 'segment' or 'ignorable', the content of 
                'item' element must be of type B or C: only one 'source' followed by at most one 'target' or only one 'target'.
            </iso:report>        </iso:rule>
    </iso:pattern> 
    <iso:pattern>
        <iso:rule context="ctr:revisions[@appliesTo='note']">
            <report test="//ctr:item//xlf:*">
                XLIFF Core elements are not allowed in 'item' elements when the ancestor 'revisions' points to 'note'.
            </report>
        </iso:rule>
    </iso:pattern>
    <iso:pattern>
        <iso:rule context="xlf:sm[ancestor::ctr:item]">
            <iso:assert test="count(ancestor::ctr:item//xlf:em[@startRef=current()/@id])=1">
                The 'em' element corresponding to this start marker with the attribute @startRef='<iso:value-of select="current()/@id"/>' is missing in the same 'item' element.
            </iso:assert>
        </iso:rule>
    </iso:pattern>
    <iso:pattern>
        <iso:rule context="xlf:em[ancestor::ctr:item]">
            <iso:assert test="count(ancestor::ctr:item//xlf:sm[@id=current()/@startRef])=1">
                The 'sm' element corresponding to this end marker with the attribute @id='<iso:value-of select="current()/@startRef"/>' is missing in the same 'item' element.
            </iso:assert>
        </iso:rule>
    </iso:pattern>
    <iso:pattern>
        <iso:rule context="xlf:sc[ancestor::ctr:item]">
            <iso:assert test="count(ancestor::ctr:item//xlf:ec[@startRef=current()/@id])=1 or @isolated='yes'">
                The 'ec' element corresponding to this start marker with the attribute @startRef='<iso:value-of select="current()/@id"/>' is missing in the same 'item' element.
            </iso:assert>
        </iso:rule>
    </iso:pattern>
    <iso:pattern>
        <iso:rule context="xlf:ec[ancestor::ctr:item]">
            <iso:assert test="count(ancestor::ctr:item//xlf:sc[@startRef=current()/@startRef])=1 or @isolated='yes'">
                The 'sc' element corresponding to this start marker with the attribute @id='<iso:value-of select="current()/@startRef"/>' is missing in the same 'item' element.
            </iso:assert>
        </iso:rule>
    </iso:pattern>
    
    <iso:pattern>
        <iso:rule context="ctr:item | ctr:simpleItem">
            <!-- Check @property uniqueness -->
            <iso:let name="property" value="@property"/>
            <iso:report test="count(ancestor::ctr:revision/ctr:item[@property=$property] | ancestor::ctr:revision/ctr:simpleItem[@property=$property])!=1">
                The value of 'property' attribute must be unique among all 'item' and 'simpleItem' elements within the enclosing 'revision' parent.
            </iso:report>
        </iso:rule>
    </iso:pattern>
   <iso:pattern>
       <iso:rule context="ctr:*[@id]">
           <iso:report test="count(ancestor::ctr:changeTracking//ctr:*[@id=current()/@id]>1)">
               The value of 'id' must be unique among all 'revisions', 'revision', 'item' and 'simpleItem' elements within the CTR module.
           </iso:report>
       </iso:rule>
   </iso:pattern>
</iso:schema>