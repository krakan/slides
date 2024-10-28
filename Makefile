parts = $(basename  $(wildcard *.rst))

pdfs = $(addsuffix .pdf,$(parts))
print = $(addsuffix -print.pdf,$(parts))

html = $(addsuffix .html,$(parts)) index.html tdbi-2019.html

all: $(html)
handout: $(print)

%.pdf: %.html
	./s52pdf.sh $<

index.html: index.sh *.rst
	./$< > $@

%.html: %.rst
	LC_ALL=sv_SE.UTF-8 rst2s5 --link-stylesheet --stylesheet=b3z.css,$(basename $@).css --smart-quotes=yes --current-slide $< $@

%-print.pdf: %.pdf
	./twoup.sh $?

publish: $(html)
	./index.sh > index.html
	find $(html) $(pdfs) index.html b3.css b3z.css b3init.css init.css devopsdayssth-2020-10-12.css ui styles img try-chef \
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
