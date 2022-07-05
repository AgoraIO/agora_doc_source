<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <!-- Change call order compared to the original template from org.dita.html5/xsl/topic.xsl -->
    <xsl:template match="*" mode="chapterHead">
        <head>
            <!-- initial meta information -->
            <xsl:call-template name="generateCharset"/>   <!-- Set the character set to UTF-8 -->
            <xsl:call-template name="generateDefaultCopyright"/> <!-- Generate a default copyright, if needed -->
            <xsl:call-template name="generateDefaultMeta"/> <!-- Standard meta for security, robots, etc -->
            <xsl:call-template name="generateCssLinks"/>  <!-- Generate links to CSS files -->
            <xsl:call-template name="getMeta"/>           <!-- Process metadata from topic prolog -->
            <xsl:call-template name="copyright"/>         <!-- Generate copyright, if specified manually -->
            <xsl:call-template name="generateChapterTitle"/> <!-- Generate the <title> element -->
            <xsl:call-template name="gen-user-head" />    <!-- include user's XSL HEAD processing here -->
            <xsl:call-template name="gen-user-scripts" /> <!-- include user's XSL javascripts here -->
            <xsl:call-template name="gen-user-styles" />  <!-- include user's XSL style element and content here -->
            <xsl:call-template name="processHDF"/>        <!-- Add user HDF file, if specified -->
        </head>
    </xsl:template>
    
</xsl:stylesheet>