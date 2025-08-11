compile: main.typ cover_letter.typ
	typst compile main.typ && typst compile cover_letter.typ

resume: main.typ
	typst watch main.typ

cover: cover_letter.typ
	typst watch cover_letter.typ

clean: 
	rm *.pdf
