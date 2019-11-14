#!/bin/sh
#Standard doc with no bibliography: one TEX file.

#Set up environment
PREDIR="`pwd`"
TEMDIR="/home/wilson/Documents/.templates"
NRMDOC="templateA.tex"

#Prepare variables for copy
DOCDIR=$PREDIR"/stddoc"
TEMPLATE=$TEMDIR/$NRMDOC

#Ensure directory exists, then copy.
mkdir $DOCDIR
cp $TEMPLATE $DOCDIR
