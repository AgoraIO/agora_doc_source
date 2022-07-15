<?xml version="1.0" encoding="UTF-8"?>
<!--   Sample from Zvon Schematron tutorial (www.zvon.org)  
    Description:    The element must have the attribute, if it is inside another one, but it must not have the one otherwise. -->
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron">
     <sch:pattern id="TestAttribute">
          <sch:rule context="CCC">
               <sch:report test="parent::BBB and not(@id)">Attribute id is missing</sch:report>
               <sch:report test="not(parent::BBB) and @id">Attribute id is used in wrong context
               </sch:report>
          </sch:rule>
     </sch:pattern>
</sch:schema>
