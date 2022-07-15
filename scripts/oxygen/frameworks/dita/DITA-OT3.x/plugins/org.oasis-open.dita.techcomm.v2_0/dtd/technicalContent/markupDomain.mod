<?xml version="1.0" encoding="UTF-8"?>
<!-- =============================================================  -->
<!--                     HEADER                                      -->
<!--  =============================================================  -->
<!--   MODULE:    DITA Markup Name Mention Domain                              -->
<!--   VERSION:   2.0                                                 -->
<!--   DATE:      [[[Release date]]]                                        -->
<!--                                                                 -->
<!--  =============================================================  -->
<!--  =============================================================       -->
<!--                                                               -->

<!-- ============================================================= -->
<!--                   ELEMENT NAME ENTITIES                       -->
<!-- ============================================================= -->

<!ENTITY % markupname  "markupname"                                  >

<!-- ============================================================= -->
<!--                    ELEMENT DECLARATIONS                       -->
<!-- ============================================================= -->

<!--                    LONG NAME: Markup name                     -->
<!ENTITY % markupname.content
                       "(#PCDATA |
                         %draft-comment; |
                         %required-cleanup; |
                         %text;)*"
>
<!ENTITY % markupname.attributes
              "keyref
                          CDATA
                                    #IMPLIED
               %univ-atts;"
>
<!ELEMENT  markupname %markupname.content;>
<!ATTLIST  markupname %markupname.attributes;>



<!-- ============================================================= -->
<!--             SPECIALIZATION ATTRIBUTE DECLARATIONS             -->
<!-- ============================================================= -->
  
<!ATTLIST  markupname   class CDATA "+ topic/keyword markup-d/markupname ">

<!-- ================== End of DITA Markup Name Mention Domain ==================== -->
 