<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
    <sch:pattern>
        <sch:rule context="ol">
            <sch:assert test="count(li) > 1">A list should have more than 1 items.</sch:assert>
        </sch:rule>
        <sch:rule context="ul">
            <sch:assert test="count(li) > 1">A list should have more than 1 items.</sch:assert>
        </sch:rule>

        <sch:rule context="li">
            <sch:assert test="not(ends-with(normalize-space(.), ';'))" role="warn"> List items
                should not end with a semi-colon (;). If it is&#xA; a sentence then end it with a
                full stop (.), otherwise leave&#xA; it without an ending character. </sch:assert>
        </sch:rule>
    </sch:pattern>

    <!-- Report if link text same as @href value -->
    <sch:pattern>
        <sch:rule context="a">
            <sch:report test="@href = text()" role="information"> Link text is the same as the
                reference. The link text can be removed. </sch:report>
        </sch:rule>
    </sch:pattern>

    <!--
        Images.
    -->
    <sch:pattern>
        <sch:rule context="img">
            <sch:assert test="string-length(@src) > 0"> Image without a reference.</sch:assert>

            <sch:assert test="string-length(@alt) > 0" role="warn">It is recommended to specify an
                alternate text as well.</sch:assert>
        </sch:rule>
    </sch:pattern>



</sch:schema>
