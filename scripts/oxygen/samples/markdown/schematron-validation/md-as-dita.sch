<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    
    <sch:ns uri="http://www.oxygenxml.com/customFunction" prefix="oxyF"/>
    
    <!-- The topic titles should not be longer than 75 characters. -->
    <sch:pattern>
        <sch:rule context="*[contains(@class, ' topic/title ') 
            and not(contains(@class, ' bookmap/booktitle '))
            and not(parent::node()/contains(@class, ' topic/section '))
            and not(parent::node()/contains(@class, ' topic/fig '))
            and not(parent::node()/contains(@class, ' topic/table '))
            and not(parent::node()/contains(@class, ' topic/example '))]" role="warn">
            <sch:assert test="string-length(string(.)) lt 76">
                The title is too long (<sch:value-of select="string-length(string(.))"/> chars).
                It should be less than 75 characters.</sch:assert>
        </sch:rule>
    </sch:pattern>

    <sch:pattern>
        <!-- Report cases when the lines in a codeblock exceeds 90 characters -->
        <sch:rule context="*[contains(@class, ' pr-d/codeblock ') and not(@outputclass='language-css') and not(@outputclass='language-bourne')]" role="warn">
            <sch:let name="offendingLines" value="oxyF:lineLengthCheck(string(), 70)"/>
            <sch:report test="string-length($offendingLines) > 0">Lines in codeblocks should not exceed 70 characters.</sch:report>
        </sch:rule>
    </sch:pattern>

    <!-- Template that breaks a text into its composing lines of text -->
    <xsl:function name="oxyF:lineLengthCheck" as="xs:string">
        <xsl:param name="textToBeChecked" as="xs:string"/>
        <xsl:param name="maxLength" as="xs:integer"/>
        <xsl:value-of>
            <xsl:for-each select="tokenize($textToBeChecked, '\n')">
                <xsl:if test="string-length(current()) > $maxLength">
                    <xsl:value-of select="concat(position(), ' - ', string-length(current()), ', ') "/>
                </xsl:if>
            </xsl:for-each>
        </xsl:value-of>
    </xsl:function>
</sch:schema>