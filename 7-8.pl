father(allen,bob).
father(allen,collin).
father(bob,dan).
father(bob,elliot).
father(collin,finn).
brother(X,Y) :- father(Z,X), father(Z,Y), not(X=Y).
cousin(X,Y) :- father(Z,X), father(W,Y), brother(Z,W).
grandson(X,Y) :- father(Z,X), father(Y,Z).
descendent(X,Y) :- father(Y,X).
descendent(X,Y) :- father(Z,X), descendent(Z,Y).