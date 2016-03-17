valentine
===========

**valentine** is a statically linked binary that validates your HTML
against the offical W3C HTML spec giving you the file name, line
number, column number, offending tag and issue.

Install it with `opam`, the OCaml package manager, with 

```shell
$ opam install valentine
```

If there is an error then valentine will exit with exit code 1 making
it very easy use in your shell scripts.

Example output
=================

```shell
$ valentine test.html
File:test.html line 4, column 1: misnested tag: 'body' in 'body'
File:test.html line 4, column 10: unmatched start tag 'em'
File:test.html line 5, column 14: bad token '>' in tag: expected attribute value after '='
File:test.html line 4, column 10: unmatched start tag 'em'
```
