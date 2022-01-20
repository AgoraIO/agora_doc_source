<?xml version="1.0" encoding="UTF-8"?>
<!--
    Copyright 2011 Jarno Elovirta
    
    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at
    
    http://www.apache.org/licenses/LICENSE-2.0
    
    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
    
    Modified 05 Jul 2011 by Syncrosoft to add a pattern for checking unique element IDs.
-->
<schema xmlns="http://purl.oclc.org/dsdl/schematron" 
    queryBinding="xslt2" xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <title>Schematron schema for DITA 1.2</title>
    <p>Version 3.0.0 released 2010-10-17.</p>
    <ns uri="http://dita.oasis-open.org/architecture/2005/" prefix="ditaarch"/>
    <!-- Topic ID must be equal to file name -->
    <pattern id="checkTopicId">
        <rule context="/*[1][contains(@class, ' topic/topic ')]">
            <let name="reqId" value="replace(tokenize(document-uri(/), '/')[last()], '.dita', '')"/>
            <assert test="@id = $reqId" sqf:fix="setId">
                Topic ID must be equal to file name.
            </assert>
            <sqf:fix id="setId">
                <sqf:description>
                    <sqf:title>Set "<value-of select="$reqId"/>" as a topic ID</sqf:title>
                    <sqf:p>The topic ID must be equal to the file name.</sqf:p>
                </sqf:description>
                <sqf:replace match="@id" node-type="attribute" target="id" select="$reqId"/>
            </sqf:fix>
        </rule>
    </pattern>
</schema>
