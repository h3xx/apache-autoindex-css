SASSC = sassc
SASSC_ARGS = -t compressed

PNPM = pnpm
PNPM_INSTALL = $(PNPM) install

MAKE_RELEASE = bin/make-release.sh

TARGETS = autoindex.css

autoindex.css: src/autoindex.scss $(wildcard src/*.scss)

$(wildcard src/_bootstrap-*.scss): pnpm

%.css:
	$(SASSC) $(SASSC_ARGS) $< > $@

all: $(TARGETS)

pnpm: angular/pnpm-lock.yaml
	cd angular && $(PNPM_INSTALL)

release: $(TARGETS) VERSION $(MAKE_RELEASE)
	$(MAKE_RELEASE)

VERSION: .git
	git tag | sort -rV | head -1 >$@

clean:
	$(RM) $(TARGETS)
	$(RM) VERSION

.PHONY: all clean \
	pnpm \
	release
