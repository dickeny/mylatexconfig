# set file to the name of the main file without the .tex
target	= report
gabbage	= *~ $(target).{out,log,aux,lot,toc}
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
	$(TEX) -no-pdf $(target).tex
	-make clean
	$(DVI) $(target).xdv && rm $(target).xdv

$(target).tar.gz : $(files)
	tar -czvf $(target).tar.gz $(files)

tarball: $(target).tar.gz

show: pdf
	$(VIEWER) $(target).pdf &

clean:
	-rm -f $(gabbage)

test:
	sed 's|^\(.*usepackage.*\)|\1\n\\usepackage{syntonly}\n\\syntaxonly|' \
				$(target).tex > $(tmp).tex
	$(TEX) -no-pdf $(tmp).tex || echo " :: TeX compile failed!!" ;
	@echo " :: Syntax test finish."
	-@rm -f $(tmp).*


