<?xml version="1.0" encoding="UTF-8"?>
<!--   Sample from Zvon Schematron tutorial (www.zvon.org)  
    Description:    Value of the attribute is two or three character abbreviation. -->
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron">
     <sch:pattern id="NumberOfcharactersInAnAbbreviation">
          <sch:rule context="BBB">
               <sch:report test="string-length(@bbb) &lt; 2">There is not enough letters in the
                    abbreviation</sch:report>
               <sch:report test="string-length(@bbb) > 3">There is too much letters in the abbreviation
               </sch:report>
          </sch:rule>
     </sch:pattern>
</sch:schema>
