<?xml version="1.0" encoding="UTF-8"?>
<!--   Sample from Zvon Schematron tutorial (www.zvon.org)  
    Description: The sum of values of all relevant elements equals 100.-->
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron">
     <sch:pattern id="SumEqualsOneHundredPercent.">
          <sch:rule context="Total">
               <sch:assert test="sum(//Percent) = 100">The values do not sum to 100%. </sch:assert>
          </sch:rule>
     </sch:pattern>
</sch:schema>
