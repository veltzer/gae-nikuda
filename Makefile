##############
# PARAMETERS # 
##############
include ~/.nikudarc

# target directory where all will be installed...
LOCAL_ROOT:=~/public_html/public/nikuda
# do you want dependency on the makefile itself ?
DO_MAKEDEPS:=1
# do you want to see the commands executed ?
DO_MKDBG:=0
# do you want to check the javascript code?
DO_CHECKJS:=0
# do you want to validate html?
DO_CHECKHTML:=1
# do you want to validate css?
DO_CHECKCSS:=0
# what is the database name?
DB_NAME:=nikuda
# what is the local database user name?
DB_USER:=root
# what is the password for the local database ?
DB_PASS:=root

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
	$(Q)rm -rf $(LOCAL_ROOT)
	$(Q)mkdir $(LOCAL_ROOT)
	$(Q)cp -r css js js_tp images php html/index.html $(LOCAL_ROOT)
	$(Q)cp php/config_local.php $(LOCAL_ROOT)/php/config.php

.PHONY: importdb_local
importdb_local:
	$(info doing [$@])
	$(Q)-mysqladmin --user=$(DB_USER) --password=$(DB_PASS) -f drop $(DB_NAME) > /dev/null
	$(Q)mysqladmin --user=$(DB_USER) --password=$(DB_PASS) create $(DB_NAME)
	$(Q)mysql --user=$(DB_USER) --password=$(DB_PASS) $(DB_NAME) < db/nikuda.mysqldump

# notes about deploy:
# we are not allowed to drop the database and create it so we don't
# instead we just load the new data.
# As far as existing table data is concerned this is ok since the mysql
# dump removes the tables and recreates them with the data.
# This is somewhat unclean since db tables which were in the old version
# and are not in the new will remain there and will need to be removed
# by hand...
.PHONY: deploy
deploy:
	$(info doing [$@])
	$(Q)mysql $(REMOTE_DB_NAME) --host=$(REMOTE_DB_HOST) --user=$(REMOTE_DB_USER) --password=$(REMOTE_DB_PASSWORD) < db/nikuda.mysqldump
	$(Q)ncftpput -R -u $(REMOTE_FTP_USER) -p $(REMOTE_FTP_PASSWORD) $(REMOTE_FTP_HOST) $(REMOTE_FTP_DIR) css js js_tp images php html/index.html
.PHONY: deploy_only_code
deploy_only_code:
	$(info doing [$@])
	$(Q)ncftpput -R -u $(REMOTE_FTP_USER) -p $(REMOTE_FTP_PASSWORD) $(REMOTE_FTP_HOST) $(REMOTE_FTP_DIR) css js js_tp images php html/index.html

.PHONY: backup_remote
backup_remote:
	$(info doing [$@])
	$(Q)wget -r ftp://$(REMOTE_FTP_HOST) --ftp-user=$(REMOTE_FTP_USER) --ftp-password=$(REMOTE_FTP_PASSWORD)

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
	$(info LOCAL_ROOT is $(LOCAL_ROOT))
	$(info REMOTE_FTP_USER is $(REMOTE_FTP_USER))
	$(info REMOTE_FTP_PASSWORD is $(REMOTE_FTP_PASSWORD))
	$(info REMOTE_FTP_HOST is $(REMOTE_FTP_HOST))
	$(info REMOTE_FTP_DIR is $(REMOTE_FTP_DIR))
	$(info REMOTE_DB_HOST is $(REMOTE_DB_HOST))
	$(info REMOTE_DB_USER is $(REMOTE_DB_USER))
	$(info REMOTE_DB_PASSWORD is $(REMOTE_DB_PASSWORD))
	$(info REMOTE_DB_NAME is $(REMOTE_DB_NAME))
	$(info REMOTE_DB_HOST is $(REMOTE_DB_HOST))
	$(info REMOTE_DB_USER is $(REMOTE_DB_USER))
	$(info REMOTE_DB_PASSWORD is $(REMOTE_DB_PASSWORD))
	$(info REMOTE_DB_NAME is $(REMOTE_DB_NAME))
	$(info SOURCES_JS is $(SOURCES_JS))
	$(info SOURCES_HTML is $(SOURCES_HTML))
	$(info SOURCES_CSS is $(SOURCES_CSS))
	$(info DB_NAME is $(DB_NAME))
	$(info DB_USER is $(DB_USER))
	$(info DB_PASS is $(DB_PASS))
