#!/bin/sh
# Oxygen XML Editor Startup script
# (c) 2006 - 2017 Syncro Soft SRL.

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
CP=$OXYGEN_HOME/classes:$OXYGEN_HOME/lib/oxygen-basic-utilities.jar:$OXYGEN_HOME/lib/oxygen.jar:$OXYGEN_HOME

#
# The command line parameters can be:
#
#  1. file paths of local files opened automatically in editor panels at startup
#
#  2. the following sequence to open a file with default schema association
#		
#      -instance pathToXMLFile -schema pathToSchemaFile -schemaType XML_SCHEMA|DTD_SCHEMA|RNG_SCHEMA|RNC_SCHEMA -dtName documentTypeName
#
#     where:
#
#       - pathToXMLFile is the name of a local XML file
#       - pathToSchemaFile is the name of the schema which you want to associate to the XML file
#       - schemaType: the four constants (XML_SCHEMA, DTD_SCHEMA, RNG_SCHEMA, RNC_SCHEMA) are the possible 
#           schema types (W3C XML Schema, DTD, Relax NG schema in full syntax, Relax NG schema 
#           in compact syntax)
#       - dtName: The name of the document type automatically generated for association. 
#
# Set multiple instances to false if you want to have a single running instance of Oxygen when
# repeatedly starting oxygen.sh. In this way you can open files by typing:
#    oxygen.sh File.xml 
# The files will be opened in the first editor instance, will not create other processes.
#

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
 -Xmx1g\
 -XX:-OmitStackTraceInFastThrow\
 -XX:SoftRefLRUPolicyMSPerMB=10\
 -Dcom.oxygenxml.editor.plugins.dir="$OXYGEN_HOME/plugins"\
 -Dcom.oxygenxml.app.descriptor=ro.sync.exml.EditorFrameDescriptor\
 -Djava.net.preferIPv4Stack=true\
 -Dsun.io.useCanonCaches=true\
 -Dsun.io.useCanonPrefixCache=true\
 -cp "$CP"\
 ro.sync.exml.Oxygen\
 "$@"

if [ "$OS" = "Darwin" ]
then
export PATH=$PATH:$OXYGEN_HOME/lib
export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:$OXYGEN_HOME/lib
 
set -- \
 -Xdock:name="Oxygen XML Editor"\
 -Xdock:icon="$OXYGEN_HOME/macOS.resources/Oxygen.icns"\
 "$@"
fi

"${OXYGEN_JAVA}" "$@"