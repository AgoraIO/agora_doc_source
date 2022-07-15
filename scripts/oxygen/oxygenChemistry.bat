@ECHO OFF
REM Oxygen PDF Chemistry Startup script
REM (c) 2017 Syncro Soft SRL.
ECHO Starting Chemistry installed in %~dp0

SET CHEMISTRY_JAVA=java.exe
IF EXIST "%JAVA_HOME%\bin\java.exe" SET CHEMISTRY_JAVA="%JAVA_HOME%\bin\java.exe"
IF EXIST "%~dp0\jre\bin\java.exe" SET CHEMISTRY_JAVA="%~dp0\jre\bin\java.exe"

SETLOCAL EnableDelayedExpansion	
IF [!JAVA_ARG_LINE!] == [] ENDLOCAL & CALL :xmx %*
ENDLOCAL	

IF EXIST "%~dp0..\..\..\pom.xml" GOTO dev
 
ECHO Java executable: %CHEMISTRY_JAVA%;

REM 
REM Build the classpath. The first should be the chemistry jar, then the oxygen SDK, then others
REM
SET CLASSPATH=%~dp0lib\oxygen-pdf-chemistry.jar;%~dp0classes
FOR /R "%~dp0lib" %%a in (oxygen*.jar) DO CALL :add-to-path "%%a"
SET CLASSPATH=%CLASSPATH%;%~dp0lib\*


REM
REM Start the production version.
REM

SET CHEMISTRY_INSTALL_DIR=%~dp0
%CHEMISTRY_JAVA% %XMX% %JAVA_ARG_LINE% -Djava.awt.headless=true -cp "%CLASSPATH%" com.oxygenxml.chemistry.OxygenPDFChemistry  %*
SET ERROR_CODE=%ERRORLEVEL%
GOTO :end


REM 
REM Determins the memory settings.
REM 
:xmx
	REM No arguments.
	REM Determine the memory setting. Start from a default value, then search the command line for a specified value.
	SET XMX=-Xmx512m
	CALL :read_xmx %*
	ECHO Memory size setting: %XMX%
GOTO :EOF

REM 
REM Starts the development version.
REM 
:dev 
	ECHO Development version
	SET MAVEN_OPTS=%JAVA_ARG_LINE% %XMX%
	ECHO Maven options: %MAVEN_OPTS%
    SET CHEMISTRY_INSTALL_DIR=%~dp0..\..\..
	CALL mvn -f "%~dp0..\..\..\pom.xml" exec:java -P exec-profile -Dexec.mainClass="com.oxygenxml.chemistry.OxygenPDFChemistry" -Dexec.args="%*"
	SET ERROR_CODE=%ERRORLEVEL%	
GOTO :end


REM
REM A procedure to append a value to the classpath
REM
:add-to-path
	SET CLASSPATH=%CLASSPATH%;%~1
GOTO :EOF


REM 
REM A procedure to find the XMX value from the command line arguments.
REM 
:read_xmx
	SET _cc=%1

	SETLOCAL EnableDelayedExpansion	
	IF "!_cc:~0,4!" == "-Xmx" ENDLOCAL & SET XMX=%_cc% & GOTO :EOF
	IF "!_cc!" == "" ENDLOCAL & GOTO :EOF
	ENDLOCAL

	REM Go to next argument.
	SHIFT
GOTO :read_xmx


REM
REM The end of the script
REM
:end
EXIT /B %ERROR_CODE%