<?xml version="1.0" encoding="UTF-8"?>
<!-- =============================================================  -->
<!--                     HEADER                                      -->
<!--  =============================================================  -->
<!--   MODULE:    DITA XML Mention Domain                              -->
<!--   VERSION:   2.0                                                 -->
<!--   DATE:      [[[Release date]]]                                       -->
<!--                                                                 -->
<!--  =============================================================  -->
<!--  =============================================================       -->
<!--                                                               -->

<!-- ============================================================= -->
<!--                   ELEMENT NAME ENTITIES                       -->
<!-- ============================================================= -->

<!ENTITY % numcharref  "numcharref"                                  >
<!ENTITY % parameterentity
                       "parameterentity"                             >
<!ENTITY % textentity  "textentity"                                  >
<!ENTITY % xmlatt      "xmlatt"                                      >
<!ENTITY % xmlelement  "xmlelement"                                  >
<!ENTITY % xmlnsname   "xmlnsname"                                   >
<!ENTITY % xmlpi       "xmlpi"                                       >

<!-- ============================================================= -->
<!--                    ELEMENT DECLARATIONS                       -->
<!-- ============================================================= -->

<!--                    LONG NAME: Numeric character reference (&#10;, &#x0a;) -->
<!ENTITY % numcharref.content
                       "(#PCDATA |
                         %draft-comment; |
                         %required-cleanup; |
                         %text;)*"
>
<!ENTITY % numcharref.attributes
              "keyref
                          CDATA
                                    #IMPLIED
               %univ-atts;"
>
<!ELEMENT  numcharref %numcharref.content;>
<!ATTLIST  numcharref %numcharref.attributes;>


<!--                    LONG NAME: Parameter entity reference (%p.content;) -->
<!ENTITY % parameterentity.content
                       "(#PCDATA |
                         %draft-comment; |
                         %required-cleanup; |
                         %text;)*"
>
<!ENTITY % parameterentity.attributes
              "keyref
                          CDATA
                                    #IMPLIED
               %univ-atts;"
>
<!ELEMENT  parameterentity %parameterentity.content;>
<!ATTLIST  parameterentity %parameterentity.attributes;>


<!--                    LONG NAME: Text entity (&prodname;)        -->
<!ENTITY % textentity.content
                       "(#PCDATA |
                         %draft-comment; |
                         %required-cleanup; |
                         %text;)*"
>
<!ENTITY % textentity.attributes
              "keyref
                          CDATA
                                    #IMPLIED
               %univ-atts;"
>
<!ELEMENT  textentity %textentity.content;>
<!ATTLIST  textentity %textentity.attributes;>


<!--                    LONG NAME: XML attribute                   -->
<!ENTITY % xmlatt.content
                       "(#PCDATA |
                         %draft-comment; |
                         %required-cleanup; |
                         %text;)*"
>
<!ENTITY % xmlatt.attributes
              "keyref
                          CDATA
                                    #IMPLIED
               %univ-atts;"
>
<!ELEMENT  xmlatt %xmlatt.content;>
<!ATTLIST  xmlatt %xmlatt.attributes;>


<!--                    LONG NAME: XML element                     -->
<!ENTITY % xmlelement.content
                       "(#PCDATA |
                         %draft-comment; |
                         %required-cleanup; |
                         %text;)*"
>
<!ENTITY % xmlelement.attributes
              "keyref
                          CDATA
                                    #IMPLIED
               %univ-atts;"
>
<!ELEMENT  xmlelement %xmlelement.content;>
<!ATTLIST  xmlelement %xmlelement.attributes;>


<!--                    LONG NAME: XML namespace name (aka "namespace URI") -->
<!ENTITY % xmlnsname.content
                       "(#PCDATA |
                         %draft-comment; |
                         %required-cleanup; |
                         %text;)*"
>
<!ENTITY % xmlnsname.attributes
              "keyref
                          CDATA
                                    #IMPLIED
               %univ-atts;"
>
<!ELEMENT  xmlnsname %xmlnsname.content;>
<!ATTLIST  xmlnsname %xmlnsname.attributes;>


<!--                    LONG NAME: XML processing instruction (PI) -->
<!ENTITY % xmlpi.content
                       "(#PCDATA |
                         %draft-comment; |
                         %required-cleanup; |
                         %text;)*"
>
<!ENTITY % xmlpi.attributes
              "keyref
                          CDATA
                                    #IMPLIED
               %univ-atts;"
>
<!ELEMENT  xmlpi %xmlpi.content;>
<!ATTLIST  xmlpi %xmlpi.attributes;>



<!-- ============================================================= -->
<!--             SPECIALIZATION ATTRIBUTE DECLARATIONS             -->
<!-- ============================================================= -->
  
<!ATTLIST  numcharref   class CDATA "+ topic/keyword markup-d/markupname xml-d/numcharref ">
<!ATTLIST  parameterentity class CDATA "+ topic/keyword markup-d/markupname xml-d/parameterentity ">
<!ATTLIST  textentity   class CDATA "+ topic/keyword markup-d/markupname xml-d/textentity ">
<!ATTLIST  xmlatt       class CDATA "+ topic/keyword markup-d/markupname xml-d/xmlatt ">
<!ATTLIST  xmlelement   class CDATA "+ topic/keyword markup-d/markupname xml-d/xmlelement ">
<!ATTLIST  xmlnsname    class CDATA "+ topic/keyword markup-d/markupname xml-d/xmlnsname ">
<!ATTLIST  xmlpi        class CDATA "+ topic/keyword markup-d/markupname xml-d/xmlpi ">

<!-- ================== End of DITA XML Construct Domain ==================== -->
 