fact(0,Result):-
	Result is 1.

fact(N,Result):-
	N>0,
	N1 is N-1,
	fact(N1,Result1),
	Result is Result1*N.

#fact(3,F).
#F=6