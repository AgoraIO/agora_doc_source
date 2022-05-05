<?xml version="1.0" encoding="UTF-8"?>
<!--                                                               -->
<!-- =============================================================  -->
<!-- MODULE:    DITA MathML Domain - RNG                           -->
<!-- VERSION:   2.0                                                 -->
<!-- DATE:      [[[Release date]]]                                           -->
<!-- PURPOSE:   Provides elements for including MathML Markup     -->
<!--            in DITA documents.                                 -->
<!-- =============================================================  -->
<!-- =============================================================  -->
<!-- (C) Copyright OASIS Open 2013                                 -->
<!-- All Rights Reserved.                                           -->
<!-- =============================================================     -->
<!--                                                               -->

<!-- ============================================================= -->
<!--                   ELEMENT NAME ENTITIES                       -->
<!-- ============================================================= -->

<!ENTITY % mathmlref   "mathmlref"                                   >
<!ENTITY % mathml      "mathml"                                      >

<!ENTITY % mathml3-ditadriver
   PUBLIC "-//OASIS//ELEMENTS DITA 2.0 Mathml3 Driver//EN"
          "mathml/mathml3-ditadriver.dtd"
>%mathml3-ditadriver;

<!-- ============================================================= -->
<!--                    ELEMENT DECLARATIONS                       -->
<!-- ============================================================= -->

<!--                    LONG NAME: MathML reference                -->
<!ENTITY % mathmlref.content
                       "(%fallback;)?"
>
<!ENTITY % mathmlref.attributes
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
                                    'mml'
               parse
                          CDATA
                                    'xml'
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
<!ELEMENT  mathmlref %mathmlref.content;>
<!ATTLIST  mathmlref %mathmlref.attributes;>


<!--                    LONG NAME: MathML container                -->
<!ENTITY % mathml.content
                       "(m:math |
                         %mathmlref; |
                         %data;)*"
>
<!ENTITY % mathml.attributes
              "%univ-atts;"
>
<!ELEMENT  mathml %mathml.content;>
<!ATTLIST  mathml %mathml.attributes;>



<!-- ============================================================= -->
<!--             SPECIALIZATION ATTRIBUTE DECLARATIONS             -->
<!-- ============================================================= -->
  
<!ATTLIST  mathml       class CDATA "+ topic/foreign mathml-d/mathml ">
<!ATTLIST  mathmlref    class CDATA "+ topic/include mathml-d/mathmlref ">

<!-- ================== End of DITA MathML Domain ==================== -->
 