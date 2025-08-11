compile: sample_main.typ sample_cover_letter.typ
	typst compile sample_main.typ && typst compile sample_cover_letter.typ

resume: sample_main.typ
	typst watch sample_main.typ

cover: sample_cover_letter.typ
	typst watch sample_cover_letter.typ

clean: 
	rm *.pdf
