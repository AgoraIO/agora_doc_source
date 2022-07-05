@echo off
rem %~dp0 is expanded pathname of the current script under NT
SET CP="%~dp0;%~dp0/lib/oxygen-basic-utilities.jar;%~dp0/lib/oxygen.jar;%~dp0/lib/oxygenAuthor.jar;%~dp0/lib/oxygenDeveloper.jar;%~dp0/lib/syncroSVNClient.jar;%~dp0/lib/oxygenXMLDiff.jar;%~dp0/classes"

rem  The two command line parameters are optional and represent the path of the directory 
rem  displayed in the left side panel of the XML Diff window and the path of the directory 
rem  displayed in the right side panel.

SET OXYGEN_JAVA=java.exe
if exist "%JAVA_HOME%\bin\java.exe" set OXYGEN_JAVA="%JAVA_HOME%\bin\java.exe"
if exist "%~dp0\jre\bin\java.exe" SET OXYGEN_JAVA="%~dp0\jre\bin\java.exe"
rem Set environment variables
call "%~dp0\env.bat"
%OXYGEN_JAVA% -Dcom.oxygenxml.app.descriptor=ro.sync.diff.ui.DiffDirectoriesFrameDescriptor -Xmx256m -XX:SoftRefLRUPolicyMSPerMB=10 -Dsun.java2d.noddraw=true -Dsun.awt.nopixfmt=true -Dsun.java2d.dpiaware=true -Djava.net.preferIPv4Stack=true -Dsun.io.useCanonCaches=true -Dsun.io.useCanonPrefixCache=true -Dsun.awt.keepWorkingSetOnMinimize=true -Dcom.oxygenxml.ApplicationDataFolder="%APPDATA%" -cp %CP% ro.sync.exml.Oxygen %1 %2