all:	clean bib pdf publish

pdf: 
	latex tutorial.tex
	latex tutorial.tex
	#dvipdfm tutorial.dvi
	dvips -o tutorial.ps -Ppdf -G0 -t a4 tutorial.dvi
	ps2pdf -sPAPERSIZE=a4 -dPDFSETTINGS=/prepress -dEmbedAllFonts=true tutorial.ps
	evince tutorial.pdf &

publish:
	cp tutorial.pdf /media/USB20FD/upf2012/webs/s3web/papers/
	s3cmd put --acl-public tutorial.pdf s3://www.jaumebarcelo.info/papers/


bib:	
	latex tutorial.tex
	bibtex tutorial
	latex tutorial.tex
					
clean:
	rm -f tutorial.aux tutorial.log tutorial.blg tutorial.bbl tutorial.out tutorial.dvi tutorial.ps tutorial.pdf diff*

differences:
	cp tutorial.tex new.tex
	#git show HEAD~10:tutorial.tex>old.tex
	latexdiff old.tex new.tex > tutorial_diff.tex
	latex tutorial_diff.tex
	latex tutorial_diff.tex
	bibtex tutorial_diff
	latex tutorial_diff.tex
	latex tutorial_diff.tex
	dvips -o tutorial_diff.ps -Ppdf -G0 -t a4 tutorial_diff.dvi
	ps2pdf -sPAPERSIZE=a4 -dPDFSETTINGS=/prepress -dEmbedAllFonts=true tutorial_diff.ps
	evince tutorial_diff.pdf &
	cp tutorial_diff.pdf /media/USB20FD/upf2012/webs/s3web/papers/
	s3cmd put --acl-public tutorial_diff.pdf s3://www.jaumebarcelo.info/papers/

