<?xml version="1.0" encoding="UTF-8"?>
<!-- ============================================================= -->
<!--                    HEADER                                     -->
<!-- ============================================================= -->
<!--  MODULE:    DITA Strict Taskbody Constraint                   -->
<!--  VERSION:   2.0                                               -->
<!--  DATE:      [[[Release date]]]                                        -->
<!--  PURPOSE:   Declaring the domain entity for the strict task   -->
<!--             constraint module                                 -->
<!--                                                               -->
<!-- ============================================================= -->
<!-- ============================================================= -->
<!--                    PUBLIC DOCUMENT TYPE DEFINITION            -->
<!--                    TYPICAL INVOCATION                         -->
<!--                                                               -->
<!--  Refer to this file by the following public identifier or an  -->
<!--       appropriate system identifier                           -->
<!-- PUBLIC "-//OASIS//ELEMENTS DITA 2.0 Strict Taskbody Constraint//EN" -->
<!--       Delivered as file "strictTaskbodyConstraint.mod"             -->
<!-- ============================================================= -->
<!--             (C) Copyright OASIS Open 2008, 2014.              -->
<!--             All Rights Reserved.                              -->
<!--                                                               -->
<!--  UPDATES:                                                     -->
<!-- ============================================================= -->
<!--                                                               -->

<!ENTITY % prereq                                          "prereq">
<!ENTITY % context                                         "context">
<!ENTITY % steps                                           "steps">
<!ENTITY % steps-unordered                                 "steps-unordered">
<!ENTITY % result                                          "result">
<!ENTITY % tasktroubleshooting                             "tasktroubleshooting">
<!ENTITY % example                                         "example">
<!ENTITY % postreq                                         "postreq">

<!ENTITY % taskbody.content
              "((%prereq;)?,
                (%context;)?,
                (%steps; |
                 %steps-unordered;)?,
                (%result;)?,
                (%tasktroubleshooting;)?,
                (%example;)?,
                (%postreq;)?)"
>

<!-- ================== DITA Strict Taskbody Constraint ==================== -->
 