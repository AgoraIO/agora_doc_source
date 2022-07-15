<?xml version="1.0" encoding="UTF-8"?>
<!--   Sample from Zvon Schematron tutorial (www.zvon.org)  
    Description:   A paragraph in XML 2 can only start with words specified in XML 1 (file source1.xml).-->
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" >
         <sch:pattern id="StartOfParagraphRestriction">
          <sch:rule context="p">
               <sch:assert test="document('source1.xml')//*[name()=substring-before(current(),' ')]">The word at the beginning of sentence is not listed in XML 1.</sch:assert>
          </sch:rule>
     </sch:pattern>
</sch:schema>