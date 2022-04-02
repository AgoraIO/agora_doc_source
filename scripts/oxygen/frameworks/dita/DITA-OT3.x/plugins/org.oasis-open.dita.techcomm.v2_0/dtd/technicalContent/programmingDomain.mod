<?xml version="1.0" encoding="UTF-8"?>
<!-- ============================================================= -->
<!--                    HEADER                                     -->
<!-- ============================================================= -->
<!--  MODULE:    DITA Programming Domain                           -->
<!--  VERSION:   2.0                                               -->
<!--  DATE:      [[[Release date]]]                                     -->
<!--  PURPOSE:   Declaring the elements and specialization         -->
<!--             attributes for the Programming Domain             -->
<!--                                                               -->
<!-- ============================================================= -->
<!-- ============================================================= -->
<!--                    PUBLIC DOCUMENT TYPE DEFINITION            -->
<!--                    TYPICAL INVOCATION                         -->
<!--                                                               -->
<!--  Refer to this file by the following public identifier or an  -->
<!--       appropriate system identifier                           -->
<!-- PUBLIC "-//OASIS//ELEMENTS DITA 2.0 Programming Domain//EN"       -->
<!--       Delivered as file "programmingDomain.mod"                    -->
<!-- ============================================================= -->
<!--             (C) Copyright OASIS Open 2005, 2009.              -->
<!--             (C) Copyright IBM Corporation 2001, 2004.         -->
<!--             All Rights Reserved.                              -->
<!--                                                               -->
<!--  UPDATES:                                                     -->
<!-- ============================================================= -->

<!-- ============================================================= -->
<!--                   ELEMENT NAME ENTITIES                       -->
<!-- ============================================================= -->

<!ENTITY % codeph      "codeph"                                      >
<!ENTITY % codeblock   "codeblock"                                   >
<!ENTITY % coderef     "coderef"                                     >
<!ENTITY % option      "option"                                      >
<!ENTITY % parmname    "parmname"                                    >
<!ENTITY % apiname     "apiname"                                     >
<!ENTITY % parml       "parml"                                       >
<!ENTITY % plentry     "plentry"                                     >
<!ENTITY % pt          "pt"                                          >
<!ENTITY % pd          "pd"                                          >

<!-- ============================================================= -->
<!--                    ELEMENT DECLARATIONS                       -->
<!-- ============================================================= -->

<!--                    LONG NAME: Code Phrase                     -->
<!ENTITY % codeph.content
                       "(#PCDATA |
                         %basic.ph.notm; |
                         %data.elements.incl; |
                         %draft-comment; |
                         %foreign.unknown.incl; |
                         %required-cleanup;)*"
>
<!ENTITY % codeph.attributes
              "%univ-atts;"
>
<!ELEMENT  codeph %codeph.content;>
<!ATTLIST  codeph %codeph.attributes;>


<!--                    LONG NAME: Code Block                      -->
<!ENTITY % codeblock.content
                       "(#PCDATA |
                         %basic.ph.notm; |
                         %coderef; |
                         %data.elements.incl; |
                         %foreign.unknown.incl; |
                         %txt.incl;)*"
>
<!ENTITY % codeblock.attributes
              "%display-atts;
               spectitle
                          CDATA
                                    #IMPLIED
               xml:space
                          (preserve)
                                    #FIXED 
                                    'preserve'
               %univ-atts;"
>
<!ELEMENT  codeblock %codeblock.content;>
<!ATTLIST  codeblock %codeblock.attributes;>


<!--                    LONG NAME: Literal code reference          -->
<!ENTITY % coderef.content
                       "(%fallback;)?"
>
<!ENTITY % coderef.attributes
              "href
                          CDATA
                                    #IMPLIED
               keyref
                          CDATA
                                    #IMPLIED
               type
                          CDATA
                                    #IMPLIED
               format
                          CDATA
                                    #IMPLIED
               parse
                          CDATA
                                    'text'
               scope
                          (external |
                           local |
                           peer |
                           -dita-use-conref-target)
                                    #IMPLIED
               encoding
                          CDATA
                                    #IMPLIED
               %univ-atts;"
>
<!ELEMENT  coderef %coderef.content;>
<!ATTLIST  coderef %coderef.attributes;>


<!--                    LONG NAME: Option                          -->
<!ENTITY % option.content
                       "(#PCDATA |
                         %text;)*"
>
<!ENTITY % option.attributes
              "keyref
                          CDATA
                                    #IMPLIED
               %univ-atts;"
>
<!ELEMENT  option %option.content;>
<!ATTLIST  option %option.attributes;>


<!--                    LONG NAME: Parameter Name                  -->
<!ENTITY % parmname.content
                       "(#PCDATA |
                         %text;)*"
>
<!ENTITY % parmname.attributes
              "keyref
                          CDATA
                                    #IMPLIED
               %univ-atts;"
>
<!ELEMENT  parmname %parmname.content;>
<!ATTLIST  parmname %parmname.attributes;>


<!--                    LONG NAME: API Name                        -->
<!ENTITY % apiname.content
                       "(#PCDATA |
                         %text;)*"
>
<!ENTITY % apiname.attributes
              "keyref
                          CDATA
                                    #IMPLIED
               %univ-atts;"
>
<!ELEMENT  apiname %apiname.content;>
<!ATTLIST  apiname %apiname.attributes;>


<!--                    LONG NAME: Parameter List                  -->
<!ENTITY % parml.content
                       "((%data;)*,
                         (%plentry;)+)"
>
<!ENTITY % parml.attributes
              "compact
                          (yes |
                           no |
                           -dita-use-conref-target)
                                    #IMPLIED
               spectitle
                          CDATA
                                    #IMPLIED
               %univ-atts;"
>
<!ELEMENT  parml %parml.content;>
<!ATTLIST  parml %parml.attributes;>


<!--                    LONG NAME: Parameter List Entry            -->
<!ENTITY % plentry.content
                       "((%pt;)+,
                         (%pd;)+)"
>
<!ENTITY % plentry.attributes
              "%univ-atts;"
>
<!ELEMENT  plentry %plentry.content;>
<!ATTLIST  plentry %plentry.attributes;>


<!--                    LONG NAME: Parameter Term                  -->
<!ENTITY % pt.content
                       "(%term.cnt;)*"
>
<!ENTITY % pt.attributes
              "keyref
                          CDATA
                                    #IMPLIED
               %univ-atts;"
>
<!ELEMENT  pt %pt.content;>
<!ATTLIST  pt %pt.attributes;>


<!--                    LONG NAME: Parameter Description           -->
<!ENTITY % pd.content
                       "(%defn.cnt;)*"
>
<!ENTITY % pd.attributes
              "%univ-atts;"
>
<!ELEMENT  pd %pd.content;>
<!ATTLIST  pd %pd.attributes;>



<!-- ============================================================= -->
<!--             SPECIALIZATION ATTRIBUTE DECLARATIONS             -->
<!-- ============================================================= -->
  
<!ATTLIST  apiname      class CDATA "+ topic/keyword pr-d/apiname ">
<!ATTLIST  codeblock    class CDATA "+ topic/pre pr-d/codeblock ">
<!ATTLIST  codeph       class CDATA "+ topic/ph pr-d/codeph ">
<!ATTLIST  coderef      class CDATA "+ topic/include pr-d/coderef ">
<!ATTLIST  option       class CDATA "+ topic/keyword pr-d/option ">
<!ATTLIST  parml        class CDATA "+ topic/dl pr-d/parml ">
<!ATTLIST  parmname     class CDATA "+ topic/keyword pr-d/parmname ">
<!ATTLIST  pd           class CDATA "+ topic/dd pr-d/pd " >
<!ATTLIST  plentry      class CDATA "+ topic/dlentry pr-d/plentry ">
<!ATTLIST  pt           class CDATA "+ topic/dt pr-d/pt " >

<!-- ================== End of DITA Programming Domain ==================== -->
 