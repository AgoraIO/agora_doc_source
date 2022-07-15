@echo off
rem
rem %~dp0 is expanded pathname of the current script under NT
rem
SET CP="%~dp0;%~dp0/lib/oxygen-basic-utilities.jar;%~dp0/lib/oxygen.jar;%~dp0/lib/oxygenAuthor.jar;%~dp0/classes;"
rem
rem The command line parameters can be:
rem
rem  1. file paths of local files opened automatically in editor panels at startup
rem
rem  2. the following sequence to open a file with default schema association
rem   
rem      -instance pathToXMLFile -schema pathToSchemaFile -schemaType XML_SCHEMA|DTD_SCHEMA|RNG_SCHEMA|RNC_SCHEMA -dtName documentTypeName
rem
rem     where:
rem
rem       - pathToXMLFile: is the name of a local XML file
rem       - pathToSchemaFile: is the name of the schema which you want to associate to the XML file
rem       - schemaType: the four constants (XML_SCHEMA, DTD_SCHEMA, RNG_SCHEMA, RNC_SCHEMA) are the possible 
rem           schema types (W3C XML Schema, DTD, Relax NG schema in full syntax, Relax NG schema 
rem           in compact syntax)
rem       - dtName: The name of the document type automatically generated for association.
rem
SET OXYGEN_JAVA=java.exe
if exist "%JAVA_HOME%\bin\java.exe" set OXYGEN_JAVA="%JAVA_HOME%\bin\java.exe"
if exist "%~dp0\jre\bin\java.exe" SET OXYGEN_JAVA="%~dp0\jre\bin\java.exe"
rem Set environment variables
call "%~dp0\env.bat"
%OXYGEN_JAVA% -Xmx1g -XX:-OmitStackTraceInFastThrow -XX:SoftRefLRUPolicyMSPerMB=10 -Dsun.java2d.noddraw=true -Dsun.awt.nopixfmt=true -Dsun.java2d.dpiaware=true -Djava.net.preferIPv4Stack=true -Dsun.io.useCanonCaches=true -Dsun.io.useCanonPrefixCache=true -Dsun.awt.keepWorkingSetOnMinimize=true -Dcom.oxygenxml.app.descriptor=ro.sync.exml.AuthorFrameDescriptor -Dcom.oxygenxml.ApplicationDataFolder="%APPDATA%" -cp %CP% ro.sync.exml.Oxygen %*