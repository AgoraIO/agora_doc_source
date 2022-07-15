#!/bin/sh
# Generated file, do not edit manually"
echo "NOTE: The startcmd.sh has been deprecated, use the 'dita' command instead."

realpath() {
  case $1 in
    /*) echo "$1" ;;
    *) echo "$PWD/${1#./}" ;;
  esac
}

if [ "${DITA_HOME:+1}" = "1" ] && [ -e "$DITA_HOME" ]; then
  export DITA_DIR="$(realpath "$DITA_HOME")"
else #elif [ "${DITA_HOME:+1}" != "1" ]; then
  export DITA_DIR="$(dirname "$(realpath "$0")")"
fi

if [ -f "$DITA_DIR"/bin/ant ] && [ ! -x "$DITA_DIR"/bin/ant ]; then
  chmod +x "$DITA_DIR"/bin/ant
fi

export ANT_OPTS="-Xmx512m $ANT_OPTS"
export ANT_OPTS="$ANT_OPTS -Djavax.xml.transform.TransformerFactory=net.sf.saxon.TransformerFactoryImpl"
export ANT_HOME="$DITA_DIR"
export PATH="$DITA_DIR"/bin:"$PATH"

NEW_CLASSPATH="$DITA_DIR/lib:$NEW_CLASSPATH"
NEW_CLASSPATH="$DITA_DIR/lib/ant-apache-resolver-1.10.12.jar:$NEW_CLASSPATH"
NEW_CLASSPATH="$DITA_DIR/lib/ant-launcher.jar:$NEW_CLASSPATH"
NEW_CLASSPATH="$DITA_DIR/lib/ant.jar:$NEW_CLASSPATH"
NEW_CLASSPATH="$DITA_DIR/lib/commons-io-2.8.0.jar:$NEW_CLASSPATH"
NEW_CLASSPATH="$DITA_DIR/lib/dost-configuration.jar:$NEW_CLASSPATH"
NEW_CLASSPATH="$DITA_DIR/lib/dost.jar:$NEW_CLASSPATH"
NEW_CLASSPATH="$DITA_DIR/lib/guava-25.1-jre.jar:$NEW_CLASSPATH"
NEW_CLASSPATH="$DITA_DIR/lib/icu4j-70.1.jar:$NEW_CLASSPATH"
NEW_CLASSPATH="$DITA_DIR/lib/isorelax-20030108.jar:$NEW_CLASSPATH"
NEW_CLASSPATH="$DITA_DIR/lib/jackson-annotations-2.13.1.jar:$NEW_CLASSPATH"
NEW_CLASSPATH="$DITA_DIR/lib/jackson-core-2.13.1.jar:$NEW_CLASSPATH"
NEW_CLASSPATH="$DITA_DIR/lib/jackson-databind-2.13.1.jar:$NEW_CLASSPATH"
NEW_CLASSPATH="$DITA_DIR/lib/jackson-dataformat-yaml-2.13.1.jar:$NEW_CLASSPATH"
NEW_CLASSPATH="$DITA_DIR/lib/jing-20181222.jar:$NEW_CLASSPATH"
NEW_CLASSPATH="$DITA_DIR/lib/logback-classic-1.2.10.jar:$NEW_CLASSPATH"
NEW_CLASSPATH="$DITA_DIR/lib/logback-core-1.2.10.jar:$NEW_CLASSPATH"
NEW_CLASSPATH="$DITA_DIR/lib/slf4j-api-1.7.32.jar:$NEW_CLASSPATH"
NEW_CLASSPATH="$DITA_DIR/lib/snakeyaml-1.28.jar:$NEW_CLASSPATH"
NEW_CLASSPATH="$DITA_DIR/lib/xercesImpl-2.12.2.jar:$NEW_CLASSPATH"
NEW_CLASSPATH="$DITA_DIR/lib/xml-apis-1.4.01.jar:$NEW_CLASSPATH"
NEW_CLASSPATH="$DITA_DIR/lib/xml-resolver-1.2.jar:$NEW_CLASSPATH"
NEW_CLASSPATH="$DITA_DIR/plugins/org.dita.pdf2/lib/fo.jar:$NEW_CLASSPATH"
NEW_CLASSPATH="$DITA_DIR/plugins/com.oxygenxml.common/lib/jakarta.xml.bind-api-2.3.3.jar:$NEW_CLASSPATH"
NEW_CLASSPATH="$DITA_DIR/plugins/com.oxygenxml.common/lib/jaxb-impl-2.3.3.jar:$NEW_CLASSPATH"
NEW_CLASSPATH="$DITA_DIR/plugins/com.oxygenxml.common/lib/jakarta.activation-1.2.2.jar:$NEW_CLASSPATH"
NEW_CLASSPATH="$DITA_DIR/plugins/com.oxygenxml.common/lib/ant-contrib-1.0b3.jar:$NEW_CLASSPATH"
NEW_CLASSPATH="$DITA_DIR/plugins/com.oxygenxml.common/lib/oxygen-dita-publishing-ant-extensions.jar:$NEW_CLASSPATH"
NEW_CLASSPATH="$DITA_DIR/plugins/com.oxygenxml.common/lib/oxygen-dita-publishing-xslt-extensions.jar:$NEW_CLASSPATH"
NEW_CLASSPATH="$DITA_DIR/plugins/com.oxygenxml.dost.patches/lib/oxygen-dost-patches.jar:$NEW_CLASSPATH"
NEW_CLASSPATH="$DITA_DIR/plugins/com.oxygenxml.dynamic.resources.converter/lib/*:$NEW_CLASSPATH"
NEW_CLASSPATH="$DITA_DIR/plugins/com.oxygenxml.dynamic.resources.converter/lib/poi/*:$NEW_CLASSPATH"
NEW_CLASSPATH="$DITA_DIR/plugins/com.oxygenxml.highlight/lib/xslthl-2.1.4.jar:$NEW_CLASSPATH"
NEW_CLASSPATH="$DITA_DIR/plugins/com.oxygenxml.highlight/lib/xslthl-saxonhe-extension-function.jar:$NEW_CLASSPATH"
NEW_CLASSPATH="$DITA_DIR/plugins/org.dita.eclipsehelp/lib/eclipsehelp.jar:$NEW_CLASSPATH"
NEW_CLASSPATH="$DITA_DIR/plugins/org.dita.htmlhelp/lib/htmlhelp.jar:$NEW_CLASSPATH"
NEW_CLASSPATH="$DITA_DIR/plugins/org.dita.index/lib/index.jar:$NEW_CLASSPATH"
NEW_CLASSPATH="$DITA_DIR/plugins/org.dita.javahelp/lib/javahelp.jar:$NEW_CLASSPATH"
NEW_CLASSPATH="$DITA_DIR/plugins/org.dita.javahelp/lib/jsearch.jar:$NEW_CLASSPATH"
NEW_CLASSPATH="$DITA_DIR/plugins/org.dita.pdf2.axf/lib/axf.jar:$NEW_CLASSPATH"
NEW_CLASSPATH="$DITA_DIR/plugins/org.dita.pdf2.fop/lib/oxygen-patched-fop-patches.jar:$NEW_CLASSPATH"
NEW_CLASSPATH="$DITA_DIR/plugins/org.dita.pdf2.fop/lib/oxygen-patched-batik-patches.jar:$NEW_CLASSPATH"
NEW_CLASSPATH="$DITA_DIR/plugins/org.dita.pdf2.fop/lib/oxygen-patched-jeuclid-core-patches.jar:$NEW_CLASSPATH"
NEW_CLASSPATH="$DITA_DIR/plugins/org.dita.pdf2.fop/lib/*:$NEW_CLASSPATH"
NEW_CLASSPATH="$DITA_DIR/plugins/org.dita.pdf2.xep/lib/xep.jar:$NEW_CLASSPATH"
NEW_CLASSPATH="$DITA_DIR/plugins/org.lwdita/lib/*:$NEW_CLASSPATH"
if test -n "$CLASSPATH"; then
  export CLASSPATH="$NEW_CLASSPATH":"$CLASSPATH"
else
  export CLASSPATH="$NEW_CLASSPATH"
fi

cd "$DITA_DIR"
"$SHELL"
