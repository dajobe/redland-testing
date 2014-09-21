#!/usr/bin/python
"""earlsum.py -- summarize earl results

LICENSE: Open Source: Share and Enjoy.

GRDDL Test Workspace: http://www.w3.org/2001/sw/grddl-wg/td/

Copyright 2002-2007 World Wide Web Consortium, (Massachusetts
Institute of Technology, European Research Consortium for
Informatics and Mathematics, Keio University). All Rights
Reserved. This work is distributed under the W3C(R) Software License
  http://www.w3.org/Consortium/Legal/2002/copyright-software-20021231
in the hope that it will be useful, but WITHOUT ANY WARRANTY;
without even the implied warranty of MERCHANTABILITY or FITNESS FOR
A PARTICULAR PURPOSE.

"""

import sys

try:
    import rdflib
except ImportError:
    print >>sys.stderr, """
    **OOPS**: earlsum.py requires rdflib, which doesn't seem to be installed.
    Try http://rdflib.net/ .
    """
    raise SystemExit

print >>sys.stderr, "rdflib version {0}".format(rdflib.__version__)

try:
    # rdflib 4
    from rdflib import Graph,URIRef,BNode,Literal,Namespace
    from rdflib.namespace import NamespaceManager
    from rdflib import RDF,RDFS
except ImportError:
    # rdflib 2
    from rdflib.Namespace import Namespace
    from rdflib.syntax.NamespaceManager import NamespaceManager
    from rdflib import RDF,RDFS,URIRef,Literal,BNode
    from rdflib.Graph import Graph

EARL = Namespace('http://www.w3.org/ns/earl#')
DOAP = Namespace('http://usefulinc.com/ns/doap#')
FOAF = Namespace('http://xmlns.com/foaf/0.1/')
DC   = Namespace('http://purl.org/dc/elements/1.1/')
DCTERMS = Namespace('http://purl.org/dc/terms/')
TS = Namespace("http://www.w3.org/2000/10/rdf-tests/rdfcore/testSchema#")
MF = Namespace("http://www.w3.org/2001/sw/DataAccess/tests/test-manifest#")

def main(argv):
    import getopt

    approvedOnly = False
    opts, argv = getopt.getopt(argv[1:], "", "approved")
    for opt, arg in opts:
        if opt in ("--approved"):
            approvedOnly = True

    kb = readfiles(argv)
    subjects, results = findTestData(kb)

    #import pprint
    #print "subjects:"
    #pprint.pprint(subjects)
    #print "results:"
    #pprint.pprint(results)
    
    # use a kid template instead?
    print "<ol>"
    for term, label in subjects:
        print "<li>"
        homepage = None

        try:
           homepage = kb.objects(subject=term, predicate=FOAF.homepage).next()
           print '<a href="%s">' % (homepage,) #@@escaping
        except StopIteration:
           pass

        print "<b>%s</b> " % label #@@ escaping

        try:
           print '<cite>%s</cite>' % \
                 (kb.objects(subject=term, predicate=DC['title']).next(),) #@@escaping
        except StopIteration:
           pass
           

        if homepage:
           print '</a>'

        # owl:versionInfo seems more standard, though perhaps
        # its domain is ontology?
        try:
           vers = kb.objects(subject=term, predicate=DCTERMS.hasVersion).next()
        except StopIteration:
           pass
        else:
            # split CVS keywords a la $<!-- -->Id: 1.2 $
            print "<br />%s<!-- -->%s" % (vers[:1], vers[1:])

        print "</li>"
    print "</ol>"


    print '<table border="1">'
    print "<tr><th colspan='2'>Subject:</th>"
    for term, label in subjects:
        print "<th>%s</th>" % label #@@ escaping
    print "</tr>"
    for term, label, outputs, approval in results:
        if approvedOnly and not approval: continue
        if isinstance(term, URIRef):
            #@@ escaping label
            print "<tr><th><a href='%s'>%s</a>" % (term, label)
        else:
            print "<tr><th>%s" % label

        try:
           print '<br /><small>%s</small>' % \
                 (kb.objects(subject=term, predicate=DC['description']).next(),) #@@escaping
        except StopIteration:
           pass

        print "</th>"
        #print "<td>dup? %d %s</td>" % (id(term), unicode(term))
        if approval:
           print '<td><a href="%s">approved</a></td>' % approval
        else:
           print '<td>-</td>'
        for o in outputs:
            if o is None:
                print "<td>-</td>"
            else:
                print "<td>%s</td>" % mklabel(kb, o)
        print "</tr>"
    print "</table>"

class FoundResult(Exception):
    pass

def findTestData(kb):
    subjects = []
    results = []

    subjects = set(kb.objects(subject=None, predicate=EARL.subject))
    subjects = [(s, mklabel(kb, s)) for s in subjects]

    tests = set(kb.objects(subject=None, predicate=EARL.test))
    for t in tests:
        row = []
        for s, l in subjects:
            try:
                for assertion in kb.subjects(predicate=EARL.subject,
                                             object=s):
                    if t in kb.objects(subject=assertion,
                                       predicate=EARL.test):
                        for r in kb.objects(subject=assertion,
                                            predicate=EARL.result):
                            for v in kb.objects(subject=r,
                                                predicate=EARL.outcome):
                                row.append(v)
                                raise FoundResult
                            # support EARL.validity too, for now...
                            for v in kb.objects(subject=r,
                                                predicate=EARL.validity):
                                row.append(v)
                                raise FoundResult
                row.append(None)
            except FoundResult:
                pass
        try:
           approval = kb.objects(subject=t, predicate=TS.approval).next()
        except StopIteration:
           approval = None
        results.append((t, mklabel(kb, t), row, approval))

    results.sort(key=lambda(result): result[1])
    return subjects, results

def mklabel(kb, t):
    for p in (MF['name'], DOAP['name'], FOAF['name'], RDFS.label, DC['title']):
        try:
            l = kb.objects(subject=t, predicate=p).next()
            return unicode(l)
        except StopIteration:
            pass

    l = str(t)
    if '#' in l:
        junk, l = l.split('#')
    elif '/' in l:
        junk, l = l.rsplit('/', 1)
    else:
        l = "g%d" % id(t)
    return l

def readfiles(filenames):
    kb = Graph()
    for fn in filenames:
        kb.parse(fn)
    return kb


if __name__ == '__main__':
    main(sys.argv)
    
