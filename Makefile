#
# Makefile for Rasqal query tests
#
# See README.md for details
#
# Requires: 'roqet' and 'rapper' in PATH variable in environment
#

top_srcdir=.

abs_top_srcdir=$(shell cd $(top_srcdir); pwd)

# GIT areas
SPARQL11_GIT_URL=git://github.com/dajobe/sparql11-tests.git

# relative directories
SPARQL11_TESTS_DIR=sparql11
SPARQL11_TESTS_SUBDIR=data-sparql11

LOGS_DIR=logs
RESULTS_DIR=results
SCRIPTS_DIR=scripts

CLEAN_DIRS=$(LOGS_DIR) $(RESULTS_DIR)

TESTS_DIRS=$(SPARQL11_TESTS_DIR)

# programs
ECHO=echo
GIT=git
MKDIR=mkdir
MKDIR_P=$(MKDIR) -p
PERL=perl

# scripts here
CHECK_SPARQL_SCRIPT="$(abs_top_srcdir)/$(SCRIPTS_DIR)/check-sparql"
CHECK_SPARQL=$(PERL) $(CHECK_SPARQL_SCRIPT)

# librdf programs
RAPPER=rapper
ROQET=roqet

# librdf library (utility) versions
RASQAL_VERSION=$(shell $(ROQET) -v 2>/dev/null)
RAPTOR_VERSION=$(shell $(RAPPER) -v 2>/dev/null)

all:
	@$(ECHO) "Try running: $(MAKE) check"

raptor-rasqal-installed:
	@failed=0; \
	if test "$(RASQAL_VERSION)X" = "X"; then \
	  $(ECHO) "No roqet version found - get, configure and install Rasqal first"; \
	  failed=1; \
	fi; \
	if test "$(RAPTOR_VERSION)X" = "X"; then \
	  $(ECHO) "No rapper version found - get, configure and install Raptor first"; \
	  failed=1; \
	fi; \
	exit $$failed

check: raptor-rasqal-installed dirs
	@$(ECHO) "Testing with Rasqal $(RASQAL_VERSION) and Raptor $(RAPTOR_VERSION)"
	$(MAKE) check-sparql11

check-sparql11: raptor-rasqal-installed
	@dir="$(SPARQL11_TESTS_DIR)/$(SPARQL11_TESTS_SUBDIR)"; \
	label="SPARQL 1.1"; \
	language="sparql11"; \
	failed=0; \
	if test ! -d $$dir; then \
	  $(ECHO) "$$label tests dir $$dir not found"; \
	  exit 1; \
	fi; \
	here=`pwd`; \
	cd $$dir; \
	subdirs=`ls -1 */manifest.ttl | sed -e 's,/manifest.ttl$$,,'`; \
	$(ECHO) "Found subdirs with manifests: $$subdirs"; \
	for name in $$subdirs; do \
	  subdir="$$dir/$$name"; \
	  $(ECHO) "  $$subdir"; \
	  cd $$here; \
	  cd $$subdir; \
          $(ECHO) $(CHECK_SPARQL) -i $$language; \
	  $(CHECK_SPARQL) -i $$language; \
	done; \
	exit $$failed

dirs:
	$(MKDIR_P) $(RESULTS_DIR) $(LOGS_DIR)

clean:
	rm -rf $(CLEAN_DIRS)

reallyclean: clean
	rm -rf $(TESTS_DIRS)

update: update-sparql11

update-sparql11:
	@dir=$(SPARQL11_TESTS_DIR); \
	url=$(SPARQL11_GIT_URL); \
	label="SPARQL 1.1"; \
	if test ! -d $$dir; then \
	  $(ECHO) "Checking out $$label tests $$url into $$dir"; \
	  $(ECHO) $(GIT) clone $$url; \
	  $(GIT) clone $$url; \
	else \
	  $(ECHO) "Updating $$label tests $$url in $$dir"; \
	  cd $$dir; \
	  $(ECHO) $(GIT) pull; \
	  $(GIT) pull; \
	fi
