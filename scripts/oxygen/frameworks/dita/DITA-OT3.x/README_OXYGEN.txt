DITA Open Toolkit bundled with Oxygen 24.1, build 2022030800

Differences between the DITA Open Toolkit bundled with Oxygen and a regular DITA Open Toolkit distribution
downloaded from the DITA-OT project:

http://www.dita-ot.org/


/bin/
The launchers dita.bat and dita.sh use now other Java class that is capable of expanding wildcard plugin references to jar files.


--------ADDITIONAL INSTALLED PLUGINS---------------

Oxygen plugins used for publishing to WebHelp and PDF (CSS based).

com.oxygenxml.common
com.oxygenxml.dita.metrics.report
com.oxygenxml.dost.patches
com.oxygenxml.editlink
com.oxygenxml.export.map
com.oxygenxml.highlight
com.oxygenxml.html.custom
com.oxygenxml.html.embed
com.oxygenxml.image.float
com.oxygenxml.copy.resources
com.oxygenxml.media
com.oxygenxml.merged
com.oxygenxml.pdf.css 		
com.oxygenxml.pdf.custom - deprecated, will be removed in future versions
com.oxygenxml.pdf.review 
com.oxygenxml.webhelp.common
com.oxygenxml.webhelp.responsive
mathml
com.oxygenxml.dynamic.resources.converter

Oxygen publishing integrations

com.oxygenxml.zendesk


DITA plugins not distributed by default:

org.dita.javahelp
org.dita.troff


Other third party plugins are distributed under the Apache 2.0 License:

com.elovirta.ooxml https://github.com/jelovirt/com.elovirta.ooxml

The following are used for publising to EPUB, Kindle and other formats:


https://github.com/dita-community

org.dita-community.adjust-copy-to
org.dita-community.common.mapdriven
org.dita-community.common.xslt
org.dita-community.dita13.html
org.dita-community.dita13.pdf
org.dita-community.preprocess-extensions


https://github.com/dita4publishers

org.dita4publishers.common.html
org.dita4publishers.common.mapdriven
org.dita4publishers.common.xslt
org.dita4publishers.dita2indesign
org.dita4publishers.epub
org.dita4publishers.html2
org.dita4publishers.json
org.dita4publishers.kindle
org.dita4publishers.word2dita
----------PATCHES---------------------
These is an overview of the major changes we made to the DITA For publishers plugins.
org.dita-community.dita13.html/xsl/mathml-d2html.xsl
   EXM-46302 Disable calling a template if certain parameters are not enabled.
org.dita4publishers.epub/xsl/epubHtmlOverrides.xsl
   EXM-42549 - adding a / for paths that do not end in a / or \
org.dita4publishers.epub/lib/epub-font-obfuscator.jar
    EXM-46537 Removed references to Apache commons io classes


--------REMOVED RESOURCES----------------
The following directories have been removed:

doc

----------PATCHES---------------------
These is an overview of the major changes we made to the default DITA-OT plugins.

org.dita.eclipsehelp/xsl/contexts.xsl	
org.dita.eclipsehelp/build_contexts.xml	
org.dita.eclipsehelp/build_dita2eclipsehelp_template.xml
  EXM-18224	Creates a context file mapping from id to file 

org.dita.htmlhelp/lib/htmlhelp.jar
  EXM-43161 HTML topics inside CHM should use UTF-8 encoding
org.dita.htmlhelp/xsl/map2htmlhelp/map2hhpImpl.xsl 
  EXM-18626 Changes for better CHM rendering
  EXM-31236 Add parameter args.htmlhelp.default.topic in DITA CHM transform that sets the 
	path of the topic opened by default in CHM output.
 
org.dita.javahelp/xsl/map2javahelpmap.xsl
  EXM-18765 Fixed broken links on children of reused topic refs
  EXM-33812 Look for copy-to attributes.
org.dita.javahelp/xsl/map2javahelptoc.xsl
  EXM-18359 Correctly look for title of map
  EXM-22437 Removed extra spaces due to frontmatter, toc, backmatter
  EXM-21663 Normalize title text
  EXM-33812 Look for copy-to attributes.
org.dita.javahelp/xsl/map2javahelpset.xsl
  Normalize map title
org.dita.javahelp/build_dita2javahelp.xml
  EXM-18027 Correct generated help IDs

 
org.dita.xhtml/xsl/dita2html-util.xsl 
	EXM-41800 REMOVE HTML 5 elements from content, to make compatible the JavaHelp output with the help reader.

org.lwdita
	Changed the plugin.xml to use the wildcard for library references.
	
org.dita.pdf2.fop
	Added oxygen-patched-* extra jar libraries to FOP. It allows the FOP to output MathML equations, and various SVG fixes.
	Updated used Batik Libraries to version 1.14 and FOP Libraries to 2.6.
org.dita.pdf2.fop/cfg.fop.xconf	
    EXM-42187, use a higher source resolution so that SVGs do not appear scaled up
    
org.oasis-open.dita.v2_0
org.oasis-open.dita.techcomm.v2_0
  Added OASIS license and updated to latest OASIS DTDs from DITA OT project.

lib/logback-*-1.2.10.jar
OPE-43 Updated the JAR library to version 1.2.6 due to security concerns
OPE-54 Updated the JAR library to version 1.2.10 due to security concerns
lib/jackson-*-2.13.1.jar
OPE-57  Updated the JAR library to version 2.13.1 due to security concerns
lib/xercesImpl-2.12.2.jar
OPE-60 Updated the JAR library to version 2.12.2 due to security concerns

com.elovirta.ooxml/docx/word/document.topic.xsl
    EXM-44025 Added a patch which uses only the SVG file name for the reference.
com.elovirta.ooxml/docx/word/_rels/document.xml.xsl
    EXM-44025 Added a patch which uses only the SVG file name for the reference.
    
config/logback.xml
    EXM-47855 Set slf4j log level to INFO for some packages from plugin com.oxygenxml.zendesk:
    io.netty, org.zendesk.client, org.asynchttpclient, com.oxygenxml.zendesk, com.oxygenxml.platform.integration
       