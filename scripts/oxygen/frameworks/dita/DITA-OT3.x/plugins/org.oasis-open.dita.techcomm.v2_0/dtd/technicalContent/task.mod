<?xml version="1.0" encoding="UTF-8"?>
<!-- ============================================================= -->
<!--                    HEADER                                     -->
<!-- ============================================================= -->
<!--  MODULE:    DITA Task                                         -->
<!--  VERSION:   2.0                                               -->
<!--  DATE:      [[[Release date]]]                                        -->
<!--  PURPOSE:   Declaring the elements and specialization         -->
<!--             attributes for the DITA Tasks                     -->
<!--                                                               -->
<!-- ============================================================= -->
<!-- ============================================================= -->
<!--                    PUBLIC DOCUMENT TYPE DEFINITION            -->
<!--                    TYPICAL INVOCATION                         -->
<!--                                                               -->
<!--  Refer to this file by the following public identifier or an  -->
<!--       appropriate system identifier                           -->
<!-- PUBLIC "-//OASIS//ELEMENTS DITA 2.0 Task//EN"                     -->
<!--       Delivered as file "task.mod"                                 -->
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

<!ENTITY % task        "task"                                        >
<!ENTITY % taskbody    "taskbody"                                    >
<!ENTITY % prereq      "prereq"                                      >
<!ENTITY % context     "context"                                     >
<!ENTITY % steps-informal
                       "steps-informal"                              >
<!ENTITY % steps       "steps"                                       >
<!ENTITY % steps-unordered
                       "steps-unordered"                             >
<!ENTITY % stepsection "stepsection"                                 >
<!ENTITY % step        "step"                                        >
<!ENTITY % cmd         "cmd"                                         >
<!ENTITY % info        "info"                                        >
<!ENTITY % tutorialinfo
                       "tutorialinfo"                                >
<!ENTITY % stepxmp     "stepxmp"                                     >
<!ENTITY % choices     "choices"                                     >
<!ENTITY % choice      "choice"                                      >
<!ENTITY % choicetable "choicetable"                                 >
<!ENTITY % chhead      "chhead"                                      >
<!ENTITY % choptionhd  "choptionhd"                                  >
<!ENTITY % chdeschd    "chdeschd"                                    >
<!ENTITY % chrow       "chrow"                                       >
<!ENTITY % choption    "choption"                                    >
<!ENTITY % chdesc      "chdesc"                                      >
<!ENTITY % stepresult  "stepresult"                                  >
<!ENTITY % steptroubleshooting
                       "steptroubleshooting"                         >
<!ENTITY % tasktroubleshooting
                       "tasktroubleshooting"                         >
<!ENTITY % result      "result"                                      >
<!ENTITY % postreq     "postreq"                                     >

<!-- ============================================================= -->
<!--                    ELEMENT DECLARATIONS                       -->
<!-- ============================================================= -->

<!ENTITY % task-info-types
              "%info-types;"
>
<!ENTITY % univ-atts-no-importance-task
              "%id-atts;
               %filter-atts;
               base
                          CDATA
                                    #IMPLIED
               %base-attribute-extensions;
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
                                    #IMPLIED
               %localization-atts;"
>
<!--                    LONG NAME: Task                            -->
<!ENTITY % task.content
                       "((%title;),
                         (%abstract; |
                          %shortdesc;)?,
                         (%prolog;)?,
                         (%taskbody;)?,
                         (%related-links;)?,
                         (%task-info-types;)*)"
>
<!ENTITY % task.attributes
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
<!ELEMENT  task %task.content;>
<!ATTLIST  task %task.attributes;
                 %arch-atts;
                 specializations 
                        CDATA
                                  "&included-domains;"
>


<!--                    LONG NAME: Task Body                       -->
<!ENTITY % taskbody.content
                       "((%prereq; |
                          %context; |
                          %section;)*,
                         (%steps; |
                          %steps-unordered; |
                          %steps-informal;)?,
                         (%result;)?,
                         (%tasktroubleshooting;)?,
                         (%example;)*,
                         (%postreq;)*)"
>
<!ENTITY % taskbody.attributes
              "%univ-atts;"
>
<!ELEMENT  taskbody %taskbody.content;>
<!ATTLIST  taskbody %taskbody.attributes;>


<!--                    LONG NAME: Prerequisites                   -->
<!ENTITY % prereq.content
                       "(%section.notitle.cnt;)*"
>
<!ENTITY % prereq.attributes
              "%univ-atts;"
>
<!ELEMENT  prereq %prereq.content;>
<!ATTLIST  prereq %prereq.attributes;>


<!--                    LONG NAME: Context                         -->
<!ENTITY % context.content
                       "(%section.notitle.cnt;)*"
>
<!ENTITY % context.attributes
              "%univ-atts;"
>
<!ELEMENT  context %context.content;>
<!ATTLIST  context %context.attributes;>


<!--                    LONG NAME: Informal Steps                  -->
<!ENTITY % steps-informal.content
                       "(%section.notitle.cnt;)*"
>
<!ENTITY % steps-informal.attributes
              "%univ-atts;"
>
<!ELEMENT  steps-informal %steps-informal.content;>
<!ATTLIST  steps-informal %steps-informal.attributes;>


<!--                    LONG NAME: Steps                           -->
<!ENTITY % steps.content
                       "((%data;)*,
                         ((%stepsection;)?,
                          (%step;))+)"
>
<!ENTITY % steps.attributes
              "%univ-atts;"
>
<!ELEMENT  steps %steps.content;>
<!ATTLIST  steps %steps.attributes;>


<!--                    LONG NAME: Unordered steps                 -->
<!ENTITY % steps-unordered.content
                       "((%data;)*,
                         ((%stepsection;)?,
                          (%step;))+)"
>
<!ENTITY % steps-unordered.attributes
              "%univ-atts;"
>
<!ELEMENT  steps-unordered %steps-unordered.content;>
<!ATTLIST  steps-unordered %steps-unordered.attributes;>


<!--                    LONG NAME: Step section                    -->
<!ENTITY % stepsection.content
                       "(%listitem.cnt;)*"
>
<!ENTITY % stepsection.attributes
              "%univ-atts;"
>
<!ELEMENT  stepsection %stepsection.content;>
<!ATTLIST  stepsection %stepsection.attributes;>


<!--                    LONG NAME: Step                            -->
<!ENTITY % step.content
                       "((%note;)*,
                         (%cmd;),
                         (%choices; |
                          %choicetable; |
                          %info; |
                          %div; |
                          %stepxmp; |
                          %steps; |
                          %steps-unordered; |
                          %tutorialinfo;)*,
                         (%stepresult;)?,
                         (%steptroubleshooting;)?)"
>
<!ENTITY % step.attributes
              "importance
                          (optional |
                           required |
                           -dita-use-conref-target)
                                    #IMPLIED
               %univ-atts-no-importance-task;"
>
<!ELEMENT  step %step.content;>
<!ATTLIST  step %step.attributes;>


<!--                    LONG NAME: Command                         -->
<!ENTITY % cmd.content
                       "(%ph.cnt;)*"
>
<!ENTITY % cmd.attributes
              "keyref
                          CDATA
                                    #IMPLIED
               %univ-atts;"
>
<!ELEMENT  cmd %cmd.content;>
<!ATTLIST  cmd %cmd.attributes;>


<!--                    LONG NAME: Information                     -->
<!ENTITY % info.content
                       "(%div.cnt;)*"
>
<!ENTITY % info.attributes
              "%univ-atts;"
>
<!ELEMENT  info %info.content;>
<!ATTLIST  info %info.attributes;>


<!--                    LONG NAME: Tutorial Information            -->
<!ENTITY % tutorialinfo.content
                       "(%div.cnt;)*"
>
<!ENTITY % tutorialinfo.attributes
              "%univ-atts;"
>
<!ELEMENT  tutorialinfo %tutorialinfo.content;>
<!ATTLIST  tutorialinfo %tutorialinfo.attributes;>


<!-- Match div.cnt from base, but exclude example element    -->
<!ENTITY % stepxmp.cnt
              "#PCDATA |
               %basic.block.noexample; |
               %basic.ph; |
               %data.elements.incl; |
               %foreign.unknown.incl; |
               %txt.incl;"
>


<!--                    LONG NAME: Step Example                    -->
<!ENTITY % stepxmp.content
                       "(%stepxmp.cnt;)*"
>
<!ENTITY % stepxmp.attributes
              "%univ-atts;"
>
<!ELEMENT  stepxmp %stepxmp.content;>
<!ATTLIST  stepxmp %stepxmp.attributes;>


<!--                    LONG NAME: Choices                         -->
<!ENTITY % choices.content
                       "((%data;)*,
                         (%choice;)+)"
>
<!ENTITY % choices.attributes
              "%univ-atts;"
>
<!ELEMENT  choices %choices.content;>
<!ATTLIST  choices %choices.attributes;>


<!--                    LONG NAME: Choice                          -->
<!ENTITY % choice.content
                       "(%listitem.cnt;)*"
>
<!ENTITY % choice.attributes
              "%univ-atts;"
>
<!ELEMENT  choice %choice.content;>
<!ATTLIST  choice %choice.attributes;>


<!--                    LONG NAME: Choice Table                    -->
<!ENTITY % choicetable.content
                       "((%title;)?,
                         (%chhead;)?,
                         (%chrow;)+)"
>
<!ENTITY % choicetable.attributes
              "relcolwidth
                          CDATA
                                    #IMPLIED
               keycol
                          NMTOKEN
                                    '1'
               spectitle
                          CDATA
                                    #IMPLIED
               %display-atts;
               %univ-atts;"
>
<!ELEMENT  choicetable %choicetable.content;>
<!ATTLIST  choicetable %choicetable.attributes;>


<!--                    LONG NAME: Choice Head                     -->
<!ENTITY % chhead.content
                       "((%choptionhd;),
                         (%chdeschd;))"
>
<!ENTITY % chhead.attributes
              "%univ-atts;"
>
<!ELEMENT  chhead %chhead.content;>
<!ATTLIST  chhead %chhead.attributes;>


<!--                    LONG NAME: Choice Option Head              -->
<!ENTITY % choptionhd.content
                       "(%tblcell.cnt;)*"
>
<!ENTITY % choptionhd.attributes
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
<!ELEMENT  choptionhd %choptionhd.content;>
<!ATTLIST  choptionhd %choptionhd.attributes;>


<!--                    LONG NAME: Choice Description Head         -->
<!ENTITY % chdeschd.content
                       "(%tblcell.cnt;)*"
>
<!ENTITY % chdeschd.attributes
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
<!ELEMENT  chdeschd %chdeschd.content;>
<!ATTLIST  chdeschd %chdeschd.attributes;>


<!--                    LONG NAME: Choice Row                      -->
<!ENTITY % chrow.content
                       "((%choption;),
                         (%chdesc;))"
>
<!ENTITY % chrow.attributes
              "%univ-atts;"
>
<!ELEMENT  chrow %chrow.content;>
<!ATTLIST  chrow %chrow.attributes;>


<!--                    LONG NAME: Choice Option                   -->
<!ENTITY % choption.content
                       "(%tblcell.cnt;)*"
>
<!ENTITY % choption.attributes
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
<!ELEMENT  choption %choption.content;>
<!ATTLIST  choption %choption.attributes;>


<!--                    LONG NAME: Choice Description              -->
<!ENTITY % chdesc.content
                       "(%tblcell.cnt;)*"
>
<!ENTITY % chdesc.attributes
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
<!ELEMENT  chdesc %chdesc.content;>
<!ATTLIST  chdesc %chdesc.attributes;>


<!--                    LONG NAME: Step Result                     -->
<!ENTITY % stepresult.content
                       "(%div.cnt;)*"
>
<!ENTITY % stepresult.attributes
              "%univ-atts;"
>
<!ELEMENT  stepresult %stepresult.content;>
<!ATTLIST  stepresult %stepresult.attributes;>


<!--                    LONG NAME: Step Troubleshooting            -->
<!ENTITY % steptroubleshooting.content
                       "(%div.cnt;)*"
>
<!ENTITY % steptroubleshooting.attributes
              "%univ-atts;"
>
<!ELEMENT  steptroubleshooting %steptroubleshooting.content;>
<!ATTLIST  steptroubleshooting %steptroubleshooting.attributes;>


<!--                    LONG NAME: Task Troubleshooting            -->
<!ENTITY % tasktroubleshooting.content
                       "(%section.notitle.cnt;)*"
>
<!ENTITY % tasktroubleshooting.attributes
              "%univ-atts;"
>
<!ELEMENT  tasktroubleshooting %tasktroubleshooting.content;>
<!ATTLIST  tasktroubleshooting %tasktroubleshooting.attributes;>


<!--                    LONG NAME: Result                          -->
<!ENTITY % result.content
                       "(%section.notitle.cnt;)*"
>
<!ENTITY % result.attributes
              "%univ-atts;"
>
<!ELEMENT  result %result.content;>
<!ATTLIST  result %result.attributes;>


<!--                    LONG NAME: Post Requirements               -->
<!ENTITY % postreq.content
                       "(%section.notitle.cnt;)*"
>
<!ENTITY % postreq.attributes
              "%univ-atts;"
>
<!ELEMENT  postreq %postreq.content;>
<!ATTLIST  postreq %postreq.attributes;>



<!-- ============================================================= -->
<!--             SPECIALIZATION ATTRIBUTE DECLARATIONS             -->
<!-- ============================================================= -->
  
<!ATTLIST  task         class CDATA "- topic/topic task/task ">
<!ATTLIST  taskbody     class CDATA "- topic/body task/taskbody ">
<!ATTLIST  steps        class CDATA "- topic/ol task/steps ">
<!ATTLIST  steps-unordered class CDATA "- topic/ul task/steps-unordered ">
<!ATTLIST  stepsection  class CDATA "- topic/li task/stepsection ">
<!ATTLIST  step         class CDATA "- topic/li task/step ">
<!ATTLIST  cmd          class CDATA "- topic/ph task/cmd ">
<!ATTLIST  tutorialinfo class CDATA "- topic/div task/tutorialinfo ">
<!ATTLIST  info         class CDATA "- topic/div task/info ">
<!ATTLIST  stepxmp      class CDATA "- topic/div task/stepxmp ">
<!ATTLIST  stepresult   class CDATA "- topic/div task/stepresult ">
<!ATTLIST  steptroubleshooting class CDATA "- topic/div task/steptroubleshooting ">
<!ATTLIST  choices      class CDATA "- topic/ul task/choices ">
<!ATTLIST  choice       class CDATA "- topic/li task/choice ">
<!ATTLIST  result       class CDATA "- topic/section task/result ">
<!ATTLIST  tasktroubleshooting class CDATA "- topic/section task/tasktroubleshooting ">
<!ATTLIST  prereq       class CDATA "- topic/section task/prereq ">
<!ATTLIST  postreq      class CDATA "- topic/section task/postreq ">
<!ATTLIST  context      class CDATA "- topic/section task/context ">
<!ATTLIST  steps-informal class CDATA "- topic/section task/steps-informal ">
<!ATTLIST  choicetable  class CDATA "- topic/simpletable task/choicetable ">
<!ATTLIST  chhead       class CDATA "- topic/sthead task/chhead ">
<!ATTLIST  chrow        class CDATA "- topic/strow task/chrow ">
<!ATTLIST  choptionhd   class CDATA "- topic/stentry task/choptionhd ">
<!ATTLIST  chdeschd     class CDATA "- topic/stentry task/chdeschd ">
<!ATTLIST  choption     class CDATA "- topic/stentry task/choption ">
<!ATTLIST  chdesc       class CDATA "- topic/stentry task/chdesc ">

<!-- ================== End of DITA Task ==================== -->
 