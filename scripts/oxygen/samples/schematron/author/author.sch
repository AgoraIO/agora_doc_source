<?xml version="1.0" encoding="UTF-8"?>
<!--   Sample from Zvon Schematron tutorial (www.zvon.org)  
    Description:    XML 1 (file source1.xml) contains a list of authors. These authors are referred to in XML 2. The Schematron checks if for each referred author in XML 2 exists an entry in XML 1.-->
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" >
     <sch:pattern id="CompareWithTheDatabase">
          <sch:rule context="author">
               <sch:assert test="document('source1.xml')//author[@id=current()/@id]">The author is not in the database </sch:assert>
          </sch:rule>
     </sch:pattern>
</sch:schema>