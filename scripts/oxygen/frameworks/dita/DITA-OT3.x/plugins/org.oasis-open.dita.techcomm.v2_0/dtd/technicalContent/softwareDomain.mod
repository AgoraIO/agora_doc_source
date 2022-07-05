<?xml version="1.0" encoding="UTF-8"?>
<!-- ============================================================= -->
<!--                    HEADER                                     -->
<!-- ============================================================= -->
<!--  MODULE:    DITA Software Domain                              -->
<!--  VERSION:   2.0                                               -->
<!--  DATE:      [[[Release date]]]                                     -->
<!--  PURPOSE:   Declaring the elements and specialization         -->
<!--             attributes for the Software Domain                -->
<!--                                                               -->
<!-- ============================================================= -->
<!-- ============================================================= -->
<!--                    PUBLIC DOCUMENT TYPE DEFINITION            -->
<!--                    TYPICAL INVOCATION                         -->
<!--                                                               -->
<!--  Refer to this file by the following public identifier or an  -->
<!--       appropriate system identifier                           -->
<!-- PUBLIC "-//OASIS//ELEMENTS DITA 2.0 Software Domain//EN"          -->
<!--       Delivered as file "softwareDomain.mod"                       -->
<!-- ============================================================= -->
<!--             (C) Copyright OASIS Open 2005, 2009.              -->
<!--             (C) Copyright IBM Corporation 2001, 2004.         -->
<!--             All Rights Reserved.                              -->
<!--                                                               -->
<!--  UPDATES:                                                     -->
<!-- =============================================================   -->

<!-- ============================================================= -->
<!--                   ELEMENT NAME ENTITIES                       -->
<!-- ============================================================= -->

<!ENTITY % msgph       "msgph"                                       >
<!ENTITY % msgblock    "msgblock"                                    >
<!ENTITY % msgnum      "msgnum"                                      >
<!ENTITY % cmdname     "cmdname"                                     >
<!ENTITY % varname     "varname"                                     >
<!ENTITY % filepath    "filepath"                                    >
<!ENTITY % userinput   "userinput"                                   >
<!ENTITY % systemoutput
                       "systemoutput"                                >

<!-- ============================================================= -->
<!--                    ELEMENT DECLARATIONS                       -->
<!-- ============================================================= -->

<!--                    LONG NAME: Message Phrase                  -->
<!ENTITY % msgph.content
                       "(%words.cnt;)*"
>
<!ENTITY % msgph.attributes
              "%univ-atts;"
>
<!ELEMENT  msgph %msgph.content;>
<!ATTLIST  msgph %msgph.attributes;>


<!--                    LONG NAME: Message Block                   -->
<!ENTITY % msgblock.content
                       "(%words.cnt; |
                         %msgph;)*"
>
<!ENTITY % msgblock.attributes
              "%display-atts;
               spectitle
                          CDATA
                                    #IMPLIED
               %univ-atts;
               xml:space
                          (preserve)
                                    #FIXED 
                                    'preserve'"
>
<!ELEMENT  msgblock %msgblock.content;>
<!ATTLIST  msgblock %msgblock.attributes;>


<!--                    LONG NAME: Message Number                  -->
<!ENTITY % msgnum.content
                       "(#PCDATA |
                         %text;)*"
>
<!ENTITY % msgnum.attributes
              "keyref
                          CDATA
                                    #IMPLIED
               %univ-atts;"
>
<!ELEMENT  msgnum %msgnum.content;>
<!ATTLIST  msgnum %msgnum.attributes;>


<!--                    LONG NAME: Command Name                    -->
<!ENTITY % cmdname.content
                       "(#PCDATA |
                         %text;)*"
>
<!ENTITY % cmdname.attributes
              "keyref
                          CDATA
                                    #IMPLIED
               %univ-atts;"
>
<!ELEMENT  cmdname %cmdname.content;>
<!ATTLIST  cmdname %cmdname.attributes;>


<!--                    LONG NAME: Variable Name                   -->
<!ENTITY % varname.content
                       "(#PCDATA |
                         %text;)*"
>
<!ENTITY % varname.attributes
              "keyref
                          CDATA
                                    #IMPLIED
               %univ-atts;"
>
<!ELEMENT  varname %varname.content;>
<!ATTLIST  varname %varname.attributes;>


<!--                    LONG NAME: File Path                       -->
<!ENTITY % filepath.content
                       "(%words.cnt;)*"
>
<!ENTITY % filepath.attributes
              "%univ-atts;"
>
<!ELEMENT  filepath %filepath.content;>
<!ATTLIST  filepath %filepath.attributes;>


<!--                    LONG NAME: User Input                      -->
<!ENTITY % userinput.content
                       "(%words.cnt;)*"
>
<!ENTITY % userinput.attributes
              "%univ-atts;"
>
<!ELEMENT  userinput %userinput.content;>
<!ATTLIST  userinput %userinput.attributes;>


<!--                    LONG NAME: System Output                   -->
<!ENTITY % systemoutput.content
                       "(%words.cnt;)*"
>
<!ENTITY % systemoutput.attributes
              "%univ-atts;"
>
<!ELEMENT  systemoutput %systemoutput.content;>
<!ATTLIST  systemoutput %systemoutput.attributes;>



<!-- ============================================================= -->
<!--             SPECIALIZATION ATTRIBUTE DECLARATIONS             -->
<!-- ============================================================= -->
  
<!ATTLIST  cmdname      class CDATA "+ topic/keyword sw-d/cmdname ">
<!ATTLIST  filepath     class CDATA "+ topic/ph sw-d/filepath ">
<!ATTLIST  msgblock     class CDATA "+ topic/pre sw-d/msgblock ">
<!ATTLIST  msgnum       class CDATA "+ topic/keyword sw-d/msgnum ">
<!ATTLIST  msgph        class CDATA "+ topic/ph sw-d/msgph ">
<!ATTLIST  systemoutput class CDATA "+ topic/ph sw-d/systemoutput ">
<!ATTLIST  userinput    class CDATA "+ topic/ph sw-d/userinput ">
<!ATTLIST  varname      class CDATA "+ topic/keyword sw-d/varname ">

<!-- ================== End of DITA Software Domain ==================== -->
 