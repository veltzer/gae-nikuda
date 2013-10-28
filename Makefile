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

# tools
TOOL_COMPILER:=~/install/closure/compiler.jar
TOOL_JSMIN:=~/install/jsmin/jsmin
TOOL_JSDOC:=~/install/jsdoc/jsdoc
TOOL_JSL:=~/install/jsl/jsl
TOOL_GJSLINT:=~/install/gjslint/gjslint
TOOL_YUICOMPRESSOR:=yui-compressor
TOOL_JSLINT:=jslint

JSCHECK:=jscheck.stamp

########
# CODE #
########
ALL:=
CLEAN:=

ifeq ($(DO_CHECKJS),1)
ALL:=$(ALL) $(JSCHECK)
CLEAN:=$(CLEAN) $(JSCHECK)
endif # DO_CHECKJS

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

SOURCES_JS:=$(shell find . -name "*.js")
SOURCES_JS:=$(filter-out ./js/jquery-1.5.min.js, $(SOURCES_JS))

#########
# RULES #
#########

.PHONY: all
all: $(ALL)

.PHONY: checkjs
checkjs: $(JSCHECK)
	$(info doing [$@])

$(JSCHECK): $(SOURCES_JS) $(ALL_DEP)
	$(info doing [$@])
	$(Q)$(TOOL_JSL) --conf=support/jsl.conf --quiet --nologo --nosummary --nofilelisting $(SOURCES_JS)
	$(Q)#scripts/wrapper.py $(TOOL_GJSLINT) --flagfile support/gjslint.cfg $(SOURCES_JS)
	$(Q)#jslint $(SOURCES_JS)
	$(Q)mkdir -p $(dir $@)
	$(Q)touch $(JSCHECK)

.PHONY: install
install: all
	$(info doing [$@])
	$(Q)rm -rf $(WEB_ROOT)
	$(Q)mkdir $(WEB_ROOT)
	$(Q)cp -r css js images php html/index.html $(WEB_ROOT)

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
