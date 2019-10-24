#!/bin/sh
#This should be run from OUTSIDE the "stddoc" directory.
#This brings up a text editor, a pdf viewer, and an automated compiler.
#All temp files are handled outside stddoc
#A complete pdf document is left, and no other residue is left.

#Set up environment
PREDIR="`pwd`"
DOCDIR=$PREDIR"/stddoc"
DOC=$DOCDIR/$DOCNAME
#DOCNAME=(something like 'main')


#Check to make sure my standard document structure is set up correctly
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
#entr is required
sh -c "find $DOC'.tex' | entr -an sh -c 'pdflatex '$DOC " &
#Wait time ensures that PDF is available when gv starts
sleep 2


#Start gv (for back of stack)
#Can be replaced with some other pdf viewer.
gv --widgetless $DOCNAME'.pdf' &
sleep 0.2 #This wait time ensures we're at the back of the stack


#Start st and vis
#Can be replaced with some other terminal.
st -e vis $DOC'.tex' #This command holds until we are done (no &)


#clean up
rm $PREDIR/$DOCNAME'.aux'
rm $PREDIR/$DOCNAME'.log'

#Exit Nicely
killall entr
sleep 0.1
echo "SUPEREDIT EXITED SUCCESSFULLY"
