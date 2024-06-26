<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<!-- This file is generated from param.xweb -->

<!-- ********************************************************************

     This file is part of the XSL DocBook Stylesheet distribution.
     See ../README or http://cdn.docbook.org/release/xsl/current/ for
     copyright and other information.

     ******************************************************************** -->


<doc:refentry xmlns:doc="http://nwalsh.com/xsl/documentation/1.0" id="man.authors.section.enabled">
<refmeta>
<refentrytitle>man.authors.section.enabled</refentrytitle>
<refmiscinfo class="other" otherclass="datatype">boolean</refmiscinfo>
</refmeta>
<refnamediv>
<refname>man.authors.section.enabled</refname>
<refpurpose>Display auto-generated AUTHORS section?</refpurpose>
</refnamediv>

<refsection><info><title>Description</title></info>

<para>If the value of
<parameter>man.authors.section.enabled</parameter> is non-zero
(the default), then an <literal>AUTHORS</literal> section is
generated near the end of each man page. The output of the
<literal>AUTHORS</literal> section is assembled from any
<tag>author</tag>, <tag>editor</tag>, and <tag>othercredit</tag>
metadata found in the contents of the child <tag>info</tag> or
<tag>refentryinfo</tag> (if any) of the <tag>refentry</tag>
itself, or from any <tag>author</tag>, <tag>editor</tag>, and
<tag>othercredit</tag> metadata that may appear in <tag>info</tag>
contents of any ancestors of the <tag>refentry</tag>.</para>

<para>If the value of
<parameter>man.authors.section.enabled</parameter> is zero, the
the auto-generated <literal>AUTHORS</literal> section is
suppressed.</para>

<para>Set the value of
  <parameter>man.authors.section.enabled</parameter> to zero if
  you want to have a manually created <literal>AUTHORS</literal>
  section in your source, and you want it to appear in output
  instead of the auto-generated <literal>AUTHORS</literal>
  section.</para>
</refsection>
</doc:refentry>
<xsl:param name="man.authors.section.enabled">1</xsl:param>

<doc:refentry xmlns:doc="http://nwalsh.com/xsl/documentation/1.0" id="man.break.after.slash">
<refmeta>
<refentrytitle>man.break.after.slash</refentrytitle>
<refmiscinfo class="other" otherclass="datatype">boolean</refmiscinfo>
</refmeta>
<refnamediv>
<refname>man.break.after.slash</refname>
<refpurpose>Enable line-breaking after slashes?</refpurpose>
</refnamediv>



<refsection><info><title>Description</title></info>

<para>If non-zero, line-breaking after slashes is enabled. This is
mainly useful for causing long URLs or pathnames/filenames to be
broken up or "wrapped" across lines (though it also has the side
effect of sometimes causing relatively short URLs and pathnames to be
broken up across lines too).</para>

<para>If zero (the default), line-breaking after slashes is
disabled. In that case, strings containing slashes (for example, URLs
or filenames) are not broken across lines, even if they exceed the
maximum column widith.</para>

<warning>
  <para>If you set a non-zero value for this parameter, check your
  man-page output carefuly afterwards, in order to make sure that the
  setting has not introduced an excessive amount of breaking-up of URLs
  or pathnames. If your content contains mostly short URLs or
  pathnames, setting a non-zero value for
  <parameter>man.break.after.slash</parameter> will probably result in
  in a significant number of relatively short URLs and pathnames being
  broken across lines, which is probably not what you want.</para>
</warning>

</refsection>
</doc:refentry>
<xsl:param name="man.break.after.slash">0</xsl:param>

<doc:refentry xmlns:doc="http://nwalsh.com/xsl/documentation/1.0" id="man.base.url.for.relative.links">
  <refmeta>
    <refentrytitle>man.base.url.for.relative.links</refentrytitle>
    <refmiscinfo class="other" otherclass="datatype">string</refmiscinfo>
  </refmeta>
  <refnamediv>
    <refname>man.base.url.for.relative.links</refname>
    <refpurpose>Specifies a base URL for relative links</refpurpose>
  </refnamediv>

  

  <refsection><info><title>Description</title></info>

    <para>For any “notesource” listed in the auto-generated
      “NOTES” section of output man pages (which is generated when
      the value of the
      <parameter>man.endnotes.list.enabled</parameter> parameter
      is non-zero), if the notesource is a link source with a
      relative URI, the URI is displayed in output with the value
      of the
      <parameter>man.base.url.for.relative.links</parameter>
      parameter prepended to the value of the link URI.</para>

    <note>
      <para>A link source is an notesource that references an
        external resource:
        <itemizedlist>
          <listitem>
            <para>a <tag>ulink</tag> element with a <tag class="attribute">url</tag> attribute</para>
          </listitem>
          <listitem>
            <para>any element with an <tag class="attribute">xlink:href</tag> attribute</para>
          </listitem>
          <listitem>
            <para>an <tag>imagedata</tag>, <tag>audiodata</tag>, or
              <tag>videodata</tag> element</para>
          </listitem>
        </itemizedlist>
      </para>
    </note>

    <para>If you use relative URIs in link sources in your DocBook
      <tag>refentry</tag> source, and you leave
      <parameter>man.base.url.for.relative.links</parameter>
      unset, the relative links will appear “as is” in the “Notes”
      section of any man-page output generated from your source.
      That’s probably not what you want, because such relative
      links are only usable in the context of HTML output. So, to
      make the links meaningful and usable in the context of
      man-page output, set a value for
      <parameter>man.base.url.for.relative.links</parameter> that
      points to the online version of HTML output generated from
      your DocBook <tag>refentry</tag> source. For
      example:
      <programlisting>&lt;xsl:param name="man.base.url.for.relative.links"
        &gt;http://www.kernel.org/pub/software/scm/git/docs/&lt;/xsl:param&gt;</programlisting>
    </para>

  </refsection>

  <refsection><info><title>Related Parameters</title></info>
    <para><parameter>man.endnotes.list.enabled</parameter></para>
  </refsection>

</doc:refentry>
<xsl:param name="man.base.url.for.relative.links">[set $man.base.url.for.relative.links]/</xsl:param>

<doc:refentry xmlns:doc="http://nwalsh.com/xsl/documentation/1.0" id="man.charmap.enabled">
<refmeta>
<refentrytitle>man.charmap.enabled</refentrytitle>
<refmiscinfo class="other" otherclass="datatype">boolean</refmiscinfo>
</refmeta>
<refnamediv>
<refname>man.charmap.enabled</refname>
<refpurpose>Apply character map before final output?</refpurpose>
</refnamediv>



<refsection><info><title>Description</title></info>

<para>If the value of the <parameter>man.charmap.enabled</parameter>
parameter is non-zero, a "character map" is used to substitute certain
Unicode symbols and special characters with appropriate roff/groff
equivalents, just before writing each man-page file to the
filesystem. If instead the value of
<parameter>man.charmap.enabled</parameter> is zero, Unicode characters
are passed through "as is".</para>

<refsection><info><title>Details</title></info>

<para>For converting certain Unicode symbols and special characters in
UTF-8 or UTF-16 encoded XML source to appropriate groff/roff
equivalents in man-page output, the DocBook XSL Stylesheets
distribution includes a <link xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="http://snapshots.docbook.org/xsl/manpages/charmap.groff.xsl">roff character map</link> that is compliant with the <link xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="http://www.w3.org/TR/xslt20/#character-maps">XSLT character
map</link> format as detailed in the XSLT 2.0 specification. The map
contains more than 800 character mappings and can be considered the
standard roff character map for the distribution.</para>

<para>You can use the <parameter>man.charmap.uri</parameter>
parameter to specify a URI for the location for an alternate roff
character map to use in place of the standard roff character map
provided in the distribution.</para>

<para>You can also use a subset of a character map. For details,
see the <parameter>man.charmap.use.subset</parameter>,
<parameter>man.charmap.subset.profile</parameter>, and
<parameter>man.charmap.subset.profile.english</parameter>
parameters.</para>

</refsection>
</refsection>
</doc:refentry>
<xsl:param name="man.charmap.enabled" select="1"/>

<doc:refentry xmlns:doc="http://nwalsh.com/xsl/documentation/1.0" id="man.charmap.subset.profile">
<refmeta>
<refentrytitle>man.charmap.subset.profile</refentrytitle>
<refmiscinfo class="other" otherclass="datatype">string</refmiscinfo>
</refmeta>
<refnamediv>
<refname>man.charmap.subset.profile</refname>
<refpurpose>Profile of character map subset</refpurpose>
</refnamediv>



<refsection><info><title>Description</title></info>

<para>If the value of the
<parameter>man.charmap.use.subset</parameter> parameter is non-zero,
and your DocBook source is not written in English (that
  is, if the <tag class="attribute">lang</tag> or <tag class="attribute">xml:lang</tag> attribute on the root element
  in your DocBook source or on the first <tag>refentry</tag>
  element in your source has a value other than
  <literal>en</literal>), then the character-map subset specified
  by the <parameter>man.charmap.subset.profile</parameter>
  parameter is used instead of the full roff character map.</para>

<para>Otherwise, if the <tag class="attribute">lang</tag> or <tag class="attribute">xml:lang</tag> attribute on the root
  element in your DocBook
  source or on the first <tag>refentry</tag> element in your source
  has the value <literal>en</literal> or if it has no <tag class="attribute">lang</tag> or <tag class="attribute">xml:lang</tag> attribute, then the character-map
  subset specified by the
  <parameter>man.charmap.subset.profile.english</parameter>
  parameter is used instead of
  <parameter>man.charmap.subset.profile</parameter>.</para>

<para>The difference between the two subsets is that
  <parameter>man.charmap.subset.profile</parameter> provides
  mappings for characters in Western European languages that are
  not part of the Roman (English) alphabet (ASCII character set).</para>

<para>The value of <parameter>man.charmap.subset.profile</parameter>
is a string representing an XPath expression that matches attribute
names and values for <tag namespace="http://docbook.sf.net/xmlns/unichar/1.0">output-character</tag>
elements in the character map.</para>

<para>The attributes supported in the <link xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="http://snapshots.docbook.org/xsl/manpages/charmap.groff.xsl">standard roff character map included in the distribution</link> are:
<variablelist>
  <varlistentry>
    <term>character</term>
    <listitem>
      <simpara>a raw Unicode character or numeric Unicode
      character-entity value (either in decimal or hex); all
      characters have this attribute</simpara>
    </listitem>
  </varlistentry>
  <varlistentry>
    <term>name</term>
    <listitem>
      <simpara>a standard full/long ISO/Unicode character name (e.g.,
      "OHM SIGN"); all characters have this attribute</simpara>
    </listitem>
  </varlistentry>
  <varlistentry>
    <term>block</term>
    <listitem>
      <simpara>a standard Unicode "block" name (e.g., "General
      Punctuation"); all characters have this attribute. For the full
      list of Unicode block names supported in the standard roff
      character map, see <xref linkend="BlocksAndClasses"/>.</simpara>
    </listitem>
  </varlistentry>
  <varlistentry>
    <term>class</term>
    <listitem>
      <simpara>a class of characters (e.g., "spaces"). Not all
      characters have this attribute; currently, it is used only with
      certain characters within the "C1 Controls And Latin-1
      Supplement" and "General Punctuation" blocks. For details, see
      <xref linkend="BlocksAndClasses"/>.</simpara>
    </listitem>
  </varlistentry>
  <varlistentry>
    <term>entity</term>
    <listitem>
      <simpara>an ISO entity name (e.g., "ohm"); not all characters
      have this attribute, because not all characters have ISO entity
      names; for example, of the 800 or so characters in the standard
      roff character map included in the distribution, only around 300
      have ISO entity names.
      </simpara>
    </listitem>
  </varlistentry>
  <varlistentry>
    <term>string</term>
    <listitem>
      <simpara>a string representing an roff/groff escape-code (with
      "@esc@" used in place of the backslash), or a simple ASCII
      string; all characters in the roff character map have this
      attribute</simpara>
    </listitem>
  </varlistentry>
</variablelist>
</para>
<para>The value of <parameter>man.charmap.subset.profile</parameter>
is evaluated as an XPath expression at run-time to select a portion of
the roff character map to use. You can tune the subset used by adding
or removing parts. For example, if you need to use a wide range of
mathematical operators in a document, and you want to have them
converted into roff markup properly, you might add the following:

<literallayout class="monospaced">  @*[local-name() = 'block'] ='MathematicalOperators' </literallayout>

That will cause a additional set of around 67 additional "math"
characters to be converted into roff markup. </para>

<note>
<para>Depending on which XSLT engine you use, either the EXSLT
<function>dyn:evaluate</function> extension function (for xsltproc or
Xalan) or <function>saxon:evaluate</function> extension function (for
Saxon) are used to dynamically evaluate the value of
<parameter>man.charmap.subset.profile</parameter> at run-time. If you
don't use xsltproc, Saxon, Xalan -- or some other XSLT engine that
supports <function>dyn:evaluate</function> -- you must either set the
value of the <parameter>man.charmap.use.subset</parameter> parameter
to zero and process your documents using the full character map
instead, or set the value of the
<parameter>man.charmap.enabled</parameter> parameter to zero instead
(so that character-map processing is disabled completely.</para>
</note>

<para>An alternative to using
<parameter>man.charmap.subset.profile</parameter> is to create your
own custom character map, and set the value of
<parameter>man.charmap.uri</parameter> to the URI/filename for
that. If you use a custom character map, you will probably want to
include in it just the characters you want to use, and so you will
most likely also want to set the value of
<parameter>man.charmap.use.subset</parameter> to zero.</para>
<para>You can create a
custom character map by making a copy of the <link xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="http://snapshots.docbook.org/xsl/manpages/charmap.groff.xsl">standard roff character map</link> provided in the distribution, and
then adding to, changing, and/or deleting from that.</para>

<caution>
<para>If you author your DocBook XML source in UTF-8 or UTF-16
encoding and aren't sure what OSes or environments your man-page
output might end up being viewed on, and not sure what version of
nroff/groff those environments might have, you should be careful about
what Unicode symbols and special characters you use in your source and
what parts you add to the value of
<parameter>man.charmap.subset.profile</parameter>.</para>
<para>Many of the escape codes used are specific to groff and using
them may not provide the expected output on an OS or environment that
uses nroff instead of groff.</para>
<para>On the other hand, if you intend for your man-page output to be
viewed only on modern systems (for example, GNU/Linux systems, FreeBSD
systems, or Cygwin environments) that have a good, up-to-date groff,
then you can safely include a wide range of Unicode symbols and
special characters in your UTF-8 or UTF-16 encoded DocBook XML source
and add any of the supported Unicode block names to the value of
<parameter>man.charmap.subset.profile</parameter>.</para>
</caution>


<para>For other details, see the documentation for the
<parameter>man.charmap.use.subset</parameter> parameter.</para>

<refsection xml:id="BlocksAndClasses"><info><title>Supported Unicode block names and "class" values</title></info>
  

  <para>Below is the full list of Unicode block names and "class"
  values supported in the standard roff stylesheet provided in the
  distribution, along with a description of which codepoints from the
  Unicode range corresponding to that block name or block/class
  combination are supported.</para>

  <itemizedlist>
    <listitem>
      <para><link xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="http://zvon.org/other/charSearch/PHP/search.php?searchType=103&amp;id=C1%20Controls%20and%20Latin-1%20Supplement%20(Latin-1%20Supplement)">C1 Controls And Latin-1 Supplement (Latin-1 Supplement)</link> (x00a0 to x00ff)
      <itemizedlist><info><title>class values</title></info>
        
        <listitem>
          <para>symbols</para>
        </listitem>
        <listitem>
          <para>letters</para>
        </listitem>
      </itemizedlist></para>
    </listitem>
    <listitem>
      <para><link xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="http://zvon.org/other/charSearch/PHP/search.php?searchType=103&amp;id=Latin%20Extended-A">Latin Extended-A</link> (x0100 to x017f, partial)</para>
    </listitem>
    <listitem>
      <para><link xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="http://zvon.org/other/charSearch/PHP/search.php?searchType=103&amp;id=Spacing%20Modifier%20Letters">Spacing Modifier Letters</link> (x02b0 to x02ee, partial)</para>
    </listitem>
    <listitem>
      <para><link xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="http://zvon.org/other/charSearch/PHP/search.php?searchType=103&amp;id=Greek%20and%20Coptic">Greek and Coptic</link> (x0370 to x03ff, partial)</para>
    </listitem>
    <listitem>
      <para><link xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="http://zvon.org/other/charSearch/PHP/search.php?searchType=103&amp;id=General%20Punctuation">General Punctuation</link> (x2000 to x206f, partial)
      <itemizedlist><info><title>class values</title></info>
        
        <listitem>
          <para><link xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="http://zvon.org/other/charSearch/PHP/search.php?searchType=103&amp;start=8192&amp;end=8203">spaces</link></para>
        </listitem>
        <listitem>
          <para><link xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="http://zvon.org/other/charSearch/PHP/search.php?searchType=103&amp;start=8208&amp;end=8213">dashes</link></para>
        </listitem>
        <listitem>
          <para>quotes</para>
        </listitem>
        <listitem>
          <para>daggers</para>
        </listitem>
        <listitem>
          <para>bullets</para>
        </listitem>
        <listitem>
          <para>leaders</para>
        </listitem>
        <listitem>
          <para>primes</para>
        </listitem>
      </itemizedlist>
      </para>
    </listitem>
    <listitem>
      <para><link xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="http://zvon.org/other/charSearch/PHP/search.php?searchType=103&amp;id=Superscripts%20and%20Subscripts">Superscripts and Subscripts</link> (x2070 to x209f)</para>
    </listitem>
    <listitem>
      <para><link xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="http://zvon.org/other/charSearch/PHP/search.php?searchType=103&amp;id=Currency%20Symbols">Currency Symbols</link> (x20a0 to x20b1)</para>
    </listitem>
    <listitem>
      <para><link xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="http://zvon.org/other/charSearch/PHP/search.php?searchType=103&amp;id=Letterlike%20Symbols">Letterlike Symbols</link> (x2100 to x214b)</para>
    </listitem>
    <listitem>
      <para><link xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="http://zvon.org/other/charSearch/PHP/search.php?searchType=103&amp;id=Number%20Forms">Number Forms</link> (x2150 to x218f)</para>
    </listitem>
    <listitem>
      <para><link xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="http://zvon.org/other/charSearch/PHP/search.php?searchType=103&amp;id=Arrows">Arrows</link> (x2190 to x21ff, partial)</para>
    </listitem>
    <listitem>
      <para><link xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="http://zvon.org/other/charSearch/PHP/search.php?searchType=103&amp;id=Mathematical%20Operators">Mathematical Operators</link> (x2200 to x22ff, partial)</para>
    </listitem>
    <listitem>
      <para><link xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="http://zvon.org/other/charSearch/PHP/search.php?searchType=103&amp;id=Control%20Pictures">Control Pictures</link> (x2400 to x243f)</para>
    </listitem>
    <listitem>
      <para><link xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="http://zvon.org/other/charSearch/PHP/search.php?searchType=103&amp;id=Enclosed%20Alphanumerics">Enclosed Alphanumerics</link> (x2460 to x24ff)</para>
    </listitem>
    <listitem>
      <para><link xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="http://zvon.org/other/charSearch/PHP/search.php?searchType=103&amp;id=Geometric%20Shapes">Geometric Shapes</link> (x25a0 to x25f7, partial)</para>
    </listitem>
    <listitem>
      <para><link xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="http://zvon.org/other/charSearch/PHP/search.php?searchType=103&amp;id=Miscellaneous%20Symbols">Miscellaneous Symbols</link> (x2600 to x26ff, partial)</para>
    </listitem>
    <listitem>
      <para><link xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="http://zvon.org/other/charSearch/PHP/search.php?searchType=103&amp;id=Dingbats">Dingbats</link> (x2700 to x27be, partial)</para>
    </listitem>
    <listitem>
      <para><link xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="http://zvon.org/other/charSearch/PHP/search.php?searchType=103&amp;id=Alphabetic%20Presentation%20Forms">Alphabetic Presentation Forms</link> (xfb00 to xfb04 only)</para>
    </listitem>
  </itemizedlist>
</refsection>
</refsection>
</doc:refentry>
<xsl:param name="man.charmap.subset.profile">
@*[local-name() = 'block'] = 'Miscellaneous Technical' or
(@*[local-name() = 'block'] = 'C1 Controls And Latin-1 Supplement (Latin-1 Supplement)' and
 (@*[local-name() = 'class'] = 'symbols' or
  @*[local-name() = 'class'] = 'letters')
) or
@*[local-name() = 'block'] = 'Latin Extended-A'
or
(@*[local-name() = 'block'] = 'General Punctuation' and
 (@*[local-name() = 'class'] = 'spaces' or
  @*[local-name() = 'class'] = 'dashes' or
  @*[local-name() = 'class'] = 'quotes' or
  @*[local-name() = 'class'] = 'bullets'
 )
) or
@*[local-name() = 'name'] = 'HORIZONTAL ELLIPSIS' or
@*[local-name() = 'name'] = 'WORD JOINER' or
@*[local-name() = 'name'] = 'SERVICE MARK' or
@*[local-name() = 'name'] = 'TRADE MARK SIGN' or
@*[local-name() = 'name'] = 'ZERO WIDTH NO-BREAK SPACE'
</xsl:param>

<doc:refentry xmlns:doc="http://nwalsh.com/xsl/documentation/1.0" id="man.charmap.subset.profile.english">
<refmeta>
<refentrytitle>man.charmap.subset.profile.english</refentrytitle>
<refmiscinfo class="other" otherclass="datatype">string</refmiscinfo>
</refmeta>
<refnamediv>
<refname>man.charmap.subset.profile.english</refname>
<refpurpose>Profile of character map subset</refpurpose>
</refnamediv>



<refsection><info><title>Description</title></info>

<para>If the value of the
  <parameter>man.charmap.use.subset</parameter> parameter is
  non-zero, and your DocBook source is written in English (that
  is, if its <tag class="attribute">lang</tag> or <tag class="attribute">xml:lang</tag> attribute on the root element
  in your DocBook source or on the first <tag>refentry</tag>
  element in your source has the value <literal>en</literal> or if
  it has no <tag class="attribute">lang</tag> or <tag class="attribute">xml:lang</tag> attribute), then the
  character-map subset specified by the
  <parameter>man.charmap.subset.profile.english</parameter>
  parameter is used instead of the full roff character map.</para>

<para>Otherwise, if the <tag class="attribute">lang</tag> or <tag class="attribute">xml:lang</tag> attribute
  on the root element in your DocBook source or on the first
  <tag>refentry</tag> element in your source has a value other
  than <literal>en</literal>, then the character-map subset
  specified by the
  <parameter>man.charmap.subset.profile</parameter> parameter is
  used instead of
  <parameter>man.charmap.subset.profile.english</parameter>.</para>

<para>The difference between the two subsets is that
  <parameter>man.charmap.subset.profile</parameter> provides
  mappings for characters in Western European languages that are
  not part of the Roman (English) alphabet (ASCII character set).</para>

<para>The value of <parameter>man.charmap.subset.profile.english</parameter>
is a string representing an XPath expression that matches attribute
names and values for <tag namespace="http://docbook.sf.net/xmlns/unichar/1.0">output-character</tag> elements in the character map.</para>

<para>For other details, see the documentation for the
<parameter>man.charmap.subset.profile.english</parameter> and
<parameter>man.charmap.use.subset</parameter> parameters.</para>

</refsection>
</doc:refentry>
<xsl:param name="man.charmap.subset.profile.english">
@*[local-name() = 'block'] = 'Miscellaneous Technical' or
(@*[local-name() = 'block'] = 'C1 Controls And Latin-1 Supplement (Latin-1 Supplement)' and
 @*[local-name() = 'class'] = 'symbols')
or
(@*[local-name() = 'block'] = 'General Punctuation' and
 (@*[local-name() = 'class'] = 'spaces' or
  @*[local-name() = 'class'] = 'dashes' or
  @*[local-name() = 'class'] = 'quotes' or
  @*[local-name() = 'class'] = 'bullets'
 )
) or
@*[local-name() = 'name'] = 'HORIZONTAL ELLIPSIS' or
@*[local-name() = 'name'] = 'WORD JOINER' or
@*[local-name() = 'name'] = 'SERVICE MARK' or
@*[local-name() = 'name'] = 'TRADE MARK SIGN' or
@*[local-name() = 'name'] = 'ZERO WIDTH NO-BREAK SPACE'
</xsl:param>

<doc:refentry xmlns:doc="http://nwalsh.com/xsl/documentation/1.0" id="man.charmap.uri">
<refmeta>
<refentrytitle>man.charmap.uri</refentrytitle>
<refmiscinfo class="other" otherclass="datatype">uri</refmiscinfo>
</refmeta>
<refnamediv>
<refname>man.charmap.uri</refname>
<refpurpose>URI for custom roff character map</refpurpose>
</refnamediv>



<refsection><info><title>Description</title></info>

<para>For converting certain Unicode symbols and special characters in
UTF-8 or UTF-16 encoded XML source to appropriate groff/roff
equivalents in man-page output, the DocBook XSL Stylesheets
distribution includes an <link xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="http://www.w3.org/TR/xslt20/#character-maps">XSLT character
map</link>. That character map can be considered the standard roff
character map for the distribution.</para>

<para>If the value of the <parameter>man.charmap.uri</parameter>
parameter is non-empty, that value is used as the URI for the location
for an alternate roff character map to use in place of the standard
roff character map provided in the distribution.</para>

<warning>
<para>Do not set a value for <parameter>man.charmap.uri</parameter>
unless you have a custom roff character map that differs from the
standard one provided in the distribution.</para>
</warning>
</refsection>
</doc:refentry>
<xsl:param name="man.charmap.uri"/>

<doc:refentry xmlns:doc="http://nwalsh.com/xsl/documentation/1.0" id="man.charmap.use.subset">
<refmeta>
<refentrytitle>man.charmap.use.subset</refentrytitle>
<refmiscinfo class="other" otherclass="datatype">boolean</refmiscinfo>
</refmeta>
<refnamediv>
<refname>man.charmap.use.subset</refname>
<refpurpose>Use subset of character map instead of full map?</refpurpose>
</refnamediv>



<refsection><info><title>Description</title></info>

<para>If the value of the
<parameter>man.charmap.use.subset</parameter> parameter is non-zero,
a subset of the roff character map is used instead of the full roff
character map. The profile of the subset used is determined either
by the value of the
<parameter>man.charmap.subset.profile</parameter>
parameter (if the source is not in English) or the
<parameter>man.charmap.subset.profile.english</parameter>
parameter (if the source is in English).</para>

<note>
  <para>You may want to experiment with setting a non-zero value of
  <parameter>man.charmap.use.subset</parameter>, so that the full
  character map is used. Depending on which XSLT engine you run,
  setting a non-zero value for
  <parameter>man.charmap.use.subset</parameter> may significantly
  increase the time needed to process your documents. Or it may
  not. For example, if you set it and run it with xsltproc, it seems
  to dramatically increase processing time; on the other hand, if you
  set it and run it with Saxon, it does not seem to increase
  processing time nearly as much.</para>

  <para>If processing time is not a important concern and/or you can
  tolerate the increase in processing time imposed by using the full
  character map, set <parameter>man.charmap.use.subset</parameter> to
  zero.</para>
</note>

<refsection><info><title>Details</title></info>

<para>For converting certain Unicode symbols and special characters in
UTF-8 or UTF-16 encoded XML source to appropriate groff/roff
equivalents in man-page output, the DocBook XSL Stylesheets
distribution includes a <link xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="http://snapshots.docbook.org/xsl/manpages/charmap.groff.xsl">roff character map</link> that is compliant with the <link xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="http://www.w3.org/TR/xslt20/#character-maps">XSLT character
map</link> format as detailed in the XSLT 2.0 specification. The map
contains more than 800 character mappings and can be considered the
standard roff character map for the distribution.</para>

<note>
<para>You can use the <parameter>man.charmap.uri</parameter>
parameter to specify a URI for the location for an alternate roff
character map to use in place of the standard roff character map
provided in the distribution.</para>
</note>

<para>Because it is not terrifically efficient to use the standard
800-character character map in full -- and for most (or all) users,
never necessary to use it in full -- the DocBook XSL Stylesheets
support a mechanism for using, within any given character map, a
subset of character mappings instead of the full set. You can use the
<parameter>man.charmap.subset.profile</parameter> or
<parameter>man.charmap.subset.profile.english</parameter>
parameter to tune the profile of that subset to use.</para>

</refsection>
</refsection>
</doc:refentry>
<xsl:param name="man.charmap.use.subset" select="1"/>

<doc:refentry xmlns:doc="http://nwalsh.com/xsl/documentation/1.0" id="man.copyright.section.enabled">
<refmeta>
<refentrytitle>man.copyright.section.enabled</refentrytitle>
<refmiscinfo class="other" otherclass="datatype">boolean</refmiscinfo>
</refmeta>
<refnamediv>
<refname>man.copyright.section.enabled</refname>
<refpurpose>Display auto-generated COPYRIGHT section?</refpurpose>
</refnamediv>

<refsection><info><title>Description</title></info>

<para>If the value of
<parameter>man.copyright.section.enabled</parameter> is non-zero
(the default), then a <literal>COPYRIGHT</literal> section is
generated near the end of each man page. The output of the
<literal>COPYRIGHT</literal> section is assembled from any
<tag>copyright</tag> and <tag>legalnotice</tag> metadata found in
the contents of the child <tag>info</tag> or
<tag>refentryinfo</tag> (if any) of the <tag>refentry</tag>
itself, or from any <tag>copyright</tag> and
<tag>legalnotice</tag> metadata that may appear in <tag>info</tag>
contents of any ancestors of the <tag>refentry</tag>.</para>

<para>If the value of
<parameter>man.copyright.section.enabled</parameter> is zero, the
the auto-generated <literal>COPYRIGHT</literal> section is
suppressed.</para>

<para>Set the value of
  <parameter>man.copyright.section.enabled</parameter> to zero if
  you want to have a manually created <literal>COPYRIGHT</literal>
  section in your source, and you want it to appear in output
  instead of the auto-generated <literal>COPYRIGHT</literal>
  section.</para>
</refsection>
</doc:refentry>
<xsl:param name="man.copyright.section.enabled">1</xsl:param>

<doc:refentry xmlns:doc="http://nwalsh.com/xsl/documentation/1.0" id="man.endnotes.are.numbered">
<refmeta>
<refentrytitle>man.endnotes.are.numbered</refentrytitle>
<refmiscinfo class="other" otherclass="datatype">boolean</refmiscinfo>
</refmeta>
<refnamediv>
<refname>man.endnotes.are.numbered</refname>
<refpurpose>Number endnotes?</refpurpose>
</refnamediv>



<refsection><info><title>Description</title></info>

<para>If the value of <parameter>man.endnotes.are.numbered</parameter> is
non-zero (the default), then for each non-empty<footnote>
<para>A “non-empty” notesource is one that looks like
this:<literallayout class="monospaced">  &lt;ulink url="http://snapshots.docbook.org/xsl/doc/manpages/"&gt;manpages&lt;/ulink&gt;</literallayout>
an “empty” notesource is on that looks like this:<literallayout class="monospaced">  &lt;ulink url="http://snapshots.docbook.org/xsl/doc/manpages/"/&gt;</literallayout>
</para></footnote> “notesource”:

<itemizedlist>
  <listitem>
    <para>a number (in square brackets) is displayed inline after the
    rendered inline contents (if any) of the notesource</para>
  </listitem>
  <listitem>
    <para>the contents of the notesource are included in a
      numbered list of endnotes that is generated at the end of
      each man page; the number for each endnote corresponds to
      the inline number for the notesource with which it is
      associated</para>
  </listitem>
</itemizedlist>
The default heading for the list of endnotes is
<literal>NOTES</literal>. To output a different heading, set a value
for the <parameter>man.endnotes.section.heading</parameter>
parameter.</para>

<note>
  <para>The endnotes list is also displayed (but without
    numbers) if the value of
    <parameter>man.endnotes.list.enabled</parameter> is
    non-zero.</para>
</note>


<para>If the value of <parameter>man.endnotes.are.numbered</parameter> is
zero, numbering of endnotess is suppressed; only inline
contents (if any) of the notesource are displayed inline.
<important>
  <para>If you are thinking about disabling endnote numbering by setting
  the value of <parameter>man.endnotes.are.numbered</parameter> to zero,
  before you do so, first take some time to carefully
  consider the information needs and experiences of your users. The
  square-bracketed numbers displayed inline after notesources may seem
  obstrusive and aesthetically unpleasing<footnote><para>As far as notesources that are links, ytou might
  think it would be better to just display URLs for non-empty
  links inline, after their content, rather than displaying
  square-bracketed numbers all over the place. But it's not better. In
  fact, it's not even practical, because many (most) URLs for links
  are too long to be displayed inline. They end up overflowing the
  right margin. You can set a non-zero value for
  <parameter>man.break.after.slash</parameter> parameter to deal with
  that, but it could be argued that what you end up with is at least
  as ugly, and definitely more obstrusive, then having short
  square-bracketed numbers displayed inline.</para></footnote>,

  but in a text-only output format, the
  numbered-notesources/endnotes-listing mechanism is the only
  practical way to handle this kind of content.</para>

  <para>Also, users of “text based” browsers such as
  <command>lynx</command> will already be accustomed to seeing inline
  numbers for links. And various "man to html" applications, such as
  the widely used <command><link xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="http://users.actrix.gen.nz/michael/vhman2html.html">man2html</link></command> (<literal>VH-Man2html</literal>)
  application, can automatically turn URLs into "real" HTML hyperlinks
  in output. So leaving <parameter>man.endnotes.are.numbered</parameter>
  at its default (non-zero) value ensures that no information is
  lost in your man-page output. It just gets
  “rearranged”.</para>
</important>
</para>
<para>The handling of empty links is not affected by this
parameter. Empty links are handled simply by displaying their URLs
inline. Empty links are never auto-numbered.</para>

<para>If you disable endnotes numbering, you should probably also set
<parameter>man.font.links</parameter> to an empty value (to
disable font formatting for links.</para>
</refsection>

<refsection><info><title>Related Parameters</title></info>
  <para><parameter>man.endnotes.list.enabled</parameter>,
    <parameter>man.font.links</parameter></para>
</refsection>
</doc:refentry>
<xsl:param name="man.endnotes.are.numbered">1</xsl:param>

<doc:refentry xmlns:doc="http://nwalsh.com/xsl/documentation/1.0" id="man.endnotes.list.enabled">
<refmeta>
<refentrytitle>man.endnotes.list.enabled</refentrytitle>
<refmiscinfo class="other" otherclass="datatype">boolean</refmiscinfo>
</refmeta>
<refnamediv>
<refname>man.endnotes.list.enabled</refname>
<refpurpose>Display endnotes list at end of man page?</refpurpose>
</refnamediv>



<refsection><info><title>Description</title></info>

<para>If the value of <parameter>man.endnotes.list.enabled</parameter> is
non-zero (the default), then an endnotes list is added to the end of
the output man page.</para>

<para>If the value of <parameter>man.endnotes.list.enabled</parameter> is
zero, the list is suppressed — unless link numbering is enabled (that
is, if <parameter>man.endnotes.are.numbered</parameter> is non-zero), in
which case, that setting overrides the
<parameter>man.endnotes.list.enabled</parameter> setting, and the
endnotes list is still displayed. The reason is that inline
numbering of notesources associated with endnotes only makes sense
if a (numbered) list of endnotes is also generated.</para>

<note>
  <para>Leaving
  <parameter>man.endnotes.list.enabled</parameter> at its default
  (non-zero) value ensures that no “out of line” information (such
  as the URLs for hyperlinks and images) gets lost in your
  man-page output. It just gets “rearranged”.</para>
  <para>So if you’re thinking about disabling endnotes listing by
    setting the value of
    <parameter>man.endnotes.list.enabled</parameter> to zero:
    Before you do so, first take some time to carefully consider
    the information needs and experiences of your users. The “out
    of line” information has value even if the presentation of it
    in text output is not as interactive as it may be in other
    output formats.</para>
  <para>As far as the specific case of URLs: Even though the URLs
    displayed in text output may not be “real” (clickable)
    hyperlinks, many X terminals have convenience features for
    recognizing URLs and can, for example, present users with
    an options to open a URL in a browser with the user clicks on
    the URL is a terminal window. And short of those, users with X
    terminals can always manually cut and paste the URLs into a web
    browser.</para>
  <para>Also, note that various “man to html” tools, such as the
    widely used <command><link xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="http://users.actrix.gen.nz/michael/vhman2html.html">man2html</link></command> (<literal>VH-Man2html</literal>)
    application, automatically mark up URLs with <literal>a@href</literal> markup
  during conversion — resulting in “real” hyperlinks in HTML
  output from those tools.</para>
</note>

<para>To “turn off” numbering of endnotes in the
endnotes list, set <parameter>man.endnotes.are.numbered</parameter>
to zero. The endnotes list will
still be displayed; it will just be displayed without the
numbers<footnote><para>It can still make sense to have
the list of endnotes displayed even if you have endnotes numbering turned
off. In that case, your endnotes list basically becomes a “list
of references” without any association with specific text in
your document. This is probably the best option if you find the inline
endnotes numbering obtrusive. Your users will still have access to all the “out of line”
such as URLs for hyperlinks.</para></footnote>
</para>

<para>The default heading for the endnotes list is
<literal>NOTES</literal>. To change that, set a non-empty
value for the <parameter>man.endnotes.list.heading</parameter>
parameter.</para>

<para>In the case of notesources that are links: Along with the
URL for each link, the endnotes list includes the contents of the
link. The list thus includes only non-empty<footnote>

<para>A “non-empty” link is one that looks like
this:<literallayout class="monospaced">  &lt;ulink url="http://snapshots.docbook.org/xsl/doc/manpages/"&gt;manpages&lt;/ulink&gt;</literallayout>
an “empty link” is on that looks like this:<literallayout class="monospaced">  &lt;ulink url="http://snapshots.docbook.org/xsl/doc/manpages/"/&gt;</literallayout>
</para></footnote> links.

Empty links are never included, and never numbered. They are simply
displayed inline, without any numbering.</para>

<para>In addition, if there are multiple instances of links in a
<tag>refentry</tag> that have the same URL, the URL is listed only
once. The contents listed for that link in the endnotes list are
the contents of the first link which has that URL.</para>

<para>If you disable endnotes listing, you should probably also set
<parameter>man.links.are.underlined</parameter> to zero (to disable
link underlining).</para>
</refsection>
</doc:refentry>
<xsl:param name="man.endnotes.list.enabled">1</xsl:param>

<doc:refentry xmlns:doc="http://nwalsh.com/xsl/documentation/1.0" id="man.endnotes.list.heading">
<refmeta>
<refentrytitle>man.endnotes.list.heading</refentrytitle>
<refmiscinfo class="other" otherclass="datatype">string</refmiscinfo>
</refmeta>
<refnamediv>
<refname>man.endnotes.list.heading</refname>
<refpurpose>Specifies an alternate name for endnotes list</refpurpose>
</refnamediv>



<refsection><info><title>Description</title></info>

<para>If the value of the
<parameter>man.endnotes.are.numbered</parameter> parameter
and/or the <parameter>man.endnotes.list.enabled</parameter>
parameter is non-zero (the defaults for both are non-zero), a
numbered list of endnotes is generated near the end of each man
page. The default heading for the list of endnotes is the
equivalent of the English word <literal>NOTES</literal> in
the current locale. To cause an alternate heading to be displayed,
set a non-empty value for the
<parameter>man.endnotes.list.heading</parameter> parameter —
for example, <literal>REFERENCES</literal>.</para>
</refsection>
</doc:refentry>
<xsl:param name="man.endnotes.list.heading"/>
  
<doc:refentry xmlns:doc="http://nwalsh.com/xsl/documentation/1.0" id="man.font.funcprototype">
<refmeta>
<refentrytitle>man.font.funcprototype</refentrytitle>
<refmiscinfo class="other" otherclass="datatype">string</refmiscinfo>
</refmeta>
<refnamediv>
<refname>man.font.funcprototype</refname>
<refpurpose>Specifies font for funcprototype output</refpurpose>
</refnamediv>



<refsection><info><title>Description</title></info>

<para>The <parameter>man.font.funcprototype</parameter> parameter
specifies the font for <tag>funcprototype</tag> output. It
should be a valid roff font name, such as <literal>BI</literal> or
<literal>B</literal>.</para>

</refsection>
</doc:refentry>
<xsl:param name="man.font.funcprototype">BI</xsl:param>
  
<doc:refentry xmlns:doc="http://nwalsh.com/xsl/documentation/1.0" id="man.font.funcsynopsisinfo">
<refmeta>
<refentrytitle>man.font.funcsynopsisinfo</refentrytitle>
<refmiscinfo class="other" otherclass="datatype">string</refmiscinfo>
</refmeta>
<refnamediv>
<refname>man.font.funcsynopsisinfo</refname>
<refpurpose>Specifies font for funcsynopsisinfo output</refpurpose>
</refnamediv>



<refsection><info><title>Description</title></info>

<para>The <parameter>man.font.funcsynopsisinfo</parameter> parameter
specifies the font for <tag>funcsynopsisinfo</tag> output. It
should be a valid roff font name, such as <literal>B</literal> or
<literal>I</literal>.</para>

</refsection>
</doc:refentry>
<xsl:param name="man.font.funcsynopsisinfo">B</xsl:param>

<doc:refentry xmlns:doc="http://nwalsh.com/xsl/documentation/1.0" id="man.font.links">
<refmeta>
<refentrytitle>man.font.links</refentrytitle>
<refmiscinfo class="other" otherclass="datatype">string</refmiscinfo>
</refmeta>
<refnamediv>
<refname>man.font.links</refname>
<refpurpose>Specifies font for links</refpurpose>
</refnamediv>



<refsection><info><title>Description</title></info>

<para>The <parameter>man.font.links</parameter> parameter
specifies the font for output of links (<tag>ulink</tag> instances
and any instances of any element with an <tag class="attribute">xlink:href</tag> attribute).</para>

<para>The value of <parameter>man.font.links</parameter> must be
  either <literal>B</literal> or <literal>I</literal>, or empty. If
the value is empty, no font formatting is applied to links.</para>

<para>If you set <parameter>man.endnotes.are.numbered</parameter> and/or
<parameter>man.endnotes.list.enabled</parameter> to zero (disabled), then
you should probably also set an empty value for
<parameter>man.font.links</parameter>. But if
<parameter>man.endnotes.are.numbered</parameter> is non-zero (enabled),
you should probably keep
<parameter>man.font.links</parameter> set to
<literal>B</literal> or <literal>I</literal><footnote><para>The
    main purpose of applying a font format to links in most output
formats it to indicate that the formatted text is
“clickable”; given that links rendered in man pages are
not “real” hyperlinks that users can click on, it might
seem like there is never a good reason to have font formatting for
link contents in man output.</para>
<para>In fact, if you suppress the
display of inline link references (by setting
<parameter>man.endnotes.are.numbered</parameter> to zero), there is no
good reason to apply font formatting to links. However, if
<parameter>man.endnotes.are.numbered</parameter> is non-zero, having
font formatting for links (arguably) serves a purpose: It provides
“context” information about exactly what part of the text
is being “annotated” by the link. Depending on how you
mark up your content, that context information may or may not
have value.</para></footnote>.</para>
</refsection>

<refsection><info><title>Related Parameters</title></info>
  <para><parameter>man.endnotes.list.enabled</parameter>,
    <parameter>man.endnotes.are.numbered</parameter></para>
</refsection>

</doc:refentry>
<xsl:param name="man.font.links">B</xsl:param>
  
<doc:refentry xmlns:doc="http://nwalsh.com/xsl/documentation/1.0" id="man.font.table.headings">
<refmeta>
<refentrytitle>man.font.table.headings</refentrytitle>
<refmiscinfo class="other" otherclass="datatype">string</refmiscinfo>
</refmeta>
<refnamediv>
<refname>man.font.table.headings</refname>
<refpurpose>Specifies font for table headings</refpurpose>
</refnamediv>



<refsection><info><title>Description</title></info>

<para>The <parameter>man.font.table.headings</parameter> parameter
specifies the font for <tag>table</tag> headings. It should be
a valid roff font, such as <literal>B</literal> or
<literal>I</literal>.</para>

</refsection>
</doc:refentry>
<xsl:param name="man.font.table.headings">B</xsl:param>
  
<doc:refentry xmlns:doc="http://nwalsh.com/xsl/documentation/1.0" id="man.font.table.title">
<refmeta>
<refentrytitle>man.font.table.title</refentrytitle>
<refmiscinfo class="other" otherclass="datatype">string</refmiscinfo>
</refmeta>
<refnamediv>
<refname>man.font.table.title</refname>
<refpurpose>Specifies font for table headings</refpurpose>
</refnamediv>



<refsection><info><title>Description</title></info>

<para>The <parameter>man.font.table.title</parameter> parameter
specifies the font for <tag>table</tag> titles. It should be
a valid roff font, such as <literal>B</literal> or
<literal>I</literal>.</para>

</refsection>
</doc:refentry>
<xsl:param name="man.font.table.title">B</xsl:param>

<doc:refentry xmlns:doc="http://nwalsh.com/xsl/documentation/1.0" id="man.funcsynopsis.style">
<refmeta>
<refentrytitle>man.funcsynopsis.style</refentrytitle>
<refmiscinfo class="other" otherclass="datatype">list</refmiscinfo>
<refmiscinfo class="other" otherclass="value">ansi</refmiscinfo>
<refmiscinfo class="other" otherclass="value">kr</refmiscinfo>
</refmeta>
<refnamediv>
<refname>man.funcsynopsis.style</refname>
<refpurpose>What style of <tag>funcsynopsis</tag> should be generated?</refpurpose>
</refnamediv>

<refsection><info><title>Description</title></info>
<para>If <parameter>man.funcsynopsis.style</parameter> is
<literal>ansi</literal>, ANSI-style function synopses are
generated for a <tag>funcsynopsis</tag>, otherwise K&amp;R-style
function synopses are generated.</para>
</refsection>
</doc:refentry>
<xsl:param name="man.funcsynopsis.style">ansi</xsl:param>

<doc:refentry xmlns:doc="http://nwalsh.com/xsl/documentation/1.0" id="man.hyphenate.computer.inlines">
<refmeta>
<refentrytitle>man.hyphenate.computer.inlines</refentrytitle>
<refmiscinfo class="other" otherclass="datatype">boolean</refmiscinfo>
</refmeta>
<refnamediv>
<refname>man.hyphenate.computer.inlines</refname>
<refpurpose>Hyphenate computer inlines?</refpurpose>
</refnamediv>



<refsection><info><title>Description</title></info>

<para>If zero (the default), hyphenation is suppressed for
<quote>computer inlines</quote> such as environment variables,
constants, etc. This parameter current affects output of the following
elements:
<simplelist type="inline">
  
  <member><tag>classname</tag></member>
  <member><tag>constant</tag></member>
  <member><tag>envar</tag></member>
  <member><tag>errorcode</tag></member>
  <member><tag>option</tag></member>
  <member><tag>replaceable</tag></member>
  <member><tag>userinput</tag></member>
  <member><tag>type</tag></member>
  <member><tag>varname</tag></member>
</simplelist>
</para>

<note>
  <para>If hyphenation is already turned off globally (that is, if
  <parameter>man.hyphenate</parameter> is zero, setting the
  <parameter>man.hyphenate.computer.inlines</parameter> is not
  necessary.</para>
</note>

<para>If <parameter>man.hyphenate.computer.inlines</parameter> is
non-zero, computer inlines will not be treated specially and will be
hyphenated like other words when needed.</para>

</refsection>
</doc:refentry>
<xsl:param name="man.hyphenate.computer.inlines">0</xsl:param>

<doc:refentry xmlns:doc="http://nwalsh.com/xsl/documentation/1.0" id="man.hyphenate.filenames">
<refmeta>
<refentrytitle>man.hyphenate.filenames</refentrytitle>
<refmiscinfo class="other" otherclass="datatype">boolean</refmiscinfo>
</refmeta>
<refnamediv>
<refname>man.hyphenate.filenames</refname>
<refpurpose>Hyphenate filenames?</refpurpose>
</refnamediv>



<refsection><info><title>Description</title></info>

<para>If zero (the default), hyphenation is suppressed for
<tag>filename</tag> output.</para>

<note>
  <para>If hyphenation is already turned off globally (that is, if
  <parameter>man.hyphenate</parameter> is zero, setting
  <parameter>man.hyphenate.filenames</parameter> is not
  necessary.</para>
</note>

<para>If <parameter>man.hyphenate.filenames</parameter> is non-zero,
filenames will not be treated specially and are subject to hyphenation
just like other words.</para>

<note>
  <para>If you are thinking about setting a non-zero value for
  <parameter>man.hyphenate.filenames</parameter> in order to make long
  filenames/pathnames break across lines, you'd probably be better off
  experimenting with setting the
  <parameter>man.break.after.slash</parameter> parameter first. That
  will cause long pathnames to be broken after slashes.</para>
</note>

</refsection>
</doc:refentry>
<xsl:param name="man.hyphenate.filenames">0</xsl:param>

<doc:refentry xmlns:doc="http://nwalsh.com/xsl/documentation/1.0" id="man.hyphenate">
<refmeta>
<refentrytitle>man.hyphenate</refentrytitle>
<refmiscinfo class="other" otherclass="datatype">boolean</refmiscinfo>
</refmeta>
<refnamediv>
<refname>man.hyphenate</refname>
<refpurpose>Enable hyphenation?</refpurpose>
</refnamediv>



<refsection><info><title>Description</title></info>

<para>If non-zero, hyphenation is enabled.</para>

<note>
<para>The default value for this parameter is zero because groff is
not particularly smart about how it does hyphenation; it can end up
hyphenating a lot of things that you don't want hyphenated. To
mitigate that, the default behavior of the stylesheets is to suppress
hyphenation of computer inlines, filenames, and URLs. (You can
override the default behavior by setting non-zero values for the
<parameter>man.hyphenate.urls</parameter>,
<parameter>man.hyphenate.filenames</parameter>, and
<parameter>man.hyphenate.computer.inlines</parameter> parameters.) But
the best way is still to just globally disable hyphenation, as the
stylesheets do by default.</para>

<para>The only good reason to enabled hyphenation is if you have also
enabled justification (which is disabled by default). The reason is
that justified text can look very bad unless you also hyphenate it; to
quote the <quote>Hypenation</quote> node from the groff info page:

<blockquote>
  <para><emphasis>Since the odds are not great for finding a set of
  words, for every output line, which fit nicely on a line without
  inserting excessive amounts of space between words, 'gtroff'
  hyphenates words so that it can justify lines without inserting too
  much space between words.</emphasis></para>
</blockquote>

So, if you set a non-zero value for the
<parameter>man.justify</parameter> parameter (to enable
justification), then you should probably also set a non-zero value for
<parameter>man.hyphenate</parameter> (to enable hyphenation).</para>
</note>


</refsection>
</doc:refentry>
<xsl:param name="man.hyphenate">0</xsl:param>

<doc:refentry xmlns:doc="http://nwalsh.com/xsl/documentation/1.0" id="man.hyphenate.urls">
<refmeta>
<refentrytitle>man.hyphenate.urls</refentrytitle>
<refmiscinfo class="other" otherclass="datatype">boolean</refmiscinfo>
</refmeta>
<refnamediv>
<refname>man.hyphenate.urls</refname>
<refpurpose>Hyphenate URLs?</refpurpose>
</refnamediv>



<refsection><info><title>Description</title></info>

<para>If zero (the default), hyphenation is suppressed for output of
the <tag>ulink</tag> <tag class="attribute">url</tag> attribute.</para>

<note>
  <para>If hyphenation is already turned off globally (that is, if
  <parameter>man.hyphenate</parameter> is zero, setting
  <parameter>man.hyphenate.urls</parameter> is not necessary.</para>
</note>

<para>If <parameter>man.hyphenate.urls</parameter> is non-zero, URLs
will not be treated specially and are subject to hyphenation just like
other words.</para>

<note>
  <para>If you are thinking about setting a non-zero value for
  <parameter>man.hyphenate.urls</parameter> in order to make long
  URLs break across lines, you'd probably be better off
  experimenting with setting the
  <parameter>man.break.after.slash</parameter> parameter first. That
  will cause long URLs to be broken after slashes.</para>
</note>

</refsection>
</doc:refentry>
<xsl:param name="man.hyphenate.urls">0</xsl:param>

<doc:refentry xmlns:doc="http://nwalsh.com/xsl/documentation/1.0" id="man.indent.blurbs">
<refmeta>
<refentrytitle>man.indent.blurbs</refentrytitle>
<refmiscinfo class="other" otherclass="datatype">boolean</refmiscinfo>
</refmeta>
<refnamediv>
<refname>man.indent.blurbs</refname>
<refpurpose>Adjust indentation of blurbs?</refpurpose>
</refnamediv>



<refsection><info><title>Description</title></info>

<para>If the value of <parameter>man.indent.blurbs</parameter> is
non-zero, the width of the left margin for
<tag>authorblurb</tag>, <tag>personblurb</tag>, and
<tag>contrib</tag> output is set to the value of the
<parameter>man.indent.width</parameter> parameter
(<literal>3n</literal> by default). If instead the value of
<parameter>man.indent.blurbs</parameter> is zero, the built-in roff
default width (<literal>7.2n</literal>) is used.</para>

</refsection>
</doc:refentry>
<xsl:param name="man.indent.blurbs" select="1"/>

<doc:refentry xmlns:doc="http://nwalsh.com/xsl/documentation/1.0" id="man.indent.lists">
<refmeta>
<refentrytitle>man.indent.lists</refentrytitle>
<refmiscinfo class="other" otherclass="datatype">boolean</refmiscinfo>
</refmeta>
<refnamediv>
<refname>man.indent.lists</refname>
<refpurpose>Adjust indentation of lists?</refpurpose>
</refnamediv>



<refsection><info><title>Description</title></info>

<para>If the value of <parameter>man.indent.lists</parameter> is
non-zero, the width of the left margin for list items in
<tag>itemizedlist</tag>,
<tag>orderedlist</tag>,
<tag>variablelist</tag> output (and output of some other
lists) is set to the value of the
<parameter>man.indent.width</parameter> parameter
(<literal>4n</literal> by default). If instead the value of
<parameter>man.indent.lists</parameter> is zero, the built-in roff
default width (<literal>7.2n</literal>) is used.</para>

</refsection>
</doc:refentry>
<xsl:param name="man.indent.lists" select="1"/>

<doc:refentry xmlns:doc="http://nwalsh.com/xsl/documentation/1.0" id="man.indent.refsect">
<refmeta>
<refentrytitle>man.indent.refsect</refentrytitle>
<refmiscinfo class="other" otherclass="datatype">boolean</refmiscinfo>
</refmeta>
<refnamediv>
<refname>man.indent.refsect</refname>
<refpurpose>Adjust indentation of refsect* and refsection?</refpurpose>
</refnamediv>



<refsection><info><title>Description</title></info>

<para>If the value of <parameter>man.indent.refsect</parameter> is
non-zero, the width of the left margin for
<tag>refsect1</tag>, <tag>refsect2</tag> and
<tag>refsect3</tag> contents and titles (and first-level,
second-level, and third-level nested
<tag>refsection</tag>instances) is adjusted by the value of
the <parameter>man.indent.width</parameter> parameter. With
<parameter>man.indent.width</parameter> set to its default value of
<literal>3n</literal>, the main results are that:

<itemizedlist>
  <listitem>
    <para>contents of <tag>refsect1</tag> are output with a
    left margin of three characters instead the roff default of seven
    or eight characters</para>
  </listitem>
  <listitem>
    <para>contents of <tag>refsect2</tag> are displayed in
    console output with a left margin of six characters instead the of
    the roff default of seven characters</para>
  </listitem>
  <listitem>
    <para> the contents of <tag>refsect3</tag> and nested
    <tag>refsection</tag> instances are adjusted
    accordingly.</para>
  </listitem>
</itemizedlist>

If instead the value of <parameter>man.indent.refsect</parameter> is
zero, no margin adjustment is done for <literal>refsect*</literal>
output.</para>

<tip>
  <para>If your content is primarly comprised of
  <tag>refsect1</tag> and <tag>refsect2</tag> content
  (or the <tag>refsection</tag> equivalent) – with few or
  no <tag>refsect3</tag> or lower nested sections , you may be
  able to “conserve” space in your output by setting
  <parameter>man.indent.refsect</parameter> to a non-zero value. Doing
  so will “squeeze” the left margin in such as way as to provide an
  additional four characters of “room” per line in
  <tag>refsect1</tag> output. That extra room may be useful
  if, for example, you have many verbatim sections with long lines in
  them.</para>
</tip>

</refsection>
</doc:refentry>
<xsl:param name="man.indent.refsect" select="0"/>

<doc:refentry xmlns:doc="http://nwalsh.com/xsl/documentation/1.0" id="man.indent.verbatims">
<refmeta>
<refentrytitle>man.indent.verbatims</refentrytitle>
<refmiscinfo class="other" otherclass="datatype">boolean</refmiscinfo>
</refmeta>
<refnamediv>
<refname>man.indent.verbatims</refname>
<refpurpose>Adjust indentation of verbatims?</refpurpose>
</refnamediv>



<refsection><info><title>Description</title></info>

<para>If the value of <parameter>man.indent.verbatims</parameter> is
non-zero, the width of the left margin for output of verbatim
environments (<tag>programlisting</tag>,
<tag>screen</tag>, and so on) is set to the value of the
<parameter>man.indent.width</parameter> parameter
(<literal>3n</literal> by default). If instead the value of
<parameter>man.indent.verbatims</parameter> is zero, the built-in roff
default width (<literal>7.2n</literal>) is used.</para>

</refsection>
</doc:refentry>
<xsl:param name="man.indent.verbatims" select="1"/>

<doc:refentry xmlns:doc="http://nwalsh.com/xsl/documentation/1.0" id="man.indent.width">
<refmeta>
<refentrytitle>man.indent.width</refentrytitle>
<refmiscinfo class="other" otherclass="datatype">length</refmiscinfo>
</refmeta>
<refnamediv>
<refname>man.indent.width</refname>
<refpurpose>Specifies width used for adjusted indents</refpurpose>
</refnamediv>



<refsection><info><title>Description</title></info>
<para>The <parameter>man.indent.width</parameter> parameter specifies
the width used for adjusted indents. The value of
<parameter>man.indent.width</parameter> is used for indenting of
lists, verbatims, headings, and elsewhere, depending on whether the
values of certain <literal>man.indent.*</literal> boolean parameters
are non-zero.</para>

<para>The value of <parameter>man.indent.width</parameter> should
include a valid roff measurement unit (for example,
<literal>n</literal> or <literal>u</literal>). The default value of
<literal>4n</literal> specifies a 4-en width; when viewed on a
console, that amounts to the width of four characters. For details
about roff measurment units, see the <literal>Measurements</literal>
node in the groff info page.</para>

</refsection>
</doc:refentry>
<xsl:param name="man.indent.width">4</xsl:param>

<doc:refentry xmlns:doc="http://nwalsh.com/xsl/documentation/1.0" id="man.justify">
<refmeta>
<refentrytitle>man.justify</refentrytitle>
<refmiscinfo class="other" otherclass="datatype">boolean</refmiscinfo>
</refmeta>
<refnamediv>
<refname>man.justify</refname>
<refpurpose>Justify text to both right and left margins?</refpurpose>
</refnamediv>



<refsection><info><title>Description</title></info>

<para>If non-zero, text is justified to both the right and left
margins (or, in roff terminology, "adjusted and filled" to both the
right and left margins). If zero (the default), text is adjusted to
the left margin only -- producing what is traditionally called
"ragged-right" text.</para>

<note>
<para>The default value for this parameter is zero because justified
text looks good only when it is also hyphenated. Without hyphenation,
excessive amounts of space often end up getting between words, in
order to "pad" lines out to align on the right margin.</para>

<para>The problem is that groff is not particularly smart about how it
does hyphenation; it can end up hyphenating a lot of things that you
don't want hyphenated. So, disabling both justification and
hyphenation ensures that hyphens won't get inserted where you don't
want to them, and you don't end up with lines containing excessive
amounts of space between words.</para>

<para>However, if do you decide to set a non-zero value for the
<parameter>man.justify</parameter> parameter (to enable
justification), then you should probably also set a non-zero value for
<parameter>man.hyphenate</parameter> (to enable hyphenation).</para>

<para>Yes, these default settings run counter to how most existing man
pages are formatted. But there are some notable exceptions, such as
the <literal>perl</literal> man pages.</para>
</note>
</refsection>
</doc:refentry>
<xsl:param name="man.justify">0</xsl:param>

<doc:refentry xmlns:doc="http://nwalsh.com/xsl/documentation/1.0" id="man.output.base.dir">
<refmeta>
<refentrytitle>man.output.base.dir</refentrytitle>
<refmiscinfo class="other" otherclass="datatype">uri</refmiscinfo>
</refmeta>
<refnamediv>
<refname>man.output.base.dir</refname>
<refpurpose>Specifies separate output directory</refpurpose>
</refnamediv>



<refsection><info><title>Description</title></info>

<para>The <parameter>man.output.base.dir</parameter> parameter
specifies the base directory into which man-page files are output. The
<parameter>man.output.subdirs.enabled</parameter> parameter controls
whether the files are output in subdirectories within the base
directory.</para>

<note>
  <para>The values of the <parameter>man.output.base.dir</parameter>
  and <parameter>man.output.subdirs.enabled</parameter> parameters are
  used only if the value of
  <parameter>man.output.in.separate.dir</parameter> parameter is
  non-zero. If the value of the
  <parameter>man.output.in.separate.dir</parameter> is zero, man-page
  files are not output in a separate directory.</para>
</note>

</refsection>
</doc:refentry>
<xsl:param name="man.output.base.dir">man/</xsl:param>

<doc:refentry xmlns:doc="http://nwalsh.com/xsl/documentation/1.0" id="man.output.encoding">
<refmeta>
<refentrytitle>man.output.encoding</refentrytitle>
<refmiscinfo class="other" otherclass="datatype">string</refmiscinfo>
</refmeta>
<refnamediv>
<refname>man.output.encoding</refname>
<refpurpose>Encoding used for man-page output</refpurpose>
</refnamediv>



<refsection><info><title>Description</title></info>

<para>This parameter specifies the encoding to use for files generated
by the manpages stylesheet. Not all processors support specification
of this parameter.</para>

<important>
  <para>If the value of the <parameter>man.charmap.enabled</parameter>
  parameter is non-zero (the default), keeping the
  <parameter>man.output.encoding</parameter> parameter at its default
  value (<literal>UTF-8</literal>) or setting it to
  <literal>UTF-16</literal> <emphasis role="bold">does not cause your
  man pages to be output in raw UTF-8 or UTF-16</emphasis> -- because
  any Unicode characters for which matches are found in the enabled
  character map will be replaced with roff escape sequences before the
  final man-page files are generated.</para>

  <para>So if you want to generate "real" UTF-8 man pages, without any
  character substitution being performed on your content, you need to
  set <parameter>man.charmap.enabled</parameter> to zero (which will
  completely disable character-map processing). </para>

  <para>You may also need to set
  <parameter>man.charmap.enabled</parameter> to zero if you want to
  output man pages in an encoding other than <literal>UTF-8</literal>
  or <literal>UTF-16</literal>. Character-map processing is based on
  Unicode character values and may not work with other output
  encodings.</para>
</important>

</refsection>
</doc:refentry>
<xsl:param name="man.output.encoding">UTF-8</xsl:param>

<doc:refentry xmlns:doc="http://nwalsh.com/xsl/documentation/1.0" id="man.output.in.separate.dir">
<refmeta>
<refentrytitle>man.output.in.separate.dir</refentrytitle>
<refmiscinfo class="other" otherclass="datatype">boolean</refmiscinfo>
</refmeta>
<refnamediv>
<refname>man.output.in.separate.dir</refname>
<refpurpose>Output man-page files in separate output directory?</refpurpose>
</refnamediv>



<refsection><info><title>Description</title></info>

<para>If the value of <literal>man.output.in.separate.dir</literal>
parameter is non-zero, man-page files are output in a separate
directory, specified by the <parameter>man.output.base.dir</parameter>
parameter; otherwise, if the value of
<literal>man.output.in.separate.dir</literal> is zero, man-page files
are not output in a separate directory.</para>

</refsection>
</doc:refentry>
<xsl:param name="man.output.in.separate.dir" select="0"/>

<doc:refentry xmlns:doc="http://nwalsh.com/xsl/documentation/1.0" id="man.output.lang.in.name.enabled">
<refmeta>
<refentrytitle>man.output.lang.in.name.enabled</refentrytitle>
<refmiscinfo class="other" otherclass="datatype">boolean</refmiscinfo>
</refmeta>
<refnamediv>
<refname>man.output.lang.in.name.enabled</refname>
<refpurpose>Include $LANG value in man-page filename/pathname?</refpurpose>
</refnamediv>



<refsection><info><title>Description</title></info>

  <para>The <parameter>man.output.lang.in.name.enabled</parameter>
  parameter specifies whether a <literal>$lang</literal> value is
  included in man-page filenames and pathnames.</para>

  <para>If the value of
  <parameter>man.output.lang.in.name.enabled</parameter> is non-zero,
  man-page files are output with the <literal>$lang</literal> value
  included in their filenames or pathnames as follows;

  <itemizedlist>
    <listitem>
      <para>if <parameter>man.output.subdirs.enabled</parameter> is
      non-zero, each file is output to, e.g., a
      <filename>man/<replaceable>$lang</replaceable>/man8/foo.8</filename>
      pathname</para>
    </listitem>
    <listitem>
      <para>if <parameter>man.output.subdirs.enabled</parameter> is
      zero, each file is output with a
      <literal>foo.<replaceable>$lang</replaceable>.8</literal>
      filename</para>
    </listitem>
  </itemizedlist>
  </para>

</refsection>
</doc:refentry>
<xsl:param name="man.output.lang.in.name.enabled" select="0"/>

<doc:refentry xmlns:doc="http://nwalsh.com/xsl/documentation/1.0" id="man.output.manifest.enabled">
  <refmeta>
    <refentrytitle>man.output.manifest.enabled</refentrytitle>
    <refmiscinfo class="other" otherclass="datatype">boolean</refmiscinfo>
  </refmeta>
  <refnamediv>
    <refname>man.output.manifest.enabled</refname>
    <refpurpose>Generate a manifest file?</refpurpose>
  </refnamediv>

  

  <refsection><info><title>Description</title></info>

    <para>If non-zero, a list of filenames for man pages generated by
    the stylesheet transformation is written to the file named by the
    <parameter>man.output.manifest.filename</parameter> parameter.</para>

  </refsection>
</doc:refentry>
<xsl:param name="man.output.manifest.enabled" select="0"/>

<doc:refentry xmlns:doc="http://nwalsh.com/xsl/documentation/1.0" id="man.output.manifest.filename">
  <refmeta>
    <refentrytitle>man.output.manifest.filename</refentrytitle>
    <refmiscinfo class="other" otherclass="datatype">string</refmiscinfo>
  </refmeta>
  <refnamediv>
    <refname>man.output.manifest.filename</refname>
    <refpurpose>Name of manifest file</refpurpose>
  </refnamediv>

  

  <refsection><info><title>Description</title></info>

    <para>The <parameter>man.output.manifest.filename</parameter> parameter
    specifies the name of the file to which the manpages manifest file
    is written (if the value of the
    <parameter>man.output.manifest.enabled</parameter> parameter is
    non-zero).</para>

  </refsection>
</doc:refentry>
<xsl:param name="man.output.manifest.filename">MAN.MANIFEST</xsl:param>

<doc:refentry xmlns:doc="http://nwalsh.com/xsl/documentation/1.0" id="man.output.better.ps.enabled">
<refmeta>
<refentrytitle>man.output.better.ps.enabled</refentrytitle>
<refmiscinfo class="other" otherclass="datatype">boolean</refmiscinfo>
</refmeta>
<refnamediv>
<refname>man.output.better.ps.enabled</refname>
<refpurpose>Enable enhanced print/PostScript output?</refpurpose>
</refnamediv>

<refsection><info><title>Description</title></info>

<para>If the value of the
<parameter>man.output.better.ps.enabled</parameter> parameter is
non-zero, certain markup is embedded in each generated man page
such that PostScript output from the <command>man -Tps</command>
command for that page will include a number of enhancements
designed to improve the quality of that output.</para>

<para>If <parameter>man.output.better.ps.enabled</parameter> is
zero (the default), no such markup is embedded in generated man
pages, and no enhancements are included in the PostScript
output generated from those man pages by the <command>man
 -Tps</command> command.</para>

<warning>
  <para>The enhancements provided by this parameter rely on
    features that are specific to groff (GNU troff) and that are
    not part of “classic” AT&amp;T troff or any of its
    derivatives. Therefore, any man pages you generate with this
    parameter enabled will be readable only on systems on which
    the groff (GNU troff) program is installed, such as GNU/Linux
    systems. The pages <emphasis role="bold">will not not be
      readable on systems on with the classic troff (AT&amp;T
      troff) command is installed</emphasis>.</para>
</warning>

<para>The value of this parameter only affects PostScript output
  generated from the <command>man</command> command. It has no
  effect on output generated using the FO backend.</para>

<tip>
  <para>You can generate PostScript output for any man page by
    running the following command:</para>
  <programlisting>  man <replaceable>FOO</replaceable> -Tps &gt; <replaceable>FOO</replaceable>.ps</programlisting>
  <para>You can then generate PDF output by running the following
    command:</para>
  <programlisting>  ps2pdf <replaceable>FOO</replaceable>.ps</programlisting>
</tip>

</refsection>
</doc:refentry>
<xsl:param name="man.output.better.ps.enabled">0</xsl:param>

<doc:refentry xmlns:doc="http://nwalsh.com/xsl/documentation/1.0" id="man.output.quietly">
<refmeta>
<refentrytitle>man.output.quietly</refentrytitle>
<refmiscinfo class="other" otherclass="datatype">boolean</refmiscinfo>
</refmeta>
<refnamediv>
<refname>man.output.quietly</refname>
<refpurpose>Suppress filename messages emitted when generating output?</refpurpose>
</refnamediv>



<refsection><info><title>Description</title></info>

<para>If zero (the default), for each man-page file created, a message
with the name of the file is emitted. If non-zero, the files are
output "quietly" -- that is, the filename messages are
suppressed.</para>

<tip>
  <para>If you are processing a large amount of <tag>refentry</tag>
  content, you may be able to speed up processing significantly by
  setting a non-zero value for
  <parameter>man.output.quietly</parameter>.</para>
</tip>

</refsection>
</doc:refentry>
<xsl:param name="man.output.quietly" select="0"/>

<doc:refentry xmlns:doc="http://nwalsh.com/xsl/documentation/1.0" id="man.output.subdirs.enabled">
<refmeta>
<refentrytitle>man.output.subdirs.enabled</refentrytitle>
<refmiscinfo class="other" otherclass="datatype">boolean</refmiscinfo>
</refmeta>
<refnamediv>
<refname>man.output.subdirs.enabled</refname>
<refpurpose>Output man-page files in subdirectories within base output directory?</refpurpose>
</refnamediv>



<refsection><info><title>Description</title></info>

<para>The <parameter>man.output.subdirs.enabled</parameter> parameter
controls whether man-pages files are output in subdirectories within
the base directory specified by the directory specified by the
<parameter>man.output.base.dir</parameter> parameter.</para>

<note>
  <para>The values of the <parameter>man.output.base.dir</parameter>
  and <parameter>man.output.subdirs.enabled</parameter> parameters are
  used only if the value of
  <parameter>man.output.in.separate.dir</parameter> parameter is
  non-zero. If the value of the
  <parameter>man.output.in.separate.dir</parameter> is zero, man-page
  files are not output in a separate directory.</para>
</note>

</refsection>
</doc:refentry>
<xsl:param name="man.output.subdirs.enabled" select="1"/>

<doc:refentry xmlns:doc="http://nwalsh.com/xsl/documentation/1.0" id="man.segtitle.suppress">
<refmeta>
<refentrytitle>man.segtitle.suppress</refentrytitle>
<refmiscinfo class="other" otherclass="datatype">boolean</refmiscinfo>
</refmeta>
<refnamediv>
<refname>man.segtitle.suppress</refname>
<refpurpose>Suppress display of segtitle contents?</refpurpose>
</refnamediv>



<refsection><info><title>Description</title></info>

<para>If the value of <parameter>man.segtitle.suppress</parameter> is
non-zero, then display of <tag>segtitle</tag> contents is
suppressed in output.</para>

</refsection>
</doc:refentry>
<xsl:param name="man.segtitle.suppress" select="0"/>

<doc:refentry xmlns:doc="http://nwalsh.com/xsl/documentation/1.0" id="man.string.subst.map">
<refmeta>
<refentrytitle>man.string.subst.map</refentrytitle>
<refmiscinfo class="other" otherclass="datatype">rtf</refmiscinfo>
</refmeta>
<refnamediv>
<refname>man.string.subst.map</refname>
<refpurpose>Specifies a set of string substitutions</refpurpose>
</refnamediv>



<refsection><info><title>Description</title></info>

<para>The <parameter>man.string.subst.map</parameter> parameter
contains <link linkend="map">a map</link> that specifies a set of
string substitutions to perform over the entire roff source for each
man page, either just before generating final man-page output (that
is, before writing man-page files to disk) or, if the value of the
<parameter>man.charmap.enabled</parameter> parameter is non-zero,
before applying the roff character map.</para>

<para>You can use <parameter>man.string.subst.map</parameter> as a
“lightweight” character map to perform “essential” substitutions --
that is, substitutions that are <emphasis>always</emphasis> performed,
even if the value of the <parameter>man.charmap.enabled</parameter>
parameter is zero. For example, you can use it to replace quotation
marks or other special characters that are generated by the DocBook
XSL stylesheets for a particular locale setting (as opposed to those
characters that are actually in source XML documents), or to replace
any special characters that may be automatically generated by a
particular customization of the DocBook XSL stylesheets.</para>

<warning>
  <para>Do you not change value of the
  <parameter>man.string.subst.map</parameter> parameter unless you are
  sure what you are doing. First consider adding your
  string-substitution mappings to either or both of the following
  parameters:
  <variablelist>
    <varlistentry>
      <term><parameter>man.string.subst.map.local.pre</parameter></term>
      <listitem><para>applied before
      <parameter>man.string.subst.map</parameter></para></listitem>
    </varlistentry>
    <varlistentry>
      <term><parameter>man.string.subst.map.local.post</parameter></term>
      <listitem><para>applied after
      <parameter>man.string.subst.map</parameter></para></listitem>
    </varlistentry>
  </variablelist>
  By default, both of those parameters contain no
  string substitutions. They are intended as a means for you to
  specify your own local string-substitution mappings.</para>

  <para>If you remove any of default mappings from the value of the
  <parameter>man.string.subst.map</parameter> parameter, you are
  likely to end up with broken output. And be very careful about adding
  anything to it; it’s used for doing string substitution over the
  entire roff source of each man page – it causes target strings to be
  replaced in roff requests and escapes, not just in the visible
  contents of the page.</para>

</warning>

<refsection xml:id="map">
  <info>
    <title>Contents of the substitution map</title>
  </info>
  <para>The string-substitution map contains one or more
  <tag>ss:substitution</tag> elements, each of which has two
  attributes:
  <variablelist>
    <varlistentry>
      <term>oldstring</term>
      <listitem>
        <simpara>string to replace</simpara>
      </listitem>
    </varlistentry>
    <varlistentry>
      <term>newstring</term>
      <listitem>
        <simpara>string with which to replace <tag class="attribute">oldstring</tag></simpara>
      </listitem>
    </varlistentry>
  </variablelist>
  It may also include XML comments (that is, delimited with
  "<literal>&lt;!--</literal>" and "<literal>--&gt;</literal>").
  </para>
</refsection>

</refsection>
</doc:refentry>
<xsl:param name="man.string.subst.map">

  <!-- * remove no-break marker at beginning of line (stylesheet artifact) --> 
  <substitution oldstring="▒▀" newstring="▒"/>
  <!-- * replace U+2580 no-break marker (stylesheet-added) w/ no-break space -->
  <substitution oldstring="▀" newstring="\ "/>

  <!-- ==================================================================== -->

  <!-- * squeeze multiple newlines before a roff request  -->
  <substitution oldstring="&#xA;&#xA;." newstring="&#xA;."/>
  <!-- * remove any .sp instances that directly precede a .PP  -->
  <substitution oldstring=".sp&#xA;.PP" newstring=".PP"/>
  <!-- * remove any .sp instances that directly follow a .PP  -->
  <substitution oldstring=".sp&#xA;.sp" newstring=".sp"/>
  <!-- * squeeze multiple .sp instances into a single .sp-->
  <substitution oldstring=".PP&#xA;.sp" newstring=".PP"/>
  <!-- * squeeze multiple newlines after start of no-fill (verbatim) env. -->
  <substitution oldstring=".nf&#xA;&#xA;" newstring=".nf&#xA;"/>
  <!-- * squeeze multiple newlines after REstoring margin -->
  <substitution oldstring=".RE&#xA;&#xA;" newstring=".RE&#xA;"/>
  <!-- * U+2591 is a marker we add before and after every Parameter in -->
  <!-- * Funcprototype output -->
  <substitution oldstring="░" newstring=" "/>
  <!-- * U+2592 is a marker we add for the newline before output of <sbr>; -->
  <substitution oldstring="▒" newstring="&#xA;"/>
  <!-- * -->
  <!-- * Now deal with some other characters that are added by the -->
  <!-- * stylesheets during processing. -->
  <!-- * -->
  <!-- * bullet -->
  <substitution oldstring="•" newstring="\(bu"/>
  <!-- * left double quote -->
  <substitution oldstring="“" newstring="\(lq"/>
  <!-- * right double quote -->
  <substitution oldstring="”" newstring="\(rq"/>
  <!-- * left single quote -->
  <substitution oldstring="‘" newstring="\(oq"/>
  <!-- * right single quote -->
  <substitution oldstring="’" newstring="\(cq"/>
  <!-- * copyright sign -->
  <substitution oldstring="©" newstring="\(co"/>
  <!-- * registered sign -->
  <substitution oldstring="®" newstring="\(rg"/>
  <!-- * ...servicemark... -->
  <!-- * There is no groff equivalent for it. -->
  <substitution oldstring="℠" newstring="(SM)"/>
  <!-- * ...trademark... -->
  <!-- * We don't do "\(tm" because for console output, -->
  <!-- * groff just renders that as "tm"; that is: -->
  <!-- * -->
  <!-- *   Product&#x2122; -> Producttm -->
  <!-- * -->
  <!-- * So we just make it to "(TM)" instead; thus: -->
  <!-- * -->
  <!-- *   Product&#x2122; -> Product(TM) -->
  <substitution oldstring="™" newstring="(TM)"/>

</xsl:param>

<doc:refentry xmlns:doc="http://nwalsh.com/xsl/documentation/1.0" id="man.string.subst.map.local.post">
<refmeta>
<refentrytitle>man.string.subst.map.local.post</refentrytitle>
<refmiscinfo class="other" otherclass="datatype">string</refmiscinfo>
</refmeta>
<refnamediv>
<refname>man.string.subst.map.local.post</refname>
<refpurpose>Specifies “local” string substitutions</refpurpose>
</refnamediv>



<refsection><info><title>Description</title></info>

<para>Use the <parameter>man.string.subst.map.local.post</parameter>
parameter to specify any “local” string substitutions to perform over
the entire roff source for each man page <emphasis>after</emphasis>
performing the string substitutions specified by the <parameter>man.string.subst.map</parameter> parameter.</para>

<para>For details about the format of this parameter, see the
documentation for the <parameter>man.string.subst.map</parameter>
parameter.</para>

</refsection>
</doc:refentry>
<xsl:param name="man.string.subst.map.local.post"/>
  
<doc:refentry xmlns:doc="http://nwalsh.com/xsl/documentation/1.0" id="man.string.subst.map.local.pre">
<refmeta>
<refentrytitle>man.string.subst.map.local.pre</refentrytitle>
<refmiscinfo class="other" otherclass="datatype">string</refmiscinfo>
</refmeta>
<refnamediv>
<refname>man.string.subst.map.local.pre</refname>
<refpurpose>Specifies “local” string substitutions</refpurpose>
</refnamediv>



<refsection><info><title>Description</title></info>

<para>Use the <parameter>man.string.subst.map.local.pre</parameter>
parameter to specify any “local” string substitutions to perform over
the entire roff source for each man page <emphasis>before</emphasis>
performing the string substitutions specified by the <parameter>man.string.subst.map</parameter> parameter.</para>

<para>For details about the format of this parameter, see the
documentation for the <parameter>man.string.subst.map</parameter>
parameter.</para>

</refsection>
</doc:refentry>
<xsl:param name="man.string.subst.map.local.pre"/>

<doc:refentry xmlns:doc="http://nwalsh.com/xsl/documentation/1.0" id="man.subheading.divider.enabled">
<refmeta>
<refentrytitle>man.subheading.divider.enabled</refentrytitle>
<refmiscinfo class="other" otherclass="datatype">boolean</refmiscinfo>
</refmeta>
<refnamediv>
<refname>man.subheading.divider.enabled</refname>
<refpurpose>Add divider comment to roff source before/after subheadings?</refpurpose>
</refnamediv>



<refsection><info><title>Description</title></info>

<para>If the value of the
<parameter>man.subheading.divider.enabled</parameter> parameter is
non-zero, the contents of the
<parameter>man.subheading.divider</parameter> parameter are used to
add a "divider" before and after subheadings in the roff
output. <emphasis role="bold">The divider is not visisble in the
rendered man page</emphasis>; it is added as a comment, in the source,
simply for the purpose of increasing reability of the source.</para>

<para>If <parameter>man.subheading.divider.enabled</parameter> is zero
(the default), the subheading divider is suppressed.</para>

</refsection>
</doc:refentry>
<xsl:param name="man.subheading.divider.enabled">0</xsl:param>

<doc:refentry xmlns:doc="http://nwalsh.com/xsl/documentation/1.0" id="man.subheading.divider">
<refmeta>
<refentrytitle>man.subheading.divider</refentrytitle>
<refmiscinfo class="other" otherclass="datatype">string</refmiscinfo>
</refmeta>
<refnamediv>
<refname>man.subheading.divider</refname>
<refpurpose>Specifies string to use as divider comment before/after subheadings</refpurpose>
</refnamediv>



<refsection><info><title>Description</title></info>

<para>If the value of the
<parameter>man.subheading.divider.enabled</parameter> parameter is
non-zero, the contents of the
<parameter>man.subheading.divider</parameter> parameter are used to
add a "divider" before and after subheadings in the roff
output. <emphasis role="bold">The divider is not visisble in the
rendered man page</emphasis>; it is added as a comment, in the source,
simply for the purpose of increasing reability of the source.</para>

<para>If <parameter>man.subheading.divider.enabled</parameter> is zero
(the default), the subheading divider is suppressed.</para>

</refsection>
</doc:refentry>
<xsl:param name="man.subheading.divider">========================================================================</xsl:param>

<doc:refentry xmlns:doc="http://nwalsh.com/xsl/documentation/1.0" id="man.table.footnotes.divider">
<refmeta>
<refentrytitle>man.table.footnotes.divider</refentrytitle>
<refmiscinfo class="other" otherclass="datatype">string</refmiscinfo>
</refmeta>
<refnamediv>
<refname>man.table.footnotes.divider</refname>
<refpurpose>Specifies divider string that appears before table footnotes</refpurpose>
</refnamediv>



<refsection><info><title>Description</title></info>

<para>In each table that contains footenotes, the string specified by
the <parameter>man.table.footnotes.divider</parameter> parameter is
output before the list of footnotes for the table.</para>

</refsection>
</doc:refentry>
<xsl:param name="man.table.footnotes.divider">----</xsl:param>

<doc:refentry xmlns:doc="http://nwalsh.com/xsl/documentation/1.0" id="man.th.extra1.suppress">
<refmeta>
<refentrytitle>man.th.extra1.suppress</refentrytitle>
<refmiscinfo class="other" otherclass="datatype">boolean</refmiscinfo>
</refmeta>
<refnamediv>
<refname>man.th.extra1.suppress</refname>
<refpurpose>Suppress extra1 part of header/footer?</refpurpose>
</refnamediv>



<refsection><info><title>Description</title></info>

<para>If the value of <parameter>man.th.extra1.suppress</parameter> is
non-zero, then the <literal>extra1</literal> part of the
<literal>.TH</literal> title line header/footer is suppressed.</para>

<para>The content of the <literal>extra1</literal> field is almost
always displayed in the center footer of the page and is, universally,
a date.</para>

</refsection>
</doc:refentry>
<xsl:param name="man.th.extra1.suppress">0</xsl:param>

<doc:refentry xmlns:doc="http://nwalsh.com/xsl/documentation/1.0" id="man.th.extra2.max.length">
<refmeta>
<refentrytitle>man.th.extra2.max.length</refentrytitle>
<refmiscinfo class="other" otherclass="datatype">integer</refmiscinfo>
</refmeta>
<refnamediv>
<refname>man.th.extra2.max.length</refname>
<refpurpose>Maximum length of extra2 in header/footer</refpurpose>
</refnamediv>



<refsection><info><title>Description</title></info>

<para>Specifies the maximum permitted length of the
<literal>extra2</literal> part of the man-page part of the
<literal>.TH</literal> title line header/footer. If the
<literal>extra2</literal> content exceeds the maxiumum specified, it
is truncated down to the maximum permitted length.</para>

<para>The content of the <literal>extra2</literal> field is usually
displayed in the left footer of the page and is typically "source"
data indicating the software system or product that the item
documented in the man page belongs to, often in the form
<replaceable>Name</replaceable> <replaceable>Version</replaceable>;
for example, "GTK+ 1.2" (from the <literal>gtk-options(7)</literal>
man page).</para>

<para>The default value for this parameter is reasonable but somewhat
arbitrary. If you are processing pages with long "source" information,
you may want to experiment with changing the value in order to achieve
the correct aesthetic results.</para>
</refsection>
</doc:refentry>
<xsl:param name="man.th.extra2.max.length">30</xsl:param>

<doc:refentry xmlns:doc="http://nwalsh.com/xsl/documentation/1.0" id="man.th.extra2.suppress">
<refmeta>
<refentrytitle>man.th.extra2.suppress</refentrytitle>
<refmiscinfo class="other" otherclass="datatype">boolean</refmiscinfo>
</refmeta>
<refnamediv>
<refname>man.th.extra2.suppress</refname>
<refpurpose>Suppress extra2 part of header/footer?</refpurpose>
</refnamediv>



<refsection><info><title>Description</title></info>

<para>If the value of <parameter>man.th.extra2.suppress</parameter> is
non-zero, then the <literal>extra2</literal> part of the
<literal>.TH</literal> title line header/footer is suppressed.</para>

<para>The content of the <literal>extra2</literal> field is usually
displayed in the left footer of the page and is typically "source"
data, often in the form
<replaceable>Name</replaceable> <replaceable>Version</replaceable>;
for example, "GTK+ 1.2" (from the <literal>gtk-options(7)</literal>
man page).</para>

<note>
  <para>You can use the
  <parameter>refentry.source.name.suppress</parameter> and
  <parameter>refentry.version.suppress</parameter> parameters to
  independently suppress the <replaceable>Name</replaceable> and
  <replaceable>Version</replaceable> parts of the
  <literal>extra2</literal> field.</para>
</note>

</refsection>
</doc:refentry>
<xsl:param name="man.th.extra2.suppress">0</xsl:param>

<doc:refentry xmlns:doc="http://nwalsh.com/xsl/documentation/1.0" id="man.th.extra3.max.length">
<refmeta>
<refentrytitle>man.th.extra3.max.length</refentrytitle>
<refmiscinfo class="other" otherclass="datatype">integer</refmiscinfo>
</refmeta>
<refnamediv>
<refname>man.th.extra3.max.length</refname>
<refpurpose>Maximum length of extra3 in header/footer</refpurpose>
</refnamediv>



<refsection><info><title>Description</title></info>

<para>Specifies the maximum permitted length of the
<literal>extra3</literal> part of the man-page <literal>.TH</literal>
title line header/footer. If the <literal>extra3</literal> content
exceeds the maxiumum specified, it is truncated down to the maximum
permitted length.</para>

<para>The content of the <literal>extra3</literal> field is usually
displayed in the middle header of the page and is typically a "manual
name"; for example, "GTK+ User's Manual" (from the
<literal>gtk-options(7)</literal> man page).</para>

<para>The default value for this parameter is reasonable but somewhat
arbitrary. If you are processing pages with long "manual names" -- or
especially if you are processing pages that have both long "title"
parts (command/function, etc. names) <emphasis>and</emphasis> long
manual names -- you may want to experiment with changing the value in
order to achieve the correct aesthetic results.</para>
</refsection>
</doc:refentry>
<xsl:param name="man.th.extra3.max.length">30</xsl:param>

<doc:refentry xmlns:doc="http://nwalsh.com/xsl/documentation/1.0" id="man.th.extra3.suppress">
<refmeta>
<refentrytitle>man.th.extra3.suppress</refentrytitle>
<refmiscinfo class="other" otherclass="datatype">boolean</refmiscinfo>
</refmeta>
<refnamediv>
<refname>man.th.extra3.suppress</refname>
<refpurpose>Suppress extra3 part of header/footer?</refpurpose>
</refnamediv>



<refsection><info><title>Description</title></info>

<para>If the value of <parameter>man.th.extra3.suppress</parameter> is
non-zero, then the <literal>extra3</literal> part of the
<literal>.TH</literal> title line header/footer is
suppressed.</para>

<para>The content of the <literal>extra3</literal> field is usually
displayed in the middle header of the page and is typically a "manual
name"; for example, "GTK+ User's Manual" (from the
<literal>gtk-options(7)</literal> man page).</para>

</refsection>
</doc:refentry>
<xsl:param name="man.th.extra3.suppress">0</xsl:param>

<doc:refentry xmlns:doc="http://nwalsh.com/xsl/documentation/1.0" id="man.th.title.max.length">
<refmeta>
<refentrytitle>man.th.title.max.length</refentrytitle>
<refmiscinfo class="other" otherclass="datatype">integer</refmiscinfo>
</refmeta>
<refnamediv>
<refname>man.th.title.max.length</refname>
<refpurpose>Maximum length of title in header/footer</refpurpose>
</refnamediv>



<refsection><info><title>Description</title></info>

<para>Specifies the maximum permitted length of the title part of the
man-page <literal>.TH</literal> title line header/footer. If the title
exceeds the maxiumum specified, it is truncated down to the maximum
permitted length.</para>

<refsection><info><title>Details</title></info>
  

<para>Every man page generated using the DocBook stylesheets has a
title line, specified using the <literal>TH</literal> roff
macro. Within that title line, there is always, at a minimum, a title,
followed by a section value (representing a man "section" -- usually
just a number).</para>

<para>The title and section are displayed, together, in the visible
header of each page. Where in the header they are displayed depends on
OS the man page is viewed on, and on what version of nroff/groff/man
is used for viewing the page. But, at a minimum and across all
systems, the title and section are displayed on the right-hand column
of the header. On many systems -- those with a modern groff, including
Linux systems -- they are displayed twice: both in the left and right
columns of the header.</para>

<para>So if the length of the title exceeds a certain percentage of
the column width in which the page is viewed, the left and right
titles can end up overlapping, making them unreadable, or breaking to
another line, which doesn't look particularly good.</para>

<para>So the stylesheets provide the
<parameter>man.th.title.max.length</parameter> parameter as a means
for truncating titles that exceed the maximum length that can be
viewing properly in a page header.</para>

<para>The default value is reasonable but somewhat arbitrary. If you
have pages with long titles, you may want to experiment with changing
the value in order to achieve the correct aesthetic results.</para>
</refsection>

</refsection>
</doc:refentry>
<xsl:param name="man.th.title.max.length">20</xsl:param>

<doc:refentry xmlns:doc="http://nwalsh.com/xsl/documentation/1.0" id="refentry.date.profile.enabled">
<refmeta>
<refentrytitle>refentry.date.profile.enabled</refentrytitle>
<refmiscinfo class="other" otherclass="datatype">boolean</refmiscinfo>
</refmeta>
<refnamediv>
<refname>refentry.date.profile.enabled</refname>
<refpurpose>Enable refentry "date" profiling?</refpurpose>
</refnamediv>



<refsection><info><title>Description</title></info>

<para>If the value of
<parameter>refentry.date.profile.enabled</parameter> is non-zero, then
during <tag>refentry</tag> metadata gathering, the info profile
specified by the customizable
<parameter>refentry.date.profile</parameter> parameter is used.</para>

<para>If instead the value of
<parameter>refentry.date.profile.enabled</parameter> is zero (the
default), then "hard coded" logic within the DocBook XSL stylesheets
is used for gathering <tag>refentry</tag> "date" data.</para>

<para>If you find that the default <tag>refentry</tag>
metadata-gathering behavior is causing incorrect "date" data to show
up in your output, then consider setting a non-zero value for
<parameter>refentry.date.profile.enabled</parameter> and adjusting the
value of <parameter>refentry.date.profile</parameter> to cause correct
data to be gathered. </para>

<para>Note that the terms "source" and "date" have special meanings in
this context. For details, see the documentation for the
<parameter>refentry.date.profile</parameter> parameter.</para>

</refsection>
</doc:refentry>
<xsl:param name="refentry.date.profile.enabled">0</xsl:param>

<doc:refentry xmlns:doc="http://nwalsh.com/xsl/documentation/1.0" id="refentry.date.profile">
<refmeta>
<refentrytitle>refentry.date.profile</refentrytitle>
<refmiscinfo class="other" otherclass="datatype">string</refmiscinfo>
</refmeta>
<refnamediv>
<refname>refentry.date.profile</refname>
<refpurpose>Specifies profile for refentry "date" data</refpurpose>
</refnamediv>



<refsection><info><title>Description</title></info>

<para>The value of <parameter>refentry.date.profile</parameter> is a
string representing an XPath expression. It is evaluated at run-time
and used only if <parameter>refentry.date.profile.enabled</parameter>
is non-zero. Otherwise, the <tag>refentry</tag> metadata-gathering
logic "hard coded" into the stylesheets is used.</para>

<para> The <literal>man(7)</literal> man page describes this content
as "the date of the last revision". In man pages, it is the content
that is usually displayed in the center footer.</para>

</refsection>
</doc:refentry>
<xsl:param name="refentry.date.profile">
  (($info[//date])[last()]/date)[1]|
  (($info[//pubdate])[last()]/pubdate)[1]
</xsl:param>

<doc:refentry xmlns:doc="http://nwalsh.com/xsl/documentation/1.0" id="refentry.manual.fallback.profile">
<refmeta>
<refentrytitle>refentry.manual.fallback.profile</refentrytitle>
<refmiscinfo class="other" otherclass="datatype">string</refmiscinfo>
</refmeta>
<refnamediv>
<refname>refentry.manual.fallback.profile</refname>
<refpurpose>Specifies profile of "fallback" for refentry "manual" data</refpurpose>
</refnamediv>



<refsection><info><title>Description</title></info>

<para>The value of
<parameter>refentry.manual.fallback.profile</parameter> is a string
representing an XPath expression. It is evaluated at run-time and
used only if no "manual" data can be found by other means (that is,
either using the <tag>refentry</tag> metadata-gathering logic "hard
coded" in the stylesheets, or the value of
<parameter>refentry.manual.profile</parameter>, if it is
enabled).</para>

<important>
<para>Depending on which XSLT engine you run, either the EXSLT
<function>dyn:evaluate</function> extension function (for xsltproc or
Xalan) or <function>saxon:evaluate</function> extension function (for
Saxon) are used to dynamically evaluate the value of
<parameter>refentry.manual.fallback.profile</parameter> at
run-time. If you don't use xsltproc, Saxon, Xalan -- or some other
XSLT engine that supports <function>dyn:evaluate</function> -- you
must manually disable fallback processing by setting an empty value
for the <parameter>refentry.manual.fallback.profile</parameter>
parameter.</para>
</important>

</refsection>
</doc:refentry>
<xsl:param name="refentry.manual.fallback.profile">
refmeta/refmiscinfo[not(@class = 'date')][1]/node()</xsl:param>

<doc:refentry xmlns:doc="http://nwalsh.com/xsl/documentation/1.0" id="refentry.manual.profile.enabled">
<refmeta>
<refentrytitle>refentry.manual.profile.enabled</refentrytitle>
<refmiscinfo class="other" otherclass="datatype">boolean</refmiscinfo>
</refmeta>
<refnamediv>
<refname>refentry.manual.profile.enabled</refname>
<refpurpose>Enable refentry "manual" profiling?</refpurpose>
</refnamediv>



<refsection><info><title>Description</title></info>

<para>If the value of
<parameter>refentry.manual.profile.enabled</parameter> is
non-zero, then during <tag>refentry</tag> metadata gathering, the info
profile specified by the customizable
<parameter>refentry.manual.profile</parameter> parameter is
used.</para>

<para>If instead the value of
<parameter>refentry.manual.profile.enabled</parameter> is zero (the
default), then "hard coded" logic within the DocBook XSL stylesheets
is used for gathering <tag>refentry</tag> "manual" data.</para>

<para>If you find that the default <tag>refentry</tag>
metadata-gathering behavior is causing incorrect "manual" data to show
up in your output, then consider setting a non-zero value for
<parameter>refentry.manual.profile.enabled</parameter> and adjusting
the value of <parameter>refentry.manual.profile</parameter> to cause
correct data to be gathered. </para>

<para>Note that the term "manual" has a special meanings in this
context. For details, see the documentation for the
<parameter>refentry.manual.profile</parameter> parameter.</para>

</refsection>
</doc:refentry>
<xsl:param name="refentry.manual.profile.enabled">0</xsl:param>

<doc:refentry xmlns:doc="http://nwalsh.com/xsl/documentation/1.0" id="refentry.manual.profile">
<refmeta>
<refentrytitle>refentry.manual.profile</refentrytitle>
<refmiscinfo class="other" otherclass="datatype">string</refmiscinfo>
</refmeta>
<refnamediv>
<refname>refentry.manual.profile</refname>
<refpurpose>Specifies profile for refentry "manual" data</refpurpose>
</refnamediv>



<refsection><info><title>Description</title></info>

<para>The value of <parameter>refentry.manual.profile</parameter> is
a string representing an XPath expression. It is evaluated at
run-time and used only if
<parameter>refentry.manual.profile.enabled</parameter> is
non-zero. Otherwise, the <tag>refentry</tag> metadata-gathering logic
"hard coded" into the stylesheets is used.</para>

<para>In man pages, this content is usually displayed in the middle of
the header of the page. The <literal>man(7)</literal> man page
describes this as "the title of the manual (e.g., <citetitle>Linux
Programmer's Manual</citetitle>)". Here are some examples from
existing man pages:
<itemizedlist>
  <listitem>
    <para><citetitle>dpkg utilities</citetitle>
    (<command>dpkg-name</command>)</para>
  </listitem>
  <listitem>
    <para><citetitle>User Contributed Perl Documentation</citetitle>
    (<command>GET</command>)</para>
  </listitem>
  <listitem>
    <para><citetitle>GNU Development Tools</citetitle>
    (<command>ld</command>)</para>
  </listitem>
  <listitem>
    <para><citetitle>Emperor Norton Utilities</citetitle>
    (<command>ddate</command>)</para>
  </listitem>
  <listitem>
    <para><citetitle>Debian GNU/Linux manual</citetitle>
    (<command>faked</command>)</para>
  </listitem>
  <listitem>
    <para><citetitle>GIMP Manual Pages</citetitle>
    (<command>gimp</command>)</para>
  </listitem>
  <listitem>
    <para><citetitle>KDOC Documentation System</citetitle>
    (<command>qt2kdoc</command>)</para>
  </listitem>
</itemizedlist>
</para>

</refsection>
</doc:refentry>
<xsl:param name="refentry.manual.profile">
  (($info[//title])[last()]/title)[1]|
  ../title/node()
</xsl:param>

<doc:refentry xmlns:doc="http://nwalsh.com/xsl/documentation/1.0" id="refentry.meta.get.quietly">
<refmeta>
<refentrytitle>refentry.meta.get.quietly</refentrytitle>
<refmiscinfo class="other" otherclass="datatype">boolean</refmiscinfo>
</refmeta>
<refnamediv>
<refname>refentry.meta.get.quietly</refname>
<refpurpose>Suppress notes and warnings when gathering refentry metadata?</refpurpose>
</refnamediv>



<refsection><info><title>Description</title></info>

<para>If zero (the default), notes and warnings about “missing” markup
are generated during gathering of refentry metadata. If non-zero, the
metadata is gathered “quietly” -- that is, the notes and warnings are
suppressed.</para>

<tip>
  <para>If you are processing a large amount of <tag>refentry</tag>
  content, you may be able to speed up processing significantly by
  setting a non-zero value for
  <parameter>refentry.meta.get.quietly</parameter>.</para>
</tip>

</refsection>
</doc:refentry>
<xsl:param name="refentry.meta.get.quietly" select="0"/>

<doc:refentry xmlns:doc="http://nwalsh.com/xsl/documentation/1.0" id="refentry.source.fallback.profile">
<refmeta>
<refentrytitle>refentry.source.fallback.profile</refentrytitle>
<refmiscinfo class="other" otherclass="datatype">string</refmiscinfo>
</refmeta>
<refnamediv>
<refname>refentry.source.fallback.profile</refname>
<refpurpose>Specifies profile of "fallback" for refentry "source" data</refpurpose>
</refnamediv>



<refsection><info><title>Description</title></info>

<para>The value of
<parameter>refentry.source.fallback.profile</parameter> is a string
representing an XPath expression. It is evaluated at run-time and used
only if no "source" data can be found by other means (that is, either
using the <tag>refentry</tag> metadata-gathering logic "hard coded" in
the stylesheets, or the value of the
<parameter>refentry.source.name.profile</parameter> and
<parameter>refentry.version.profile</parameter> parameters, if those
are enabled).</para>

<important>
<para>Depending on which XSLT engine you run, either the EXSLT
<function>dyn:evaluate</function> extension function (for xsltproc or
Xalan) or <function>saxon:evaluate</function> extension function (for
Saxon) are used to dynamically evaluate the value of
<parameter>refentry.source.fallback.profile</parameter> at
run-time. If you don't use xsltproc, Saxon, Xalan -- or some other
XSLT engine that supports <function>dyn:evaluate</function> -- you
must manually disable fallback processing by setting an empty value
for the <parameter>refentry.source.fallback.profile</parameter>
parameter.</para>
</important>

</refsection>
</doc:refentry>
<xsl:param name="refentry.source.fallback.profile">
refmeta/refmiscinfo[not(@class = 'date')][1]/node()</xsl:param>

<doc:refentry xmlns:doc="http://nwalsh.com/xsl/documentation/1.0" id="refentry.source.name.profile.enabled">
<refmeta>
<refentrytitle>refentry.source.name.profile.enabled</refentrytitle>
<refmiscinfo class="other" otherclass="datatype">boolean</refmiscinfo>
</refmeta>
<refnamediv>
<refname>refentry.source.name.profile.enabled</refname>
<refpurpose>Enable refentry "source name" profiling?</refpurpose>
</refnamediv>



<refsection><info><title>Description</title></info>

<para>If the value of
<parameter>refentry.source.name.profile.enabled</parameter> is
non-zero, then during <tag>refentry</tag> metadata gathering, the info
profile specified by the customizable
<parameter>refentry.source.name.profile</parameter> parameter is
used.</para>

<para>If instead the value of
<parameter>refentry.source.name.profile.enabled</parameter> is zero (the
default), then "hard coded" logic within the DocBook XSL stylesheets
is used for gathering <tag>refentry</tag> "source name" data.</para>

<para>If you find that the default <tag>refentry</tag>
metadata-gathering behavior is causing incorrect "source name" data to
show up in your output, then consider setting a non-zero value for
<parameter>refentry.source.name.profile.enabled</parameter> and
adjusting the value of
<parameter>refentry.source.name.profile</parameter> to cause correct
data to be gathered. </para>

<para>Note that the terms "source" and "source name" have special
meanings in this context. For details, see the documentation for the
<parameter>refentry.source.name.profile</parameter> parameter.</para>

</refsection>
</doc:refentry>
<xsl:param name="refentry.source.name.profile.enabled">0</xsl:param>

<doc:refentry xmlns:doc="http://nwalsh.com/xsl/documentation/1.0" id="refentry.source.name.profile">
<refmeta>
<refentrytitle>refentry.source.name.profile</refentrytitle>
<refmiscinfo class="other" otherclass="datatype">string</refmiscinfo>
</refmeta>
<refnamediv>
<refname>refentry.source.name.profile</refname>
<refpurpose>Specifies profile for refentry "source name" data</refpurpose>
</refnamediv>



<refsection><info><title>Description</title></info>

<para>The value of <parameter>refentry.source.name.profile</parameter>
is a string representing an XPath expression. It is evaluated at
run-time and used only if
<parameter>refentry.source.name.profile.enabled</parameter> is
non-zero. Otherwise, the <tag>refentry</tag> metadata-gathering logic
"hard coded" into the stylesheets is used.</para>

<para>A "source name" is one part of a (potentially) two-part
<replaceable>Name</replaceable> <replaceable>Version</replaceable>
"source" field. In man pages, it is usually displayed in the left
footer of the page. It typically indicates the software system or
product that the item documented in the man page belongs to. The
<literal>man(7)</literal> man page describes it as "the source of
the command", and provides the following examples:
<itemizedlist>
  <listitem>
    <para>For binaries, use something like: GNU, NET-2, SLS
    Distribution, MCC Distribution.</para>
  </listitem>
  <listitem>
    <para>For system calls, use the version of the kernel that you
    are currently looking at: Linux 0.99.11.</para>
  </listitem>
  <listitem>
    <para>For library calls, use the source of the function: GNU, BSD
    4.3, Linux DLL 4.4.1.</para>
  </listitem>
</itemizedlist>
</para>

<para>In practice, there are many pages that simply have a Version
number in the "source" field. So, it looks like what we have is a
two-part field,
<replaceable>Name</replaceable> <replaceable>Version</replaceable>,
where:
<variablelist>
  <varlistentry>
    <term>Name</term>
    <listitem>
      <para>product name (e.g., BSD) or org. name (e.g., GNU)</para>
    </listitem>
  </varlistentry>
  <varlistentry>
    <term>Version</term>
    <listitem>
      <para>version number</para>
    </listitem>
  </varlistentry>
</variablelist>
Each part is optional. If the <replaceable>Name</replaceable> is a
product name, then the <replaceable>Version</replaceable> is probably
the version of the product. Or there may be no
<replaceable>Name</replaceable>, in which case, if there is a
<replaceable>Version</replaceable>, it is probably the version
of the item itself, not the product it is part of. Or, if the
<replaceable>Name</replaceable> is an organization name, then there
probably will be no <replaceable>Version</replaceable>.</para>
</refsection>
</doc:refentry>
<xsl:param name="refentry.source.name.profile">
  (($info[//productname])[last()]/productname)[1]|
  (($info[//corpname])[last()]/corpname)[1]|
  (($info[//corpcredit])[last()]/corpcredit)[1]|
  (($info[//corpauthor])[last()]/corpauthor)[1]|
  (($info[//orgname])[last()]/orgname)[1]|
  (($info[//publishername])[last()]/publishername)[1]
</xsl:param>

<doc:refentry xmlns:doc="http://nwalsh.com/xsl/documentation/1.0" id="refentry.source.name.suppress">
<refmeta>
<refentrytitle>refentry.source.name.suppress</refentrytitle>
<refmiscinfo class="other" otherclass="datatype">boolean</refmiscinfo>
</refmeta>
<refnamediv>
<refname>refentry.source.name.suppress</refname>
<refpurpose>Suppress "name" part of refentry "source" contents?</refpurpose>
</refnamediv>



<refsection><info><title>Description</title></info>

<para>If the value of
<parameter>refentry.source.name.suppress</parameter> is non-zero, then
during <tag>refentry</tag> metadata gathering, no "source name" data
is added to the <tag>refentry</tag> "source" contents. Instead (unless
<parameter>refentry.version.suppress</parameter> is also non-zero),
only "version" data is added to the "source" contents.</para>

<para>If you find that the <tag>refentry</tag> metadata gathering
mechanism is causing unwanted "source name" data to show up in your
output -- for example, in the footer (or possibly header) of a man
page -- then you might consider setting a non-zero value for
<parameter>refentry.source.name.suppress</parameter>.</para>

<para>Note that the terms "source", "source name", and "version" have
special meanings in this context. For details, see the documentation
for the <parameter>refentry.source.name.profile</parameter>
parameter.</para>

</refsection>
</doc:refentry>
<xsl:param name="refentry.source.name.suppress">0</xsl:param>

<doc:refentry xmlns:doc="http://nwalsh.com/xsl/documentation/1.0" id="refentry.version.profile.enabled">
<refmeta>
<refentrytitle>refentry.version.profile.enabled</refentrytitle>
<refmiscinfo class="other" otherclass="datatype">boolean</refmiscinfo>
</refmeta>
<refnamediv>
<refname>refentry.version.profile.enabled</refname>
<refpurpose>Enable refentry "version" profiling?</refpurpose>
</refnamediv>



<refsection><info><title>Description</title></info>

<para>If the value of
<parameter>refentry.version.profile.enabled</parameter> is
non-zero, then during <tag>refentry</tag> metadata gathering, the info
profile specified by the customizable
<parameter>refentry.version.profile</parameter> parameter is
used.</para>

<para>If instead the value of
<parameter>refentry.version.profile.enabled</parameter> is zero (the
default), then "hard coded" logic within the DocBook XSL stylesheets
is used for gathering <tag>refentry</tag> "version" data.</para>

<para>If you find that the default <tag>refentry</tag>
metadata-gathering behavior is causing incorrect "version" data to show
up in your output, then consider setting a non-zero value for
<parameter>refentry.version.profile.enabled</parameter> and adjusting
the value of <parameter>refentry.version.profile</parameter> to cause
correct data to be gathered. </para>

<para>Note that the terms "source" and "version" have special
meanings in this context. For details, see the documentation for the
<parameter>refentry.version.profile</parameter> parameter.</para>

</refsection>
</doc:refentry>
<xsl:param name="refentry.version.profile.enabled">0</xsl:param>

<doc:refentry xmlns:doc="http://nwalsh.com/xsl/documentation/1.0" id="refentry.version.profile">
<refmeta>
<refentrytitle>refentry.version.profile</refentrytitle>
<refmiscinfo class="other" otherclass="datatype">string</refmiscinfo>
</refmeta>
<refnamediv>
<refname>refentry.version.profile</refname>
<refpurpose>Specifies profile for refentry "version" data</refpurpose>
</refnamediv>



<refsection><info><title>Description</title></info>

<para>The value of <parameter>refentry.version.profile</parameter> is
a string representing an XPath expression. It is evaluated at
run-time and used only if
<parameter>refentry.version.profile.enabled</parameter> is
non-zero. Otherwise, the <tag>refentry</tag> metadata-gathering logic
"hard coded" into the stylesheets is used.</para>

<para>A "source.name" is one part of a (potentially) two-part
<replaceable>Name</replaceable> <replaceable>Version</replaceable>
"source" field. For more details, see the documentation for the
<parameter>refentry.source.name.profile</parameter> parameter.</para>

</refsection>
</doc:refentry>
<xsl:param name="refentry.version.profile">
  (($info[//productnumber])[last()]/productnumber)[1]|
  (($info[//edition])[last()]/edition)[1]|
  (($info[//releaseinfo])[last()]/releaseinfo)[1]
</xsl:param>

<doc:refentry xmlns:doc="http://nwalsh.com/xsl/documentation/1.0" id="refentry.version.suppress">
<refmeta>
<refentrytitle>refentry.version.suppress</refentrytitle>
<refmiscinfo class="other" otherclass="datatype">boolean</refmiscinfo>
</refmeta>
<refnamediv>
<refname>refentry.version.suppress</refname>
<refpurpose>Suppress "version" part of refentry "source" contents?</refpurpose>
</refnamediv>



<refsection><info><title>Description</title></info>

<para>If the value of <parameter>refentry.version.suppress</parameter>
is non-zero, then during <tag>refentry</tag> metadata gathering, no
"version" data is added to the <tag>refentry</tag> "source"
contents. Instead (unless
<parameter>refentry.source.name.suppress</parameter> is also
non-zero), only "source name" data is added to the "source"
contents.</para>

<para>If you find that the <tag>refentry</tag> metadata gathering
mechanism is causing unwanted "version" data to show up in your output
-- for example, in the footer (or possibly header) of a man page --
then you might consider setting a non-zero value for
<parameter>refentry.version.suppress</parameter>.</para>

<para>Note that the terms "source", "source name", and "version" have
special meanings in this context. For details, see the documentation
for the <parameter>refentry.source.name.profile</parameter>
parameter.</para>

</refsection>
</doc:refentry>
<xsl:param name="refentry.version.suppress">0</xsl:param>
</xsl:stylesheet>
