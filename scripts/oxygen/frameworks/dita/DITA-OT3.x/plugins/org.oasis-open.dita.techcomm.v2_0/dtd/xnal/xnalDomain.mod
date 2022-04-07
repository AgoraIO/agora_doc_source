<?xml version="1.0" encoding="UTF-8"?>
<!-- ============================================================= -->
<!--                    HEADER                                     -->
<!-- ============================================================= -->
<!--  MODULE:    XNAL Domain                                       -->
<!--  VERSION:   2.0                                               -->
<!--  DATE:      [[[Release date]]]                                     -->
<!--  PURPOSE:   Define elements and specialization atttributes    -->
<!--             for the XNAL Domain                               -->
<!--                                                               -->
<!-- ============================================================= -->
<!-- ============================================================= -->
<!--                    PUBLIC DOCUMENT TYPE DEFINITION            -->
<!--                    TYPICAL INVOCATION                         -->
<!--                                                               -->
<!--  Refer to this file by the following public identfier or an   -->
<!--       appropriate system identifier                           -->
<!-- PUBLIC "-//OASIS//ELEMENTS DITA 2.0 XNAL Domain//EN"              -->
<!--       Delivered as file "xnalDomain.mod"                           -->
<!-- ============================================================= -->
<!--             (C) Copyright OASIS Open 2006, 2009.              -->
<!--             All Rights Reserved.                              -->
<!--  UPDATES:                                                     -->
<!-- =============================================================   -->

<!-- ============================================================= -->
<!--                   ELEMENT NAME ENTITIES                       -->
<!-- ============================================================= -->

<!ENTITY % authorinformation
                       "authorinformation"                           >
<!ENTITY % namedetails "namedetails"                                 >
<!ENTITY % organizationnamedetails
                       "organizationnamedetails"                     >
<!ENTITY % organizationname
                       "organizationname"                            >
<!ENTITY % personname  "personname"                                  >
<!ENTITY % honorific   "honorific"                                   >
<!ENTITY % firstname   "firstname"                                   >
<!ENTITY % middlename  "middlename"                                  >
<!ENTITY % lastname    "lastname"                                    >
<!ENTITY % generationidentifier
                       "generationidentifier"                        >
<!ENTITY % otherinfo   "otherinfo"                                   >
<!ENTITY % addressdetails
                       "addressdetails"                              >
<!ENTITY % locality    "locality"                                    >
<!ENTITY % localityname
                       "localityname"                                >
<!ENTITY % administrativearea
                       "administrativearea"                          >
<!ENTITY % thoroughfare
                       "thoroughfare"                                >
<!ENTITY % postalcode  "postalcode"                                  >
<!ENTITY % country     "country"                                     >
<!ENTITY % personinfo  "personinfo"                                  >
<!ENTITY % organizationinfo
                       "organizationinfo"                            >
<!ENTITY % contactnumbers
                       "contactnumbers"                              >
<!ENTITY % contactnumber
                       "contactnumber"                               >
<!ENTITY % emailaddresses
                       "emailaddresses"                              >
<!ENTITY % emailaddress
                       "emailaddress"                                >
<!ENTITY % urls        "urls"                                        >
<!ENTITY % url         "url"                                         >

<!-- ============================================================= -->
<!--                    ELEMENT DECLARATIONS                       -->
<!-- ============================================================= -->

<!--                    LONG NAME: Author Information              -->
<!ENTITY % authorinformation.content
                       "(%organizationinfo; |
                         %personinfo;)*"
>
<!ENTITY % authorinformation.attributes
              "%univ-atts;
               href
                          CDATA
                                    #IMPLIED
               format
                          CDATA
                                    #IMPLIED
               type
                          CDATA
                                    #IMPLIED
               scope
                          (external |
                           local |
                           peer |
                           -dita-use-conref-target)
                                    #IMPLIED
               keyref
                          CDATA
                                    #IMPLIED"
>
<!ELEMENT  authorinformation %authorinformation.content;>
<!ATTLIST  authorinformation %authorinformation.attributes;>


<!--                    LONG NAME: Name Details                    -->
<!ENTITY % namedetails.content
                       "(%organizationnamedetails; |
                         %personname;)*"
>
<!ENTITY % namedetails.attributes
              "%data-element-atts;"
>
<!ELEMENT  namedetails %namedetails.content;>
<!ATTLIST  namedetails %namedetails.attributes;>


<!--                    LONG NAME: Organization Details            -->
<!ENTITY % organizationnamedetails.content
                       "((%organizationname;)?,
                         (%otherinfo;)*)"
>
<!ENTITY % organizationnamedetails.attributes
              "keyref
                          CDATA
                                    #IMPLIED
               %univ-atts;"
>
<!ELEMENT  organizationnamedetails %organizationnamedetails.content;>
<!ATTLIST  organizationnamedetails %organizationnamedetails.attributes;>


<!--                    LONG NAME: Organization Name               -->
<!ENTITY % organizationname.content
                       "(%ph.cnt;)*"
>
<!ENTITY % organizationname.attributes
              "keyref
                          CDATA
                                    #IMPLIED
               %univ-atts;"
>
<!ELEMENT  organizationname %organizationname.content;>
<!ATTLIST  organizationname %organizationname.attributes;>


<!--                    LONG NAME: Person Name                     -->
<!ENTITY % personname.content
                       "((%honorific;)?,
                         (%firstname;)*,
                         (%middlename;)*,
                         (%lastname;)*,
                         (%generationidentifier;)?,
                         (%otherinfo;)*)"
>
<!ENTITY % personname.attributes
              "%data-element-atts;"
>
<!ELEMENT  personname %personname.content;>
<!ATTLIST  personname %personname.attributes;>


<!--                    LONG NAME: Honorific                       -->
<!ENTITY % honorific.content
                       "(#PCDATA |
                         %keyword; |
                         %text;)*"
>
<!ENTITY % honorific.attributes
              "%data-element-atts;"
>
<!ELEMENT  honorific %honorific.content;>
<!ATTLIST  honorific %honorific.attributes;>


<!--                    LONG NAME: First Name                      -->
<!ENTITY % firstname.content
                       "(#PCDATA |
                         %keyword; |
                         %text;)*"
>
<!ENTITY % firstname.attributes
              "%data-element-atts;"
>
<!ELEMENT  firstname %firstname.content;>
<!ATTLIST  firstname %firstname.attributes;>


<!--                    LONG NAME: Middle Name                     -->
<!ENTITY % middlename.content
                       "(#PCDATA |
                         %keyword; |
                         %text;)*"
>
<!ENTITY % middlename.attributes
              "%data-element-atts;"
>
<!ELEMENT  middlename %middlename.content;>
<!ATTLIST  middlename %middlename.attributes;>


<!--                    LONG NAME: Last Name                       -->
<!ENTITY % lastname.content
                       "(#PCDATA |
                         %keyword; |
                         %text;)*"
>
<!ENTITY % lastname.attributes
              "%data-element-atts;"
>
<!ELEMENT  lastname %lastname.content;>
<!ATTLIST  lastname %lastname.attributes;>


<!--                    LONG NAME: Generation Identifier           -->
<!ENTITY % generationidentifier.content
                       "(#PCDATA |
                         %keyword; |
                         %text;)*"
>
<!ENTITY % generationidentifier.attributes
              "%data-element-atts;"
>
<!ELEMENT  generationidentifier %generationidentifier.content;>
<!ATTLIST  generationidentifier %generationidentifier.attributes;>


<!--                    LONG NAME: Other Information               -->
<!ENTITY % otherinfo.content
                       "(%words.cnt;)*"
>
<!ENTITY % otherinfo.attributes
              "%data-element-atts;"
>
<!ELEMENT  otherinfo %otherinfo.content;>
<!ATTLIST  otherinfo %otherinfo.attributes;>


<!--                    LONG NAME: Address Details                 -->
<!ENTITY % addressdetails.content
                       "(%words.cnt; |
                         %administrativearea; |
                         %country; |
                         %locality; |
                         %thoroughfare;)*"
>
<!ENTITY % addressdetails.attributes
              "keyref
                          CDATA
                                    #IMPLIED
               %univ-atts;"
>
<!ELEMENT  addressdetails %addressdetails.content;>
<!ATTLIST  addressdetails %addressdetails.attributes;>


<!--                    LONG NAME: Locality                        -->
<!ENTITY % locality.content
                       "(%words.cnt; |
                         %localityname; |
                         %postalcode;)*"
>
<!ENTITY % locality.attributes
              "keyref
                          CDATA
                                    #IMPLIED
               %univ-atts;"
>
<!ELEMENT  locality %locality.content;>
<!ATTLIST  locality %locality.attributes;>


<!--                    LONG NAME: Locality Name                   -->
<!ENTITY % localityname.content
                       "(%words.cnt;)*"
>
<!ENTITY % localityname.attributes
              "keyref
                          CDATA
                                    #IMPLIED
               %univ-atts;"
>
<!ELEMENT  localityname %localityname.content;>
<!ATTLIST  localityname %localityname.attributes;>


<!--                    LONG NAME: Administrative Area             -->
<!ENTITY % administrativearea.content
                       "(%words.cnt;)*"
>
<!ENTITY % administrativearea.attributes
              "keyref
                          CDATA
                                    #IMPLIED
               %univ-atts;"
>
<!ELEMENT  administrativearea %administrativearea.content;>
<!ATTLIST  administrativearea %administrativearea.attributes;>


<!--                    LONG NAME: Thoroughfare                    -->
<!ENTITY % thoroughfare.content
                       "(%words.cnt;)*"
>
<!ENTITY % thoroughfare.attributes
              "keyref
                          CDATA
                                    #IMPLIED
               %univ-atts;"
>
<!ELEMENT  thoroughfare %thoroughfare.content;>
<!ATTLIST  thoroughfare %thoroughfare.attributes;>


<!--                    LONG NAME: Postal Code                     -->
<!ENTITY % postalcode.content
                       "(#PCDATA |
                         %keyword; |
                         %text;)*"
>
<!ENTITY % postalcode.attributes
              "keyref
                          CDATA
                                    #IMPLIED
               %univ-atts;"
>
<!ELEMENT  postalcode %postalcode.content;>
<!ATTLIST  postalcode %postalcode.attributes;>


<!--                    LONG NAME: Country                         -->
<!ENTITY % country.content
                       "(#PCDATA |
                         %keyword; |
                         %text;)*"
>
<!ENTITY % country.attributes
              "keyref
                          CDATA
                                    #IMPLIED
               %univ-atts;"
>
<!ELEMENT  country %country.content;>
<!ATTLIST  country %country.attributes;>


<!--                    LONG NAME: Person Information              -->
<!ENTITY % personinfo.content
                       "((%namedetails;)?,
                         (%addressdetails;)?,
                         (%contactnumbers;)?,
                         (%emailaddresses;)?)"
>
<!ENTITY % personinfo.attributes
              "%data-element-atts;"
>
<!ELEMENT  personinfo %personinfo.content;>
<!ATTLIST  personinfo %personinfo.attributes;>


<!--                    LONG NAME: Organization Information        -->
<!ENTITY % organizationinfo.content
                       "((%namedetails;)?,
                         (%addressdetails;)?,
                         (%contactnumbers;)?,
                         (%emailaddresses;)?,
                         (%urls;)?)"
>
<!ENTITY % organizationinfo.attributes
              "%data-element-atts;"
>
<!ELEMENT  organizationinfo %organizationinfo.content;>
<!ATTLIST  organizationinfo %organizationinfo.attributes;>


<!--                    LONG NAME: Contact Numbers                 -->
<!ENTITY % contactnumbers.content
                       "(%contactnumber;)*"
>
<!ENTITY % contactnumbers.attributes
              "%data-element-atts;"
>
<!ELEMENT  contactnumbers %contactnumbers.content;>
<!ATTLIST  contactnumbers %contactnumbers.attributes;>


<!--                    LONG NAME: Contact Number                  -->
<!ENTITY % contactnumber.content
                       "(#PCDATA |
                         %keyword; |
                         %text;)*"
>
<!ENTITY % contactnumber.attributes
              "%data-element-atts;"
>
<!ELEMENT  contactnumber %contactnumber.content;>
<!ATTLIST  contactnumber %contactnumber.attributes;>


<!--                    LONG NAME: Email Addresses                 -->
<!ENTITY % emailaddresses.content
                       "(%emailaddress;)*"
>
<!ENTITY % emailaddresses.attributes
              "%data-element-atts;"
>
<!ELEMENT  emailaddresses %emailaddresses.content;>
<!ATTLIST  emailaddresses %emailaddresses.attributes;>


<!--                    LONG NAME: Email Address                   -->
<!ENTITY % emailaddress.content
                       "(%words.cnt;)*"
>
<!ENTITY % emailaddress.attributes
              "%data-element-atts;"
>
<!ELEMENT  emailaddress %emailaddress.content;>
<!ATTLIST  emailaddress %emailaddress.attributes;>


<!--                    LONG NAME: URLs                            -->
<!ENTITY % urls.content
                       "(%url;)*"
>
<!ENTITY % urls.attributes
              "%data-element-atts;"
>
<!ELEMENT  urls %urls.content;>
<!ATTLIST  urls %urls.attributes;>


<!--                    LONG NAME: URL                             -->
<!ENTITY % url.content
                       "(%words.cnt;)*"
>
<!ENTITY % url.attributes
              "%data-element-atts;"
>
<!ELEMENT  url %url.content;>
<!ATTLIST  url %url.attributes;>



<!-- ============================================================= -->
<!--             SPECIALIZATION ATTRIBUTE DECLARATIONS             -->
<!-- ============================================================= -->
  
<!ATTLIST  addressdetails class CDATA "+ topic/ph xnal-d/addressdetails ">
<!ATTLIST  administrativearea class CDATA "+ topic/ph xnal-d/administrativearea ">
<!ATTLIST  authorinformation class CDATA "+ topic/author xnal-d/authorinformation ">
<!ATTLIST  contactnumber class CDATA "+ topic/data xnal-d/contactnumber ">
<!ATTLIST  contactnumbers class CDATA "+ topic/data xnal-d/contactnumbers ">
<!ATTLIST  country      class CDATA "+ topic/ph xnal-d/country ">
<!ATTLIST  emailaddress class CDATA "+ topic/data xnal-d/emailaddress ">
<!ATTLIST  emailaddresses class CDATA "+ topic/data xnal-d/emailaddresses ">
<!ATTLIST  firstname    class CDATA "+ topic/data xnal-d/firstname ">
<!ATTLIST  generationidentifier class CDATA "+ topic/data xnal-d/generationidentifier ">
<!ATTLIST  honorific    class CDATA "+ topic/data xnal-d/honorific ">
<!ATTLIST  lastname     class CDATA "+ topic/data xnal-d/lastname ">
<!ATTLIST  locality     class CDATA "+ topic/ph xnal-d/locality ">
<!ATTLIST  localityname class CDATA "+ topic/ph xnal-d/localityname ">
<!ATTLIST  middlename   class CDATA "+ topic/data xnal-d/middlename ">
<!ATTLIST  namedetails  class CDATA "+ topic/data xnal-d/namedetails ">
<!ATTLIST  organizationinfo class CDATA "+ topic/data xnal-d/organizationinfo ">
<!ATTLIST  organizationname class CDATA "+ topic/ph xnal-d/organizationname ">
<!ATTLIST  organizationnamedetails class CDATA "+ topic/ph xnal-d/organizationnamedetails ">
<!ATTLIST  otherinfo    class CDATA "+ topic/data xnal-d/otherinfo ">
<!ATTLIST  personinfo   class CDATA "+ topic/data xnal-d/personinfo ">
<!ATTLIST  personname   class CDATA "+ topic/data xnal-d/personname ">
<!ATTLIST  postalcode   class CDATA "+ topic/ph xnal-d/postalcode ">
<!ATTLIST  thoroughfare class CDATA "+ topic/ph xnal-d/thoroughfare ">
<!ATTLIST  url          class CDATA "+ topic/data xnal-d/url ">
<!ATTLIST  urls         class CDATA "+ topic/data xnal-d/urls ">

<!-- ================== End of DITA XNAL Domain ==================== -->
 