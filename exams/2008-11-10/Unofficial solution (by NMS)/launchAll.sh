#! /bin/sh

CLASSPATH="$CLASSPATH:/usr/share/java/cup.jar"
export CLASSPATH

exec /usr/bin/java Main input.m
