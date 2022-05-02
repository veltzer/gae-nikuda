##############
# parameters #
##############
# do you want to see the commands executed ?
DO_MKDBG:=0
# do you want to check the javascript code?
DO_CHECKJS:=1
# do you want to validate html?
DO_CHECKHTML:=1
# do you want to validate css?
DO_CHECKCSS:=0
# do you want dependency on the makefile itself ?
DO_ALLDEP:=1

#########
# tools #
#########
TOOL_COMPILER:=tools/closure-compiler-v20160822.jar
TOOL_JSMIN:=tools/jsmin
TOOL_CSS_VALIDATOR:=tools/css-validator/css-validator.jar
TOOL_JSL:=tools/jsl/jsl
TOOL_JSDOC:=node_modules/jsdoc/jsdoc.js
TOOL_JSLINT:=node_modules/jslint/bin/jslint.js
TOOL_GJSLINT:=/usr/bin/gjslint
TOOL_YUICOMPRESSOR:=/usr/bin/yui-compressor
TOOL_HTMLHINT:=node_modules/htmlhint/bin/htmlhint
TOOL_TIDY=/usr/bin/tidy
TOOL_CSSTIDY=/usr/bin/csstidy

JSCHECK:=out/jscheck.stamp
HTMLCHECK:=out/html.stamp
CSSCHECK:=out/css.stamp

########
# code #
########
CLEAN:=

ifeq ($(DO_CHECKJS),1)
ALL+=$(JSCHECK)
all: $(ALL)
CLEAN+=$(JSCHECK)
endif # DO_CHECKJS

ifeq ($(DO_CHECKHTML),1)
ALL+=$(HTMLCHECK)
all: $(ALL)
CLEAN+=$(HTMLCHECK)
endif # DO_CHECKHTML

ifeq ($(DO_CHECKCSS),1)
ALL+=$(CSSCHECK)
all: $(ALL)
CLEAN+=$(CSSCHECK)
endif # DO_CHECKCSS

# silent stuff
ifeq ($(DO_MKDBG),1)
Q:=
# we are not silent in this branch
else # DO_MKDBG
Q:=@
#.SILENT:
endif # DO_MKDBG

SOURCES_JS:=$(shell find static/js -name "*.js")
SOURCES_HTML:=$(shell find static/html -name "*.html")
SOURCES_CSS:=$(shell find static/css -name "*.css")

# dependency on the makefile itself
ifeq ($(DO_ALLDEP),1)
.EXTRA_PREREQS+=$(foreach mk, ${MAKEFILE_LIST},$(abspath ${mk}))
endif # DO_ALLDEP

# all variables between the snapshot of BUILT_IN_VARS and this place in the code
DEFINED_VARS:=$(filter-out $(BUILT_IN_VARS) BUILT_IN_VARS, $(.VARIABLES))
###########
# targets #
###########
.PHONY: all
all: $(ALL)
	@true

.PHONY: debug
debug:
	$(info doing [$@])
	$(foreach v, $(DEFINED_VARS), $(info $(v) = $($(v))))
.PHONY: clean
clean:
	$(info doing [$@])
	$(Q)-rm -f $(CLEAN)
.PHONY: clean_hard
clean_hard:
	$(info doing [$@])
	$(Q)git clean -qffxd
.PHONY: checkjs
checkjs: $(JSCHECK)
	$(info doing [$@])
.PHONY: checkhtml
checkhtml: $(HTMLCHECK)
	$(info doing [$@])
.PHONY: checkcss
checkcss: $(CSSCHECK)
	$(info doing [$@])
$(JSCHECK): $(SOURCES_JS)
	$(info doing [$@])
	$(Q)pymakehelper touch_mkdir $@
# $(Q)pymakehelper only_print_on_error $(TOOL_GJSLINT) --flagfile support/gjslint.cfg $(SOURCES_JS)
# $(Q)$(TOOL_JSL) --conf=support/jsl.conf --quiet --nologo --nosummary --nofilelisting $(SOURCES_JS)
$(HTMLCHECK): $(SOURCES_HTML)
	$(info doing [$@])
	$(Q)pymakehelper touch_mkdir $@
#$(Q)pymakehelper only_print_on_error $(TOOL_HTMLHINT) $(SOURCES_HTML)
#$(Q)$(TOOL_TIDY) -errors -q -utf8 $(SOURCES_HTML)
$(CSSCHECK): $(SOURCES_CSS)
	$(info doing [$@])
	$(Q)pymakehelper wrapper_css_validator java -jar $(TOOL_CSS_VALIDATOR) --profile=css3 --output=text -vextwarning=true --warning=0 $(addprefix file:,$(SOURCES_CSS))
	$(Q)pymakehelper touch_mkdir $@
