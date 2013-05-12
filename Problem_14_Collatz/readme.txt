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

Solution.ml VS. NoMemos.ml

FFFFFF IIIIIII   GGGG    HH  HH  TTTTTTT  !!
FF       II     GG       HH  HH    TT     !!
FFFFF    II     GG  GGG  HHHHHH    TT     !!
FF       II     GG  GG   HH  HH    TT
FF     IIIIII     GGG    HH  HH    TT     !!

The interesting thing here is that I pre-emptively optimized - or so I thought -
solution.ml to save the results of each call in a Map structure, so that when I
arrived at number I saw before I wouldn't recalculate it needlessly.

This ended up being hideously slow. It took about 3 minutes to complete; after
removing the Map stucture to see how much I had 'optimized' my code, I was stunned
to see it finish in about 12 seconds. Considering I was inserting into the map
at least 1 million times and looking things up in it many more times than that,
and the underlying data structure is a tree and not a hastable, it makes sense that
just doing the calculation was the proper route. Still, pretty surprising, and a kick
to the noggin to remember that I shouldn't optimize pre-emptively.

#########################################################################

Compilation Note:

Solution.ml uses some modules from the "batteries" package library for
Ocaml (https://github.com/ocaml-batteries-team/batteries-included); once
the batteries package is installed, the program can be compiled with

ocamlfind ocamlc -package batteries -linkpkg solution.ml
