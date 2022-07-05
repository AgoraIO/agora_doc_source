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

<iso:schema xmlns:iso="http://purl.oclc.org/dsdl/schematron" xmlns:xlf="urn:oasis:names:tc:xliff:document:2.0" 
    queryBinding="xslt2" schemaVersion="ISO19757-3">
    <iso:title>Schematron Rules for validation of XLIFF Version &version; Core constraints</iso:title>
    <iso:ns prefix="xlf" uri="urn:oasis:names:tc:xliff:document:2.0"/>
    
    <iso:pattern id="K1">
        <iso:title>The value [of id] must be unique among all 'file' id attribute values within the enclosing 'xliff' element</iso:title>
        <iso:rule context="xlf:file">
            <iso:let name="id" value="current()/@id"/>
            <iso:let name="fragid" value="concat('f=',$id)"/>
            <iso:report diagnostics="fragid-report" see="&this-loc;/&name;-&stage;.html#id"
                test="following-sibling::xlf:file[@id=$id]">
                id duplication found. The value '<iso:value-of select="$id"/>' is used more than once for 'file' elements 
                within the enclosing 'xliff'.
            </iso:report>
        </iso:rule>
    </iso:pattern>
    <iso:pattern id="K2">
        <iso:title>The value [of id] must be unique among all 'group' id attribute values within the enclosing 'file' element</iso:title>
        <iso:rule context="xlf:group">
            <iso:let name="id" value="current()/@id"/>
            <iso:let name="fragid" value="concat('f=',ancestor::xlf:file/@id,'/g=',$id)"/>
            <iso:report diagnostics="fragid-report"  see="&this-loc;/&name;-&stage;.html#id"
                test="count(ancestor::xlf:file//xlf:group[@id=$id])>1">
                id duplication found. The value '<iso:value-of select="$id"/>' is used more than once for 'group' elements 
                within the enclosing 'file'.
            </iso:report>
        </iso:rule>
    </iso:pattern>
    <iso:pattern id="K3">
        <iso:title>The value [of id] must be unique among all 'unit' id attribute values within the enclosing 'file' element</iso:title>
        <iso:rule context="xlf:unit">
            <iso:let name="id" value="@id"/>
            <iso:let name="fragid" value="concat('f=', ancestor::xlf:file/@id,'/u=',$id)"/>
            <iso:report diagnostics="fragid-report" see="&this-loc;/&name;-&stage;.html#id"
                test="count(ancestor::xlf:file//xlf:unit[@id=$id])>1">
                id duplication found. The value '<iso:value-of select="$id"/>' is used more than once for 'unit' elements 
                within the enclosing 'file'.
            </iso:report>
        </iso:rule>
    </iso:pattern>
    <iso:pattern id="K4F">
        <iso:title>The value [of id] must be unique among all 'note' id attribute values within the enclosing 'notes' element</iso:title>
        <iso:rule context="xlf:note[@id][not(ancestor::xlf:unit)][not(ancestor::xlf:group)]">
            <iso:let name="id" value="@id"/>
            <iso:let name="fragid" value="concat('f=',ancestor::xlf:file/@id,'/n=',$id) "/>
            <iso:report diagnostics="fragid-report" see="&this-loc;/&name;-&stage;.htmll#id"
                test="following-sibling::xlf:note[@id=$id]">
                id duplication found. The value '<iso:value-of select="$id"/>' is used more than once for 'note' elements 
                within the enclosing 'notes'.
            </iso:report>
        </iso:rule>
    </iso:pattern>
    <iso:pattern id="K4GU">
        <iso:title>The value [of id] must be unique among all 'note' id attribute values within the enclosing 'notes' element</iso:title>
        <iso:rule context="xlf:note[@id][ancestor::xlf:unit| ancestor::xlf:group]">
            <iso:let name="id" value="current()/@id"/>
            <iso:let name="fragid" value="concat('f=',ancestor::xlf:file/@id,concat('/',substring(name(../..),1,1),'=',../../@id),'/n=',$id)"/>
            <iso:report diagnostics="fragid-report" see="&this-loc;/&name;-&stage;.html#id"
                test="following-sibling::xlf:note[@id=$id]">
                id duplication found. The value '<iso:value-of select="$id"/>' is used more than once for 'note' elements 
                within the enclosing 'notes'.
            </iso:report>
        </iso:rule>
    </iso:pattern>
    <iso:pattern id="K5">
        <iso:title>The value [of id] must be unique among all 'data' id attribute values within the enclosing 'originalData' element</iso:title>
        <iso:rule context="xlf:data">
            <iso:let name="id" value="current()/@id"/>
            <iso:let name="fragid" value="concat('f=',ancestor::xlf:file/@id,'/u=', ancestor::xlf:unit/@id,'/d=',$id)"/>
            <iso:report diagnostics="fragid-report" see="&this-loc;/&name;-&stage;.html#id"
                test="following-sibling::xlf:data[@id=$id]">
                id duplication found. The value '<iso:value-of select="$id"/>' is used more than once for 'data' elements 
                within the enclosing 'unit'.
            </iso:report>
        </iso:rule>
    </iso:pattern>
    <iso:pattern id="K6">
        <iso:title>Except for the above exception [target duplication], the value [of id attribute] must be unique among all of the above 
            [segment, ignorable, mkr, sm,pc, sc, ec, ph] within the enclosing 'unit' element</iso:title>
        <iso:rule context="xlf:source[ancestor::xlf:segment| ancestor::xlf:ignorable]//xlf:*[@id]|
            xlf:segment[@id]| xlf:ignorable[@id]">
            <iso:let name="id" value="current()/@id"/>
            <iso:let name="fragid" value="concat('f=',ancestor::xlf:file/@id,'/u=',ancestor::xlf:unit/@id,'/',$id)"/>
            <iso:report diagnostics="fragid-report" see="&this-loc;/&name;-&stage;.html#id"
                test="count(ancestor::xlf:unit//xlf:*[@id=$id][ancestor-or-self::xlf:segment| ancestor-or-self::xlf:ignorable][not(ancestor::xlf:target)])>1">
                id duplication found. The value '<iso:value-of select="$id"/>' is used more then once among inline and/or 'segmen'/'ignorable' 
                elements within the enclosing 'unit'.
            </iso:report>
        </iso:rule>
    </iso:pattern>
    <iso:pattern id="K7">
        <iso:title>The value of the order attribute must be unique within the enclosing 'unit' element</iso:title>
        <iso:rule context="xlf:target[@order][ancestor::xlf:segment|ancestor::xlf:ignorable]">
            <iso:let name="order" value="@order"/>
            <iso:let name="fragid" value="concat('f=', ancestor::xlf:file/@id, '/u=', ancestor::xlf:unit/@id)"/>
            <iso:report diagnostics="fragid-report"  see="&this-loc;/&name;-&stage;.html#order"
                test="count(ancestor::xlf:unit//xlf:target[ancestor::xlf:segment|ancestor::xlf:ignorable][@order=$order])>1">
                The value '<iso:value-of select="$order"/>' is used more than once for 'order' attributes of 'target' elements 
                within the enclosing 'unit'.
            </iso:report>
        </iso:rule>
    </iso:pattern>
    <iso:pattern id="K8">
        <iso:title>The inline elements enclosed by a &lt;target&gt; element must use the duplicate id values of their corresponding inline elements enclosed within the sibling &lt;source&gt; element if and only if those corresponding elements exist</iso:title>
        <iso:rule context="xlf:target[ancestor::xlf:segment | ancestor::xlf:ignorable]//xlf:*[@id]">
            <iso:let name="id" value="@id"/>
            <iso:let name="file-id" value="ancestor::xlf:file/@id"/>
            <iso:let name="unit-id" value="ancestor::xlf:unit/@id"/>
            <iso:let name="fragid" value="concat('f=', $file-id,'/u=',$unit-id,'/t=',$id)"/>
            <iso:let name="counter" value="count(ancestor::xlf:unit//xlf:*[@id=$id]
                [ancestor-or-self::xlf:segment| ancestor-or-self::xlf:ignorable])"/>
            <!-- If the counter is 1, then the id is unique and therefore valid -->
            <!-- If the counter is 2 (duplication exsists), the duplication must be 
            in the sibling source, have the same name and contain same attributes-->
            <!-- If the counter is more than 2 or the duplication is not in the right 
            position, then as error will be reported -->
            <iso:assert diagnostics="fragid-report" see="&this-loc;/&name;-&stage;.html#id"
                test="($counter=1) or ($counter=2 and
                count(ancestor::xlf:segment/xlf:source//xlf:*[@id=$id]
                [name()= name(current())] | 
                ancestor::xlf:ignorable/xlf:source//xlf:*[@id=$id][name()= 
                name(current())][@*=current()/@*])=1)"> 
                Invalid id used for element '<iso:name/>'. It must duplicate the 
                id of its corresponding element, enclosed within the 'source' 
                element or be unique in the scope of 'unit'.
            </iso:assert>
        </iso:rule>
    </iso:pattern>
    
    <iso:pattern id="F1">
        <iso:title>The 'trgLang' attribute is required if and only if the XLIFF Document contains 'target' elements 
            that are children of 'segment' or 'ignorable'</iso:title>
        <iso:rule context="xlf:target[parent::xlf:segment | parent::xlf:ignorable]">
            <iso:let name="fragid" value="concat('f=', ancestor::xlf:file/@id, '/u=', ancestor::xlf:unit/@id)"/>
            <iso:assert diagnostics="fragid-report" see="&this-loc;/&name;-&stage;.html#xliff" 
                test="/xlf:xliff/@trgLang">
                XLIFF document contains 'target' element(s), but the 'trgLang' attribute of 'xliff' is missing.
            </iso:assert>
        </iso:rule>
    </iso:pattern>
    <iso:pattern id="F2">
        <iso:title>The attribute 'href' is required if and only if the 'skeleton' element is empty</iso:title>
        <iso:rule context="xlf:skeleton">
            <iso:let name="fragid" value="concat('f=',ancestor::xlf:file/@id)"/>
            <iso:report diagnostics="fragid-report" see="&this-loc;/&name;-&stage;.html#skeleton"
                test="not(@href) and not(child::node())">
                'skeleton' element must not be empty when the 'href' attribute is missing.
            </iso:report>
            <iso:report diagnostics="fragid-report" see="&this-loc;/&name;-&stage;.html#skeleton"
                test="@href and  child::node()">
                'skeleton' element must be empty when containing 'href' attribute.
            </iso:report>
        </iso:rule>
    </iso:pattern>
    <iso:pattern id="F3">
        <iso:title>A 'unit' must contain at least one 'segment' element</iso:title>
        <iso:rule context="xlf:unit">
            <iso:let name="fragid" value="concat('f=',ancestor::xlf:file/@id,'/u=', current()/@id)"/>
            <iso:report  diagnostics="fragid-report" see="&this-loc;/&name;-&stage;.html#unit"
                test="not(child::xlf:segment)">
                Incomplete 'unit'; it must have at least one 'segment' child.
            </iso:report>
        </iso:rule>
    </iso:pattern>
    <iso:pattern id="F4">
        <iso:title>When a 'target' element is a child of 'segment' or 'ignorable', the explicit or inherited value
            of the optional xml:lang must be equal to the value of the trgLang attribute of the enclosing 'xliff' 
            element</iso:title>
        <iso:p>This rule does not rais an error if 'xml:lang' is a subcategory of 'trgLang', but not vice versa.
            i.e. 'trgLang="en"/xml:lang="en-ie"' is a valid pair.</iso:p>
        <iso:rule context="xlf:target[@xml:lang][parent::xlf:segment | parent::xlf:ignorable]">
            <iso:let name="trgLang" value="/xlf:xliff/@trgLang"/>
            <iso:let name="fragid" value="concat('f=',ancestor::xlf:file/@id,'/u=', ancestor::xlf:unit/@id)"/>
            <iso:report  diagnostics="fragid-report" see="&this-loc;/&name;-&stage;.html#target"
                test="not(lang($trgLang))">
                'xml:lang' attribute of the 'target' element and 'trgLang' attribute of the 'xliff' are not matching.
            </iso:report>
        </iso:rule>
    </iso:pattern>
    <iso:pattern id="F5S">
        <iso:title>The attribute isolated must be set to yes if and only if the 'ec' element corresponding to this
            start marker is not in the same 'unit', and set to no otherwise</iso:title>
        <iso:p>This rule selects those 'sc' with 'isolated' attribute set to 'yes' and appear in 'source'. 
            An error will be raised if
            a) there exists any 'ec' in the same 'unit' and in a 'source', corresponding to this 'sc' by 'startRef';
            b) there is not any 'ec' in the document which appears after the start code and is not in the same 'unit' 
            and is within a 'source';
            c) the values of 'canCopy', 'canDelete', 'canOverlap' or 'canReorder' attributes are not matching with the 
            corresponding 'ec';
            d) the value of 'canReorder' is set to 'firstNo', but is not 'no' in the corresponding 'ec'</iso:p>
        <iso:rule context="xlf:sc[ancestor::xlf:source][@isolated='yes'][ancestor::xlf:segment | ancestor::xlf:ignorable]">
            <iso:let name="id" value="current()/@id"/>
            <iso:let name="file-id" value="ancestor::xlf:file/@id"/>
            <iso:let name="unit-id" value="ancestor::xlf:unit/@id"/>
            <iso:let name="fragid" value="concat('f=', $file-id, '/u=', $unit-id, '/', $id)"/>
            <iso:report diagnostics="fragid-report" see="&this-loc;/&name;-&stage;.html#isolated"
                test="ancestor::xlf:unit//xlf:ec[@startRef=$id][ancestor::xlf:source]">
                'isolated' attribute is set to 'yes', but 'ec' element(s) referencing this start code found within the same unit.
            </iso:report>
            <iso:assert diagnostics="fragid-report" see="&this-loc;/&name;-&stage;.html#isolated"
                test="following::xlf:ec[@id=$id][ancestor::xlf:source][ancestor::xlf:file/@id=$file-id]
                [not(ancestor::xlf:unit[@id=$unit-id])]">
                'isolated' attribute is set to 'yes', but the corresponding 'ec' element, out of the 'unit' with 
                'id=<iso:value-of select="$unit-id"/>', was not found. The end code must appear after the start code, but in the
                same 'file'.
            </iso:assert>
            <iso:report diagnostics="fragid-report" see="&this-loc;/&name;-&stage;.html#sc"
                test="@canCopy='no' and not(following::xlf:ec[@id=$id][ancestor::xlf:source][ancestor::xlf:file/@id=$file-id][not(ancestor::xlf:unit[@id=$unit-id])]
                [ancestor::xlf:segment | ancestor::xlf:ignorable][@canCopy='no'])">
                'canCopy' attribute is not matching with the 'canCopy' attribute of the corresponding 'ec' element 
                (out of 'unit' with 'id=<iso:value-of select="$unit-id"/>').
            </iso:report>
            <iso:report diagnostics="fragid-report" see="&this-loc;/&name;-&stage;.html#sc"
                test="(@canCopy='yes' or not(@canCopy)) and 
                not(following::xlf:ec[@id=$id][ancestor::xlf:source][ancestor::xlf:file/@id=$file-id][not(ancestor::xlf:unit[@id=$unit-id])]
                [ancestor::xlf:segment | ancestor::xlf:ignorable][@canCopy='yes']) and
                not(following::xlf:ec[@id=$id][ancestor::xlf:source][ancestor::xlf:file/@id=$file-id][not(ancestor::xlf:unit[@id=$unit-id])]
                [ancestor::xlf:segment | ancestor::xlf:ignorable][not(@canCopy)])">
                'canCopy' attribute is not matching with the 'canCopy' attribute of the corresponding 'ec' element 
                (out of 'unit' with 'id=<iso:value-of select="$unit-id"/>').
            </iso:report>
            <iso:report diagnostics="fragid-report" see="&this-loc;/&name;-&stage;.html#sc"
                test="@canDelete='no' and not(following::xlf:ec[@id=$id][ancestor::xlf:source][ancestor::xlf:file/@id=$file-id][not(ancestor::xlf:unit[@id=$unit-id])]
                [ancestor::xlf:segment | ancestor::xlf:ignorable][@canDelete='no'])">
                'canDelete' attribute is not matching with the 'canDelete' attribute of the corresponding 'ec' element 
                (out of 'unit' with 'id=<iso:value-of select="$unit-id"/>').
            </iso:report>
            <iso:report diagnostics="fragid-report" see="&this-loc;/&name;-&stage;.html#sc"
                test="(@canDelete='yes' or not(@canDelete)) and 
                not(following::xlf:ec[@id=$id][ancestor::xlf:source][ancestor::xlf:file/@id=$file-id][not(ancestor::xlf:unit[@id=$unit-id])]
                [ancestor::xlf:segment | ancestor::xlf:ignorable][@canDelete='yes']) and
                not(following::xlf:ec[@id=$id][ancestor::xlf:source][ancestor::xlf:file/@id=$file-id][not(ancestor::xlf:unit[@id=$unit-id])]
                [ancestor::xlf:segment | ancestor::xlf:ignorable][not(@canDelete)])">
                'canDelete' attribute is not matching with the 'canDelete' attribute of the corresponding 'ec' element 
                (out of 'unit' with 'id=<iso:value-of select="$unit-id"/>').
            </iso:report>
            <iso:report diagnostics="fragid-report" see="&this-loc;/&name;-&stage;.html#sc"
                test="@canReorder='no' and not(following::xlf:ec[@id=$id][ancestor::xlf:source][ancestor::xlf:file/@id=$file-id][not(ancestor::xlf:unit[@id=$unit-id])]
                [ancestor::xlf:segment | ancestor::xlf:ignorable][@canReorder='no'])">
                'canReorder' attribute is not matching with the 'canReorder' attribute of the corresponding 'ec' element 
                (out of 'unit' with 'id=<iso:value-of select="$unit-id"/>').
            </iso:report>
            <iso:report diagnostics="fragid-report" see="&this-loc;/&name;-&stage;.html#sc"
                test="(@canReorder='yes' or not(@canReorder)) and 
                not(following::xlf:ec[@id=$id][ancestor::xlf:source][ancestor::xlf:file/@id=$file-id][not(ancestor::xlf:unit[@id=$unit-id])]
                [ancestor::xlf:segment | ancestor::xlf:ignorable][@canReorder='yes']) and
                not(following::xlf:ec[@id=$id][ancestor::xlf:source][ancestor::xlf:file/@id=$file-id][not(ancestor::xlf:unit[@id=$unit-id])]
                [ancestor::xlf:segment | ancestor::xlf:ignorable][not(@canReorder)])">
                'canReorder' attribute is not matching with the 'canReorder' attribute of the corresponding 'ec' element 
                (out of 'unit' with 'id=<iso:value-of select="$unit-id"/>').
            </iso:report>
            <iso:report diagnostics="fragid-report" see="&this-loc;/&name;-&stage;.html#sc"
                test="@canOverlap='no' and not(following::xlf:ec[@id=$id][ancestor::xlf:source][ancestor::xlf:file/@id=$file-id][not(ancestor::xlf:unit[@id=$unit-id])]
                [ancestor::xlf:segment | ancestor::xlf:ignorable][@canOverlap='no'])">
                'canOverlap' attribute is not matching with the 'canOverlap' attribute of the corresponding 'ec' element 
                (out of 'unit' with 'id=<iso:value-of select="$unit-id"/>').
            </iso:report>
            <iso:report diagnostics="fragid-report" see="&this-loc;/&name;-&stage;.html#sc"
                test="(@canOverlap='yes' or not(@canOverlap)) and 
                not(following::xlf:ec[@id=$id][ancestor::xlf:source][ancestor::xlf:file/@id=$file-id][not(ancestor::xlf:unit[@id=$unit-id])]
                [ancestor::xlf:segment | ancestor::xlf:ignorable][@canOverlap='yes']) and
                not(following::xlf:ec[@id=$id][ancestor::xlf:source][ancestor::xlf:file/@id=$file-id][not(ancestor::xlf:unit[@id=$unit-id])]
                [ancestor::xlf:segment | ancestor::xlf:ignorable][not(@canOverlap)])">
                'canOverlap' attribute is not matching with the 'canOverlap' attribute of the corresponding 'ec' element 
                (out of 'unit' with 'id=<iso:value-of select="$unit-id"/>').
            </iso:report>
            <iso:report diagnostics="fragid-report" see="&this-loc;/&name;-&stage;.html#ec"
                test="@canReorder='firstNo' and not(following::xlf:ec[@id=$id][ancestor::xlf:source][ancestor::xlf:file/@id=$file-id]
                [not(ancestor::xlf:unit[@id=$unit-id])][ancestor::xlf:segment | ancestor::xlf:ignorable][@canReorder='no'])">
                'canReorder' is set to 'firstNo', but the corresponding 'ec' (out of 'unit' with 'id=<iso:value-of select="$unit-id"/>')
                has not set its 'canReorder' attribute to 'no'.
            </iso:report>
        </iso:rule>
    </iso:pattern>
    <iso:pattern id="F5T">
        <iso:title>The attribute isolated must be set to yes if and only if the 'ec' element corresponding to this
            start marker is not in the same 'unit', and set to no otherwise</iso:title>
        <iso:p>This rule selects those 'sc' files with 'isolated' attribute set to 'yes' and appear in 'target'. 
            An error will be raised if
            a) there exists any 'ec' in the same 'unit' and in a 'target', corresponding to this 'sc' by 'startRef';
            b) there is not any 'ec' in the document which appears after the start code and is not in the same 'unit' 
            and is within a 'target';
            c) the value of 'canCopy', 'canDelete', 'canOverlap' or 'canReorder' attributes are not matching with the 
            corresponding 'ec';
            d) the value of 'canReorder' is set to 'firstNo', but is not 'no' in the corresponding 'ec'</iso:p>
        <iso:rule context="xlf:sc[ancestor::xlf:target][@isolated='yes'][ancestor::xlf:segment | ancestor::xlf:ignorable]">
            <iso:let name="id" value="current()/@id"/>
            <iso:let name="file-id" value="ancestor::xlf:file/@id"/>
            <iso:let name="unit-id" value="ancestor::xlf:unit/@id"/>
            <iso:let name="fragid" value="concat('f=', $file-id, '/u=', $unit-id, '/t=', $id)"/>
            <iso:report diagnostics="fragid-report" see="&this-loc;/&name;-&stage;.html#isolated"
                test="ancestor::xlf:unit//xlf:ec[@startRef=$id][ancestor::xlf:target]">
                'isolated' attribute is set to 'yes', but 'ec' element(s) referencing this start code found within the same unit.
            </iso:report>
            <iso:assert diagnostics="fragid-report" see="&this-loc;/&name;-&stage;.html#isolated"
                test="following::xlf:ec[@id=$id][ancestor::xlf:target][ancestor::xlf:file/@id=$file-id]
                [not(ancestor::xlf:unit[@id=$unit-id])]">
                'isolated' attribute is set to 'yes', but the corresponding 'ec' element, out of the 'unit' with
                'id=<iso:value-of select="$unit-id"/>', was not found. The end code must appear after the start code, but in the
                same 'file'.
            </iso:assert>
            <iso:report diagnostics="fragid-report" see="&this-loc;/&name;-&stage;.html#sc"
                test="@canCopy='no' and not(following::xlf:ec[@id=$id][ancestor::xlf:target][ancestor::xlf:file/@id=$file-id][not(ancestor::xlf:unit[@id=$unit-id])]
                [ancestor::xlf:segment | ancestor::xlf:ignorable][@canCopy='no'])">
                'canCopy' attribute is not matching with the 'canCopy' attribute of the corresponding 'ec' element 
                (out of 'unit' with 'id=<iso:value-of select="$unit-id"/>').
            </iso:report>
            <iso:report diagnostics="fragid-report" see="&this-loc;/&name;-&stage;.html#sc"
                test="(@canCopy='yes' or not(@canCopy)) and 
                not(following::xlf:ec[@id=$id][ancestor::xlf:target][ancestor::xlf:file/@id=$file-id][not(ancestor::xlf:unit[@id=$unit-id])]
                [ancestor::xlf:segment | ancestor::xlf:ignorable][@canCopy='yes']) and
                not(following::xlf:ec[@id=$id][ancestor::xlf:target][ancestor::xlf:file/@id=$file-id][not(ancestor::xlf:unit[@id=$unit-id])]
                [ancestor::xlf:segment | ancestor::xlf:ignorable][not(@canCopy)])">
                'canCopy' attribute is not matching with the 'canCopy' attribute of the corresponding 'ec' element 
                (out of 'unit' with 'id=<iso:value-of select="$unit-id"/>').
            </iso:report>
            <iso:report diagnostics="fragid-report" see="&this-loc;/&name;-&stage;.html#sc"
                test="@canDelete='no' and not(following::xlf:ec[@id=$id][ancestor::xlf:target][ancestor::xlf:file/@id=$file-id][not(ancestor::xlf:unit[@id=$unit-id])]
                [ancestor::xlf:segment | ancestor::xlf:ignorable][@canDelete='no'])">
                'canDelete' attribute is not matching with the 'canDelete' attribute of the corresponding 'ec' element 
                (out of 'unit' with 'id=<iso:value-of select="$unit-id"/>').
            </iso:report>
            <iso:report diagnostics="fragid-report" see="&this-loc;/&name;-&stage;.html#sc"
                test="(@canDelete='yes' or not(@canDelete)) and 
                not(following::xlf:ec[@id=$id][ancestor::xlf:target][ancestor::xlf:file/@id=$file-id][not(ancestor::xlf:unit[@id=$unit-id])]
                [ancestor::xlf:segment | ancestor::xlf:ignorable][@canDelete='yes']) and
                not(following::xlf:ec[@id=$id][ancestor::xlf:target][ancestor::xlf:file/@id=$file-id][not(ancestor::xlf:unit[@id=$unit-id])]
                [ancestor::xlf:segment | ancestor::xlf:ignorable][not(@canDelete)])">
                'canDelete' attribute is not matching with the 'canDelete' attribute of the corresponding 'ec' element 
                (out of 'unit' with 'id=<iso:value-of select="$unit-id"/>').
            </iso:report>
            <iso:report diagnostics="fragid-report" see="&this-loc;/&name;-&stage;.html#sc"
                test="@canReorder='no' and not(following::xlf:ec[@id=$id][ancestor::xlf:target][ancestor::xlf:file/@id=$file-id][not(ancestor::xlf:unit[@id=$unit-id])]
                [ancestor::xlf:segment | ancestor::xlf:ignorable][@canReorder='no'])">
                'canReorder' attribute is not matching with the 'canReorder' attribute of the corresponding 'ec' element 
                (out of 'unit' with 'id=<iso:value-of select="$unit-id"/>').
            </iso:report>
            <iso:report diagnostics="fragid-report" see="&this-loc;/&name;-&stage;.html#sc"
                test="(@canReorder='yes' or not(@canReorder)) and 
                not(following::xlf:ec[@id=$id][ancestor::xlf:target][ancestor::xlf:file/@id=$file-id][not(ancestor::xlf:unit[@id=$unit-id])]
                [ancestor::xlf:segment | ancestor::xlf:ignorable][@canReorder='yes']) and
                not(following::xlf:ec[@id=$id][ancestor::xlf:target][ancestor::xlf:file/@id=$file-id][not(ancestor::xlf:unit[@id=$unit-id])]
                [ancestor::xlf:segment | ancestor::xlf:ignorable][not(@canReorder)])">
                'canReorder' attribute is not matching with the 'canReorder' attribute of the corresponding 'ec' element 
                (out of 'unit' with 'id=<iso:value-of select="$unit-id"/>').
            </iso:report>
            <iso:report diagnostics="fragid-report" see="&this-loc;/&name;-&stage;.html#sc"
                test="@canOverlap='no' and not(following::xlf:ec[@id=$id][ancestor::xlf:target][ancestor::xlf:file/@id=$file-id][not(ancestor::xlf:unit[@id=$unit-id])]
                [ancestor::xlf:segment | ancestor::xlf:ignorable][@canOverlap='no'])">
                'canOverlap' attribute is not matching with the 'canOverlap' attribute of the corresponding 'ec' element 
                (out of 'unit' with 'id=<iso:value-of select="$unit-id"/>').
            </iso:report>
            <iso:report diagnostics="fragid-report" see="&this-loc;/&name;-&stage;.html#sc"
                test="(@canOverlap='yes' or not(@canOverlap)) and 
                not(following::xlf:ec[@id=$id][ancestor::xlf:source][ancestor::xlf:file/@id=$file-id][not(ancestor::xlf:unit[@id=$unit-id])]
                [ancestor::xlf:segment | ancestor::xlf:ignorable][@canOverlap='yes']) and
                not(following::xlf:ec[@id=$id][ancestor::xlf:source][ancestor::xlf:file/@id=$file-id][not(ancestor::xlf:unit[@id=$unit-id])]
                [ancestor::xlf:segment | ancestor::xlf:ignorable][not(@canOverlap)])">
                'canOverlap' attribute is not matching with the 'canOverlap' attribute of the corresponding 'ec' element 
                (out of 'unit' with 'id=<iso:value-of select="$unit-id"/>').
            </iso:report>
            <iso:report diagnostics="fragid-report" see="&this-loc;/&name;-&stage;.html#ec"
                test="@canReorder='firstNo' and not(following::xlf:ec[@id=$id][ancestor::xlf:target][ancestor::xlf:file/@id=$file-id]
                [not(ancestor::xlf:unit[@id=$unit-id])][ancestor::xlf:segment | ancestor::xlf:ignorable][@canReorder='no'])">
                'canReorder' is set to 'firstNo', but the corresponding 'ec' (out of 'unit' with 'id=<iso:value-of select="$unit-id"/>')
                has not set its 'canReorder' attribute to 'no'.
            </iso:report>
        </iso:rule>
    </iso:pattern>
    <iso:pattern id="F5.1S">
        <iso:title>The attribute isolated must be set to yes if and only if the 'ec' element corresponding to this
            start marker is not in the same 'unit', and set to no otherwise</iso:title>
        <iso:p>This rule selects those 'sc' with 'isolated' attribute set to 'no' (or missing) and appear in 'source'. 
            An error will be raised if
            a) there is not one and only one 'ec' element in the same 'unit', in a 'source', which appears after the 'sc' 
            and corresponds to this 'sc' by 'startRef';
            b) the values of 'canCopy', 'canDelete', 'canReorder' or 'canOverlap' attributes are not matching with the 
            corresponding ec;
            c) the value of 'canReorder' is set to 'firstNo', but is not 'no' in the corresponding 'ec'</iso:p>
        <iso:rule context="xlf:sc[ancestor::xlf:source][ancestor::xlf:segment | ancestor::xlf:ignorable][@isolated='no'] | 
            xlf:sc[ancestor::xlf:source][ancestor::xlf:segment | ancestor::xlf:ignorable][not(@isolated)]">
            <iso:let name="id" value="current()/@id"/>
            <iso:let name="file-id" value="ancestor::xlf:file/@id"/>
            <iso:let name="unit-id" value="ancestor::xlf:unit/@id"/>
            <iso:let name="fragid" value="concat('f=', $file-id, '/u=', $unit-id, '/', $id)"/>
            <iso:assert diagnostics="fragid-report" see="&this-loc;/&name;-&stage;.html#isolated"
                test="count(following::xlf:ec[@startRef=$id][ancestor::xlf:source]
                [ancestor::xlf:unit[@id=$unit-id]][ancestor::xlf:file[@id=$file-id]])=1">
                'isolated' attribute is set to 'not', but the corresponding 'ec' element within the same 'unit' was not found. 
                The end code must appear after the start code.
            </iso:assert>
            <iso:report diagnostics="fragid-report" see="&this-loc;/&name;-&stage;.html#sc"
                test="@canCopy='no' and not(following::xlf:ec[@startRef=$id][ancestor::xlf:source]
                [ancestor::xlf:unit/@id=$unit-id][ancestor::xlf:file/@id=$file-id][@canCopy='no'])">
                'canCopy' attribute is not matching with the 'canCopy' attribute of the corresponding 'ec' element within the same 'unit'.
            </iso:report>
            <iso:report diagnostics="fragid-report" see="&this-loc;/&name;-&stage;.html#sc"
                test="(@canCopy='yes' or not(@canCopy)) and not(following::xlf:ec[@startRef=$id][ancestor::xlf:source]
                [ancestor::xlf:unit/@id=$unit-id][ancestor::xlf:file/@id=$file-id][@canCopy='yes']) and 
                not(following::xlf:ec[@startRef=$id][ancestor::xlf:source][ancestor::xlf:unit/@id=$unit-id]
                [ancestor::xlf:file/@id=$file-id][not(@canCopy)])">
                'canCopy' attribute is not matching with the 'canCopy' attribute of the corresponding 'ec' element within the same 'unit'.
            </iso:report>
            <iso:report diagnostics="fragid-report" see="&this-loc;/&name;-&stage;.html#sc"
                test="@canDelete='no' and not(following::xlf:ec[@startRef=$id][ancestor::xlf:source]
                [ancestor::xlf:unit/@id=$unit-id][ancestor::xlf:file/@id=$file-id][@canDelete='no'])">
                'canDelete' attribute is not matching with the 'canDelete' attribute of the corresponding 'ec' element within the same 'unit'.
            </iso:report>
            <iso:report diagnostics="fragid-report" see="&this-loc;/&name;-&stage;.html#sc"
                test="(@canDelete='yes' or not(@canDelete)) and not(following::xlf:ec[@startRef=$id]
                [ancestor::xlf:source][ancestor::xlf:unit/@id=$unit-id][ancestor::xlf:file/@id=$file-id][@canDelete='yes']) and 
                not(following::xlf:ec[@startRef=$id][ancestor::xlf:source][ancestor::xlf:unit/@id=$unit-id]
                [ancestor::xlf:file/@id=$file-id][not(@canDelete)])">
                'canDelete' attribute is not matching with the 'canDelete' attribute of the corresponding 'ec' element within the same 'unit'.
            </iso:report>
            <iso:report diagnostics="fragid-report" see="&this-loc;/&name;-&stage;.html#sc"
                test="@canReorder='no' and not(following::xlf:ec[@startRef=$id][ancestor::xlf:source]
                [ancestor::xlf:unit/@id=$unit-id][ancestor::xlf:file/@id=$file-id][@canReorder='no'])">
                'canReorder' attribute is not matching with the 'canReorder' attribute of the corresponding 'ec' element within the same 'unit'.
            </iso:report>
            <iso:report diagnostics="fragid-report" see="&this-loc;/&name;-&stage;.html#sc"
                test="(@canReorder='yes' or not(@canReorder)) and not(following::xlf:ec[@startRef=$id]
                [ancestor::xlf:source][ancestor::xlf:unit/@id=$unit-id][ancestor::xlf:file/@id=$file-id][@canReorder='yes']) and 
                not(following::xlf:ec[@startRef=$id][ancestor::xlf:source][ancestor::xlf:unit/@id=$unit-id]
                [ancestor::xlf:file/@id=$file-id][not(@canReorder)])">
                'canReorder' attribute is not matching with the 'canReorder' attribute of the corresponding 'ec' element within the same 'unit'.
            </iso:report>
            <iso:report diagnostics="fragid-report" see="&this-loc;/&name;-&stage;.html#sc"
                test="@canOverlap='no' and not(following::xlf:ec[@startRef=$id][ancestor::xlf:source]
                [ancestor::xlf:unit/@id=$unit-id][ancestor::xlf:file/@id=$file-id][@canOverlap='no'])">
                'canOverlap' attribute is not matching with the 'canOverlap' attribute of the corresponding 'ec' element within the same 'unit'.
            </iso:report>
            <iso:report diagnostics="fragid-report" see="&this-loc;/&name;-&stage;.html#sc"
                test="(@canOverlap='yes' or not(@canOverlap)) and not(following::xlf:ec[@startRef=$id]
                [ancestor::xlf:source][ancestor::xlf:unit/@id=$unit-id][ancestor::xlf:file/@id=$file-id][@canOverlap='yes']) and 
                not(following::xlf:ec[@startRef=$id][ancestor::xlf:source][ancestor::xlf:unit/@id=$unit-id]
                [ancestor::xlf:file/@id=$file-id][not(@canOverlap)])">
                'canOverlap' attribute is not matching with the 'canOverlap' attribute of the corresponding 'ec' element within the same 'unit'.
            </iso:report>
            <iso:report diagnostics="fragid-report" see="&this-loc;/&name;-&stage;.html#ec"
                test="@canReorder='firstNo' and not(following::xlf:ec[@startRef=$id][ancestor::xlf:source][ancestor::xlf:unit/@id=$unit-id]
                [ancestor::xlf:file/@id=$file-id][@canReorder='no'])">
                'canReorder' is set to 'firstNo', but the corresponding 'ec', within the same 'unit'
                has not set its 'canReorder' attribute to 'no'.
            </iso:report>
        </iso:rule>
    </iso:pattern>
    <iso:pattern id="F5.1T">
        <iso:title>The attribute isolated must be set to yes if and only if the 'ec' element corresponding to this
            start marker is not in the same 'unit', and set to no otherwise</iso:title>
        <iso:p>This rule selects those 'sc' with 'isolated' attribute set to 'no' (or missing) and appear in 'target'. 
            An error will be raised if
            a) there is not one and only one 'ec' element in the same 'unit', in a 'target', which appears after the 'sc' 
            and corresponds to this 'sc' by 'startRef';
            b) the values of 'canCopy', 'canDelete', 'canReorder' or 'canOverlap' attributes are not matching with the 
            corresponding ec;
            c) the value of 'canReorder' is set to 'firstNo', but is not 'no' in the corresponding 'ec'</iso:p>
        <iso:rule context="xlf:sc[ancestor::xlf:target][ancestor::xlf:segment | ancestor::xlf:ignorable][@isolated='no'] | 
            xlf:sc[ancestor::xlf:target][ancestor::xlf:segment | ancestor::xlf:ignorable][not(@isolated)]">
            <iso:let name="id" value="current()/@id"/>
            <iso:let name="file-id" value="ancestor::xlf:file/@id"/>
            <iso:let name="unit-id" value="ancestor::xlf:unit/@id"/>
            <iso:let name="fragid" value="concat('f=', $file-id, '/u=', $unit-id, '/t=', $id)"/>
            <iso:assert diagnostics="fragid-report" see="&this-loc;/&name;-&stage;.html#isolated"
                test="count(following::xlf:ec[@startRef=$id][ancestor::xlf:target]
                [ancestor::xlf:unit[@id=$unit-id]][ancestor::xlf:file[@id=$file-id]])=1">
                'isolated' attribute is set to 'not', but the corresponding 'ec' element within the same 'unit' was not found.
                The end code must appear after the start code.
            </iso:assert>
            <iso:report diagnostics="fragid-report" see="&this-loc;/&name;-&stage;.html#sc"
                test="@canCopy='no' and not(following::xlf:ec[@startRef=$id][ancestor::xlf:target]
                [ancestor::xlf:unit/@id=$unit-id][ancestor::xlf:file/@id=$file-id][@canCopy='no'])">
                'canCopy' attribute is not matching with the 'canCopy' attribute of the corresponding 'ec' element within the same 'unit'.
            </iso:report>
            <iso:report diagnostics="fragid-report" see="&this-loc;/&name;-&stage;.html#sc"
                test="(@canCopy='yes' or not(@canCopy)) and not(following::xlf:ec[@startRef=$id]
                [ancestor::xlf:target][ancestor::xlf:unit/@id=$unit-id][ancestor::xlf:file/@id=$file-id][@canCopy='yes']) and 
                not(following::xlf:ec[@startRef=$id][ancestor::xlf:target][ancestor::xlf:unit/@id=$unit-id]
                [ancestor::xlf:file/@id=$file-id][not(@canCopy)])">
                'canCopy' attribute is not matching with the 'canCopy' attribute of the corresponding 'ec' element within the same 'unit'.
            </iso:report>
            <iso:report diagnostics="fragid-report" see="&this-loc;/&name;-&stage;.html#sc"
                test="@canDelete='no' and not(following::xlf:ec[@startRef=$id][ancestor::xlf:target]
                [ancestor::xlf:unit/@id=$unit-id][ancestor::xlf:file/@id=$file-id][@canDelete='no'])">
                'canDelete' attribute is not matching with the 'canDelete' attribute of the corresponding 'ec' element within the same 'unit'.
            </iso:report>
            <iso:report diagnostics="fragid-report" see="&this-loc;/&name;-&stage;.html#sc"
                test="(@canDelete='yes' or not(@canDelete)) and not(following::xlf:ec[@startRef=$id]
                [ancestor::xlf:target][ancestor::xlf:unit/@id=$unit-id][ancestor::xlf:file/@id=$file-id][@canDelete='yes']) and 
                not(following::xlf:ec[@startRef=$id][ancestor::xlf:target][ancestor::xlf:unit/@id=$unit-id]
                [ancestor::xlf:file/@id=$file-id][not(@canDelete)])">
                The 'canDelete' attribute is not matching with the 'canDelete' attribute of the corresponding 'ec' element within the same 'unit'.
            </iso:report>
            <iso:report diagnostics="fragid-report" see="&this-loc;/&name;-&stage;.html#sc"
                test="@canReorder='no' and not(following::xlf:ec[@startRef=$id][ancestor::xlf:target]
                [ancestor::xlf:unit/@id=$unit-id][ancestor::xlf:file/@id=$file-id][@canReorder='no'])">
                'canReorder' attribute is not matching with the 'canReorder' attribute of the corresponding 'ec' element within the same 'unit'.
            </iso:report>
            <iso:report diagnostics="fragid-report" see="&this-loc;/&name;-&stage;.html#sc"
                test="(@canReorder='yes' or not(@canReorder)) and not(following::xlf:ec[@startRef=$id]
                [ancestor::xlf:target][ancestor::xlf:unit/@id=$unit-id][ancestor::xlf:file/@id=$file-id][@canReorder='yes']) and 
                not(following::xlf:ec[@startRef=$id][ancestor::xlf:target][ancestor::xlf:unit/@id=$unit-id]
                [ancestor::xlf:file/@id=$file-id][not(@canReorder)])">
                'canReorder' attribute is not matching with the 'canReorder' attribute of the corresponding 'ec' element within the same 'unit'.
            </iso:report>
            <iso:report diagnostics="fragid-report" see="&this-loc;/&name;-&stage;.html#sc"
                test="@canOverlap='no' and not(following::xlf:ec[@startRef=$id][ancestor::xlf:target]
                [ancestor::xlf:unit/@id=$unit-id][ancestor::xlf:file/@id=$file-id][@canOverlap='no'])">
                'canOverlap' attribute is not matching with the 'canOverlap' attribute of the corresponding 'ec' element within the same 'unit'.
            </iso:report>
            <iso:report diagnostics="fragid-report" see="&this-loc;/&name;-&stage;.html#sc"
                test="(@canOverlap='yes' or not(@canOverlap)) and not(following::xlf:ec[@startRef=$id]
                [ancestor::xlf:target][ancestor::xlf:unit/@id=$unit-id][ancestor::xlf:file/@id=$file-id][@canOverlap='yes']) and 
                not(following::xlf:ec[@startRef=$id][ancestor::xlf:target][ancestor::xlf:unit/@id=$unit-id]
                [ancestor::xlf:file/@id=$file-id][not(@canOverlap)])">
                The 'canOverlap' attribute is not matching with the 'canOverlap' attribute of the corresponding 'ec' element within the same 'unit'.
            </iso:report>
            <iso:report diagnostics="fragid-report" see="&this-loc;/&name;-&stage;.html#ec"
                test="@canReorder='firstNo' and not(following::xlf:ec[@startRef=$id][ancestor::xlf:target][ancestor::xlf:unit/@id=$unit-id]
                [ancestor::xlf:file/@id=$file-id][@canReorder='no'])">
                'canReorder' is set to 'firstNo', but the corresponding 'ec', within the same 'unit'
                has not set its 'canReorder' attribute to 'no'.
            </iso:report>
        </iso:rule>
    </iso:pattern>
    <iso:pattern id="F6S">
        <iso:title>The attribute isolated must be set to yes if and only if the 'sc' element corresponding to this
            end code [ec] is not in the same 'unit' and set to no otherwise</iso:title>
        <iso:p>This rule selects those 'ec' which are in 'source' and raises an error if
            a) 'id' and 'startRef' attributes are used illegally, based on the value of 'isolated': if 'yes',
            only 'id' must be used and if 'no' (or missing), only 'startRef' must be specified;
            b) 'isolated' is set to 'yes', but there is no 'sc' in the same 'file', in a different 'unit', in
            'source' and which appears before this end code;
            c)'isolated' is set to 'no', but there is no 'sc' in the same 'unit', in a 'source' and which
            appears before this end code.
        </iso:p>
        <iso:rule context="xlf:ec[ancestor::xlf:source][ancestor::xlf:segment | ancestor::xlf:ignorable]">
            <iso:let name="file-id" value="ancestor::xlf:file/@id"/>
            <iso:let name="unit-id" value="ancestor::xlf:unit/@id"/>
            <iso:let name="fragid" value="concat('f=', $file-id, '/u=', $unit-id)"/>
            <iso:assert diagnostics="fragid-report" see="&this-loc;/&name;-&stage;.html#ec"
                test="(@isolated='yes' and @id and not(@startRef)) or 
                ((@isolated='no' or not(@isolated)) and @startRef and not(@id))">
                Illegal use of 'id' and 'startRef' atribute. If 'isolated' is set to 'yes', only 'id' must be 
                used and if set to 'no' (or missing), only 'startRef' must be specified
            </iso:assert>
            <iso:report diagnostics="fragid-report" see="&this-loc;/&name;-&stage;.html#ec"
                test="(@isolated='yes' and not(preceding::xlf:sc[@id=current()/@id][@isolated='yes'][ancestor::xlf:source]
                [ancestor::xlf:segment | ancestor::xlf:ignorable][ancestor::xlf:file/@id=$file-id]
                [not(ancestor::xlf:unit/@id=$unit-id)]))">
                'isolated' attribute is set to 'yes', but the corresponding 'sc' element, out of the 'unit' with 
                'id=<iso:value-of select="$unit-id"/>', was not found. The start code must appear before the end code, but in the
                same 'file'.
            </iso:report>
            <iso:report diagnostics="fragid-report" see="&this-loc;/&name;-&stage;.html#ec"
                test="(@isolated='no' or not(@isolated)) and count(preceding::xlf:sc[@id=current()/@startRef][ancestor::xlf:source]
                [ancestor::xlf:file/@id=$file-id][ancestor::xlf:unit/@id=$unit-id][not(@isolated='yes')])!=1">
                'isolated' attribute is set to 'not', but the corresponding 'sc' element within the same 'unit' was not found. 
                The start code must appear befor the end code.
            </iso:report>
        </iso:rule>
    </iso:pattern>
    <iso:pattern id="F6T">
        <iso:title>The attribute isolated must be set to yes if and only if the 'sc' element corresponding to this
            end code [ec] is not in the same 'unit' and set to no otherwise</iso:title>
        <iso:p>This rule selects those 'ec' which are in 'target' and raises an error if
            a) 'id' and 'startRef' attributes are used illegally, based on the value of 'isolated': if 'yes',
            only 'id' must be used and if 'no' (or missing), only 'startRef' must be specified;
            b) 'isolated' is set to 'yes', but there is no 'sc' in the same 'file', in a different 'unit', in
            'target' and which appears before this end code;
            c)'isolated' is set to 'no' (or missing), but there is no 'sc' in the same 'unit', in a 'target' and which
            appears before this end code.
            d) 'isolate' is set to 'no' (or missing) and 'dir' attribute is used. 
        </iso:p>
        <iso:rule context="xlf:ec[ancestor::xlf:target][ancestor::xlf:segment | ancestor::xlf:ignorable]">
            <iso:let name="file-id" value="ancestor::xlf:file/@id"/>
            <iso:let name="unit-id" value="ancestor::xlf:unit/@id"/>
            <iso:let name="fragid" value="concat('f=', $file-id, '/u=', $unit-id)"/>
            <iso:assert diagnostics="fragid-report" see="&this-loc;/&name;-&stage;.html#ec"
                test="(@isolated='yes' and @id and not(@startRef)) or 
                ((@isolated='no' or not(@isolated)) and @startRef and not(@id))">
                Illegal use of 'id' and 'startRef' atribute. If 'isolated' is set to 'yes', only 'id' must be 
                used and if set to 'no' (or missing), only 'startRef' must be specified
            </iso:assert>
            <iso:report diagnostics="fragid-report" see="&this-loc;/&name;-&stage;.html#ec"
                test="(@isolated='yes' and not(preceding::xlf:sc[@id=current()/@id][@isolated='yes'][ancestor::xlf:target]
                [ancestor::xlf:segment | ancestor::xlf:ignorable][ancestor::xlf:file/@id=$file-id]
                [not(ancestor::xlf:unit/@id=$unit-id)]))">
                'isolated' attribute is set to 'yes', but the corresponding 'sc' element, out of the 'unit' with 
                'id=<iso:value-of select="$unit-id"/>', was not found. The start code must appear before the end code, but in the
                same 'file'.
            </iso:report>
            <iso:report diagnostics="fragid-report" see="&this-loc;/&name;-&stage;.html#ec"
                test="(@isolated='no' or not(@isolated)) and count(preceding::xlf:sc[@id=current()/@startRef][ancestor::xlf:target]
                [ancestor::xlf:file/@id=$file-id][ancestor::xlf:unit/@id=$unit-id][not(@isolated='yes')])!=1">
                'isolated' attribute is set to 'not', but the corresponding 'sc' element within the same 'unit' was not found. 
                The start code must appear befor the end code.
            </iso:report>
            <iso:report diagnostics="fragid-report" see="&this-loc;/&name;-&stage;.html#ec"
                test="(@isolated='no' or not(@isolated)) and @dir">
                'dir' attribute is not allowed when 'ec' is not isolated ('isolated' is set to 'no' or missing).
            </iso:report>
        </iso:rule>
    </iso:pattern>
    <iso:pattern id="F7">
        <iso:title>If the attribute subState is used, the attribute state must be explicitly set</iso:title>
        <iso:rule context="xlf:segment[@subState]" >
            <iso:let name="fragid" value="concat('f=',ancestor::xlf:file/@id, '/u=',ancestor::xlf:unit/@id)"/>
            <iso:assert diagnostics="fragid-report" see="&this-loc;/&name;-&stage;.html#substate"
                test="@state" >
                'segment' element specifies 'subState' attribute, but missing the 'state' attribute.
            </iso:assert>
        </iso:rule>
    </iso:pattern>
    <iso:pattern id="F8">
        <iso:title>If the attribute 'subType' is used, the attribute 'type' must be specified as well</iso:title>
        <iso:p>This rule select inline elements, which specify 'subType'. It also checks the value of 'subType'.</iso:p>
        <iso:rule context="xlf:*[@subType]">
            <iso:let name="fragid" value="concat('f=',ancestor::xlf:file/@id,'/u=',ancestor::xlf:unit/@id)"/>
            <iso:assert diagnostics="fragid-report" see="&this-loc;/&name;-&stage;.html#subtype"
                test="@type">
                '<iso:name/>' element specifies 'subType' attribute, but missing the 'type' attribute.
            </iso:assert>
            <iso:assert diagnostics="fragid-report" see="&this-loc;/&name;-&stage;.html#subtype"
                test="((@subType='xlf:i' or @subType='xlf:u' or @subType='xlf:lb' or @subType='xlf:pb' or @subType='xlf:b')and( @type='fmt')) or
                (@subType='xlf:var' and @type='ui') or not(starts-with(@subType,'xlf:'))">
                'type' and 'subType' attributes don't match. Value of 'type' must either be set to a user-defined value, 
                or to 'ui' when 'subType=xlf:var', or to 'fmt' for following values of 'subType':'xlf:i','xlf:u','xlf:lb' and 'xlf:pb'.
            </iso:assert>
        </iso:rule>
    </iso:pattern>
    <iso:pattern id="F9">
        <iso:title>The copyOf attribute must be used when, and only when, the base code has no associated original data</iso:title>
        <iso:rule context="xlf:*[@copyOf]">
            <iso:let name="fragid" value="concat('f=',ancestor::xlf:file/@id,'/u=',ancestor::xlf:unit/@id)"/>
            <iso:report diagnostics="fragid-report" see="&this-loc;/&name;-&stage;.html#duplicatingexistingcode"
                test="name()='pc' and (@dataRefStart or @dataRefEnd)">
                'pc' cannot use 'copyOf' attribute while referring to the original data through 'dataRefStart/dataRefEnd' attributes.
            </iso:report>
            <iso:report diagnostics="fragid-report" see="&this-loc;/&name;-&stage;.html#duplicatingexistingcode"
                test="name()!='pc' and @dataRef">
                '<iso:name/>' cannot use 'copyOf' attribute while referring to the original data through 'dataRef' attribute.
            </iso:report>
        </iso:rule>
    </iso:pattern>
    <iso:pattern id="F10">
        <iso:title>When the attribute canReorder is set to no or firstNo, the attributes canCopy and canDelete must also be set to no</iso:title>
        <iso:rule context="xlf:*[@canReorder='no'] | xlf:*[@canReorder='firstNo']">
            <iso:let name="fragid" value="concat('f=',ancestor::xlf:file/@id,'/u=',ancestor::xlf:unit/@id)"/>
            <iso:assert diagnostics="fragid-report" see="&this-loc;/&name;-&stage;.html#editinghints"
                test="@canDelete='no' and @canCopy='no'">
                '<iso:name/>' element has set its 'canReorder' attribute is set to '<iso:value-of select="@canReorder"/>', but 'canDelete' and 
                'canCopy' attributes are not set to 'no'.
            </iso:assert>
        </iso:rule>
    </iso:pattern>
    <iso:pattern id="F11S">
        <iso:title>Translate Annotation</iso:title>
        <iso:rule context="xlf:sm[@type='generic'][ancestor::xlf:source] | xlf:sm[not(@type)][ancestor::xlf:source] |
            xlf:mrk[@type='generic'][ancestor::xlf:source] | xlf:mrk[not(@type)][ancestor::xlf:source]">
            <iso:let name="fragid" value="concat('f=',ancestor::xlf:file/@id,'/u=',ancestor::xlf:unit/@id,'/',current()/@id)"/>
            <iso:assert diagnostics="fragid-report" see="&this-loc;/&name;-&stage;.html#translateAnnotation"
                test="@translate">
                '<iso:name/>' element is being used for translate annotaition, but missing the 'translate' attribute.
            </iso:assert>
        </iso:rule>
    </iso:pattern>
    <iso:pattern id="F11T">
        <iso:title>Translate Annotation</iso:title>
        <iso:rule context="xlf:sm[@type='generic'][ancestor::xlf:target]|xlf:sm[not(@type)][ancestor::xlf:target]|
            xlf:mrk[@type='generic'][ancestor::xlf:target] | xlf:mrk[not(@type)][ancestor::xlf:target]">
            <iso:let name="fragid" value="concat('f=',ancestor::xlf:file/@id,'/u=',ancestor::xlf:unit/@id,'/t=',current()/@id)"/>
            <iso:assert diagnostics="fragid-report" see="&this-loc;/&name;-&stage;.html#translateAnnotation"
                test="@translate">
                '<iso:name/>' element is being used for translate annotaition, but missing the 'translate' attribute.
            </iso:assert>
        </iso:rule>
    </iso:pattern>
    <iso:pattern id="F12S">
        <iso:title>Comment Annotation</iso:title>
        <iso:rule context="xlf:sm[@type='comment'][ancestor::xlf:source]|xlf:mrk[@type='comment'][ancestor::xlf:source]">
            <iso:let name="fragid" value="concat('f', ancestor::xlf:file/@id,'/u=',ancestor::xlf:unit/@id,'/',current()/@id)"/>
            <iso:assert diagnostics="fragid-report" see="&this-loc;/&name;-&stage;.html#commentAnnotation"
                test="(@value and not(@ref))or(@ref and not(@value))" >
                '<iso:name/>' element cannot contain both 'value' and 'ref' attributes simultaneously when used for comment annotation.
            </iso:assert>
        </iso:rule>
    </iso:pattern>
    <iso:pattern id="F12T">
        <iso:title>Comment Annotation</iso:title>
        <iso:rule context="xlf:sm[@type='comment'][ancestor::xlf:target]|xlf:mrk[@type='comment'][ancestor::xlf:target]">
            <iso:let name="fragid" value="concat('f=',ancestor::xlf:file/@id,'/u=',ancestor::xlf:unit/@id,'/t=',current()/@id)"/>
            <iso:assert diagnostics="fragid-report" see="&this-loc;/&name;-&stage;.html#commentAnnotation"
                test="(@value and not(@ref))or(@ref and not(@value))">
                '<iso:name/>' element cannot contain both 'value' and 'ref' attributes simultaneously when used for comment annotation.
            </iso:assert>
        </iso:rule>
    </iso:pattern>
    <iso:pattern id="F13S">
        <iso:title>ref attribute in Comment Annotation</iso:title>
        <iso:rule context="xlf:sm[@type='comment'][@ref][ancestor::xlf:source]|xlf:mrk[@type='comment'][@ref][ancestor::xlf:source]">
            <iso:let name="ref" value="@ref"/>
            <iso:let name="fragid" value="concat('f=',ancestor::xlf:file/@id,'/u=',ancestor::xlf:unit/@id,'/',current()/@id)"/>
            <iso:assert diagnostics="fragid-report" see="&this-loc;/&name;-&stage;.html#commentAnnotation"
                test="(not(contains($ref,'#')) and count(ancestor::xlf:unit//xlf:note[@id=$ref])=1) or
                (contains($ref,'#') and not(contains($ref,'=')) and count(ancestor::xlf:unit//xlf:note[@id=substring-after($ref,'#')]))">
                'ref' attribute of '<iso:name/>' must point to a 'note' element within the same unit.
            </iso:assert>
        </iso:rule>
    </iso:pattern>
    <iso:pattern id="FD13T">
        <iso:title>ref attribute in Comment Annotation</iso:title>
        <iso:rule context="xlf:sm[@type='comment'][@ref][ancestor::xlf:target]|xlf:mrk[@type='comment'][@ref][ancestor::xlf:target]">
            <iso:let name="ref" value="@ref"/>
            <iso:let name="fragid" value="concat('f=',ancestor::xlf:file/@id,'/u=',ancestor::xlf:unit/@id,'/t=',current()/@id)"/>
            <iso:assert diagnostics="fragid-report" see="&this-loc;/&name;-&stage;.html#commentAnnotation"
                test="(not(contains($ref,'#')) and count(ancestor::xlf:unit//xlf:note[@id=$ref])=1) or
                (contains($ref,'#') and not(contains($ref,'=')) and count(ancestor::xlf:unit//xlf:note[@id=substring-after($ref,'#')]))">
                'ref' attribute of '<iso:name/>' must point to a 'note' element within the same unit.
            </iso:assert>
        </iso:rule>
    </iso:pattern>
    <iso:pattern id="F14">
        <iso:title>The 'copyOf' attribute must point to a code within the same 'unit'</iso:title>
        <iso:rule context="xlf:*[@copyOf]">
            <iso:let name="fragid" value="concat(ancestor::xlf:file/@id,'/u=',ancestor::xlf:unit/@id)"/>
            <iso:assert diagnostics="fragid-report" see="&this-loc;/&name;-&stage;.html#duplicatingexistingcode"
                test="ancestor::xlf:unit//xlf:*[ancestor::xlf:source|ancestor::xlf:target][@id=current()/@copyOf]">
                No inline element with 'id=<iso:value-of select="current()/@copyOf"/>' found within the same 'unit'.
            </iso:assert>
        </iso:rule>
    </iso:pattern>
    <iso:pattern id="F15">
        <iso:title>dataRef attribute must point to a data element within the same unit</iso:title>
        <iso:rule context="xlf:*[@dataRef][ancestor::xlf:source]">
            <iso:let name="fragid" value="concat('f=', ancestor::xlf:file/@id,'/u=',ancestor::xlf:unit/@id)"/>
            <iso:assert diagnostics="fragid-report" see="&this-loc;/&name;-&stage;.html#dataref"
                test="ancestor::xlf:unit//xlf:data[@id=current()/@dataRef]">
                'dataRef' attribute must point to a 'data' element within the same 'unit'.
            </iso:assert>
        </iso:rule>
    </iso:pattern>
    <iso:pattern id="F16S">
        <iso:title>dataRefEnd attribute must point to a data element within the same unit</iso:title>
        <iso:rule context="xlf:pc[@dataRefEnd][ancestor::xlf:source]">
            <iso:let name="fragid" value="concat('f=', ancestor::xlf:file/@id,'/u=',ancestor::xlf:unit/@id,'/',current()/@id)"/>
            <iso:assert diagnostics="fragid-report" see="&this-loc;/&name;-&stage;.html#datarefend"
                test="ancestor::xlf:unit//xlf:data[@id=current()/@dataRefEnd]">
                'dataRefEnd' attribute must point to a 'data' element within the same 'unit'.
            </iso:assert>
        </iso:rule>
    </iso:pattern>
    <iso:pattern id="F16T">
        <iso:title>dataRefEnd attribute must point to a data element within the same unit</iso:title>
        <iso:rule context="xlf:pc[@dataRefEnd][ancestor::xlf:target]" see="&this-loc;/&name;-&stage;.html#datarefend">
            <iso:let name="fragid" value="concat('f=',ancestor::xlf:file/@id,'/u=',ancestor::xlf:unit/@id,'/t=',current()/@id)"/>
            <iso:assert diagnostics="fragid-report" see="&this-loc;/&name;-&stage;.html#datarefend"
                test="ancestor::xlf:unit//xlf:data[@id=current()/@dataRefEnd]">
                'dataRefEnd' attribute must point to a 'data' element within the same 'unit'.
            </iso:assert>
        </iso:rule>
    </iso:pattern>
    <iso:pattern id="F17S">
        <iso:title>dataRefStart attribute must point to a data element within the same unit</iso:title>
        <iso:rule context="xlf:pc[@dataRefStart][ancestor::xlf:source]">
            <iso:let name="fragid" value="concat('f=',ancestor::xlf:file/@id,'/u=',ancestor::xlf:unit/@id,'/',current()/@id)"/>
            <iso:assert diagnostics="fragid-report" see="&this-loc;/&name;-&stage;.html#datarefstart"
                test="ancestor::xlf:unit//xlf:data[@id=current()/@dataRefStart]">
                'dataRefStart' attribute must point to a 'data' element within the same 'unit'.
            </iso:assert>
        </iso:rule>
    </iso:pattern>
    <iso:pattern id="F17T">
        <iso:title>dataRefStart attribute must point to a data element within the same unit</iso:title>
        <iso:rule context="xlf:*[@dataRefStart][ancestor::xlf:target]">
            <iso:let name="fragid" value="concat('f=',ancestor::xlf:file/@id,'/u=',ancestor::xlf:unit/@id,'/t=',current()/@id)"/>
            <iso:assert diagnostics="fragid-report" see="&this-loc;/&name;-&stage;.html#datarefstart"
                test="ancestor::xlf:unit//xlf:data[@id=current()/@dataRefStart]">
                'dataRefStart' attribute must point to a 'data' element within the same 'unit'.
            </iso:assert>
        </iso:rule>
    </iso:pattern>
    <iso:pattern id="F18">
        <iso:title>Its value [order attribute] is an integer from 1 to N, where N is the sum of the numbers of the &lt;segment&gt; 
            and &lt;ignorable&gt; elements within the given enclosing &lt;unit&gt; element</iso:title>
        <iso:rule context="xlf:unit">
            <iso:let name="maxOrder" value="count(xlf:segment|xlf:ignorable)"/>
            <iso:let name="fragid" value="concat('f=',ancestor::xlf:file/@id,'/u=',current()/@id)"/>
            <iso:report diagnostics="fragid-report" see="&this-loc;/&name;-&stage;.html#segorder"
                test=".//xlf:target[@order>$maxOrder][ancestor::xlf:segment|ancestor::xlf:ignorable]">
                Invalid value used for order attribute of &lt;target&gt; element(s). It must be an integer from 1 to <iso:value-of select="$maxOrder"/>.
            </iso:report>
        </iso:rule>
    </iso:pattern>
    <iso:pattern id="F19">
        <iso:title>To be able to map order differences, the &lt;target&gt; element has an optional order attribute that indicates its position in the sequence of segments (and inter-segments). Its value is an
            integer from 1 to N, where N is the sum of the numbers of the &lt;segment&gt; and &lt;ignorable&gt; elements within the given enclosing &lt;unit&gt; element.
            When Writers set explicit order on&lt;target&gt; elements, they have to check for conflicts with implicit order, as &lt;target&gt; elements without explicit
            order correspond to their sibling &lt;source&gt; elements</iso:title>
        <iso:rule context="xlf:target[@order]">
            <iso:let name="order" value="@order"/>
            <iso:let name="actual-pos" value="count(../preceding-sibling::xlf:segment| ../preceding-sibling::xlf:ignorable)+1"/>
            <iso:let name="fragid" value="concat('f=',ancestor::xlf:file/@id,'/u=',current()/@id)"/>
            <iso:assert diagnostics="fragid-report" see="&this-loc;/&name;-&stage;.html#segorder"
                test="ancestor::xlf:unit//xlf:target[@order=$actual-pos][ancestor::xlf:segment | ancestor::xlf:ignorable]"> 
                The corresponding 'target' element, 'order' attribute of which must be '<iso:value-of select="$actual-pos"/>', is missing within the enclosing 'unit'.
            </iso:assert>
        </iso:rule>
    </iso:pattern>
    <iso:pattern id="F20">
        <iso:title>Modifiers must not delete inline codes that have their attribute canDelete set to no</iso:title>
        <iso:rule context="xlf:source//xlf:*[@canDelete='no']">
            <iso:let name="id" value="current()/@id"/>
            <iso:let name="fragid" value="concat('f=', ancestor::xlf:file/@id,'/u=', ancestor::xlf:unit/@id,'/', $id)"/>
            <iso:report diagnostics="fragid-report" see="&this-loc;/&name;-&stage;.html#editinghints"
                test="not(ancestor::xlf:segment/xlf:target//xlf:*[@id=$id])">
                'canDelete' attribute is set to 'no', but the corresponding element is missing in the sibling target.
            </iso:report>
        </iso:rule>
    </iso:pattern>
    <iso:diagnostics>
        <iso:diagnostic id="fragid-report">#<iso:value-of select="$fragid"/></iso:diagnostic>
    </iso:diagnostics>
</iso:schema>