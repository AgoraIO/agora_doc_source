@echo off

REM Usage:
REM sh translationPackageBuilder.sh -gm -i ditamapFile [-m milestoneFile] [-verbose]
REM sh translationPackageBuilder.sh -gp -i ditamapFile [-m milestoneFile] -p package.zip [-verbose]
REM sh translationPackageBuilder.sh -ap -i ditamapFile -p package.zip [-verbose]

echo Script file for detecting changes, sending them to translation and applying translated files.

SET BASE_DIR=%~dp0/..

SET CP="%BASE_DIR%;%BASE_DIR%/classes;%BASE_DIR%/lib;%BASE_DIR%/lib/oxygen.jar;%BASE_DIR%/lib/oxygenDeveloper.jar;%BASE_DIR%/lib/*"

SET OXYGEN_JAVA=java.exe
if exist "%JAVA_HOME%\bin\java.exe" set OXYGEN_JAVA="%JAVA_HOME%\bin\java.exe"
if exist "%~dp0\jre\bin\java.exe" SET OXYGEN_JAVA="%~dp0\jre\bin\java.exe"

call "%~dp0/toolsEnv.bat"
%OXYGEN_JAVA% -cp %CP% -Djava.awt.headless=true ro.sync.ecss.dita.map.translation.TranslationPackageBuilder %*