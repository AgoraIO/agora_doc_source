<?xml version="1.0" encoding="UTF-8"?>
<!-- ============================================================= -->
<!--                    HEADER                                     -->
<!-- ============================================================= -->
<!--  MODULE:    DITA Glossary Group                               -->
<!--  VERSION:   2.0                                               -->
<!--  DATE:      [[[Release date]]]                                     -->
<!--  PURPOSE:   Define elements and specialization atttributes    -->
<!--             for Glossary Group topics                         -->
<!--                                                               -->
<!-- ============================================================= -->
<!-- ============================================================= -->
<!--                    PUBLIC DOCUMENT TYPE DEFINITION            -->
<!--                    TYPICAL INVOCATION                         -->
<!--                                                               -->
<!--  Refer to this file by the following public identifier or an  -->
<!--       appropriate system identifier                           -->
<!-- PUBLIC "-//OASIS//ELEMENTS DITA 2.0 Glossary Group//EN"           -->
<!--       Delivered as file "glossgroup.mod"                           -->
<!-- ============================================================= -->
<!--             (C) Copyright OASIS Open 2008, 2009.              -->
<!--             All Rights Reserved.                              -->
<!--                                                               -->
<!--  UPDATES:                                                     -->
<!-- ============================================================= -->

<!-- ============================================================= -->
<!--                   ELEMENT NAME ENTITIES                       -->
<!-- ============================================================= -->

<!ENTITY % glossgroup  "glossgroup"                                  >

<!-- ============================================================= -->
<!--                    ELEMENT DECLARATIONS                       -->
<!-- ============================================================= -->

<!ENTITY % glossgroup-info-types
              "glossgroup |
               glossentry"
>
<!--                    LONG NAME: Glossary Group                  -->
<!ENTITY % glossgroup.content
                       "((%title;),
                         (%prolog;)?,
                         (%glossgroup-info-types;)*)"
>
<!ENTITY % glossgroup.attributes
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
<!ELEMENT  glossgroup %glossgroup.content;>
<!ATTLIST  glossgroup %glossgroup.attributes;
                 %arch-atts;
                 specializations 
                        CDATA
                                  "&included-domains;"
>



<!-- ============================================================= -->
<!--             SPECIALIZATION ATTRIBUTE DECLARATIONS             -->
<!-- ============================================================= -->
  
<!ATTLIST  glossgroup   class CDATA "- topic/topic concept/concept glossgroup/glossgroup ">

<!-- ================== End of DITA Glossary Group ==================== -->
 