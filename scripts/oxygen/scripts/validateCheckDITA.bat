@echo off

echo Script file for DITA map completeness check
echo using oXygen XML Editor DITA map completeness check.
REM Usage:
REM "validateCheckDITA.bat -i ditamapFile [ [-s settingsFile] | [-r reportFile]]"

SET BASE_DIR=%~dp0/..

SET CP="%BASE_DIR%;%BASE_DIR%/classes;%BASE_DIR%/lib;%BASE_DIR%/lib/oxygen.jar;%BASE_DIR%/lib/oxygenDeveloper.jar;%BASE_DIR%/lib/*"

SET OXYGEN_JAVA=java.exe
if exist "%JAVA_HOME%\bin\java.exe" set OXYGEN_JAVA="%JAVA_HOME%\bin\java.exe"
if exist "%~dp0\jre\bin\java.exe" SET OXYGEN_JAVA="%~dp0\jre\bin\java.exe"

call "%~dp0/toolsEnv.bat"
%OXYGEN_JAVA% -cp %CP% -Djava.awt.headless=true ro.sync.ecss.dita.map.checker.ValidateCheckDITA %*