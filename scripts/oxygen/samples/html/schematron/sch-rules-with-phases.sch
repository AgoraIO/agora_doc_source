<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
    
    <sch:ns uri="http://www.w3.org/1999/xhtml" prefix="html"/>
    
    <!-- The validation consists of two phases -->
    
    <!-- One phase for checking the <head> -->
    <sch:phase id="HeadChecking">
        <sch:active pattern="DocumentHeadCheck"/>
    </sch:phase>
    
    <!-- One phase for checking the <body> -->
    <sch:phase id="BodyChecking">
        <sch:active pattern="DocumentBodyCheck"/>
    </sch:phase>
    
    <sch:pattern id="DocumentHeadCheck">
        <sch:rule context="html:head">
            <!-- Check if the page has a title -->
            <sch:assert test="html:title">Page does not have a title.</sch:assert>
            
            <!-- Check if there is a link to the standard stylesheet to be used -->
            <sch:assert test="html:link/@rel = 'stylesheet'
                and html:link/@type = 'text/css'
                and html:link/@href = 'std.css'">
                Page does not use the standard stylesheet ('std.css').
            </sch:assert>
        </sch:rule>
        <sch:rule context="html:head/html:style">
            <!-- Further report for non linking to the standard stylesheet ('std.css') -->
            <sch:report test="true()">
                Style tag used instead of linking to the standard stylesheet ('std.css').
            </sch:report>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id="DocumentBodyCheck">
        <sch:rule context="html:body">
            <!-- Check for using the standard body class -->
            <sch:assert test="@class = 'std-body'">
                The standard body class should be used ('std-body').
            </sch:assert>
        </sch:rule>
        
        <sch:rule  context="html:body/html:*[1]">
            <!-- Check that the first component in <body> is the required one -->
            <sch:assert test="@class = 'std-top'">
                Page does not start with the required page top component ('std-top').
            </sch:assert>
        </sch:rule>
        
        <sch:rule context="html:div[@class='second-div']">
            <!-- Check if the 2nd <div> contains exactly 3 paragraphs -->
            <sch:let name="pno" value="count(html:p)"/>
            <sch:assert test="$pno eq 3">
                Exactly 3 paragraphs accepted in the 2nd 'div' of the 'body', but found <sch:value-of select="$pno"/>.
            </sch:assert>
        </sch:rule>
        
        <sch:rule context="html:div[@class='second-div']/html:p[1]">
            <!-- Check if the 1st paragraph in the 2nd <div> has less than 250 characters -->
            <sch:let name="firstParaLength" value="string-length()"/>
            <sch:assert test="$firstParaLength le 250" role="warning">
                The 1st paragraph should be limited to max. 250 characters (actual length: <sch:value-of select="$firstParaLength"/>).
            </sch:assert>
        </sch:rule>
    </sch:pattern>
</sch:schema>