SASSC = sassc
SASSC_ARGS = -t compressed

TARGETS = autoindex.css

autoindex.css: src/autoindex.scss $(wildcard src/*.scss)

%.css:
	$(SASSC) $(SASSC_ARGS) $< > $@

all: $(TARGETS)

clean:
	$(RM) $(TARGETS)

.PHONY: all clean
