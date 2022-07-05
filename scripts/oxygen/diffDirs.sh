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
CP=$OXYGEN_HOME/lib/oxygen-basic-utilities.jar:$OXYGEN_HOME/lib/oxygen.jar:$OXYGEN_HOME/lib/oxygenAuthor.jar:$OXYGEN_HOME/lib/oxygenDeveloper.jar:$OXYGEN_HOME/lib/syncroSVNClient.jar:$OXYGEN_HOME/lib/oxygenXMLDiff.jar:$OXYGEN_HOME/classes:$OXYGEN_HOME

#  The two command line parameters are optional and represent the path of the directory 
#  displayed in the left side panel of the XML Diff window and the path of the directory 
#  displayed in the right side panel.

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

# Set environment variables
. "${OXYGEN_HOME}/env.sh"

set -- \
 -Xmx512m\
 -XX:SoftRefLRUPolicyMSPerMB=10\
 -Dcom.oxygenxml.app.descriptor=ro.sync.diff.ui.DiffDirectoriesFrameDescriptor\
 -Djava.net.preferIPv4Stack=true\
 -Dsun.io.useCanonCaches=true\
 -Dsun.io.useCanonPrefixCache=true\
 -cp "$CP"\
 ro.sync.exml.Oxygen\
 "$@"

if [ "$OS" = "Darwin" ]
then
set -- \
 -Xdock:name="Diff Directories"\
 -Xdock:icon="$OXYGEN_HOME/macOS.resources/DiffDirs.icns"\
 "$@"
fi

"${OXYGEN_JAVA}" "$@"