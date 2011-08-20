Redland Rasqal query tests
==========================

This GIT repository holds an environment for testing
[Rasqal](http://librdf.org/rasqal/) against the standard query tests,
concentrating on the
[W3C SPARQL Working Group](http://www.w3.org/2009/sparql/wiki/Main_Page)
SPARQL 1.1 tests which is mirrored in a GIT repository at
[SPARQL 1.1 Tests Repository](https://github.com/dajobe/sparql11-tests)


Requirements
------------

The `roqet(1)` and `rapper(1)` utilities from Raptor and Rasqal:

* [Raptor](http://librdf.org/raptor/) V2.0.0 or higher
* [Rasqal](http://librdf.org/rasqal/) V0.9.26

These must be fetched, configured ( `configure --prefix=somewhere` )
and installed ( `make install` )

The `roqet(1)` and `rapper(1)` utilities must be available in a
directory in the `PATH` variable of the environment.

The rules that build the EARL data files require the Redland librdf
`rdfproc(1)` utility which can be found at the [Redland site](http://librdf.org/)


Use
---

The `Makefile` drives the fetching and running of the tests.  The
main rules to use are:

* `make update` to GIT checkout the tests or update them
* `make check` to run the test
* `make earl` to generate EARL summary files (requires `rdfproc(1)` )
