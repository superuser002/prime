fibonacci(1).
fibonacci(N):-
	N1=N-1,
	N1>=0,!,
	fibonacci(N1),
	write(F1," ,"),
	F=F1+N.

#fibonacci(3).
#0 1 2