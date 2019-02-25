next(Code,Code,K,K1) :-
	K1 is K + 1,!.
next(_,_,K,K) :- !.

run([Code|Array],Num,K,K2) :-
	next(Code,Num,K,K1),
	run(Array,Num,K1,K2),!.
run([],_,K,K) :-
	writeln(K), !.

firstinset(List,[C|SortList]):-
	string_codes(Char,[C]),
	write(Char),
	write(" - "),
	run(List,C,0,_),
	firstinset(List,SortList),
	!.

firstinset(_,[]):-
	!.

count(String) :-
	string_codes(String, List),
	sort(List, SortList),
	firstinset(List,SortList),
	!.
