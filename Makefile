##############
# PARAMETERS # 
##############
# target directory where all will be installed...
WEB_ROOT:=~/public_html/public/nikuda
# user to be used to access the application
WEB_USER:=$(shell cat ~/.nikudarc | grep WEB_USER= | cut -d = -f 2)
# password (generated using makepasswd)
WEB_PASSWORD:=$(shell cat ~/.nikudarc | grep WEB_PASSWORD= | cut -d = -f 2)
# do you want dependency on the makefile itself ?
DO_MAKEDEPS:=1
# do you want to see the commands executed ?
DO_MKDBG:=0
# do you want to check the javascript code?
DO_CHECKJS:=1
# do you want to validate html?
DO_CHECKHTML:=1
# do you want to validate css?
DO_CHECKCSS:=1

# tools
TOOL_COMPILER:=~/install/closure/compiler.jar
TOOL_JSMIN:=~/install/jsmin/jsmin
TOOL_JSDOC:=~/install/jsdoc/jsdoc
TOOL_JSL:=~/install/jsl/jsl
TOOL_GJSLINT:=~/install/gjslint/gjslint
TOOL_YUICOMPRESSOR:=yui-compressor
TOOL_JSLINT:=jslint
TOOL_CSS_VALIDATOR:=~/install/css-validator/css-validator.jar

JSCHECK:=jscheck.stamp
HTMLCHECK:=html.stamp
CSSCHECK:=css.stamp

########
# CODE #
########
ALL:=
CLEAN:=

ifeq ($(DO_CHECKJS),1)
ALL:=$(ALL) $(JSCHECK)
CLEAN:=$(CLEAN) $(JSCHECK)
endif # DO_CHECKJS

ifeq ($(DO_CHECKHTML),1)
ALL:=$(ALL) $(HTMLCHECK)
CLEAN:=$(CLEAN) $(HTMLCHECK)
endif # DO_CHECKHTML

ifeq ($(DO_CHECKCSS),1)
ALL:=$(ALL) $(CSSCHECK)
CLEAN:=$(CLEAN) $(CSSCHECK)
endif # DO_CHECKCSS

# silent stuff
ifeq ($(DO_MKDBG),1)
Q:=
# we are not silent in this branch
else # DO_MKDBG
Q:=@
#.SILENT:
endif # DO_MKDBG

# handle dependency on the makefile itself...
ALL_DEP:=
ifeq ($(DO_MAKEDEPS),1)
	ALL_DEP:=$(ALL_DEP) Makefile
endif

SOURCES_JS:=$(shell find js -name "*.js")
SOURCES_HTML:=$(shell find html -name "*.html")
SOURCES_CSS:=$(shell find css -name "*.css")

#########
# RULES #
#########

.PHONY: all
all: $(ALL)

.PHONY: checkjs
checkjs: $(JSCHECK)
	$(info doing [$@])

.PHONY: checkhtml
checkhtml: $(HTMLCHECK)
	$(info doing [$@])

.PHONY: checkcss
checkcss: $(CSSCHECK)
	$(info doing [$@])

$(JSCHECK): $(SOURCES_JS) $(ALL_DEP)
	$(info doing [$@])
	$(Q)$(TOOL_JSL) --conf=support/jsl.conf --quiet --nologo --nosummary --nofilelisting $(SOURCES_JS)
	$(Q)#scripts/wrapper.py $(TOOL_GJSLINT) --flagfile support/gjslint.cfg $(SOURCES_JS)
	$(Q)#jslint $(SOURCES_JS)
	$(Q)mkdir -p $(dir $@)
	$(Q)touch $(JSCHECK)

$(HTMLCHECK): $(SOURCES_HTML) $(ALL_DEP)
	$(info doing [$@])
	$(Q)tidy -errors -q -utf8 $(SOURCES_HTML) 
	$(Q)mkdir -p $(dir $@)
	$(Q)touch $(HTMLCHECK)

$(CSSCHECK): $(SOURCES_CSS) $(ALL_DEP)
	$(info doing [$@])
	$(Q)scripts/css-validator-wrapper.py java -jar $(TOOL_CSS_VALIDATOR) --vextwarning=true --output=text $(addprefix file:,$(SOURCES_CSS))
	$(Q)mkdir -p $(dir $@)
	$(Q)touch $(CSSCHECK)

.PHONY: install
install: all
	$(info doing [$@])
	$(Q)rm -rf $(WEB_ROOT)
	$(Q)mkdir $(WEB_ROOT)
	$(Q)cp -r css js js_tp images php html/index.html $(WEB_ROOT)
	$(Q)cp php/config_local.php $(WEB_ROOT)/php/config.php

.PHONY: importdb_local
importdb_local:
	$(info doing [$@])

.PHONY: clean
clean:
	$(info doing [$@])
	$(Q)git clean -fxd > /dev/null

.PHONY: clean_manual
clean_manual:
	$(info doing [$@])
	$(Q)-rm -f $(CLEAN)

.PHONY: debug
debug:
	$(info ALL is $(ALL))
	$(info CLEAN is $(CLEAN))
	$(info WEB_ROOT is $(WEB_ROOT))
	$(info WEB_USER is $(WEB_USER))
	$(info WEB_PASSWORD is $(WEB_PASSWORD))
	$(info SOURCES_JS is $(SOURCES_JS))
	$(info SOURCES_HTML is $(SOURCES_HTML))
	$(info SOURCES_CSS is $(SOURCES_CSS))
