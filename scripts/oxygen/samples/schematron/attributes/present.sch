<?xml version="1.0" encoding="UTF-8"?>
<!--   Sample from Zvon Schematron tutorial (www.zvon.org)  
    Description:    Specification of required attribute. -->
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron">
     <sch:pattern id="AttributeTest">
          <sch:rule context="CCC">
               <sch:assert test="@name">attribute name is not present</sch:assert>
               <sch:report test="@name">attribute name is present</sch:report>
          </sch:rule>
     </sch:pattern>
</sch:schema>
