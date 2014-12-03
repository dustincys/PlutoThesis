DVIPDFMX:=$(shell grep '\\def\\usewhat{dvipdfmx}' main.tex)
PDFLATEX:=$(shell grep '\\def\\usewhat{pdflatex}' main.tex)
DVIPSPDF:=$(shell grep '\\def\\usewhat{dvipspdf}' main.tex)
YAP:=$(shell grep '\\def\\usewhat{yap}' main.tex)
XELATEX :=$(shell grep '\\def\\usewhat{xelatex}'  main.tex)
empty=
all:
ifneq ($(empty),$(XELATEX))
	@echo Making xelatex......
	xelatex main.tex
	xelatex main.tex
	bibtex main
	xelatex main.tex
	@echo Done. Starting the browser......
	acroread main_xelatex.pdf&
endif
ifneq ($(empty),$(DVIPDFMX))
	@echo Making dvipdfmx......
	rm -f main.pdf main.dvi &
	latex main.tex
	env BIBINPUTS=./ BSTINPUTS=./ bibtex main
	latex main.tex
	latex main.tex
	dvipdfmx -p a4 main.dvi
	@echo Done. Starting the browser......
	acroread main.pdf&
endif
ifneq ($(empty),$(PDFLATEX))
	@echo Making pdflatex......
	rm -f main_pdflatex.pdf&
	pdflatex main.tex
	env BIBINPUTS=./ BSTINPUTS=./ bibtex main
	pdflatex main.tex
	pdflatex main.tex
	mv main.pdf main_pdflatex.pdf
	@echo Done. Starting the browser......
	acroread main_pdflatex.pdf&
endif
ifneq ($(empty),$(DVIPSPDF))
	@echo Making dvipspdf......
	rm -f main_dvipspdf.pdf main.dvi main.ps&
	latex main.tex
	env BIBINPUTS=./ BSTINPUTS=./ bibtex main
	latex main.tex
	latex main.tex
	dvips  -G0 -ta4 main.dvi
	ps2pdf main.ps main_dvipspdf.pdf
	@echo Done. Starting the browser......
	acroread main_dvipspdf.pdf&
endif
ifneq ($(empty),$(YAP))
	@echo Making dvi......
	rm -f main.dvi&
	latex main.tex
	env BIBINPUTS=./ BSTINPUTS=./ bibtex main
	latex main.tex
	latex main.tex
	xdvi main.dvi&
endif

clean:
	@echo Cleaning up......
	-find -name '*.aux' -exec rm -f {} \;
	-find -name '*.bak' -exec rm -f {} \;
	-find -name '*.dvi' -exec rm -f {} \;
	-find -name '*~' -exec rm -f {} \;
	-find -name '#*#' -exec rm -f {} \;
	-find -name 'semantic.cache' -exec rm -f {} \;
	-find -name '*.log' -exec rm -f {} \;
	-rm -f *.bbl *.blg *.log *.out *.ps *.thm *.toc *.toe *.lof *.lot 
	-rm -f *.loa *.aen
	-rm -f *.html *.css *.scm *.hlog
	-rm -f _region_.tex
	-rm -f -rf auto
	-rm -f *.fen
	-rm -f *.ten
	-rm -rf ./body/auto
	-rm -rf ./reference/auto
	-rm -rf ./setup/auto
	-rm -rf ./preface/auto
	-rm -rf *.prv
	@echo All done.
