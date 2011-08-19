#
# Makefile for Rasqal query tests
#
# See README.md for details
#
# Requires: 'roqet' and 'rapper' in PATH variable in environment
#

# GIT areas
SPARQL11_GIT_URL=git://github.com/dajobe/sparql11-tests.git

# directories
SPARQL11_TESTS_DIR=sparql11
RESULTS_DIR=results

TESTS_DIRS=$(SPARQL11_TESTS_DIR)

# programs
ECHO=echo
GIT=git
MKDIR=mkdir
MKDIR_P=$(MKDIR) -p

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


dirs:
	$(MKDIR_P) $(RESULTS_DIR)

clean:
	rm -rf $(RESULTS_DIR)

reallyclean: clean
	rm -rf $(RESULTS_DIR)

update: update-sparql11

update-sparql11:
	@dir=$(SPARQL11_TESTS_DIR); \
	url=$(SPARQL11_GIT_URL); \
	if test ! -d $$dir; then \
	  $(ECHO) "Checking out $$url into $$dir"; \
	  $(ECHO) $(GIT) clone $$url; \
	  $(GIT) clone $$url; \
	else \
	  $(ECHO) "Updating $$url in $$dir"; \
	  cd $$dir; \
	  $(ECHO) $(GIT) pull; \
	  $(GIT) pull; \
	fi
