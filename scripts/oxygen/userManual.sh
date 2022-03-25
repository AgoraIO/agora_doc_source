#!/bin/sh
# Oxygen Startup script
# (c) 2017 Syncro Soft SRL.

oldpwd=`pwd`

# Resolve the location of the oxygen installation.
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

OXYGEN_HOME=`dirname "$PRG"`

# Absolutize dir
cd "${OXYGEN_HOME}"; OXYGEN_HOME=`pwd`
cd "${oldpwd}"; unset oldpwd

# Classpath
CP=$OXYGEN_HOME
CP=$CP:$OXYGEN_HOME/lib/oxygen.jar
CP=$CP:$OXYGEN_HOME/lib/oxygenAuthor.jar
CP=$CP:$OXYGEN_HOME/lib/oxygenDeveloper.jar
CP=$CP:$OXYGEN_HOME/lib/syncroSVNClient.jar
CP=$CP:$OXYGEN_HOME/lib/oxygenXMLDiff.jar
CP=$CP:$OXYGEN_HOME/lib/*

OXYGEN_JAVA=java
if [ -f "${JAVA_HOME}/bin/java" ]
then
  OXYGEN_JAVA="${JAVA_HOME}/bin/java"
fi
if [ -f "${OXYGEN_HOME}/jre/bin/java" ]
then
  OXYGEN_JAVA="${OXYGEN_HOME}/jre/bin/java"
fi
if [ -f "${OXYGEN_HOME}/.install4j/jre.bundle/Contents/Home/jre/bin/java" ]
then
  OXYGEN_JAVA="${OXYGEN_HOME}/.install4j/jre.bundle/Contents/Home/jre/bin/java"
fi
if [ -f "${OXYGEN_HOME}/.install4j/jre.bundle/Contents/Home/bin/java" ]
then
  OXYGEN_JAVA="${OXYGEN_HOME}/.install4j/jre.bundle/Contents/Home/bin/java"
fi

set -- \
 -Xms20m\
 -Xmx128m\
 -XX:SoftRefLRUPolicyMSPerMB=10\
 -cp "$CP"\
 ro.sync.exml.HelpFrame\
 UserManual_editor

if [ "$OS" = "Darwin" ]
then
set -- \
 -Xdock:name="User Manual"\
 -Xdock:icon="${OXYGEN_HOME}/macOS.resources/UserManual.icns"\
 "$@"
fi

"${OXYGEN_JAVA}" "$@"