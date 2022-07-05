<?xml version="1.0" encoding="UTF-8"?>
<!--   Sample from Zvon Schematron tutorial (www.zvon.org)  
    Description:    If the element has one attribute then it must have the second one as well. -->
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron">
     <sch:pattern id="AttributesPresent">
          <sch:rule context="BBB">
               <sch:assert test="not(@aaa) or (@aaa and @bbb)">The element must not have an isolated aaa
                    attribute</sch:assert>
               <sch:assert test="not(@bbb) or (@aaa and @bbb)">The element must not have an isolated bbb
                    attribute</sch:assert>
          </sch:rule>
     </sch:pattern>
</sch:schema>
