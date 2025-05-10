<null:module $input.module>
<null:module_name $module.format('BLM::Startup::%s')>

<sink:makefile ->
#-*- mode: makefile; -*-


MODULE = BLM::Startup::<var $module_name>

PERL_MODULES = \
    lib/BLM/Startup/<var $module>.pm

VERSION := $(shell perl -I lib -M<var $module_name> -e 'print $$<var $module_name>::VERSION;')

TARBALL = <var $module_name.replace('::', '-', 'g')>-$(VERSION).tar.gz

all: $(TARBALL)

.PHONY: cpan
cpan: $(TARBALL)

$(TARBALL): buildspec.yml $(PERL_MODULES) requires test-requires README.md
	make-cpan-dist.pl -b $<

README.md: lib/BLM/Startup/<var $module>.pm
	pod2markdown $< > $@

requires.json: $(PERL_MODULES)
	find-requires --no-progress create-requires >$@

requires: requires.json
	find-requires -r $< -t text dump-requires > $@

NON_PROJECT_FILES = \
    Makefile.roc \
    00-test.roc \
    test-plugin.roc \
    buildspec.roc \
    create-plugin-project.sh

clean:
	rm -f *.tar.gz
	rm -f $(NON_PROJECT_FILES)

</sink>
<var --flush $makefile>
