parts = $(basename  $(wildcard *.rst))

pdfs = $(addsuffix .pdf,$(parts))
print = $(addsuffix -print.pdf,$(parts))

html = $(addsuffix .html,$(parts))

all: $(html)
handout: $(print)

%.pdf: %.html
	./s52pdf.sh $<

%.html: %.rst
	LC_ALL=sv_SE.UTF-8 rst2s5 --link-stylesheet --stylesheet=init.css,$(basename $@).css --smart-quotes=yes --current-slide $< $@
	perl -pi -e 's%<div class="layout">%<div class="layout">\n<img id="slant" src="img/slant.png">%' $@
	cp $@ index.html

%-print.pdf: %.pdf
	./twoup.sh $?

publish:
	find $(html) index.html init.css $(pdfs) ui styles img \
	 -type f -newer .publish -size +0 | \
	 while read file; do \
	    aws s3 cp "$$file" s3://jonaseel.se/slides/"$$file"; \
	 done
	touch .publish
