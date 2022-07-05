<?xml version="1.0" encoding="UTF-8"?>
<!-- ============================================================= -->
<!--                    HEADER                                     -->
<!-- ============================================================= -->
<!--  MODULE:    DITA Reference                                    -->
<!--  VERSION:   2.0                                               -->
<!--  DATE:      [[[Release date]]]                                     -->
<!--  PURPOSE:   Declaring the elements and specialization         -->
<!--             attributes for Reference                          -->
<!--                                                               -->
<!-- ============================================================= -->
<!-- ============================================================= -->
<!--                    PUBLIC DOCUMENT TYPE DEFINITION            -->
<!--                    TYPICAL INVOCATION                         -->
<!--                                                               -->
<!--  Refer to this file by the following public identifier or an  -->
<!--       appropriate system identifier                           -->
<!-- PUBLIC "-//OASIS//ELEMENTS DITA 2.0 Reference//EN"                -->
<!--       Delivered as file "reference.mod"                            -->
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

<!ENTITY % reference   "reference"                                   >
<!ENTITY % refbody     "refbody"                                     >
<!ENTITY % refbodydiv  "refbodydiv"                                  >
<!ENTITY % refsyn      "refsyn"                                      >
<!ENTITY % properties  "properties"                                  >
<!ENTITY % prophead    "prophead"                                    >
<!ENTITY % proptypehd  "proptypehd"                                  >
<!ENTITY % propvaluehd "propvaluehd"                                 >
<!ENTITY % propdeschd  "propdeschd"                                  >
<!ENTITY % property    "property"                                    >
<!ENTITY % proptype    "proptype"                                    >
<!ENTITY % propvalue   "propvalue"                                   >
<!ENTITY % propdesc    "propdesc"                                    >

<!-- ============================================================= -->
<!--                    ELEMENT DECLARATIONS                       -->
<!-- ============================================================= -->

<!ENTITY % reference-info-types
              "%info-types;"
>
<!--                    LONG NAME: Reference                       -->
<!ENTITY % reference.content
                       "((%title;),
                         (%abstract; |
                          %shortdesc;)?,
                         (%prolog;)?,
                         (%refbody;)?,
                         (%related-links;)?,
                         (%reference-info-types;)*)"
>
<!ENTITY % reference.attributes
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
<!ELEMENT  reference %reference.content;>
<!ATTLIST  reference %reference.attributes;
                 %arch-atts;
                 specializations 
                        CDATA
                                  "&included-domains;"
>


<!--                    LONG NAME: Reference Body                  -->
<!ENTITY % refbody.content
                       "(%data.elements.incl; |
                         %example; |
                         %foreign.unknown.incl; |
                         %refbodydiv; |
                         %refsyn; |
                         %properties; |
                         %section; |
                         %simpletable; |
                         %table;)*"
>
<!ENTITY % refbody.attributes
              "%univ-atts;"
>
<!ELEMENT  refbody %refbody.content;>
<!ATTLIST  refbody %refbody.attributes;>


<!--                    LONG NAME: Reference Body division         -->
<!ENTITY % refbodydiv.content
                       "(%data.elements.incl; |
                         %example; |
                         %foreign.unknown.incl; |
                         %refbodydiv; |
                         %refsyn; |
                         %properties; |
                         %section; |
                         %simpletable; |
                         %table;)*"
>
<!ENTITY % refbodydiv.attributes
              "%univ-atts;"
>
<!ELEMENT  refbodydiv %refbodydiv.content;>
<!ATTLIST  refbodydiv %refbodydiv.attributes;>


<!--                    LONG NAME: Reference Syntax                -->
<!ENTITY % refsyn.content
                       "(%section.cnt; | %properties;)*"
>
<!ENTITY % refsyn.attributes
              "spectitle
                          CDATA
                                    #IMPLIED
               %univ-atts;"
>
<!ELEMENT  refsyn %refsyn.content;>
<!ATTLIST  refsyn %refsyn.attributes;>


<!--                    LONG NAME: Properties                      -->
<!ENTITY % properties.content
                       "((%title;)?,
                         (%prophead;)?,
                         (%property;)+)"
>
<!ENTITY % properties.attributes
              "relcolwidth
                          CDATA
                                    #IMPLIED
               keycol
                          NMTOKEN
                                    #IMPLIED
               spectitle
                          CDATA
                                    #IMPLIED
               %display-atts;
               %univ-atts;"
>
<!ELEMENT  properties %properties.content;>
<!ATTLIST  properties %properties.attributes;>


<!--                    LONG NAME: Property Head                   -->
<!ENTITY % prophead.content
                       "((%proptypehd;)?,
                         (%propvaluehd;)?,
                         (%propdeschd;)?)"
>
<!ENTITY % prophead.attributes
              "%univ-atts;"
>
<!ELEMENT  prophead %prophead.content;>
<!ATTLIST  prophead %prophead.attributes;>


<!--                    LONG NAME: Property Type Head              -->
<!ENTITY % proptypehd.content
                       "(%tblcell.cnt;)*"
>
<!ENTITY % proptypehd.attributes
              "specentry
                          CDATA
                                    #IMPLIED
               scope
                          (row |
                           col |
                           rowgroup |
                           colgroup |
                           -dita-use-conref-target)
                                    #IMPLIED
               headers
                          NMTOKENS
                                    #IMPLIED
               %univ-atts;"
>
<!ELEMENT  proptypehd %proptypehd.content;>
<!ATTLIST  proptypehd %proptypehd.attributes;>


<!--                    LONG NAME: Property Value Head             -->
<!ENTITY % propvaluehd.content
                       "(%tblcell.cnt;)*"
>
<!ENTITY % propvaluehd.attributes
              "specentry
                          CDATA
                                    #IMPLIED
               scope
                          (row |
                           col |
                           rowgroup |
                           colgroup |
                           -dita-use-conref-target)
                                    #IMPLIED
               headers
                          NMTOKENS
                                    #IMPLIED
               %univ-atts;"
>
<!ELEMENT  propvaluehd %propvaluehd.content;>
<!ATTLIST  propvaluehd %propvaluehd.attributes;>


<!--                    LONG NAME: Property Description Head       -->
<!ENTITY % propdeschd.content
                       "(%tblcell.cnt;)*"
>
<!ENTITY % propdeschd.attributes
              "specentry
                          CDATA
                                    #IMPLIED
               scope
                          (row |
                           col |
                           rowgroup |
                           colgroup |
                           -dita-use-conref-target)
                                    #IMPLIED
               headers
                          NMTOKENS
                                    #IMPLIED
               %univ-atts;"
>
<!ELEMENT  propdeschd %propdeschd.content;>
<!ATTLIST  propdeschd %propdeschd.attributes;>


<!--                    LONG NAME: Property                        -->
<!ENTITY % property.content
                       "((%proptype;)?,
                         (%propvalue;)?,
                         (%propdesc;)?)"
>
<!ENTITY % property.attributes
              "%univ-atts;"
>
<!ELEMENT  property %property.content;>
<!ATTLIST  property %property.attributes;>


<!--                    LONG NAME: Property Type                   -->
<!ENTITY % proptype.content
                       "(%ph.cnt;)*"
>
<!ENTITY % proptype.attributes
              "specentry
                          CDATA
                                    #IMPLIED
               rowspan
                          NMTOKEN
                                    #IMPLIED                     
               scope
                          (row |
                           col |
                           rowgroup |
                           colgroup |
                           -dita-use-conref-target)
                                    #IMPLIED
               headers
                          NMTOKENS
                                    #IMPLIED
               %univ-atts;"
>
<!ELEMENT  proptype %proptype.content;>
<!ATTLIST  proptype %proptype.attributes;>


<!--                    LONG NAME: Property Value                  -->
<!ENTITY % propvalue.content
                       "(%ph.cnt;)*"
>
<!ENTITY % propvalue.attributes
              "specentry
                          CDATA
                                    #IMPLIED
               rowspan
                          NMTOKEN
                                    #IMPLIED                     
               scope
                          (row |
                           col |
                           rowgroup |
                           colgroup |
                           -dita-use-conref-target)
                                    #IMPLIED
               headers
                          NMTOKENS
                                    #IMPLIED
               %univ-atts;"
>
<!ELEMENT  propvalue %propvalue.content;>
<!ATTLIST  propvalue %propvalue.attributes;>


<!--                    LONG NAME: Property Description            -->
<!ENTITY % propdesc.content
                       "(%desc.cnt;)*"
>
<!ENTITY % propdesc.attributes
              "specentry
                          CDATA
                                    #IMPLIED
               rowspan
                          NMTOKEN
                                    #IMPLIED                     
               scope
                          (row |
                           col |
                           rowgroup |
                           colgroup |
                           -dita-use-conref-target)
                                    #IMPLIED
               headers
                          NMTOKENS
                                    #IMPLIED
               %univ-atts;"
>
<!ELEMENT  propdesc %propdesc.content;>
<!ATTLIST  propdesc %propdesc.attributes;>



<!-- ============================================================= -->
<!--             SPECIALIZATION ATTRIBUTE DECLARATIONS             -->
<!-- ============================================================= -->
  
<!ATTLIST  reference    class CDATA "- topic/topic       reference/reference ">
<!ATTLIST  refbody      class CDATA "- topic/body        reference/refbody ">
<!ATTLIST  refbodydiv   class CDATA "- topic/bodydiv     reference/refbodydiv ">
<!ATTLIST  refsyn       class CDATA "- topic/section     reference/refsyn ">
<!ATTLIST  properties   class CDATA "- topic/simpletable reference/properties ">
<!ATTLIST  property     class CDATA "- topic/strow       reference/property ">
<!ATTLIST  proptype     class CDATA "- topic/stentry     reference/proptype ">
<!ATTLIST  propvalue    class CDATA "- topic/stentry     reference/propvalue ">
<!ATTLIST  propdesc     class CDATA "- topic/stentry     reference/propdesc ">
<!ATTLIST  prophead     class CDATA "- topic/sthead      reference/prophead ">
<!ATTLIST  proptypehd   class CDATA "- topic/stentry     reference/proptypehd ">
<!ATTLIST  propvaluehd  class CDATA "- topic/stentry     reference/propvaluehd ">
<!ATTLIST  propdeschd   class CDATA "- topic/stentry     reference/propdeschd ">

<!-- ================== End of DITA Reference ==================== -->
 