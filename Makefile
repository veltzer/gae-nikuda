# include /usr/share/templar/make/Makefile

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
DO_ALL_DEP:=1

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
# what is the stamp file for the tools?
TOOLS:=out/tools.stamp

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
ifeq ($(DO_ALL_DEP),1)
ALL_DEP:=Makefile out/tools.stamp
else
ALL_DEP:=
endif

# all variables between the snapshot of BUILT_IN_VARS and this place in the code
DEFINED_VARS:=$(filter-out $(BUILT_IN_VARS) BUILT_IN_VARS, $(.VARIABLES))
###########
# targets #
###########

all:
	$(info doing [$@])

$(TOOLS): package.json
	$(info doing [$@])
	$(Q)templar install_deps
	$(Q)make_helper touch-mkdir $@

.PHONY: debug_me
debug_me:
	$(info doing [$@])
	$(foreach v, $(DEFINED_VARS), $(info $(v) = $($(v))))

# clean

.PHONY: clean_manual
clean_manual:
	$(info doing [$@])
	$(Q)-rm -f $(CLEAN)

# checks

.PHONY: checkjs
checkjs: $(JSCHECK)
	$(info doing [$@])

.PHONY: checkhtml
checkhtml: $(HTMLCHECK)
	$(info doing [$@])

.PHONY: checkcss
checkcss: $(CSSCHECK)
	$(info doing [$@])

$(JSCHECK): $(SOURCES_JS) $(TOOLS) $(ALL_DEP)
	$(info doing [$@])
	$(Q)$(TOOL_JSL) --conf=support/jsl.conf --quiet --nologo --nosummary --nofilelisting $(SOURCES_JS)
	$(Q)make_helper wrapper-silent $(TOOL_GJSLINT) --flagfile support/gjslint.cfg $(SOURCES_JS)
	$(Q)make_helper touch-mkdir $@

$(HTMLCHECK): $(SOURCES_HTML) $(TOOLS) $(ALL_DEP)
	$(info doing [$@])
	$(Q)make_helper wrapper-silent $(TOOL_HTMLHINT) $(SOURCES_HTML)
	$(Q)make_helper touch-mkdir $@
#$(Q)$(TOOL_TIDY) -errors -q -utf8 $(SOURCES_HTML)

$(CSSCHECK): $(SOURCES_CSS) $(TOOLS) $(ALL_DEP)
	$(info doing [$@])
	$(Q)make_helper wrapper-css-validator java -jar $(TOOL_CSS_VALIDATOR) --profile=css3 --output=text -vextwarning=true --warning=0 $(addprefix file:,$(SOURCES_CSS))
	$(Q)make_helper touch-mkdir $@
