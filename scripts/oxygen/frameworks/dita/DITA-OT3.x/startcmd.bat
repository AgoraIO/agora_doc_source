@echo off
REM Generated file, do not edit manually
echo "NOTE: The startcmd.bat has been deprecated, use the dita.bat command instead."
pause

REM Get the absolute path of DITAOT's home directory
set DITA_DIR=%~dp0

REM Set environment variables
set ANT_OPTS=-Xmx512m %ANT_OPTS%
set ANT_OPTS=%ANT_OPTS% -Djavax.xml.transform.TransformerFactory=net.sf.saxon.TransformerFactoryImpl
set ANT_HOME=%DITA_DIR%
set PATH=%DITA_DIR%\bin;%PATH%
set CLASSPATH=%DITA_DIR%lib;%CLASSPATH%
set CLASSPATH=%DITA_DIR%lib\ant-apache-resolver-1.10.12.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%lib\ant-launcher.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%lib\ant.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%lib\commons-io-2.8.0.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%lib\dost-configuration.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%lib\dost.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%lib\guava-25.1-jre.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%lib\icu4j-70.1.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%lib\isorelax-20030108.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%lib\jackson-annotations-2.13.1.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%lib\jackson-core-2.13.1.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%lib\jackson-databind-2.13.1.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%lib\jackson-dataformat-yaml-2.13.1.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%lib\jing-20181222.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%lib\logback-classic-1.2.10.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%lib\logback-core-1.2.10.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%lib\slf4j-api-1.7.32.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%lib\snakeyaml-1.28.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%lib\xercesImpl-2.12.2.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%lib\xml-apis-1.4.01.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%lib\xml-resolver-1.2.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%plugins\org.dita.pdf2\lib\fo.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%plugins\com.oxygenxml.common\lib\jakarta.xml.bind-api-2.3.3.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%plugins\com.oxygenxml.common\lib\jaxb-impl-2.3.3.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%plugins\com.oxygenxml.common\lib\jakarta.activation-1.2.2.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%plugins\com.oxygenxml.common\lib\ant-contrib-1.0b3.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%plugins\com.oxygenxml.common\lib\oxygen-dita-publishing-ant-extensions.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%plugins\com.oxygenxml.common\lib\oxygen-dita-publishing-xslt-extensions.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%plugins\com.oxygenxml.dost.patches\lib\oxygen-dost-patches.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%plugins\com.oxygenxml.dynamic.resources.converter\lib\*;%CLASSPATH%
set CLASSPATH=%DITA_DIR%plugins\com.oxygenxml.dynamic.resources.converter\lib\poi\*;%CLASSPATH%
set CLASSPATH=%DITA_DIR%plugins\com.oxygenxml.highlight\lib\xslthl-2.1.4.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%plugins\com.oxygenxml.highlight\lib\xslthl-saxonhe-extension-function.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%plugins\org.dita.eclipsehelp\lib\eclipsehelp.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%plugins\org.dita.htmlhelp\lib\htmlhelp.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%plugins\org.dita.index\lib\index.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%plugins\org.dita.javahelp\lib\javahelp.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%plugins\org.dita.javahelp\lib\jsearch.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%plugins\org.dita.pdf2.axf\lib\axf.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%plugins\org.dita.pdf2.fop\lib\oxygen-patched-fop-patches.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%plugins\org.dita.pdf2.fop\lib\oxygen-patched-batik-patches.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%plugins\org.dita.pdf2.fop\lib\oxygen-patched-jeuclid-core-patches.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%plugins\org.dita.pdf2.fop\lib\*;%CLASSPATH%
set CLASSPATH=%DITA_DIR%plugins\org.dita.pdf2.xep\lib\xep.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%plugins\org.lwdita\lib\*;%CLASSPATH%
start "DITA-OT" cmd.exe
