<?xml version="1.0" encoding="UTF-8"?>
<!--                                                               -->
<!-- =============================================================  -->
<!-- DITA SVG Domain                                               -->
<!-- =============================================================  -->
<!--                                                               -->

<!-- ============================================================= -->
<!--                   ELEMENT NAME ENTITIES                       -->
<!-- ============================================================= -->

<!ENTITY % svg-container
                       "svg-container"                               >
<!ENTITY % svgref      "svgref"                                      >

<!ENTITY % svg11-ditadriver
   PUBLIC "-//OASIS//ELEMENTS DITA 2.0 SVG 1.1 Driver//EN"
          "svg/svg11-ditadriver.dtd"
>%svg11-ditadriver;

<!-- ============================================================= -->
<!--                    ELEMENT DECLARATIONS                       -->
<!-- ============================================================= -->

<!--                    LONG NAME: SVG container                   -->
<!ENTITY % svg-container.content
                       "(svg:svg |
                         %svgref; |
                         %data;)*"
>
<!ENTITY % svg-container.attributes
              "%univ-atts;"
>
<!ELEMENT  svg-container %svg-container.content;>
<!ATTLIST  svg-container %svg-container.attributes;>


<!--                    LONG NAME: SVG element reference           -->
<!ENTITY % svgref.content
                       "(%fallback;)?"
>
<!ENTITY % svgref.attributes
              "href
                          CDATA
                                    #IMPLIED
               keyref
                          CDATA
                                    #IMPLIED
               format
                          CDATA
                                    'svg'
               scope
                          (external |
                           local |
                           peer |
                           -dita-use-conref-target)
                                    #IMPLIED                                    
               parse
                          CDATA
                                    'xml'
               encoding
                          CDATA
                                    #IMPLIED
               %univ-atts;"
>
<!ELEMENT  svgref %svgref.content;>
<!ATTLIST  svgref %svgref.attributes;>



<!-- ============================================================= -->
<!--             SPECIALIZATION ATTRIBUTE DECLARATIONS             -->
<!-- ============================================================= -->
  
<!ATTLIST  svg-container class CDATA "+ topic/foreign svg-d/svg-container ">
<!ATTLIST  svgref       class CDATA "+ topic/include svg-d/svgref ">

<!-- ================== End of DITA SVG Domain ==================== -->
 