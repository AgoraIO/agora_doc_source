<?xml version="1.0" encoding="UTF-8"?>
<!-- ============================================================= -->
<!--                    HEADER                                     -->
<!-- ============================================================= -->
<!--  MODULE:    DITA User Interface Domain                        -->
<!--  VERSION:   2.0                                               -->
<!--  DATE:      [[[Release date]]]                                     -->
<!--  PURPOSE:   Declaring the elements and specialization         -->
<!--             attributes for the User Interface Domain          -->
<!--                                                               -->
<!-- ============================================================= -->
<!-- ============================================================= -->
<!--                    PUBLIC DOCUMENT TYPE DEFINITION            -->
<!--                    TYPICAL INVOCATION                         -->
<!--                                                               -->
<!--  Refer to this file by the following public identifier or an  -->
<!--       appropriate system identifier                           -->
<!-- PUBLIC "-//OASIS//ELEMENTS DITA 2.0 User Interface Domain//EN"    -->
<!--       Delivered as file "uiDomain.mod"                             -->
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

<!ENTITY % uicontrol   "uicontrol"                                   >
<!ENTITY % wintitle    "wintitle"                                    >
<!ENTITY % menucascade "menucascade"                                 >
<!ENTITY % shortcut    "shortcut"                                    >
<!ENTITY % screen      "screen"                                      >

<!-- ============================================================= -->
<!--                    ELEMENT DECLARATIONS                       -->
<!-- ============================================================= -->

<!--                    LONG NAME: User Interface Control          -->
<!ENTITY % uicontrol.content
                       "(%words.cnt; |
                         %image; |
                         %shortcut;)*"
>
<!ENTITY % uicontrol.attributes
              "keyref
                          CDATA
                                    #IMPLIED
               %univ-atts;"
>
<!ELEMENT  uicontrol %uicontrol.content;>
<!ATTLIST  uicontrol %uicontrol.attributes;>


<!--                    LONG NAME: Window Title                    -->
<!ENTITY % wintitle.content
                       "(#PCDATA |
                         %text;)*"
>
<!ENTITY % wintitle.attributes
              "keyref
                          CDATA
                                    #IMPLIED
               %univ-atts;"
>
<!ELEMENT  wintitle %wintitle.content;>
<!ATTLIST  wintitle %wintitle.attributes;>


<!--                    LONG NAME: Menu Cascade                    -->
<!ENTITY % menucascade.content
                       "(%uicontrol;)+"
>
<!ENTITY % menucascade.attributes
              "keyref
                          CDATA
                                    #IMPLIED
               %univ-atts;"
>
<!ELEMENT  menucascade %menucascade.content;>
<!ATTLIST  menucascade %menucascade.attributes;>


<!--                    LONG NAME: Short Cut                       -->
<!ENTITY % shortcut.content
                       "(#PCDATA |
                         %text;)*"
>
<!ENTITY % shortcut.attributes
              "keyref
                          CDATA
                                    #IMPLIED
               %univ-atts;"
>
<!ELEMENT  shortcut %shortcut.content;>
<!ATTLIST  shortcut %shortcut.attributes;>


<!--                    LONG NAME: Text Screen Capture             -->
<!ENTITY % screen.content
                       "(#PCDATA |
                         %basic.ph.notm; |
                         %data.elements.incl; |
                         %foreign.unknown.incl; |
                         %txt.incl;)*"
>
<!ENTITY % screen.attributes
              "%display-atts;
               spectitle
                          CDATA
                                    #IMPLIED
               xml:space
                          (preserve)
                                    #FIXED 
                                    'preserve'
               %univ-atts;"
>
<!ELEMENT  screen %screen.content;>
<!ATTLIST  screen %screen.attributes;>



<!-- ============================================================= -->
<!--             SPECIALIZATION ATTRIBUTE DECLARATIONS             -->
<!-- ============================================================= -->
  
<!ATTLIST  menucascade  class CDATA "+ topic/ph ui-d/menucascade ">
<!ATTLIST  screen       class CDATA "+ topic/pre ui-d/screen ">
<!ATTLIST  shortcut     class CDATA "+ topic/keyword ui-d/shortcut ">
<!ATTLIST  uicontrol    class CDATA "+ topic/ph ui-d/uicontrol ">
<!ATTLIST  wintitle     class CDATA "+ topic/keyword ui-d/wintitle ">

<!-- ================== End of DITA User Interface Domain ==================== -->
 