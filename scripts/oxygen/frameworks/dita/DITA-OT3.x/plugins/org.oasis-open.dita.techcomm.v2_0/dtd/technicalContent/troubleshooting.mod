<?xml version="1.0" encoding="UTF-8"?>
<!-- ============================================================= -->
<!--                    HEADER                                     -->
<!-- ============================================================= -->
<!--  MODULE:    DITA Troubleshooting Domain                                       -->
<!--  VERSION:   2.0                                               -->
<!--  DATE:      [[[Release date]]]                                        -->
<!--  PURPOSE:   Declaring the elements and specialization         -->
<!--             attributes for DITA Troubleshooting               -->
<!--                                                               -->
<!-- ============================================================= -->
<!-- ============================================================= -->
<!--                    PUBLIC DOCUMENT TYPE DEFINITION            -->
<!--                    TYPICAL INVOCATION                         -->
<!--                                                               -->
<!--  Refer to this file by the following public identifier or an  -->
<!--       appropriate system identifier                           -->
<!-- PUBLIC "-//OASIS//ELEMENTS DITA 2.0 Troubleshooting//EN"      -->
<!--       Delivered as file "troubleshooting.mod"                 -->
<!-- ============================================================= -->
<!--             (C) Copyright OASIS Open 2021                     -->
<!--             All Rights Reserved.                              -->
<!--                                                               -->
<!-- ============================================================= -->

<!-- ============================================================= -->
<!--                   ELEMENT NAME ENTITIES                       -->
<!-- ============================================================= -->

<!ENTITY % troubleshooting
                       "troubleshooting"                             >
<!ENTITY % troublebody "troublebody"                                 >
<!ENTITY % cause       "cause"                                       >
<!ENTITY % condition   "condition"                                   >
<!ENTITY % diagnostics "diagnostics"                                 >
<!ENTITY % diagnostics-general      
                       "diagnostics-general"                         >
<!ENTITY % diagnostics-steps        
                       "diagnostics-steps"                           >
<!ENTITY % remedy      "remedy"                                      >
<!ENTITY % responsibleParty
                       "responsibleParty"                            >
<!ENTITY % troubleSolution
                       "troubleSolution"                             >

<!-- ============================================================= -->
<!--                    ELEMENT DECLARATIONS                       -->
<!-- ============================================================= -->

<!ENTITY % troubleshooting-info-types
              "%info-types;"
>
<!ENTITY % section.blocks.only.cnt
              "((%title;)?,
                (%basic.block; |
                 %data.elements.incl; |
                 %foreign.unknown.incl; |
                 %txt.incl;)*)"
>
<!--                    LONG NAME: Troubleshooting                 -->
<!ENTITY % troubleshooting.content
                       "((%title;),
                         (%abstract; |
                          %shortdesc;)?,
                         (%prolog;)?,
                         (%troublebody;)?,
                         (%related-links;)?,
                         (%troubleshooting-info-types;)*)"
>
<!ENTITY % troubleshooting.attributes
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
<!ELEMENT  troubleshooting %troubleshooting.content;>
<!ATTLIST  troubleshooting %troubleshooting.attributes;
                 %arch-atts;
                 specializations 
                        CDATA
                                  "&included-domains;"
>


<!--                    LONG NAME: Troubleshooting Body            -->
<!ENTITY % troublebody.content
                       "((%condition;)?,
                         (%diagnostics;)?,
                         (%troubleSolution;)*)?"
>
<!ENTITY % troublebody.attributes
              "%univ-atts;"
>
<!ELEMENT  troublebody %troublebody.content;>
<!ATTLIST  troublebody %troublebody.attributes;>


<!--                    LONG NAME: Cause                           -->
<!ENTITY % cause.content
                       "(%section.blocks.only.cnt;)?"
>
<!ENTITY % cause.attributes
              "%univ-atts;
               spectitle
                          CDATA
                                    #IMPLIED"
>
<!ELEMENT  cause %cause.content;>
<!ATTLIST  cause %cause.attributes;>


<!--                    LONG NAME: Condition                       -->
<!ENTITY % condition.content
                       "(%section.blocks.only.cnt;)?"
>
<!ENTITY % condition.attributes
              "%univ-atts;
               spectitle
                          CDATA
                                    #IMPLIED"
>
<!ELEMENT  condition %condition.content;>
<!ATTLIST  condition %condition.attributes;>


<!--                    LONG NAME: Diagnostics                      -->
<!ENTITY % diagnostics.content
                       "(((%diagnostics-general;), (%diagnostics-steps;)?) |
                          (%diagnostics-steps;))"
>
<!ENTITY % diagnostics.attributes
              "%univ-atts;"
>
<!ELEMENT  diagnostics %diagnostics.content;>
<!ATTLIST  diagnostics %diagnostics.attributes;>


<!--                    LONG NAME: Diagnostics general              -->
<!ENTITY % diagnostics-general.content
                       "(%section.blocks.only.cnt;)?"
>
<!ENTITY % diagnostics-general.attributes
              "%univ-atts;
               spectitle
                          CDATA
                                    #IMPLIED"
>
<!ELEMENT  diagnostics-general %diagnostics-general.content;>
<!ATTLIST  diagnostics-general %diagnostics-general.attributes;>


<!--                    LONG NAME: Diagnostics steps                -->
<!ENTITY % diagnostics-steps.content
                       "((%title;)?,
                         (%steps; |
                          %steps-unordered; |
                          %steps-informal;))"
>
<!ENTITY % diagnostics-steps.attributes
              "%univ-atts;
               spectitle
                          CDATA
                                    #IMPLIED"
>
<!ELEMENT  diagnostics-steps %diagnostics-steps.content;>
<!ATTLIST  diagnostics-steps %diagnostics-steps.attributes;>


<!--                    LONG NAME: Remedy                          -->
<!ENTITY % remedy.content
                       "((%title;)?,
                         (%responsibleParty;)?,
                         (%steps; |
                          %steps-unordered; |
                          %steps-informal;))"
>
<!ENTITY % remedy.attributes
              "spectitle
                          CDATA
                                    #IMPLIED
               %univ-atts;"
>
<!ELEMENT  remedy %remedy.content;>
<!ATTLIST  remedy %remedy.attributes;>


<!--                    LONG NAME: Responsible Party               -->
<!ENTITY % responsibleParty.content
                       "(%para.cnt;)*"
>
<!ENTITY % responsibleParty.attributes
              "%univ-atts;"
>
<!ELEMENT  responsibleParty %responsibleParty.content;>
<!ATTLIST  responsibleParty %responsibleParty.attributes;>


<!--                    LONG NAME: Trouble Solution                -->
<!ENTITY % troubleSolution.content
                       "(                         (%cause;)*,
                         (%remedy;)*)"
>
<!ENTITY % troubleSolution.attributes
              "%univ-atts;"
>
<!ELEMENT  troubleSolution %troubleSolution.content;>
<!ATTLIST  troubleSolution %troubleSolution.attributes;>



<!-- ============================================================= -->
<!--             SPECIALIZATION ATTRIBUTE DECLARATIONS             -->
<!-- ============================================================= -->
  
<!ATTLIST  troubleshooting class CDATA "- topic/topic troubleshooting/troubleshooting ">
<!ATTLIST  troublebody  class CDATA "- topic/body troubleshooting/troublebody ">
<!ATTLIST  troubleSolution class CDATA "- topic/bodydiv troubleshooting/troubleSolution ">
<!ATTLIST  cause        class CDATA "- topic/section troubleshooting/cause ">
<!ATTLIST  condition    class CDATA "- topic/section troubleshooting/condition ">
<!ATTLIST  diagnostics         class CDATA "- topic/bodydiv troubleshooting/diagnostics ">
<!ATTLIST  diagnostics-general class CDATA "- topic/section troubleshooting/diagnostics-general ">
<!ATTLIST  diagnostics-steps   class CDATA "- topic/section troubleshooting/diagnostics-steps ">
<!ATTLIST  remedy       class CDATA "- topic/section troubleshooting/remedy ">
<!ATTLIST  responsibleParty class CDATA "- topic/p troubleshooting/responsibleParty ">

<!-- ================== End of DITA Troubleshooting Domain ==================== -->
 