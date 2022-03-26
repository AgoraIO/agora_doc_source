<?xml version="1.0" encoding="UTF-8"?>
<!-- ============================================================= -->
<!--                    HEADER                                     -->
<!-- ============================================================= -->
<!--  MODULE:    DITA Concept                                      -->
<!--  VERSION:   2.0                                               -->
<!--  DATE:      [[[Release date]]]                                     -->
<!--  PURPOSE:   Define elements and specialization atttributes    -->
<!--             for Concepts                                      -->
<!--                                                               -->
<!-- ============================================================= -->
<!-- ============================================================= -->
<!--                    PUBLIC DOCUMENT TYPE DEFINITION            -->
<!--                    TYPICAL INVOCATION                         -->
<!--                                                               -->
<!--  Refer to this file by the following public identifier or an  -->
<!--       appropriate system identifier                           -->
<!-- PUBLIC "-//OASIS//ELEMENTS DITA 2.0 Concept//EN"              -->
<!--       Delivered as file "concept.mod"                              -->
<!-- ============================================================= -->
<!--             (C) Copyright OASIS Open 2005, 2009.              -->
<!--             (C) Copyright IBM Corporation 2001, 2004.         -->
<!--             All Rights Reserved.                              -->
<!--  UPDATES:                                                     -->
<!-- ============================================================= -->

<!-- ============================================================= -->
<!--                   ELEMENT NAME ENTITIES                       -->
<!-- ============================================================= -->

<!ENTITY % concept     "concept"                                     >
<!ENTITY % conbody     "conbody"                                     >
<!ENTITY % conbodydiv  "conbodydiv"                                  >

<!-- ============================================================= -->
<!--                    ELEMENT DECLARATIONS                       -->
<!-- ============================================================= -->

<!-- Based on body.cnt, but swaps
     basic.block ==> basic.block.noexample-->
<!ENTITY % conbody.cnt
              "%basic.block.noexample; |
               %data.elements.incl; |
               %draft-comment; |
               %foreign.unknown.incl; |
               %required-cleanup;"
>

<!ENTITY % concept-info-types
              "%info-types;"
>
<!--                    LONG NAME: Concept                         -->
<!ENTITY % concept.content
                       "((%title;),
                         (%abstract; |
                          %shortdesc;)?,
                         (%prolog;)?,
                         (%conbody;)?,
                         (%related-links;)?,
                         (%concept-info-types;)*)"
>
<!ENTITY % concept.attributes
              "id
                          ID
                                    #REQUIRED
               %conref-atts;
               %select-atts;
               %localization-atts;
               outputclass
                          CDATA
                                    #IMPLIED"
>
<!ELEMENT  concept %concept.content;>
<!ATTLIST  concept %concept.attributes;
                 %arch-atts;
                 specializations 
                        CDATA
                                  "&included-domains;"
>


<!--                    LONG NAME: Concept Body                    -->
<!ENTITY % conbody.content
                       "((%conbody.cnt;)*,
                         (%section; |
                          %example; |
                          %conbodydiv;)*)"
>
<!ENTITY % conbody.attributes
              "%univ-atts;"
>
<!ELEMENT  conbody %conbody.content;>
<!ATTLIST  conbody %conbody.attributes;>


<!--                    LONG NAME: Concept Body division           -->
<!ENTITY % conbodydiv.content
                       "(%example; |
                         %section;)*"
>
<!ENTITY % conbodydiv.attributes
              "%univ-atts;"
>
<!ELEMENT  conbodydiv %conbodydiv.content;>
<!ATTLIST  conbodydiv %conbodydiv.attributes;>



<!-- ============================================================= -->
<!--             SPECIALIZATION ATTRIBUTE DECLARATIONS             -->
<!-- ============================================================= -->
  
<!ATTLIST  concept      class CDATA "- topic/topic concept/concept ">
<!ATTLIST  conbody      class CDATA "- topic/body  concept/conbody ">
<!ATTLIST  conbodydiv   class CDATA "- topic/bodydiv concept/conbodydiv ">

<!-- ================== End of DITA Concept ==================== -->
 