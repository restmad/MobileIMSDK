#!/bin/sh

sudo $JAVA_HOME/bin/java -cp lib/gson-2.7.jar:lib/log4j-1.2.17.jar:lib/slf4j-api-1.7.21.jar:lib/slf4j-log4j12-1.7.21.jar:lib/MobileIMSDKServerX_netty.jar:lib/rabbitmq-client.jar:$JAVA_HOME/lib/tools.jar:classes/.:lib/netty-all-4.1.17.Final.jar: net.openmob.mobileimsdk.server.demo.ServerLauncherImpl %1