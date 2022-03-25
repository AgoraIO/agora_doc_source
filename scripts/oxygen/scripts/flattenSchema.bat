@echo off
rem %~dp0 is expanded pathname of the current script under NT

SET BASE_DIR=%~dp0/..
SET CP="%BASE_DIR%;%BASE_DIR%/lib/*;%BASE_DIR%/classes"
REM
REM The command line parameters are mandatory and represents the path of the input
REM and the output files.
REM
SET OXYGEN_JAVA=java.exe
if exist "%JAVA_HOME%\bin\java.exe" set OXYGEN_JAVA="%JAVA_HOME%\bin\java.exe"
if exist "%BASE_DIR%\jre\bin\java.exe" SET OXYGEN_JAVA="%BASE_DIR%\jre\bin\java.exe"
call "%~dp0/toolsEnv.bat"
%OXYGEN_JAVA% -Xmx128m -cp %CP% ro.sync.exml.editor.xsdeditor.flatten.FlattenXmlSchema %*