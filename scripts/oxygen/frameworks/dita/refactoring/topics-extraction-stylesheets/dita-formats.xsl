<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="3.0">
    
    <!-- DITA output format -->
    <xsl:output name="topic" exclude-result-prefixes="#all" indent="yes" doctype-public="-//OASIS//DTD DITA Topic//EN" doctype-system="topic.dtd"/>
    
    <!-- DITA task -->
    <xsl:output name="task" exclude-result-prefixes="#all" indent="yes" doctype-public="-//OASIS//DTD DITA Task//EN" doctype-system="task.dtd"/>
    
    <!-- DITA glossentry -->
    <xsl:output name="glossentry" exclude-result-prefixes="#all" indent="yes" doctype-public="-//OASIS//DTD DITA Glossary//EN" doctype-system="glossary.dtd"/>
    
    <!-- DITA  Concept-->
    <xsl:output name="concept" exclude-result-prefixes="#all" indent="yes" doctype-public="-//OASIS//DTD DITA Concept//EN" doctype-system="concept.dtd"/>
    
    <!-- DITA  Glossgroup-->
    <xsl:output name="glossgroup" exclude-result-prefixes="#all" indent="yes" doctype-public="-//OASIS//DTD DITA Glossary Group//EN" doctype-system="glossgroup.dtd"/>
    
    <!-- DITA  Reference-->
    <xsl:output name="reference" exclude-result-prefixes="#all" indent="yes" doctype-public="-//OASIS//DTD DITA Reference//EN" doctype-system="reference.dtd"/>
    
    <!-- DITA  Troubleshooting-->
    <xsl:output name="troubleshooting" exclude-result-prefixes="#all" indent="yes" doctype-public="-//OASIS//DTD DITA Troubleshooting//EN" doctype-system="troubleshooting.dtd"/>
    
    <!-- Maps topic names to RNG URLs -->
    <xsl:variable name="DEFAULT_RNG_FORMATS" as="map(xs:string, xs:string)" select="map { 
        'topic' : 'urn:oasis:names:tc:dita:rng:topic.rng',
        'task' : 'urn:oasis:names:tc:dita:rng:task.rng',
        'glossentry' : 'urn:oasis:names:tc:dita:rng:glossentry.rng',
        'concept' : 'urn:oasis:names:tc:dita:rng:concept.rng',
        'glossgroup' : 'urn:oasis:names:tc:dita:rng:glossgroup.rng',
        'reference' : 'urn:oasis:names:tc:dita:rng:reference.rng',
        'troubleshooting' : 'urn:oasis:names:tc:dita:rng:troubleshooting.rng'
        }">      
    </xsl:variable>
    
    
</xsl:stylesheet>