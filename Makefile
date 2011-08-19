#
# Makefile for Rasqal query tests
#
# See README.md for details
#
# Requires: 'roqet' and 'rapper' in PATH variable in environment
#

top_srcdir=.
top_builddir=.

abs_top_srcdir=$(shell cd $(top_srcdir); pwd)
abs_top_builddir=$(shell cd $(top_builddir); pwd)

# URIs
TESTS_BASE_URI=http://www.w3.org/2009/sparql/docs/tests/data-sparql11/
RDF_NS_URI=http://www.w3.org/1999/02/22-rdf-syntax-ns#

# GIT areas
SPARQL11_GIT_URL=git://github.com/dajobe/sparql11-tests.git

# relative directories
SPARQL11_TESTS_DIR=sparql11
SPARQL11_TESTS_SUBDIR=data-sparql11

LOGS_DIR=logs
RESULTS_DIR=results
SCRIPTS_DIR=scripts
QUERIES_DIR=queries
TMP_DIR=tmp

CLEAN_DIRS=$(LOGS_DIR) $(RESULTS_DIR) $(TMP_DIR)

TESTS_DIRS=$(SPARQL11_TESTS_DIR)

# programs
ECHO=echo
GIT=git
GREP=grep
MKDIR=mkdir
MKDIR_P=$(MKDIR) -p
PERL=perl
PYTHON=python
SED=sed
TEE=tee
WC=wc
SORT=sort

# scripts here
CHECK_SPARQL_SCRIPT="$(abs_top_srcdir)/$(SCRIPTS_DIR)/check-sparql"
CHECK_SPARQL=$(PERL) $(CHECK_SPARQL_SCRIPT)

# FILTER_CHECK_SPARQL=$(PERL) -n -e '$$end=1 if /FAILED tests/; print if /^check-sparql/ or $$end;'
FILTER_CHECK_SPARQL=$(GREP) '^check-sparql'
FILTER_RESULT_URI=$(SED) -e 's/^.*uri<\([^>]*\)>.*/\1/'
# queries
GET_EARL_FAILURES_QUERY=get-earl-failures.rq
GET_EARL_PASSES_QUERY=get-earl-passes.rq

# librdf programs
RAPPER=rapper
ROQET=roqet

# librdf library (utility) versions
RASQAL_VERSION=$(shell $(ROQET) -v 2>/dev/null)
RAPTOR_VERSION=$(shell $(RAPPER) -v 2>/dev/null)


.PHONY: all \
check check-sparql11 \
clean \
make-dirs \
raptor-rasqal-installed reallyclean \
update update-sparql11


all: raptor-rasqal-installed
	@$(ECHO) "Try running: $(MAKE) check"

raptor-rasqal-installed:
	@failed=0; \
	if test "$(RAPTOR_VERSION)X" = "X"; then \
	  $(ECHO) "No rapper version found - get, configure and install Raptor first"; \
	  $(ECHO) "Get Raptor from http://librdf.org/raptor/"; \
	  failed=1; \
	fi; \
	if test "$(RASQAL_VERSION)X" = "X"; then \
	  $(ECHO) "No roqet version found - get, configure and install Rasqal first"; \
	  $(ECHO) "Get Rasqal from http://librdf.org/rasqal/"; \
	  failed=1; \
	fi; \
	exit $$failed

check: make-dirs raptor-rasqal-installed
	@$(ECHO) "Testing with Rasqal $(RASQAL_VERSION) and Raptor $(RAPTOR_VERSION)"
	$(MAKE) check-sparql11

clean-logs: make-dirs
	@find $(LOGS_DIR)/ -type f -print | xargs rm -f

clean-results: make-dirs
	@find $(RESULTS_DIR)/ -type f -print | xargs rm -f

check-sparql11: make-dirs clean-logs
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
	subdirs=`ls -1 */manifest.ttl | $(SED) -e 's,/manifest.ttl$$,,'`; \
	subdirs_count=`echo $$subdirs | $(WC) -w`; \
	$(ECHO) "Found $$subdirs_count subdirs with manifests"; \
	log_dir="$(abs_top_srcdir)/$(LOGS_DIR)"; \
	tmp_dir="$(abs_top_builddir)/$(TMP_DIR)"; \
	pass_urls_file="$$log_dir/pass-urls.lst"; \
	failure_urls_file="$$log_dir/failure-urls.lst"; \
	for name in $$subdirs; do \
	  subdir="$$dir/$$name"; \
	  $(ECHO) "Checking in $$subdir"; \
	  cd $$here; \
	  cd $$subdir; \
	  base_file=`echo $$subdir | $(SED) -e 's,/,-,g'`; \
	  abs_log_file="$$log_dir/$$base_file.log"; \
	  abs_earl_file="$$log_dir/$$base_file-earl.ttl"; \
	  rm -f $$abs_log_file $$abs_earl_file; \
          $(ECHO) "cd $$subdir; RAPPER=$(RAPPER) ROQET=$(ROQET) $(CHECK_SPARQL) -i $$language"; \
	  RAPPER=$(RAPPER) ROQET=$(ROQET) \
	    $(CHECK_SPARQL) -i $$language --earl $$abs_earl_file 2>&1 | \
              $(TEE) $$abs_log_file | $(FILTER_CHECK_SPARQL); \
          status=$$?; \
          $(ECHO) "Test returned status $$status"; \
	  if test -r $$abs_earl_file; then \
	    query_file="$(abs_top_srcdir)/$(QUERIES_DIR)/$(GET_EARL_FAILURES_QUERY)"; \
	    $(ROQET) -i sparql -D $$abs_earl_file $$query_file 2>/dev/null | $(FILTER_RESULT_URI) >> $$failure_urls_file; \
	    query_file="$(abs_top_srcdir)/$(QUERIES_DIR)/$(GET_EARL_PASSES_QUERY)"; \
	    $(ROQET) -i sparql -D $$abs_earl_file $$query_file 2>/dev/null | $(FILTER_RESULT_URI) >> $$pass_urls_file; \
	  fi; \
	done; \
	tmp_file="$$tmp_dir/sort.tmp"; \
	$(SORT) -u $$pass_urls_file > $$tmp_file; mv $$tmp_file $$pass_urls_file; \
	$(SORT) -u $$failure_urls_file > $$tmp_file; mv $$tmp_file $$failure_urls_file; \
	count=`$(WC) -l < $$pass_urls_file`; \
	$(ECHO) "Total Passes:   $$count"; \
	count=`$(WC) -l < $$failure_urls_file`; \
	$(ECHO) "total Failures: $$count"; \
	exit $$failed

make-dirs:
	$(MKDIR_P) $(CLEAN_DIRS)

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

$(RESULTS_DIR)/manifests.ttl:
	@manifests=`find $(SPARQL11_TESTS_DIR) -name manifest.ttl -print`; \
	tmp_nt=$(TMP_DIR)/tmp.nt; \
	for manifest in $$manifests; do \
	  $(ECHO) "Converting manifest in $$manifest"; \
	  $(RAPPER) -q -i turtle -o ntriples $$manifest $(TESTS_BASE_URI)/$$manifest >> $$tmp_nt; \
	done; \
	$(ECHO) "Converting manifests to turtle"; \
	$(RAPPER) -q -i ntriples -o turtle -f 'xmlns:rdf="$(RDF_NS_URI)"' $$tmp_nt  > $(RESULTS_DIR)/manifests.ttl; \
	rm -f $$tmp_nt; \
	$(ECHO) "Converting manifests to rdf/xml"; \
	$(RAPPER) -q -i turtle -o rdfxml-abbrev $(RESULTS_DIR)/manifests.ttl > $(RESULTS_DIR)/manifests.rdf

$(RESULTS_DIR)/earl.rdf: $(RESULTS_DIR)/manifests.ttl
	@cat $(LOGS_DIR)/*-earl.ttl $(RESULTS_DIR)/manifests.ttl > $(RESULTS_DIR)/earl.ttl; \
	cd $(RESULTS_DIR); \
	$(RAPPER) -i turtle -o rdfxml-abbrev earl.ttl > earl.rdf; \
	$(RAPPER) -i rdfxml -o turtle earl.rdf > earl.ttl

earl: $(SCRIPTS_DIR)/earlsum.py $(RESULTS_DIR)/earl.rdf
	$(PYTHON) $(SCRIPTS_DIR)/earlsum.py $(RESULTS_DIR)/earl.rdf > $(RESULTS_DIR)/earl.html

