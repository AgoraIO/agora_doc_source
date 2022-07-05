<?xml version="1.0" encoding="UTF-8"?>
<!-- =============================================================  -->
<!-- DITA Equation Domain                                          -->
<!--  PURPOSE:Provides elements for identifying equations as       -->
<!--          equations independent of how the equation itself     -->
<!--          is defined (e.g., as a graphic, using MathML, etc.). -->
<!--                                                               -->
<!-- Copyright (c) OASIS Open 2014                                 -->
<!-- =============================================================       -->

<!-- ============================================================= -->
<!--                   ELEMENT NAME ENTITIES                       -->
<!-- ============================================================= -->

<!ENTITY % equation-inline
                       "equation-inline"                             >
<!ENTITY % equation-block
                       "equation-block"                              >
<!ENTITY % equation-number
                       "equation-number"                             >
<!ENTITY % equation-figure
                       "equation-figure"                             >

<!-- ============================================================= -->
<!--                    ELEMENT DECLARATIONS                       -->
<!-- ============================================================= -->

<!ENTITY % equation.cnt
              "%ph.cnt;"
>
<!--                    LONG NAME: Inline equation                 -->
<!ENTITY % equation-inline.content
                       "(%equation.cnt;)*"
>
<!ENTITY % equation-inline.attributes
              "%univ-atts;"
>
<!ELEMENT  equation-inline %equation-inline.content;>
<!ATTLIST  equation-inline %equation-inline.attributes;>


<!--                    LONG NAME: Block equation                  -->
<!ENTITY % equation-block.content
                       "(%equation.cnt; |
                         %equation-number;)*"
>
<!ENTITY % equation-block.attributes
              "%univ-atts;"
>
<!ELEMENT  equation-block %equation-block.content;>
<!ATTLIST  equation-block %equation-block.attributes;>


<!--                    LONG NAME: Equation number                 -->
<!ENTITY % equation-number.content
                       "(#PCDATA |
                         %ph; |
                         %text;)*"
>
<!ENTITY % equation-number.attributes
              "%univ-atts;"
>
<!ELEMENT  equation-number %equation-number.content;>
<!ATTLIST  equation-number %equation-number.attributes;>


<!--                    LONG NAME: Equation figure                 -->
<!ENTITY % equation-figure.content
                       "((%title;)?,
                         (%desc;)?,
                         (%figgroup; |
                          %fig.cnt;)*)"
>
<!ENTITY % equation-figure.attributes
              "%display-atts;
               spectitle
                          CDATA
                                    #IMPLIED
               %univ-atts;"
>
<!ELEMENT  equation-figure %equation-figure.content;>
<!ATTLIST  equation-figure %equation-figure.attributes;>



<!-- ============================================================= -->
<!--             SPECIALIZATION ATTRIBUTE DECLARATIONS             -->
<!-- ============================================================= -->
  
<!ATTLIST  equation-inline class CDATA "+ topic/ph equation-d/equation-inline ">
<!ATTLIST  equation-block class CDATA "+ topic/div equation-d/equation-block ">
<!ATTLIST  equation-number class CDATA "+ topic/ph equation-d/equation-number ">
<!ATTLIST  equation-figure class CDATA "+ topic/fig equation-d/equation-figure ">

<!-- ================== End of DITA Equation Domain ==================== -->
 