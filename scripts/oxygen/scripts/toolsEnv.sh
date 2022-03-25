#!/bin/sh
# Oxygen tools environment script
# (c) 2021 Syncro Soft SRL.

export JDK_JAVA_OPTIONS="--add-opens=java.base/java.lang=ALL-UNNAMED\
 --add-opens=java.base/java.net=ALL-UNNAMED\
 --add-opens=java.base/java.util=ALL-UNNAMED\
 --add-opens=java.base/java.util.regex=ALL-UNNAMED\
 --add-opens=java.base/sun.net.util=ALL-UNNAMED\
 --add-opens=java.base/sun.net.www.protocol.http=ALL-UNNAMED\
 --add-opens=java.base/sun.net.www.protocol.https=ALL-UNNAMED\
 --add-opens=java.desktop/java.awt=ALL-UNNAMED\
 --add-opens=java.desktop/java.awt.dnd=ALL-UNNAMED\
 --add-opens=java.desktop/javax.swing=ALL-UNNAMED\
 --add-opens=java.desktop/javax.swing.text=ALL-UNNAMED\
 --add-opens=java.desktop/javax.swing.plaf.basic=ALL-UNNAMED\
 --add-opens=java.xml/com.sun.org.apache.xerces.internal.xni=ALL-UNNAMED"