#
# Makefile for Rasqal query SPARQL tests
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
RDF_NS_URI=http://www.w3.org/1999/02/22-rdf-syntax-ns\#
DOAP_NS_URI=http://usefulinc.com/ns/doap\#
MF_NS_URI=http://www.w3.org/2001/sw/DataAccess/tests/test-manifest\#
EARL_NS_URI=http://www.w3.org/ns/earl\#
RDFS_NS_URI=http://www.w3.org/2000/01/rdf-schema\#
DAWGT_NS_URI=http://www.w3.org/2001/sw/DataAccess/tests/test-dawg\#
QT_NS_URI=http://www.w3.org/2001/sw/DataAccess/tests/test-query\#


NS_URI_ARGS=\
  -f 'xmlns:rdf="$(RDF_NS_URI)"' \
  -f 'xmlns:doap="$(DOAP_NS_URI)"' \
  -f 'xmlns:mf="$(MF_NS_URI)"' \
  -f 'xmlns:earl="$(EARL_NS_URI)"' \
  -f 'xmlns:rdfs="$(RDFS_NS_URI)"' \
  -f 'xmlns:dawgt="$(DAWGT_NS_URI)"' \
  -f 'xmlns:qt="$(QT_NS_URI)"'

# URLs
SPARQL10_TESTS_ARCHIVE_URL=http://www.w3.org/2001/sw/DataAccess/tests/data-r2.tar.gz
SPARQL11_GIT_URL=git://github.com/dajobe/sparql11-tests.git

# relative directories
SPARQL11_TESTS_DIR=sparql11
SPARQL11_TESTS_SUBDIR=data-sparql11

SPARQL10_TESTS_DIR=sparql10
SPARQL10_TESTS_SUBDIR=data-r2

LOGS_DIR=logs
RESULTS_DIR=results
SCRIPTS_DIR=scripts
QUERIES_DIR=queries
TMP_DIR=tmp

CLEAN_DIRS=$(LOGS_DIR) $(RESULTS_DIR) $(TMP_DIR)
CLEAN_FILES=README.html

TESTS_DIRS=$(TESTS_DIRS_GIT) $(SPARQL10_TESTS_DIR)
# These are 'reallyclean'ed
TESTS_DIRS_GIT=$(SPARQL11_TESTS_DIR)

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
CURL=curl
TAR=tar

# scripts here
CHECK_SPARQL_SCRIPT="$(abs_top_srcdir)/$(SCRIPTS_DIR)/check-sparql"
CHECK_SPARQL=$(PERL) $(CHECK_SPARQL_SCRIPT)

# FILTER_CHECK_SPARQL=$(PERL) -n -e '$$end=1 if /FAILED tests/; print if /^check-sparql/ or $$end;'
FILTER_CHECK_SPARQL=$(GREP) '^check-sparql'
FILTER_RESULT_URI=$(GREP) -v '^testUri'
# queries
GET_EARL_FAILURES_QUERY=get-earl-failures.rq
GET_EARL_PASSES_QUERY=get-earl-passes.rq

# librdf programs
RAPPER=rapper
ROQET=roqet
RDFPROC=rdfproc

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
	@$(ECHO) "Possibilities"
	@$(ECHO) "  $(MAKE) update - to checkout / update the GIT tests"
	@$(ECHO) "  $(MAKE) check  - to run the tests"
	@$(ECHO) "  $(MAKE) earl   - to generate an EARL report (requires rdfproc, rdflib)"
	@$(ECHO) "There are SPARQL 1.0 / 1.1 versions of the update and check rules"
	@$(ECHO) "  for example: $(MAKE) check-sparql10"

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

check:
	@$(ECHO) "Testing with Rasqal $(RASQAL_VERSION) and Raptor $(RAPTOR_VERSION)"
	$(MAKE) check-sparql11

clean-logs: make-dirs
	@find $(LOGS_DIR)/ -type f -print | xargs rm -f

clean-results: make-dirs
	@find $(RESULTS_DIR)/ -type f -print | xargs rm -f

check-sparql10: make-dirs clean-logs raptor-rasqal-installed
	@$(MAKE) check-dir \
          DIR="$(SPARQL10_TESTS_DIR)/$(SPARQL10_TESTS_SUBDIR)" \
	  LABEL="SPARQL 1.0" \
          LANGUAGE="sparql"

check-sparql11: make-dirs clean-logs raptor-rasqal-installed
	@$(MAKE) check-dir \
          DIR="$(SPARQL11_TESTS_DIR)/$(SPARQL11_TESTS_SUBDIR)" \
	  LABEL="SPARQL 1.1" \
          LANGUAGE="sparql11"

check-dir: make-dirs clean-logs
	@dir="$(DIR)"; \
	label="$(LABEL)"; \
	language="$(LANGUAGE)"; \
	failed=0; \
	if test ! -d $$dir; then \
	  $(ECHO) "$$label tests dir $$dir not found: try $(MAKE) update"; \
	  exit 1; \
	fi; \
	here=`pwd`; \
	cd $$dir; \
	subdirs=`ls -1 */manifest.ttl | $(SED) -e 's,/manifest.ttl$$,,'`; \
	subdirs_count=`echo $$subdirs | $(WC) -w`; \
	$(ECHO) "$$label testing in $$subdirs_count subdirs with manifests"; \
	log_dir="$(abs_top_srcdir)/$(LOGS_DIR)"; \
	tmp_dir="$(abs_top_builddir)/$(TMP_DIR)"; \
	pass_urls_file="$$log_dir/pass-urls.lst"; \
	failure_urls_file="$$log_dir/failure-urls.lst"; \
	for name in $$subdirs; do \
	  subdir="$$dir/$$name"; \
	  $(ECHO) "$$label checking in $$subdir"; \
	  cd $$here; \
	  cd $$subdir; \
	  base_file=`echo $$subdir | $(SED) -e 's,/,-,g'`; \
	  abs_log_file="$$log_dir/$$base_file.log"; \
	  abs_earl_file="$$log_dir/$$base_file-earl.ttl"; \
	  abs_junit_file="$$log_dir/$$base_file-junit.xml"; \
	  rm -f $$abs_log_file $$abs_earl_file; \
	  RAPPER=$(RAPPER) ROQET=$(ROQET) \
	    $(CHECK_SPARQL) -i $$language --approved --earl $$abs_earl_file --junit $$abs_junit_file --suite "$$name" 2>&1 | \
              $(TEE) $$abs_log_file | $(FILTER_CHECK_SPARQL); \
          status=$$?; \
	  if test $$status != 0; then \
            $(ECHO) "check-sparql for $$name returned status $$status"; \
	  fi; \
	  if test -r $$abs_earl_file; then \
	    query_file="$(abs_top_srcdir)/$(QUERIES_DIR)/$(GET_EARL_FAILURES_QUERY)"; \
	    $(ROQET) -i sparql -r csv -D $$abs_earl_file $$query_file 2>/dev/null | $(FILTER_RESULT_URI)  >> $$failure_urls_file; \
	    query_file="$(abs_top_srcdir)/$(QUERIES_DIR)/$(GET_EARL_PASSES_QUERY)"; \
	    $(ROQET) -i sparql -r csv -D $$abs_earl_file $$query_file 2>/dev/null | $(FILTER_RESULT_URI) >> $$pass_urls_file; \
	  fi; \
	  $(ECHO) " "; \
	done; \
	$(ECHO) " "; \
	$(ECHO) "$$label Summary:"; \
	tmp_file="$$tmp_dir/sort.tmp"; \
	$(SORT) -u $$pass_urls_file > $$tmp_file; mv $$tmp_file $$pass_urls_file; \
	$(SORT) -u $$failure_urls_file > $$tmp_file; mv $$tmp_file $$failure_urls_file; \
	count=`$(WC) -l < $$pass_urls_file`; \
	$(ECHO) "$$label   total passes:   $$count"; \
	count=`$(WC) -l < $$failure_urls_file`; \
	$(ECHO) "$$label   total failures: $$count"; \
	exit $$failed

make-dirs:
	$(MKDIR_P) $(CLEAN_DIRS)

clean:
	rm -rf $(CLEAN_DIRS) $(CLEAN_FILES)

reallyclean: clean
	rm -rf $(TESTS_DIRS_GIT)

update: update-sparql10 update-sparql11

update-sparql10: make-dirs
	@dir=$(SPARQL10_TESTS_DIR); \
	url=$(SPARQL10_TESTS_ARCHIVE_URL); \
	label="SPARQL 1.0"; \
	tmp_dir="$(abs_top_builddir)/$(TMP_DIR)"; \
	if test ! -d $$dir; then \
	  $(ECHO) "Fetching $$label tests from $$url into $$dir"; \
          tmp_file="$$tmp_dir/tarball"; \
	  $(CURL) -q -o $$tmp_file $$url; \
	  $(TAR) -x -z -p -f $$tmp_file; \
	  rm -f $$tmp_file; \
	  mv test-suite-archive $(SPARQL10_TESTS_DIR); \
	fi

update-sparql11: make-dirs
	@dir=$(SPARQL11_TESTS_DIR); \
	url=$(SPARQL11_GIT_URL); \
	label="SPARQL 1.1"; \
	if test ! -d $$dir; then \
	  $(ECHO) "Checking out $$label tests $$url into $$dir"; \
	  $(ECHO) $(GIT) clone $$url $$dir; \
	  $(GIT) clone $$url $$dir; \
	else \
	  $(ECHO) "Updating $$label tests $$url in $$dir"; \
	  cd $$dir; \
	  $(ECHO) $(GIT) pull; \
	  $(GIT) pull; \
	fi

$(RESULTS_DIR)/manifests.ttl:
	@manifests=`find $(SPARQL11_TESTS_DIR) -name manifest.ttl -print`; \
	tmp_db=$(TMP_DIR)/tmpdb.rdf; \
	tmp_nt=$(TMP_DIR)/tmpdb.nt; \
	$(ECHO) "Reading manifest files into single DB"; \
	rm -f $$tmp_db; \
	for manifest in $$manifests; do \
          $(RDFPROC) -q -s file $$tmp_db parse $$manifest turtle $(TESTS_BASE_URI)$$manifest; \
	done; \
	$(ECHO) "Generating aggregated manifest in turtle and rdfxml"; \
        $(RDFPROC) -q -s file $$tmp_db serialize ntriples > $$tmp_nt; \
	rm -f $$tmp_db; \
	$(RAPPER) -q -i ntriples -o turtle $(NS_URI_ARGS) $$tmp_nt > $(RESULTS_DIR)/manifests.ttl; \
	rm -f $$tmp_db; \
	$(RAPPER) -q -i turtle -o rdfxml-abbrev $(RESULTS_DIR)/manifests.ttl > $(RESULTS_DIR)/manifests.rdf

$(RESULTS_DIR)/results.ttl:
	@earlttls=`find $(LOGS_DIR) -name \*-earl.ttl -print`; \
	tmp_db=$(TMP_DIR)/tmpdb.rdf; \
	tmp_nt=$(TMP_DIR)/tmpdb.nt; \
	rm -f $$tmp_db; \
	for earlttl in $$earlttls; do \
          $(RDFPROC) -q -s file $$tmp_db parse $$earlttl turtle; \
	done; \
	$(ECHO) "Normalizing aggregated EARL result to turtle and rdfxml"; \
        $(RDFPROC) -q -s file $$tmp_db serialize ntriples > $$tmp_nt; \
	rm -f $$tmp_db; \
	$(RAPPER) -q -i ntriples -o turtle $(NS_URI_ARGS) $$tmp_nt > $(RESULTS_DIR)/results.ttl; \
	rm -f $$tmp_nt; \
	$(RAPPER) -q -i turtle -o rdfxml-abbrev $(RESULTS_DIR)/results.ttl > $(RESULTS_DIR)/results.rdf

$(RESULTS_DIR)/earl.rdf: $(RESULTS_DIR)/manifests.ttl $(RESULTS_DIR)/results.ttl
	@cd $(RESULTS_DIR); \
	cat manifests.ttl results.ttl > earl.ttl; \
	$(ECHO) "Converting EARL KB to turtle and rdfxml"; \
	$(RAPPER) -q -i turtle -o rdfxml-abbrev earl.ttl > earl.rdf; \
	$(RAPPER) -q -i rdfxml -o turtle $(NS_URI_ARGS) earl.rdf > earl.ttl

earl: $(SCRIPTS_DIR)/earlsum.py $(RESULTS_DIR)/earl.rdf
	@log_dir="$(abs_top_srcdir)/$(LOGS_DIR)"; \
	pass_urls_file="$$log_dir/pass-urls.lst"; \
	failure_urls_file="$$log_dir/failure-urls.lst"; \
	$(ECHO) cp $$pass_urls_file $$failure_urls_file $(RESULTS_DIR); \
	cp $$pass_urls_file $$failure_urls_file $(RESULTS_DIR)
	$(PYTHON) $(SCRIPTS_DIR)/earlsum.py $(RESULTS_DIR)/earl.rdf > $(RESULTS_DIR)/earl.html

