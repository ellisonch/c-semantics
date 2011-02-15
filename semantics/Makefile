K_MAUDE_BASE ?= ..
K_COMPILE_BASE = tools/kompile.pl
K-PROGRAM-COMPILE = $(K_MAUDE_BASE)/tools/kcompile-program.sh

K_MAUDE = $(K_MAUDE_BASE)/$(K_COMPILE_BASE)
K_PRELUDE = $(K_MAUDE_BASE)/k-prelude
K-PL-BUILTINS = $(K_MAUDE_BASE)/pl-builtins
K_PL_MODEL_CHECKER = $(K_MAUDE_BASE)/k-model-checker

ADDITIONAL_SYNTAX = "including MATCH-C-SYNTAX ."

PROGRAM_BASE_NAMES = $(foreach var,$(INPUT), $(notdir $(subst .gen.maude,,$(var))))
PROGRAM_NAMES = $(foreach var, $(PROGRAM_BASE_NAMES), program-$(var))
PROGRAM_DIR = ../programs
PROGRAM_TARGET = $(foreach var, $(PROGRAM_BASE_NAMES), program-$(var)-compiled.maude)
PROGRAM_TARGET_NO_MAUDE = $(foreach var, $(PROGRAM_BASE_NAMES), program-$(var)-compiled)
COMPILED_PROGRAM_LOADS = `echo -e "$(foreach var, $(PROGRAM_TARGET_NO_MAUDE), load $(var) .\n)"`


.PHONY: all clean force check-input dynamic match semantics

.SECONDARY:

all: dynamic 

check-input: 
ifeq ($(INPUT),)
	exit 1
endif
	
c-syntax.k: Makefile
	@printf "`cat c-syntax.template`" $(ADDITIONAL_SYNTAX) > c-syntax.k	
	
c.k: c-syntax.k c-maude.template Makefile
	@printf "`cat c-maude.template`" $(K_PRELUDE) $(CONFIGURATION_FILE) $(SEMANTICS_FILE) $(SEMANTICS_MODULE) > c.k
	
c-compiled.maude: c.k $(K_MAUDE_BASE)/k-prelude.maude $(K_MAUDE) \
common-c-syntax.k common-c-configuration.k common-c-semantics.k common-c-standard-lib.k common-c-expressions.k common-c-memory.k common-c-statements.k common-c-conversions.k common-c-typing.k common-c-declarations.k \
match-c-syntax.k match-c-semantics.k match-c-configuration.k \
dynamic-c-semantics.k dynamic-c-configuration.k
	@echo "Compiling the C definition..."
	@$(K_MAUDE) c.k -u -language C
	@echo "Done".
	
c-total.maude: c-compiled.maude $(K_PRELUDE).maude $(K-PL-BUILTINS).maude $(K_PL_MODEL_CHECKER).maude Makefile
#@sed -i '2 i load $(K_PL_MODEL_CHECKER)' c-compiled.maude
#@sed -i'' -e '2i\
#load $(K_PL_MODEL_CHECKER)' c-compiled.maude
#echo adds a newline
	@echo | cat c-compiled.maude c-syntax.maude - common-c-configuration.maude | perl slurp.pl ./ > c-total.maude
	
dynamic-test: dynamic test.maude

match-test: match test.maude

dynamic: SEMANTICS_MODULE = "DYNAMIC-C-SEMANTICS" 
dynamic: SEMANTICS_FILE = "dynamic-c-semantics"
dynamic: CONFIGURATION_FILE = "dynamic-c-configuration"
dynamic: semantics

match: SEMANTICS_MODULE = "MATCH-C-SEMANTICS"
match: SEMANTICS_FILE = "match-c-semantics"
match: CONFIGURATION_FILE = "match-c-configuration"
match: semantics

semantics: c-total.maude

clean:
	rm -f program-*-gen.maude program-*-compiled.maude program-*-compiled.maude.tmp kcompile_* quoted.maude \
	c-syntax.maude c-syntax.k c-compiled.maude c.k c.maude test.maude programs-gen.maude test-benchmark.maude c-total.maude \
	common-c-syntax.maude common-c-configuration.maude common-c-semantics.maude common-c-declarations.maude common-c-expressions.maude common-c-memory.maude common-c-typing.maude common-c-conversions.maude common-c-statements.maude common-c-standard-lib.maude match-c-syntax.maude shared.maude match-c-configuration.maude match-c-semantics.maude \
	dynamic-c-configuration.maude dynamic-c-semantics.maude  

force: ;