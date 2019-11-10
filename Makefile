parts = $(basename  $(wildcard *.rst))

pdfs = $(addsuffix .pdf,$(parts))
print = $(addsuffix -print.pdf,$(parts))

html = $(addsuffix .html,$(parts))

all: $(html)
handout: $(print)

%.pdf: %.html
	./s52pdf.sh $<

%.html: %.rst
	LC_ALL=sv_SE.UTF-8 rst2s5 --link-stylesheet --stylesheet=b3.css,$(basename $@).css --smart-quotes=yes --current-slide $< $@
	perl -pi -e 's%<div class="layout">%<div class="layout">\n<div id="parc"></div>\n<div id="pcut"></div>\n<div id="yarc"></div>\n<div id="ycut"></div>%' $@
	cp $@ index.html

%-print.pdf: %.pdf
	./twoup.sh $?

publish: $(html)
	find $(html) $(pdfs) index.html b3.css b3init.css init.css ui styles img \
	 -type f -newer .publish -size +0 2>/dev/null | \
	 while read file; do \
	    aws s3 cp "$$file" s3://jonaseel.se/slides/"$$file"; \
	    aws cloudfront create-invalidation --distribution-id E3B54NF1F05380 --path "/slides/$$file" | \
	       jq .Invalidation.InvalidationBatch.Paths.Items[]; \
	    if test $$file = index.html; then \
	       aws cloudfront create-invalidation --distribution-id E3B54NF1F05380 --path "/slides/" | \
	          jq .Invalidation.InvalidationBatch.Paths.Items[]; \
	    fi; \
	 done
	touch .publish
