<?xml version="1.0" encoding="UTF-8"?>
<!--   Sample from Zvon Schematron tutorial (www.zvon.org)  
    Description:    If an element contains an attribute , the attribute name must be id.. -->
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron">
     <sch:pattern id="IdIsTheOnlyPermitedAttributeName">
          <sch:rule context="*">
               <sch:report test="@*[not(name()='id')]">Atrribute <sch:name path="@*[not(name()='id')]"/> is
                    forbidden in element <sch:name/>
               </sch:report>
          </sch:rule>
     </sch:pattern>
</sch:schema>
