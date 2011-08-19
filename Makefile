# GIT areas
SPARQL11_GIT_URL=git://github.com/dajobe/sparql11-tests.git

# directories
SPARQL11_TESTS_DIR=sparql11
RESULTS_DIR=results

TESTS_DIRS=$(SPARQL11_TESTS_DIR)

# commands
ECHO=echo
GIT=git
MKDIR=mkdir
MKDIR_P=$(MKDIR) -p

all:
	@$(ECHO) "Try running: $(MAKE) check"

check: dirs
	@$(ECHO) "Nothing to do yet"

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
