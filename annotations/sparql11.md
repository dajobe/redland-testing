Rasqal SPARQL 1.1 testing
=========================

Approved tests only.

Passes: 155

Failures: 86

Tested:

* [GIT e932f0ea8bbbc9819d572f7fa2e8c71877c32037](https://github.com/dajobe/rasqal/commit/e932f0ea8bbbc9819d572f7fa2e8c71877c32037)
* Tue Mar 27 21:19:19 PDT 2012

aggregates: 4
-------------

aggregates/manifest#agg-err-02
    Wrong expected result canonical format

    check-sparql: 'Protect from error in AVG' FAILED
    roqet -d debug -W 0 -i sparql11 -D agg-err-02.ttl agg-err-02.rq
    --- result.out	2012-03-24 21:06:15.000000000 -0700
    +++ roqet.out	2012-03-24 21:06:15.000000000 -0700
    @@ -1,3 +1,3 @@
    -result: [g=uri<http://example.com/data/#x>, avg=string("2.5e0"^^<http://www.w3.org/2001/XMLSchema#double>)]
    +result: [g=uri<http://example.com/data/#x>, avg=string("2.5E0"^^<http://www.w3.org/2001/XMLSchema#double>)]
     result: [g=uri<http://example.com/data/#y>, avg=string("2.0"^^<http://www.w3.org/2001/XMLSchema#decimal>)]
    -result: [g=uri<http://example.com/data/#z>, avg=string("2.5e0"^^<http://www.w3.org/2001/XMLSchema#double>)]
    +result: [g=uri<http://example.com/data/#z>, avg=string("2.5E0"^^<http://www.w3.org/2001/XMLSchema#double>)]

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


bind: 2
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

bind/manifest#bind10
    ???? filter variable scoping

    check-sparql: 'bind10 - BIND scoping - Variable in filter not in scope' FAILED (Expected 0 results, got 1)
    roqet -d debug -W 0 -i sparql11 -D data.ttl bind10.rq
    --- result.out	2012-03-24 21:06:19.000000000 -0700
    +++ roqet.out	2012-03-24 21:06:19.000000000 -0700
    @@ -0,0 +1 @@
    +result: [s=uri<http://example.org/s4>, v=string("4"^^<http://www.w3.org/2001/XMLSchema#integer>), z=string("4"^^<http://www.w3.org/2001/XMLSchema#integer>)]


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

csv-tsv-res: 3
--------------

csv-tsv-res/manifest#csv01
    plain literal / xsd:string equality issue

csv-tsv-res/manifest#csv02
    plain literal / xsd:string equality issue

csv-tsv-res/manifest#csv03
    more like a syntax comparison but blank nodes are need eliding

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

functions: 28
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

functions/manifest#if02

* error propogation in IF????

functions/manifest#iri01

* base URIs?

functions/manifest#lcase01

* test runner: unicode compare

functions/manifest#length01

* test runner: unicode compare

functions/manifest#notin01

* CRASH

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

functions/manifest#sha1-02

* unicode distinct

functions/manifest#sha256-02

* unicode distinct

functions/manifest#sha512-02

* unicode distinct

functions/manifest#strafter01

* unicode????

functions/manifest#strbefore01

* unicode????

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


property-path: 33
-----------------

property-path/manifest#pp01
property-path/manifest#pp02
property-path/manifest#pp03
property-path/manifest#pp04
property-path/manifest#pp05
property-path/manifest#pp06
property-path/manifest#pp07
property-path/manifest#pp08
property-path/manifest#pp09
property-path/manifest#pp10
property-path/manifest#pp11
property-path/manifest#pp12
property-path/manifest#pp13
property-path/manifest#pp14
property-path/manifest#pp15
property-path/manifest#pp16
property-path/manifest#pp20
property-path/manifest#pp21
property-path/manifest#pp22
property-path/manifest#pp23
property-path/manifest#pp24
property-path/manifest#pp25
property-path/manifest#pp26
property-path/manifest#pp27
property-path/manifest#pp28
property-path/manifest#pp29
property-path/manifest#pp30
property-path/manifest#pp31
property-path/manifest#pp32
property-path/manifest#pp33
property-path/manifest#pp34
property-path/manifest#pp35

* not implementing

subquery: 2
-----------

subquery/manifest#subquery02

* ????

subquery/manifest#subquery10

* EXISTS not implemented

subquery: 10
------------

syntax-query/manifest#test_24
syntax-query/manifest#test_25
syntax-query/manifest#test_26
syntax-query/manifest#test_27
syntax-query/manifest#test_28
syntax-query/manifest#test_29
syntax-query/manifest#test_32
syntax-query/manifest#test_35
syntax-query/manifest#test_36
syntax-query/manifest#test_37

* ???? Several EXISTS and BINDINGS failures

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
