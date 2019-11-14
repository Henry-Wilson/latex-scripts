#!/bin/sh
#This should be run from OUTSIDE the "stddoc" directory.
#Tries not to leave residue, but is not well-tested.
#Ought not to be used around other ENTR scripts!

#Set up environment
PREDIR="`pwd`"
DOCNAME="main"
DOCDIR=$PREDIR"/stddoc"
DOC=$DOCDIR/$DOCNAME
PDFVIEWER="gv --widgetless"

#Check to make sure my standard document structure is set up correctly
#Remove this or edit vars to your liking.
if test -d $DOCDIR; then
	echo "DOCDIR EXISTS"
else
	echo "NO DOCDIR"
	exit
fi
if test -e $DOC'.tex'; then
	echo "DOC EXISTS"
else
	echo "NO DOC"
	exit
fi

#Start ENTR to compile with pdflatex (can bereplaced with xelatex)
sh -c "find $DOC'.tex' | entr -an sh -c 'pdflatex '$DOC " &
sleep 2 #Wait time ensures that PDF is available

#Start pdf viewer
$PDFVIEWER $DOCNAME'.pdf' &&

#clean up
rm $PREDIR/$DOCNAME'.aux'
rm $PREDIR/$DOCNAME'.log'

#Exit Nicely
killall entr #Best not to use this with other ENTR scripts!
sleep 0.1
echo "LATEX PREVIEW EXITED CORRECTLY"
