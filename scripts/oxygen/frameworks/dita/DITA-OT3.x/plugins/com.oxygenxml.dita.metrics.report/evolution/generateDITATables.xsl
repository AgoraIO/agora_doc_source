<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs oxyd"
    xmlns:oxyd="http://www.oxygenxml.com/ns/dita"
    version="2.0">
    
    <xsl:output doctype-public="-//OASIS//DTD DITA Topic//EN" doctype-system="topic.dita" indent="yes"/>
    
    <xsl:template match="/">
        <xsl:variable name="allReports" select="collection('samples/?select=*.xml')"/>
        <xsl:variable name="allReportsSorted">
            <xsl:for-each select="$allReports">
                <xsl:sort select="replace(tokenize(document-uri(.), '/')[last()], '%20', ' ')"/>
                <xsl:copy-of select="."/>
            </xsl:for-each>
        </xsl:variable>
        <xsl:variable name="allReportsSortedFileNames">
            <xsl:for-each select="$allReports">
                <xsl:sort select="replace(tokenize(document-uri(.), '/')[last()], '%20', ' ')"/>
                <fn>
                    <xsl:copy-of select="replace(tokenize(document-uri(.), '/')[last()], '%20', ' ')"/>
                </fn>
            </xsl:for-each>
        </xsl:variable>
        <topic id="topic_nrk_bnd_phb">
            <title>oXygen metrics Evolution</title>
            <body>
                <!--<section>
                    <title>Main information</title>
                    <table outputclass="embed-svg-report">
                        <tgroup cols="{count($allReports) + 1}">
                            <thead>
                                <row>
                                    <entry>Evolution</entry>
                                    <xsl:for-each select="$allReportsSortedFileNames/*">
                                        <entry><xsl:value-of select="."/></entry>
                                    </xsl:for-each>
                                </row>
                            </thead>
                            <tbody>
                                <row>
                                    <entry>Total maps processed</entry>
                                    <xsl:for-each select="$allReportsSorted/*/oxyd:stats/oxyd:overview/oxyd:maps">
                                        <entry><xsl:value-of select="."/></entry>
                                    </xsl:for-each>
                                </row>
                                <row>
                                    <entry>Unique maps</entry>
                                    <xsl:for-each select="$allReportsSorted/*/oxyd:stats/oxyd:overview/oxyd:uniqueMaps">
                                        <entry><xsl:value-of select="."/></entry>
                                    </xsl:for-each>
                                </row>
                                <row>
                                    <entry>Total topics processed</entry>
                                    <xsl:for-each select="$allReportsSorted/*/oxyd:stats/oxyd:overview/oxyd:topics">
                                        <entry><xsl:value-of select="."/></entry>
                                    </xsl:for-each>
                                </row>
                                <row>
                                    <entry>Unique topics</entry>
                                    <xsl:for-each select="$allReportsSorted/*/oxyd:stats/oxyd:overview/oxyd:uniqueTopics">
                                        <entry><xsl:value-of select="."/></entry>
                                    </xsl:for-each>
                                </row>
                            </tbody>
                        </tgroup>
                    </table>
                </section>-->
                
                <section>
                    <title>Maps</title>
                    <table outputclass="embed-svg-report">
                        <tgroup cols="{count($allReports) + 1}">
                            <thead>
                                <row>
                                    <entry>Evolution</entry>
                                    <xsl:for-each select="$allReportsSortedFileNames/*">
                                        <entry><xsl:value-of select="."/></entry>
                                    </xsl:for-each>
                                </row>
                            </thead>
                            <tbody>
                                <xsl:for-each select="$allReportsSorted[1]/*[1]/oxyd:stats/oxyd:infoTypes/oxyd:mapInfoTypes/oxyd:element">
                                    <xsl:variable name="name" select="@name"/>
                                    <row>
                                        <entry><xsl:value-of select="$name"/></entry>
                                        <xsl:for-each select="$allReportsSorted/*/oxyd:stats/oxyd:infoTypes/oxyd:mapInfoTypes/oxyd:element[@name=$name]">
                                            <entry><xsl:value-of select="@count"/></entry>
                                        </xsl:for-each>
                                    </row>
                                </xsl:for-each>
                            </tbody>
                        </tgroup>
                    </table>
                </section>
                
                <section>
                    <title>Topics</title>
                    <table outputclass="embed-svg-report">
                        <tgroup cols="{count($allReports) + 1}">
                            <thead>
                                <row>
                                    <entry>Evolution</entry>
                                    <xsl:for-each select="$allReportsSortedFileNames/*">
                                        <entry><xsl:value-of select="."/></entry>
                                    </xsl:for-each>
                                </row>
                            </thead>
                            <tbody>
                                <xsl:for-each select="$allReportsSorted[1]/*[1]/oxyd:stats/oxyd:infoTypes/oxyd:topicInfoTypes/oxyd:element">
                                    <xsl:variable name="name" select="@name"/>
                                    <row>
                                        <entry><xsl:value-of select="$name"/></entry>
                                        <xsl:for-each select="$allReportsSorted/*/oxyd:stats/oxyd:infoTypes/oxyd:topicInfoTypes/oxyd:element[@name=$name]">
                                            <entry><xsl:value-of select="@count"/></entry>
                                        </xsl:for-each>
                                    </row>
                                </xsl:for-each>
                            </tbody>
                        </tgroup>
                    </table>
                </section>
                
                <section>
                    <title>Content reuse</title>
                     <!-- /oxyd:report/oxyd:stats[1]/oxyd:conrefs[1] -->
                    <table outputclass="embed-svg-report">
                        <tgroup cols="{count($allReports) + 1}">
                            <thead>
                                <row>
                                    <entry>Evolution</entry>
                                    <xsl:for-each select="$allReportsSortedFileNames/*">
                                        <entry><xsl:value-of select="."/></entry>
                                    </xsl:for-each>
                                </row>
                            </thead>
                            <tbody>
                                <row>
                                    <entry>Reused words</entry>
                                    <xsl:for-each select="$allReportsSorted/*/oxyd:stats/oxyd:conrefs/oxyd:conrefTotalWords">
                                        <entry><xsl:value-of select="."/></entry>
                                    </xsl:for-each>
                                </row>
                                <row>
                                    <entry>Reused elements</entry>
                                    <xsl:for-each select="$allReportsSorted/*/oxyd:stats/oxyd:conrefs/oxyd:conrefTotalElements">
                                        <entry><xsl:value-of select="."/></entry>
                                    </xsl:for-each>
                                </row>
                                <row>
                                    <entry>Total conrefs</entry>
                                    <xsl:for-each select="$allReportsSorted/*/oxyd:stats/oxyd:conrefs/oxyd:totalConrefs">
                                        <entry><xsl:value-of select="."/></entry>
                                    </xsl:for-each>
                                </row>
                            </tbody>
                        </tgroup>
                    </table>
                </section>
            </body>
        </topic>
    </xsl:template>
</xsl:stylesheet>