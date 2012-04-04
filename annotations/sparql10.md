Rasqal SPARQL 1.0 testing
=========================

Approved tests only.

Passes: 439

Failures: 2

Tested:

* [GIT 23e44c7facfab39914fba28e11ac4a6f8f8b34d8](https://github.com/dajobe/rasqal/commit/23e44c7facfab39914fba28e11ac4a6f8f8b34d8)
* Tue Apr  3 20:35:49 PDT 2012

algebra: 2
----------

Filter-nested - 2

     roqet -d debug -i sparql -D data-1.ttl filter-nested-2.rq
	 A nested FILTER fails.  Scope of variable in FILTER?
	 => FILTER should always return FALSE
	 "A FILTER in a group { ... } cannot see variables bound outside that group"

Filter-scope - 1

     roqet -d debug -i sparql -D data-2.ttl filter-scope-1.rq
	 Scope of variable in FILTER - it cannot see variables bound
	 outside a group. => FILTER should always return FALSE
	 "FILTERs in an OPTIONAL do not extend to variables bound outside of the LeftJoin(...) operation" 
