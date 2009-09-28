# set file to the name of the main file without the .tex
target	= report
gabbage	= $(target).out $(target).log $(target).aux
files	= $(shell ls *.*)
tmp		= $(target).test

VIEWER	= okular
TEX 	= xelatex
DVI		= xdvipdfmx

#===============================================

default: test

all: tarball show

pdf:	
	$(TEX) -no-pdf $(target).tex
	$(TEX) -no-pdf $(target).tex && rm $(gabbage)
	$(DVI) $(target).xdv && rm $(target).xdv

$(target).tar.gz : $(files)
	tar -czvf $(target).tar.gz $(files)

tarball: $(target).tar.gz

show: pdf
	$(VIEWER) $(target).pdf &

clean:
	-@rm *~
	-@rm *.aux *.toc *.log *.out
		
test:
	sed 's|^\(.*usepackage.*\)|\1\n\\usepackage{syntonly}\n\\syntaxonly|' \
				$(target).tex > $(tmp).tex
	$(TEX) -no-pdf $(tmp).tex || echo " :: TeX compile failed!!" ;
	@echo " :: Syntax test finish."
	-@rm $(tmp).*


