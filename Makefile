compile: main.typ
	typst compile main.typ

watch: resume.typ
	typst watch main.typ

clean: 
	rm resume.pdf
