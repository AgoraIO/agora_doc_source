#!/bin/sh
# Oxygen Startup script
# (c) 2017 Syncro Soft SRL.

oldpwd=`pwd`

# Resolve the location of the chemistry installation.
# This includes resolving any symlinks.
PRG=$0

# Check OS
OS=`uname -s`
if [ "$OS" = "Darwin" ]
then
# OS X was detected
    cd "`dirname "$PRG"`"
    PRG=`basename "$PRG"`

    while [ -L "$PRG" ]
    do
        PRG="`readlink "$PRG"`"
        cd "`dirname "$PRG"`"
        PRG="`basename "$PRG"`"
    done
else
# Assuming is Linux
    while [ -h "$PRG" ]; do
        ls=`ls -ld "$PRG"`
        link=`expr "$ls" : '^.*-> \(.*\)$' 2>/dev/null`
        if expr "$link" : '^/' 2> /dev/null >/dev/null; then
            PRG="$link"
        else
            PRG="`dirname "$PRG"`/$link"
        fi
    done
fi

CHEMISTRY_HOME=`dirname "$PRG"`
# Absolutize dir
cd "${CHEMISTRY_HOME}"; CHEMISTRY_HOME=`pwd`
cd "${oldpwd}"; unset oldpwd

echo "Starting Chemistry installed in ${CHEMISTRY_HOME} "

CHEMISTRY_JAVA=java
if [ -f "${JAVA_HOME}/bin/java" ]
then
  CHEMISTRY_JAVA="${JAVA_HOME}/bin/java"
fi
if [ -f "${CHEMISTRY_HOME}/jre/bin/java" ]
then
  CHEMISTRY_JAVA="${CHEMISTRY_HOME}/jre/bin/java"
fi
if [ -f "${CHEMISTRY_HOME}/.install4j/jre.bundle/Contents/Home/jre/bin/java" ]
then
  CHEMISTRY_JAVA="${CHEMISTRY_HOME}/.install4j/jre.bundle/Contents/Home/jre/bin/java"
fi
if [ -f "${CHEMISTRY_HOME}/.install4j/jre.bundle/Contents/Home/bin/java" ]
then
  CHEMISTRY_JAVA="${CHEMISTRY_HOME}/.install4j/jre.bundle/Contents/Home/bin/java"
fi
if [ "${JAVA_ARG_LINE}" = "" ]
then
        # Determine the memory setting. Start from a default value, then search the command line for a specified value.
        XMX="-Xmx512m"
        
        for i in "$@"
        do
        key="$i"
        case $key in
            -Xmx*)
                 XMX="$key"
            ;;
            *)
                # unknown option
            ;;
        esac
       
        done
        
        echo "Memory size setting: $XMX";
fi
echo "Java executable: $CHEMISTRY_JAVA";

# Classpath
# The first should be the chemistry jar, then the oxygen SDK, then others
oldpwd=`pwd`
cd "${CHEMISTRY_HOME}"
CP=$CHEMISTRY_HOME/lib/oxygen-pdf-chemistry.jar:$CHEMISTRY_HOME/classes
for i in `ls -d lib/oxygen*.jar`
do
  CP=${CP}:$CHEMISTRY_HOME/${i}
done
CP=${CP}:$CHEMISTRY_HOME/lib/*
cd "${oldpwd}"; unset oldpwd

export CHEMISTRY_INSTALL_DIR="${CHEMISTRY_HOME}"
"${CHEMISTRY_JAVA}" ${JAVA_ARG_LINE} ${XMX} -cp "${CP}" -Djava.awt.headless=true com.oxygenxml.chemistry.OxygenPDFChemistry "$@"
ERROR_CODE=$?

# Propagate the exit code of the last command as the result of the script
exit ${ERROR_CODE}
