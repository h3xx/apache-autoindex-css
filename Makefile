TARGETS = autoindex.css

autoindex.css: src/autoindex.scss

%.css:
	sassc -t compressed $< > $@

all: $(TARGETS)

clean:
	$(RM) $(TARGETS)

.PHONY: all clean
