<?xml version="1.0" encoding="UTF-8"?>
<!-- =============================================================  -->
<!--                     HEADER                                      -->
<!--  =============================================================  -->
<!--   MODULE:    DITA Hardware Domain                              -->
<!--   VERSION:   2.0                                                 -->
<!--   DATE:      [[[Release date]]]                                       -->
<!--                                                                 -->
<!--  =============================================================  -->
<!--  =============================================================       -->
<!--                                                               -->

<!-- ============================================================= -->
<!--                   ELEMENT NAME ENTITIES                       -->
<!-- ============================================================= -->

<!ENTITY % hwControl  "hwcontrol"                                    >
<!ENTITY % partno     "partno"                                       >

<!-- ============================================================= -->
<!--                    ELEMENT DECLARATIONS                       -->
<!-- ============================================================= -->

<!--                    LONG NAME:  Hardware control               -->
<!ENTITY % hwcontrol.content
                       "(#PCDATA |
                         %data; |
                         %draft-comment; |
                         %image; |
                         %keyword; |
                         %ph; |
                         %text;)*"
>
<!ENTITY % hwcontrol.attributes
              "keyref
                          CDATA
                                    #IMPLIED
               %univ-atts;"
>
<!ELEMENT  hwcontrol %hwcontrol.content;>
<!ATTLIST  hwcontrol %hwcontrol.attributes;>


<!--                    LONG NAME: Part number                      -->
<!ENTITY % partno.content
                       "(#PCDATA |
                         %data; |
                         %draft-comment; |
                         %keyword; |
                         %text;)*"
>
<!ENTITY % partno.attributes
              "keyref
                          CDATA
                                    #IMPLIED
               %univ-atts;"
>
<!ELEMENT  partno %partno.content;>
<!ATTLIST  partno %partno.attributes;>

<!-- ============================================================= -->
<!--             SPECIALIZATION ATTRIBUTE DECLARATIONS             -->
<!-- ============================================================= -->
  
<!ATTLIST  hwcontrol   class CDATA "+ topic/ph hw-d/hwcontrol ">
<!ATTLIST  partno      class CDATA "+ topic/ph hw-d/partno ">

<!-- ================== End of DITA Hardware Domain ============== -->