TARGETS = autoindex.css

autoindex.css: src/autoindex.scss $(wildcard src/*.scss)

%.css:
	sassc -t compressed $< > $@

all: $(TARGETS)

clean:
	$(RM) $(TARGETS)

.PHONY: all clean
