<?xml version="1.0" encoding="UTF-8"?>
<!-- ============================================================= -->
<!--                    HEADER                                     -->
<!-- ============================================================= -->
<!--  MODULE:    DITA Syntax Diagram Domain                        -->
<!--  VERSION:   2.0                                               -->
<!--  DATE:      [[[Release date]]]                                     -->
<!--  PURPOSE:   Declaring the elements and specialization         -->
<!--             attributes for the Syntax Diagram Domain          -->
<!--                                                               -->
<!-- ============================================================= -->
<!-- ============================================================= -->
<!--                    PUBLIC DOCUMENT TYPE DEFINITION            -->
<!--                    TYPICAL INVOCATION                         -->
<!--                                                               -->
<!--  Refer to this file by the following public identifier or an  -->
<!--       appropriate system identifier                           -->
<!-- PUBLIC "-//OASIS//ELEMENTS DITA 2.0 Syntax Diagram Domain//EN" -->
<!--       Delivered as file "syntaxdiagramDomain.mod"             -->
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

<!ENTITY % var         "var"                                         >
<!ENTITY % synph       "synph"                                       >
<!ENTITY % oper        "oper"                                        >
<!ENTITY % delim       "delim"                                       >
<!ENTITY % sep         "sep"                                         >
<!ENTITY % syntaxdiagram
                       "syntaxdiagram"                               >
<!ENTITY % synblk      "synblk"                                      >
<!ENTITY % groupseq    "groupseq"                                    >
<!ENTITY % groupchoice "groupchoice"                                 >
<!ENTITY % groupcomp   "groupcomp"                                   >
<!ENTITY % fragment    "fragment"                                    >
<!ENTITY % fragref     "fragref"                                     >
<!ENTITY % synnote     "synnote"                                     >
<!ENTITY % synnoteref  "synnoteref"                                  >
<!ENTITY % repsep      "repsep"                                      >
<!ENTITY % kwd         "kwd"                                         >

<!-- ============================================================= -->
<!--                    ELEMENT DECLARATIONS                       -->
<!-- ============================================================= -->

<!ENTITY % univ-atts-no-importance
              "base
                          CDATA
                                    #IMPLIED
               %base-attribute-extensions;
               %id-atts;
               %filter-atts;
               %localization-atts;
               outputclass
                          CDATA
                                    #IMPLIED
               rev
                          CDATA
                                    #IMPLIED
               status
                          (new |
                           changed |
                           deleted |
                           unchanged |
                           -dita-use-conref-target)
                                    #IMPLIED"
>

<!--                    LONG NAME: Variable                        -->
<!ENTITY % var.content
                       "(%words.cnt;)*"
>
<!ENTITY % var.attributes
              "importance
                          (default |
                           optional |
                           required |
                           -dita-use-conref-target)
                                    #IMPLIED
               %univ-atts-no-importance;"
>
<!ELEMENT  var %var.content;>
<!ATTLIST  var %var.attributes;>

<!--                    LONG NAME: Syntax Phrase                   -->
<!ENTITY % synph.content
                       "(#PCDATA |
                         %codeph; |
                         %delim; |
                         %kwd; |
                         %oper; |
                         %option; |
                         %parmname; |
                         %sep; |
                         %synph; |
                         %text; |
                         %var;)*"
>
<!ENTITY % synph.attributes
              "%univ-atts;"
>
<!ELEMENT  synph %synph.content;>
<!ATTLIST  synph %synph.attributes;>


<!--                    LONG NAME: Operator                        -->
<!ENTITY % oper.content
                       "(%words.cnt;)*"
>
<!ENTITY % oper.attributes
              "importance
                          (default |
                           optional |
                           required |
                           -dita-use-conref-target)
                                    #IMPLIED
               %univ-atts-no-importance;"
>
<!ELEMENT  oper %oper.content;>
<!ATTLIST  oper %oper.attributes;>


<!--                    LONG NAME: Delimiter                       -->
<!ENTITY % delim.content
                       "(%words.cnt;)*"
>
<!ENTITY % delim.attributes
              "importance
                          (optional |
                           required |
                           -dita-use-conref-target)
                                    #IMPLIED
               %univ-atts-no-importance;"
>
<!ELEMENT  delim %delim.content;>
<!ATTLIST  delim %delim.attributes;>


<!--                    LONG NAME: Separator                       -->
<!ENTITY % sep.content
                       "(%words.cnt;)*"
>
<!ENTITY % sep.attributes
              "importance
                          (optional |
                           required |
                           -dita-use-conref-target)
                                    #IMPLIED
               %univ-atts-no-importance;"
>
<!ELEMENT  sep %sep.content;>
<!ATTLIST  sep %sep.attributes;>


<!--                    LONG NAME: Syntax Diagram                  -->
<!ENTITY % syntaxdiagram.content
                       "((%title;)?,
                         (%fragment; |
                          %fragref; |
                          %groupchoice; |
                          %groupcomp; |
                          %groupseq; |
                          %synblk; |
                          %synnote; |
                          %synnoteref;)*)"
>
<!ENTITY % syntaxdiagram.attributes
              "%display-atts;
               %univ-atts;"
>
<!ELEMENT  syntaxdiagram %syntaxdiagram.content;>
<!ATTLIST  syntaxdiagram %syntaxdiagram.attributes;>


<!--                    LONG NAME: Syntax Block                    -->
<!ENTITY % synblk.content
                       "((%title;)?,
                         (%fragment; |
                          %fragref; |
                          %groupchoice; |
                          %groupcomp; |
                          %groupseq; |
                          %synnote; |
                          %synnoteref;)*)"
>
<!ENTITY % synblk.attributes
              "%univ-atts;"
>
<!ELEMENT  synblk %synblk.content;>
<!ATTLIST  synblk %synblk.attributes;>


<!--                    LONG NAME: Sequence Group                  -->
<!ENTITY % groupseq.content
                       "((%title;)?,
                         (%repsep;)?,
                         (%delim; |
                          %fragref; |
                          %groupchoice; |
                          %groupcomp; |
                          %groupseq; |
                          %kwd; |
                          %oper; |
                          %sep; |
                          %synnote; |
                          %synnoteref; |
                          %var;)*)"
>
<!ENTITY % groupseq.attributes
              "importance
                          (default |
                           required |
                           optional |
                           -dita-use-conref-target)
                                    #IMPLIED
               %univ-atts-no-importance;"
>
<!ELEMENT  groupseq %groupseq.content;>
<!ATTLIST  groupseq %groupseq.attributes;>


<!--                    LONG NAME: Choice Group                    -->
<!ENTITY % groupchoice.content
                       "((%title;)?,
                         (%repsep;)?,
                         (%delim; |
                          %fragref; |
                          %groupchoice; |
                          %groupcomp; |
                          %groupseq; |
                          %kwd; |
                          %oper; |
                          %sep; |
                          %synnote; |
                          %synnoteref; |
                          %var;)*)"
>
<!ENTITY % groupchoice.attributes
              "importance
                          (default |
                           required |
                           optional |
                           -dita-use-conref-target)
                                    #IMPLIED
               %univ-atts-no-importance;"
>
<!ELEMENT  groupchoice %groupchoice.content;>
<!ATTLIST  groupchoice %groupchoice.attributes;>


<!--                    LONG NAME: Composite group                 -->
<!ENTITY % groupcomp.content
                       "((%title;)?,
                         (%repsep;)?,
                         (%delim; |
                          %fragref; |
                          %groupchoice; |
                          %groupcomp; |
                          %groupseq; |
                          %kwd; |
                          %oper; |
                          %sep; |
                          %synnote; |
                          %synnoteref; |
                          %var;)*)"
>
<!ENTITY % groupcomp.attributes
              "importance
                          (default |
                           required |
                           optional |
                           -dita-use-conref-target)
                                    #IMPLIED
               %univ-atts-no-importance;"
>
<!ELEMENT  groupcomp %groupcomp.content;>
<!ATTLIST  groupcomp %groupcomp.attributes;>


<!--                    LONG NAME: Fragment                        -->
<!ENTITY % fragment.content
                       "((%title;)?,
                         (%fragref; |
                          %groupchoice; |
                          %groupcomp; |
                          %groupseq; |
                          %synnote; |
                          %synnoteref;)*)"
>
<!ENTITY % fragment.attributes
              "%univ-atts;"
>
<!ELEMENT  fragment %fragment.content;>
<!ATTLIST  fragment %fragment.attributes;>


<!--                    LONG NAME: Fragment Reference              -->
<!ENTITY % fragref.content
                       "(%xrefph.cnt;)*"
>
<!ENTITY % fragref.attributes
              "href
                          CDATA
                                    #IMPLIED
               importance
                          (optional |
                           required |
                           -dita-use-conref-target)
                                    #IMPLIED
               %univ-atts-no-importance;"
>
<!ELEMENT  fragref %fragref.content;>
<!ATTLIST  fragref %fragref.attributes;>


<!--                    LONG NAME: Syntax Diagram Note             -->
<!ENTITY % synnote.content
                       "(#PCDATA |
                         %basic.ph;)*"
>
<!ENTITY % synnote.attributes
              "callout
                          CDATA
                                    #IMPLIED
               %univ-atts;"
>
<!ELEMENT  synnote %synnote.content;>
<!ATTLIST  synnote %synnote.attributes;>


<!--                    LONG NAME: Syntax Note Reference           -->
<!ENTITY % synnoteref.content
                       "EMPTY"
>
<!ENTITY % synnoteref.attributes
              "href
                          CDATA
                                    #IMPLIED
               %univ-atts;"
>
<!ELEMENT  synnoteref %synnoteref.content;>
<!ATTLIST  synnoteref %synnoteref.attributes;>


<!--                    LONG NAME: Repeat Separator                -->
<!ENTITY % repsep.content
                       "(%words.cnt;)*"
>
<!ENTITY % repsep.attributes
              "importance
                          (optional |
                           required |
                           -dita-use-conref-target)
                                    #IMPLIED
               %univ-atts-no-importance;"
>
<!ELEMENT  repsep %repsep.content;>
<!ATTLIST  repsep %repsep.attributes;>


<!--                    LONG NAME: Syntax Keyword                  -->
<!ENTITY % kwd.content
                       "(#PCDATA |
                         %text;)*"
>
<!ENTITY % kwd.attributes
              "keyref
                          CDATA
                                    #IMPLIED
               importance
                          (default |
                           required |
                           optional |
                           -dita-use-conref-target)
                                    #IMPLIED
               %univ-atts-no-importance;"
>
<!ELEMENT  kwd %kwd.content;>
<!ATTLIST  kwd %kwd.attributes;>



<!-- ============================================================= -->
<!--             SPECIALIZATION ATTRIBUTE DECLARATIONS             -->
<!-- ============================================================= -->
  
<!ATTLIST  delim        class CDATA "+ topic/ph pr-d/ph syntaxdiagram-d/delim ">
<!ATTLIST  fragment     class CDATA "+ topic/figgroup pr-d/figgroup syntaxdiagram-d/fragment ">
<!ATTLIST  fragref      class CDATA "+ topic/xref pr-d/xref syntaxdiagram-d/fragref ">
<!ATTLIST  groupchoice  class CDATA "+ topic/figgroup pr-d/figgroup syntaxdiagram-d/groupchoice ">
<!ATTLIST  groupcomp    class CDATA "+ topic/figgroup pr-d/figgroup syntaxdiagram-d/groupcomp ">
<!ATTLIST  groupseq     class CDATA "+ topic/figgroup pr-d/figgroup syntaxdiagram-d/groupseq ">
<!ATTLIST  kwd          class CDATA "+ topic/keyword pr-d/keyword syntaxdiagram-d/kwd ">
<!ATTLIST  oper         class CDATA "+ topic/ph pr-d/ph syntaxdiagram-d/oper ">
<!ATTLIST  repsep       class CDATA "+ topic/ph pr-d/ph syntaxdiagram-d/repsep ">
<!ATTLIST  sep          class CDATA "+ topic/ph pr-d/ph syntaxdiagram-d/sep ">
<!ATTLIST  synblk       class CDATA "+ topic/figgroup pr-d/figgroup syntaxdiagram-d/synblk ">
<!ATTLIST  synnote      class CDATA "+ topic/fn pr-d/fn syntaxdiagram-d/synnote ">
<!ATTLIST  synnoteref   class CDATA "+ topic/xref pr-d/xref syntaxdiagram-d/synnoteref ">
<!ATTLIST  synph        class CDATA "+ topic/ph pr-d/ph syntaxdiagram-d/synph ">
<!ATTLIST  syntaxdiagram class CDATA "+ topic/fig pr-d/fig syntaxdiagram-d/syntaxdiagram ">
<!ATTLIST  var          class CDATA "+ topic/ph pr-d/ph syntaxdiagram-d/var ">

<!-- ================== End of DITA Programming Domain ==================== -->
 