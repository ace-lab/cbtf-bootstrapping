OUT = cbtf-bootstrapping
TEX = pdflatex
BIBTEX = bibtex
ZIP = zip

SRCS = $(shell find . -name '*.tex') $(OUT).bib

all: $(OUT).pdf

.DELETE_ON_ERROR:
$(OUT).pdf: $(SRCS) $(OUT).bib
	$(TEX) $(OUT)
	$(BIBTEX) $(OUT)
	$(TEX) $(OUT)
	$(TEX) $(OUT)

TAGS: $(SRCS)
	etags $(shell find . -name '*.tex' -o -name '*.bib') 

find_undefined:
	-@$(TEX) $(OUT) | grep -E '(multiply|Reference.*undefined)' 2>&1

clean:
	rm -f ${OUT}.pdf *.bbl *.bcf *.aux *.blg *.log

.PHONY: force
force:
	/bin/rm $(OUT).pdf
	make

$(OUT).zip: $(SRCS) $(OUT).bib Makefile figs/*
	$(ZIP) -r $@ $^
