test:-go([4,1,3,7,2,5,0,8,6],[1,2,3,4,5,6,7,8,0]).
%problem specific part

%move blank cell right
%S is current state
%Snew is next state
%the same is in left, up, down.
move(S,Snew):-right(S,Snew).

%move blank cell right
%first parameter is current state
%Snew is next state
right([R1,R2,R3,R4,R5,R6,R7,R8,R9],Snew):-
	R3>0,
	R6>0,
	R9>0,
	blank_right([R1,R2,R3,R4,R5,R6,R7,R8,R9],Snew).

%move blank cell right
%first parameter is current state
%Snew is next state
blank_right([R1,R2,R3,R4,R5,R6,R7,R8,R9],S):-
	nth0(N,[R1,R2,R3,R4,R5,R6,R7,R8,R9], 0),
	Z is N+1,
	nth0(Z,[R1,R2,R3,R4,R5,R6,R7,R8,R9],R),
	substitute(R,[R1,R2,R3,R4,R5,R6,R7,R8,R9],10,Q),
	substitute(0,Q,R,V),
	substitute(10,V,0,S).

move(S,Snew):-left(S,Snew).

left([R1,R2,R3,R4,R5,R6,R7,R8,R9],Snew):-
	R1>0,
	R4>0,
	R7>0,
	blank_left([R1,R2,R3,R4,R5,R6,R7,R8,R9],Snew).

blank_left([R1,R2,R3,R4,R5,R6,R7,R8,R9],S):-
	nth0(N,[R1,R2,R3,R4,R5,R6,R7,R8,R9],0),
	Z is N-1,
	nth0(Z,[R1,R2,R3,R4,R5,R6,R7,R8,R9],R),
	substitute(R,[R1,R2,R3,R4,R5,R6,R7,R8,R9],10,Q),
	substitute(0,Q,R,V),
	substitute(10,V,0,S).

move(S,Snew):-down(S,Snew).

down([R1,R2,R3,R4,R5,R6,R7,R8,R9],Snew):-
	R7>0,
	R8>0,
	R9>0,
	blank_down([R1,R2,R3,R4,R5,R6,R7,R8,R9],Snew).

blank_down([R1,R2,R3,R4,R5,R6,R7,R8,R9],S):-
	nth0(N,[R1,R2,R3,R4,R5,R6,R7,R8,R9],0),
	Z is N+3,
	nth0(Z,[R1,R2,R3,R4,R5,R6,R7,R8,R9],R),
	substitute(R,[R1,R2,R3,R4,R5,R6,R7,R8,R9],10,Q),
	substitute(0,Q,R,V),
	substitute(10,V,0,S).

move(S,Snew):-up(S,Snew).

up([R1,R2,R3,R4,R5,R6,R7,R8,R9],Snew):-
	R1>0,
	R2>0,
	R3>0,
	blank_up([R1,R2,R3,R4,R5,R6,R7,R8,R9],Snew).

blank_up([R1,R2,R3,R4,R5,R6,R7,R8,R9],S):-
	nth0(N,[R1,R2,R3,R4,R5,R6,R7,R8,R9],0),
	Z is N-3,
	nth0(Z,[R1,R2,R3,R4,R5,R6,R7,R8,R9],R),
	substitute(R,[R1,R2,R3,R4,R5,R6,R7,R8,R9],10,Q),
	substitute(0,Q,R,V),
	substitute(10,V,0,S).

%substitutes the first parameter with the third parameter
%e.g. substitute(1, [1,2,3,1,4], 4, X) will make X=[4,2,3,4,4]
%first parameter is value to be substituted by third parameter
%second parameter is the given list to be substituted.
%third parameter is the value that will replace the first parameter
%forth parameter is the new list after substitution.
substitute(_, [], _, []):-!.
substitute(X, [X|T], Y, [Y|T1]):-
	substitute(X, T, Y, T1),!.

substitute(X, [H|T], Y, [H|T1]):-
	substitute(X, T, Y, T1).


%general algorithm

%query of user and takes start state and next state
go(Start,Goal):-
		path([[Start,null]],[],Goal).

%main predicate that takes open list, closed list and goal state
path([],_,_):-
		write('No solution'),nl,!.
path([[Goal,Parent] | _], Closed, Goal):-
		write('A solution is found'), nl ,
		printsolution([Goal,Parent],Closed),!.
path(Open, Closed, Goal):-
		removeFromOpen(Open, [State, Parent], RestOfOpen),
		getchildren(State, Open, Closed, Children),
		addListToOpen(Children , RestOfOpen, NewOpen),
		path(NewOpen, [[State, Parent] | Closed], Goal).

%gets Children of State that are not in Open or Close
getchildren(State, Open ,Closed , Children):-
		bagof(X, moves( State, Open, Closed, X), Children), ! .
getchildren(_,_,_, []).

%adds children to open list (without head child) to form new open list
%here it is like append i.e.Breadth First
addListToOpen(Children, [], Children).
addListToOpen(Children, [H|Open], [H|NewOpen]):-
		addListToOpen(Children, Open, NewOpen).

%gets head of open list to get its children later
removeFromOpen([State|RestOpen], State, RestOpen).

%gets next state given the current state
moves( State, Open, Closed,[Next,State]):-
		move(State,Next),
		\+ member([Next,_],Open),
		\+ member([Next,_],Closed).

%prints the path from start state to goal state
printsolution([State, null],_):-
		write(State),nl.
printsolution([State, Parent], Closed):-
		member([Parent, GrandParent], Closed),
		printsolution([Parent, GrandParent], Closed),
		write(State), nl.