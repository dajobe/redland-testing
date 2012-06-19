Rasqal SPARQL 1.1 testing
=========================

Approved tests only.

Passes: 190

Failures: 98

Tested:

* [GIT d66f1587b3fd483ec90dcba62be1e17b5db47302](https://github.com/dajobe/rasqal/commit/d66f1587b3fd483ec90dcba62be1e17b5db47302)
* Sun Jun 17 13:20:51 2012 -0700

Against SPARQL 1.1 tests:

* [GIT 2cf8d5bf585db1acb6b491006ec12b7cef61c581](https://github.com/dajobe/sparql11-tests/commit/2cf8d5bf585db1acb6b491006ec12b7cef61c581)
* Updated Mon Jun 18 16:11:05 2012 -0700


aggregates: 3
-------------

aggregates/manifest#agg-groupconcat-02
    ???? variable scope???

    check-sparql: 'GROUP_CONCAT 2' FAILED (exited with status 1)
    ...
    roqet -d debug -W 0 -i sparql11 -D agg-groupconcat-1.ttl agg-groupconcat-2.rq
    roqet: Error - URI file:///Users/dajobe/dev/redland/testing/sparql11/data-sparql11/aggregates/agg-groupconcat-2.rq:1 - Variable c was not bound and not used in the query (where is it from?)
    ...

aggregates/manifest#agg-min-02
    Wrong rasqal double canonical format

    check-sparql: 'MIN with GROUP BY' FAILED
    roqet -d debug -W 0 -i sparql11 -D agg-numeric.ttl agg-min-02.rq
    --- result.out	2012-03-24 21:06:14.000000000 -0700
    +++ roqet.out	2012-03-24 21:06:14.000000000 -0700
    -result: [s=uri<http://www.example.org/mixed2>, min=string("2.0E-1"^^<http://www.w3.org/2001/XMLSchema#double>)]
    +result: [s=uri<http://www.example.org/mixed2>, min=string("2E-1"^^<http://www.w3.org/2001/XMLSchema#double>)]

aggregates/manifest#agg08b
    ????

    check-sparql: 'COUNT 8b' FAILED (Expected 5 results, got 1)
    roqet -d debug -W 0 -i sparql11 -D agg08.ttl agg08b.rq
    Difference is:
    --- result.out	2012-03-24 21:06:10.000000000 -0700
    +++ roqet.out	2012-03-24 21:06:10.000000000 -0700
    @@ -1,5 +1 @@
    -result: [O12=string("0"^^<http://www.w3.org/2001/XMLSchema#integer>), C=string("1"^^<http://www.w3.org/2001/XMLSchema#integer>)]
    -result: [O12=string("1"^^<http://www.w3.org/2001/XMLSchema#integer>), C=string("2"^^<http://www.w3.org/2001/XMLSchema#integer>)]
    -result: [O12=string("2"^^<http://www.w3.org/2001/XMLSchema#integer>), C=string("3"^^<http://www.w3.org/2001/XMLSchema#integer>)]
    -result: [O12=string("3"^^<http://www.w3.org/2001/XMLSchema#integer>), C=string("2"^^<http://www.w3.org/2001/XMLSchema#integer>)]
    -result: [O12=string("4"^^<http://www.w3.org/2001/XMLSchema#integer>), C=string("1"^^<http://www.w3.org/2001/XMLSchema#integer>)]
    +result: [O12=string("4"^^<http://www.w3.org/2001/XMLSchema#integer>), C=string("9"^^<http://www.w3.org/2001/XMLSchema#integer>)]


bind: 1
-------

bind/manifest#bind07
    ????

    check-sparql: 'bind07 - BIND' FAILED
    roqet -d debug -W 0 -i sparql11 -D data.ttl bind07.rq
    -result: [s=uri<http://example.org/s1>, p=uri<http://example.org/p>, o=string("1"^^<http://www.w3.org/2001/XMLSchema#integer>)]
    -result: [s=uri<http://example.org/s1>, p=uri<http://example.org/p>, o=string("1"^^<http://www.w3.org/2001/XMLSchema#integer>)]
    -result: [s=uri<http://example.org/s2>, p=uri<http://example.org/p>, o=string("2"^^<http://www.w3.org/2001/XMLSchema#integer>)]
    -result: [s=uri<http://example.org/s2>, p=uri<http://example.org/p>, o=string("2"^^<http://www.w3.org/2001/XMLSchema#integer>)]
    -result: [s=uri<http://example.org/s3>, p=uri<http://example.org/p>, o=string("3"^^<http://www.w3.org/2001/XMLSchema#integer>)]
    -result: [s=uri<http://example.org/s3>, p=uri<http://example.org/p>, o=string("3"^^<http://www.w3.org/2001/XMLSchema#integer>)]
    -result: [s=uri<http://example.org/s4>, p=uri<http://example.org/p>, o=string("4"^^<http://www.w3.org/2001/XMLSchema#integer>)]
    -result: [s=uri<http://example.org/s4>, p=uri<http://example.org/p>, o=string("4"^^<http://www.w3.org/2001/XMLSchema#integer>)]
    +result: [s=uri<http://example.org/s1>, p=uri<http://example.org/p>, o=string("1"^^<http://www.w3.org/2001/XMLSchema#integer>), z=string("2"^^<http://www.w3.org/2001/XMLSchema#integer>)]
    +result: [s=uri<http://example.org/s1>, p=uri<http://example.org/p>, o=string("1"^^<http://www.w3.org/2001/XMLSchema#integer>), z=string("3"^^<http://www.w3.org/2001/XMLSchema#integer>)]
    +result: [s=uri<http://example.org/s2>, p=uri<http://example.org/p>, o=string("2"^^<http://www.w3.org/2001/XMLSchema#integer>), z=string("3"^^<http://www.w3.org/2001/XMLSchema#integer>)]
    +result: [s=uri<http://example.org/s2>, p=uri<http://example.org/p>, o=string("2"^^<http://www.w3.org/2001/XMLSchema#integer>), z=string("4"^^<http://www.w3.org/2001/XMLSchema#integer>)]
    +result: [s=uri<http://example.org/s3>, p=uri<http://example.org/p>, o=string("3"^^<http://www.w3.org/2001/XMLSchema#integer>), z=string("4"^^<http://www.w3.org/2001/XMLSchema#integer>)]
    +result: [s=uri<http://example.org/s3>, p=uri<http://example.org/p>, o=string("3"^^<http://www.w3.org/2001/XMLSchema#integer>), z=string("5"^^<http://www.w3.org/2001/XMLSchema#integer>)]
    +result: [s=uri<http://example.org/s4>, p=uri<http://example.org/p>, o=string("4"^^<http://www.w3.org/2001/XMLSchema#integer>), z=string("5"^^<http://www.w3.org/2001/XMLSchema#integer>)]
    +result: [s=uri<http://example.org/s4>, p=uri<http://example.org/p>, o=string("4"^^<http://www.w3.org/2001/XMLSchema#integer>), z=string("6"^^<http://www.w3.org/2001/XMLSchema#integer>)]

bindings: 7
-----------

bindings/manifest#b1
    ????

bindings/manifest#b2
    ????

bindings/manifest#b3
    ????

bindings/manifest#b4
    ????

bindings/manifest#b5
    ????

bindings/manifest#b6
    ????

bindings/manifest#b7
    ????

csv-tsv-res: 4
--------------

csv-tsv-res/manifest#csv01

* plain literal / xsd:string equality issue

csv-tsv-res/manifest#csv02

* plain literal / xsd:string equality issue

csv-tsv-res/manifest#csv03

* more like a syntax comparison but blank nodes are need eliding

csv-tsv-res/manifest#tsv03

* ???? rasqal outputs a double with 'e'

exists: 5
---------

exists/manifest#exists01

* exists syntax not supported

exists/manifest#exists02

* exists syntax not supported

exists/manifest#exists03

* exists syntax not supported

exists/manifest#exists04

* exists syntax not supported

exists/manifest#exists05

* exists syntax not supported

functions: 20
-------------

functions/manifest#ceil01

* decimal format differences

functions/manifest#concat02

* decimal format differences
* test runner: unicode compare

functions/manifest#encode01

* test runner: unicode compare

functions/manifest#floor01

* decimal format differences

functions/manifest#if01

* unicode????

functions/manifest#iri01

* base URIs?

functions/manifest#lcase01

* test runner: unicode compare

functions/manifest#length01

* test runner: unicode compare

functions/manifest#plus-1

* decimal format differences

functions/manifest#plus-2

* decimal format differences

functions/manifest#replace01

* unicode????

functions/manifest#replace03

* capture failure????

functions/manifest#round01

* decimal format differences

functions/manifest#seconds

* decimal format differences

functions/manifest#strdt03

* test runner: unicode compare

functions/manifest#strlang03

* lang and unicode compare

functions/manifest#substring01

* test runner: unicode compare

functions/manifest#substring02

* test runner: unicode compare

functions/manifest#timezone

* ???? duration negation

functions/manifest#ucase01

* test runner: unicode compare

grouping: 1
-----------

Group-4

* check-sparql: 'Group-4' FAILED (Expected 2 results, got 1)


json-res: 4
-----------

json-res/manifest#jsonres01
json-res/manifest#jsonres02
json-res/manifest#jsonres03
json-res/manifest#jsonres04

* cannot read JSON results


negation 9
----------

Subsets by exclusion (NOT EXISTS)

Subsets by exclusion (MINUS)

Medical, temporal proximity by exclusion (NOT EXISTS)

Calculate which sets are subsets of others (include A subsetOf A)

Calculate which sets are subsets of others (exclude A subsetOf A)

Calculate which sets have the same elements

Calculate proper subset

Positive EXISTS 1

Positive EXISTS 2


property-path: 24
-----------------

property-path/manifest#pp01
property-path/manifest#pp02
property-path/manifest#pp03
property-path/manifest#pp06
property-path/manifest#pp07
property-path/manifest#pp08
property-path/manifest#pp09
property-path/manifest#pp10
property-path/manifest#pp11
property-path/manifest#pp12
property-path/manifest#pp14
property-path/manifest#pp16
property-path/manifest#pp21
property-path/manifest#pp23
property-path/manifest#pp25
property-path/manifest#pp28
property-path/manifest#pp30
property-path/manifest#pp31
property-path/manifest#pp32
property-path/manifest#pp33
property-path/manifest#pp34
property-path/manifest#pp35
property-path/manifest#pp36
property-path/manifest#pp37

* not implementing

subquery: 2
-----------

subquery/manifest#subquery02
    ????

subquery/manifest#subquery10
    EXISTS not implemented

syntax-query: 10
----------------

syntax-query/manifest#test_24
syntax-query/manifest#test_25
syntax-query/manifest#test_26
syntax-query/manifest#test_27
syntax-query/manifest#test_28
syntax-query/manifest#test_29

* EXISTS failures

syntax-query/manifest#test_32

*  PrefixName with hex-encoded colons

syntax-query/manifest#test_35
syntax-query/manifest#test_36
syntax-query/manifest#test_37

* BINDINGS failures

syntax-update-1: 8
------------------

syntax-update-1/manifest#test_25
syntax-update-1/manifest#test_27
syntax-update-1/manifest#test_28
syntax-update-1/manifest#test_31
syntax-update-1/manifest#test_32
syntax-update-1/manifest#test_38
syntax-update-1/manifest#test_39
syntax-update-1/manifest#test_40

* ???? GRAPH in insert/delete data syntax.
* ???? empty INSERT DATA {} syntax
* ???? empty query syntax


Failure URLs
------------

	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/aggregates/manifest#agg-groupconcat-02
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/aggregates/manifest#agg-min-02
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/aggregates/manifest#agg08b
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/bind/manifest#bind07
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/bindings/manifest#b1
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/bindings/manifest#b2
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/bindings/manifest#b3
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/bindings/manifest#b4
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/bindings/manifest#b5
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/bindings/manifest#b6
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/bindings/manifest#b7
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/csv-tsv-res/manifest#csv01
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/csv-tsv-res/manifest#csv02
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/csv-tsv-res/manifest#csv03
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/csv-tsv-res/manifest#tsv03
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/exists/manifest#exists01
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/exists/manifest#exists02
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/exists/manifest#exists03
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/exists/manifest#exists04
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/exists/manifest#exists05
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/functions/manifest#ceil01
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/functions/manifest#concat02
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/functions/manifest#encode01
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/functions/manifest#floor01
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/functions/manifest#if01
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/functions/manifest#iri01
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/functions/manifest#lcase01
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/functions/manifest#length01
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/functions/manifest#plus-1
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/functions/manifest#plus-2
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/functions/manifest#replace01
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/functions/manifest#replace03
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/functions/manifest#round01
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/functions/manifest#seconds
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/functions/manifest#strdt03
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/functions/manifest#strlang03
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/functions/manifest#substring01
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/functions/manifest#substring02
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/functions/manifest#timezone
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/functions/manifest#ucase01
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/grouping/manifest#group04
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/json-res/manifest#jsonres01
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/json-res/manifest#jsonres02
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/json-res/manifest#jsonres03
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/json-res/manifest#jsonres04
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/negation/manifest#exists-01
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/negation/manifest#exists-02
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/negation/manifest#set-equals-1
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/negation/manifest#subset-01
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/negation/manifest#subset-02
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/negation/manifest#subset-03
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/negation/manifest#subset-by-exclusion-minus-1
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/negation/manifest#subset-by-exclusion-nex-1
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/negation/manifest#temporal-proximity-by-exclusion-nex-1
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/property-path/manifest#pp01
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/property-path/manifest#pp02
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/property-path/manifest#pp03
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/property-path/manifest#pp06
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/property-path/manifest#pp07
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/property-path/manifest#pp08
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/property-path/manifest#pp09
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/property-path/manifest#pp10
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/property-path/manifest#pp11
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/property-path/manifest#pp12
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/property-path/manifest#pp14
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/property-path/manifest#pp16
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/property-path/manifest#pp21
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/property-path/manifest#pp23
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/property-path/manifest#pp25
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/property-path/manifest#pp28
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/property-path/manifest#pp30
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/property-path/manifest#pp31
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/property-path/manifest#pp32
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/property-path/manifest#pp33
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/property-path/manifest#pp34
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/property-path/manifest#pp35
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/property-path/manifest#pp36
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/property-path/manifest#pp37
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/subquery/manifest#subquery02
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/subquery/manifest#subquery10
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/syntax-query/manifest#test_24
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/syntax-query/manifest#test_25
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/syntax-query/manifest#test_26
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/syntax-query/manifest#test_27
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/syntax-query/manifest#test_28
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/syntax-query/manifest#test_29
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/syntax-query/manifest#test_35
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/syntax-query/manifest#test_36
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/syntax-query/manifest#test_37
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/syntax-query/manifest#test_53
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/syntax-update-1/manifest#test_25
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/syntax-update-1/manifest#test_27
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/syntax-update-1/manifest#test_28
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/syntax-update-1/manifest#test_31
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/syntax-update-1/manifest#test_32
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/syntax-update-1/manifest#test_38
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/syntax-update-1/manifest#test_39
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/syntax-update-1/manifest#test_40
