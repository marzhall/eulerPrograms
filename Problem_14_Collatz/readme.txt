Problem:

The following iterative sequence is defined for the set of positive integers:

n  n/2 (n is even)
n  3n + 1 (n is odd)

Using the rule above and starting with 13, we generate the following sequence:

13  40  20  10  5  16  8  4  2  1
It can be seen that this sequence (starting at 13 and finishing at 1) contains 10 terms. Although it has not been proved yet (Collatz Problem), it is thought that all starting numbers finish at 1.

Which starting number, under one million, produces the longest chain?

NOTE: Once the chain starts the terms are allowed to go above one million.

#########################################################################

Compilation Note:

This solution uses some modules from the "batteries" package library for
Ocaml (https://github.com/ocaml-batteries-team/batteries-included); once
the batteries package is installed, the program can be compiled with

ocamlfind ocamlc -package batteries -linkpkg solution.ml
