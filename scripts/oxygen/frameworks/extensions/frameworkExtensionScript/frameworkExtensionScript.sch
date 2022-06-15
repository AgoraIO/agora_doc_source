<?xml version="1.0" encoding="UTF-8"?>
<!-- A few rules that should guide the user writing a configuration file for CC. -->
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
    <ns prefix="s" uri="http://www.oxygenxml.com/ns/framework/extend"/>
    <pattern>
        <rule context="s:script">
            <assert test="not(@base) or string-length(@base) > 0">The @base attribute must specify
                the name of the extended framework. Remove it if you want to create a framework from
                without extending an existing one.</assert>
        </rule>

        <rule context="s:name">
            <assert test="string-length(normalize-space(text())) > 0">The framework name is
                mandatory.</assert>
        </rule>

    </pattern>

    <pattern>
        <rule context="s:contentCompletion/s:authorActions/s:addAction">
            <assert test="@inCCWindow or @inElementsView or @inMenus">This action will not appear
                anywhere because neither of @inCCWindow, @inElementsView nor @inMenus is
                specified.</assert>
        </rule>
    </pattern>

    <pattern>
        <rule context="s:extensionPoints/s:extension">
            <let name="extPoint" value="@name"/>
            <assert role="warning"
                test="empty((preceding-sibling::s:extension[@name = $extPoint], following-sibling::s:extension[@name = $extPoint]))"
                >This "<value-of select="$extPoint"/>" extension point is specified multiple times. Only the first occurence will be used.</assert>
        </rule>
    </pattern>

</schema>
