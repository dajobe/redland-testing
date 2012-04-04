Rasqal SPARQL 1.0 testing
=========================

Approved tests only.

Passes: 437

Failures: 4

Tested:

* [GIT 23e44c7facfab39914fba28e11ac4a6f8f8b34d8](https://github.com/dajobe/rasqal/commit/23e44c7facfab39914fba28e11ac4a6f8f8b34d8)
* Tue Apr 3 19:50:26 2012 -0700

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
    
reduced: 2
----------
These are `mf:resultCardinality` `mf:LaxCardinality` tests which means
the cardinality should be [1, _n_] when _n_ is what's in the results file

SELECT REDUCED *

     roqet -d debug -i sparql -D reduced-star.ttl reduced-1.rq
	 mf:resultCardinality mf:LaxCardinality see above
	 returns 1 duplicate

SELECT REDUCED ?x with strings

     roqet -d debug -i sparql -D reduced-str.ttl reduced-2.rq
	 mf:resultCardinality mf:LaxCardinality see above
	 returns extras that are not seen as equal due to "" != ""^^xsd:string


