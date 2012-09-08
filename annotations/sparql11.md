Rasqal SPARQL 1.1 testing
=========================

Approved tests only.

Passes: 217

Failures: 128

Tested:

* [GIT 7170af2f02766f07b1f90977ba0bfe14ed2b0fde](https://github.com/dajobe/rasqal/commit/7170af2f02766f07b1f90977ba0bfe14ed2b0fde)
* Sat Sep  8 10:03:23 PDT 2012


Against SPARQL 1.1 tests:

* [GIT f2a12103564e898a6f455fdbd9f8132c7b04c9df](https://github.com/dajobe/sparql11-tests/commit/f2a12103564e898a6f455fdbd9f8132c7b04c9df)
* Updated Sep 8 10:09:47 2012 -0700

Failures by section summary
---------------------------

	aggregates             6
	bindings              10
	bind                   1
	csv-tsv-res            4
	exists                 5
	functions             24
	json-res               4
	negation              11
	property-path         24
	service-description    3
	service                7
	subquery               2
	syntax-query          18
	syntax-update-1        9


aggregates: 6
-------------

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


aggregates/manifest#agg-avg-02
    ????

aggregates/manifest#agg-empty-group
    ????

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

aggregates/manifest#agg-sum-02
    ????

bindings: 10
------------

bindings/manifest#inline1
    ????

bindings/manifest#inline2
    ????

bindings/manifest#values1
    ????

bindings/manifest#values2
    ????

bindings/manifest#values3
    ????

bindings/manifest#values4
    ????

bindings/manifest#values5
    ????

bindings/manifest#values6
    ????

bindings/manifest#values7
    ????

bindings/manifest#values8
    ????

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

functions: 24
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

functions/manifest#strafter01a

* ?

functions/manifest#strafter02

* ?

functions/manifest#strbefore01a

* ?

functions/manifest#strbefore02

* ?

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

json-res: 4
-----------

json-res/manifest#jsonres01
json-res/manifest#jsonres02
json-res/manifest#jsonres03
json-res/manifest#jsonres04

* cannot read JSON results


negation: 11
------------

negation/manifest#exists-01
negation/manifest#set-equals-1
negation/manifest#subset-01
negation/manifest#subset-02
negation/manifest#subset-03
negation/manifest#temporal-proximity-by-exclusion-nex-1

* NOT is not implemented

negation/manifest#exists-02

* EXISTS is not implemented

negation/manifest#full-minuend
negation/manifest#partial-minuend
negation/manifest#subset-by-exclusion-minus-1
negation/manifest#subset-by-exclusion-nex-1

* ????


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
property-path/manifest#pp14
property-path/manifest#pp28
property-path/manifest#pp30
property-path/manifest#pp31
property-path/manifest#pp32
property-path/manifest#pp33
property-path/manifest#pp34
property-path/manifest#pp35

* Property Path: not implementing


service-description: 3
----------------------

service-description/manifest#conforms-to-schema
service-description/manifest#has-endpoint-triple
service-description/manifest#returns-rdf


service: 7
-----------

SERVICE test 1
SERVICE test 2
SERVICE test 3
SERVICE test 4a with VALUES clause
SERVICE test 5
SERVICE test 6
SERVICE test 7

* not implemented


subquery: 2
-----------

subquery/manifest#subquery02
    ????

subquery/manifest#subquery10
    EXISTS not implemented

syntax-query: 18
----------------

syntax-query/manifest#test_24
syntax-query/manifest#test_25
syntax-query/manifest#test_26
syntax-query/manifest#test_27
syntax-query/manifest#test_28
syntax-query/manifest#test_29

* EXISTS failures

syntax-query/manifest#test_35a
syntax-query/manifest#test_36a
syntax-query/manifest#test_38a

* VALUES failures

syntax-query/manifest#test_53
syntax-query/manifest#test_54
syntax-query/manifest#test_pn_04
syntax-query/manifest#test_pn_05
syntax-query/manifest#test_pn_06
syntax-query/manifest#test_pn_07
syntax-query/manifest#test_pn_09
syntax-query/manifest#test_pp_coll

* Prefix name failures such as backslashes, hex, colons

syntax-query/manifest#test_63

* Property Path: not implementing

syntax-update-1: 9
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

syntax-update-1/manifest#test_53

* ????

Failure URLs
------------

	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/aggregates/manifest#agg08b
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/aggregates/manifest#agg-avg-02
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/aggregates/manifest#agg-empty-group
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/aggregates/manifest#agg-groupconcat-02
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/aggregates/manifest#agg-min-02
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/aggregates/manifest#agg-sum-02
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/bindings/manifest#inline1
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/bindings/manifest#inline2
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/bindings/manifest#values1
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/bindings/manifest#values2
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/bindings/manifest#values3
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/bindings/manifest#values4
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/bindings/manifest#values5
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/bindings/manifest#values6
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/bindings/manifest#values7
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/bindings/manifest#values8
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/bind/manifest#bind07
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
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/functions/manifest#strafter01a
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/functions/manifest#strafter02
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/functions/manifest#strbefore01a
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/functions/manifest#strbefore02
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/functions/manifest#strdt03
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/functions/manifest#strlang03
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/functions/manifest#substring01
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/functions/manifest#substring02
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/functions/manifest#timezone
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/functions/manifest#ucase01
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/json-res/manifest#jsonres01
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/json-res/manifest#jsonres02
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/json-res/manifest#jsonres03
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/json-res/manifest#jsonres04
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/negation/manifest#exists-01
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/negation/manifest#exists-02
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/negation/manifest#full-minuend
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/negation/manifest#partial-minuend
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
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/property-path/manifest#pp28a
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/property-path/manifest#pp30
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/property-path/manifest#pp31
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/property-path/manifest#pp32
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/property-path/manifest#pp33
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/property-path/manifest#pp34
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/property-path/manifest#pp35
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/property-path/manifest#pp36
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/property-path/manifest#pp37
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/service-description/manifest#conforms-to-schema
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/service-description/manifest#has-endpoint-triple
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/service-description/manifest#returns-rdf
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/service/manifest#service1
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/service/manifest#service2
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/service/manifest#service3
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/service/manifest#service4a
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/service/manifest#service5
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/service/manifest#service6
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/service/manifest#service7
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/subquery/manifest#subquery02
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/subquery/manifest#subquery10
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/syntax-query/manifest#test_24
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/syntax-query/manifest#test_25
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/syntax-query/manifest#test_26
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/syntax-query/manifest#test_27
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/syntax-query/manifest#test_28
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/syntax-query/manifest#test_29
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/syntax-query/manifest#test_35a
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/syntax-query/manifest#test_36a
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/syntax-query/manifest#test_38a
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/syntax-query/manifest#test_53
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/syntax-query/manifest#test_54
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/syntax-query/manifest#test_63
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/syntax-query/manifest#test_pn_04
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/syntax-query/manifest#test_pn_05
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/syntax-query/manifest#test_pn_06
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/syntax-query/manifest#test_pn_07
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/syntax-query/manifest#test_pn_09
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/syntax-query/manifest#test_pp_coll
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/syntax-update-1/manifest#test_25
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/syntax-update-1/manifest#test_27
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/syntax-update-1/manifest#test_28
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/syntax-update-1/manifest#test_31
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/syntax-update-1/manifest#test_32
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/syntax-update-1/manifest#test_38
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/syntax-update-1/manifest#test_39
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/syntax-update-1/manifest#test_40
	http://www.w3.org/2009/sparql/docs/tests/data-sparql11/syntax-update-1/manifest#test_53
