SASSC = sassc
SASSC_ARGS = -t compressed

PNPM = pnpm
PNPM_INSTALL = $(PNPM) install

TARGETS = autoindex.css

autoindex.css: src/autoindex.scss $(wildcard src/*.scss)

$(wildcard src/_bootstrap-*.scss): pnpm

%.css:
	$(SASSC) $(SASSC_ARGS) $< > $@

all: $(TARGETS)

pnpm: angular/pnpm-lock.yaml
	cd angular && $(PNPM_INSTALL)

clean:
	$(RM) $(TARGETS)

.PHONY: all clean \
	pnpm
