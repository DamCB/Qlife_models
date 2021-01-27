
html:
	rm -Rf build_html
	mkdir build_html
	ln -s ~/Presentations/reveal.js build_html
	cp -R images build_html
	pandoc --citeproc \
		   -t revealjs \
           -s main.md \
		   -o build_html/main.html \
           --slide-level 2 \
	       --mathjax

beamer:
	rm -Rf build_pdf
	mkdir build_pdf
	cp main.md build_pdf
	cp tyssue.bib build_pdf
	cp -R images build_pdf
	cd build_pdf
	pandoc --citeproc \
		   -t beamer \
		   --pdf-engine lualatex \
	       --slide-level 2 \
           -s main.md \
		   -o main.pdf

clean:
	rm -Rf build_html
	rm -Rf build_pdf
