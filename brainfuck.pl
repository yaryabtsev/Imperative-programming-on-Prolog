block([Comands]) --> "[", convert(Comands), "]".
block(C) --> [C|_].
convert([]) --> "".
convert([I|L]) --> block(I), convert(L).
fill([0],[]):-!.
fill(T,T):-!.
ll([A],A):-!.
ll([_|H],V):-ll(H,V),!.
next(62,L-E-[H|T],[E|L]-H-T1):-fill(T1,T),!.
next(60,[H|T]-E-L,T1-H-[E|L]):-fill(T1,T),!.
next(43,L-E-R,L-E1-R) :- E1 is E + 1,!.
next(45,L-E-R,L-E1-R) :- E1 is E - 1,!.
next(44,L-_-R,L-C-R):-read(Ch), string_codes(Ch,A),ll(A,C),!.
next(46,L-C-R,L-C-R):-string_codes(W,[C]), write(W).
next([_],L-0-R,L-0-R) :- !.
next([Comands],L-E-R,TapeOut) :-
	run(Comands,L-E-R,TapeNew),
	next([Comands],TapeNew,TapeOut),!.
next(_,Tape,Tape) :- !.
run([Comand|T],TapeIn,FinTape) :-
	next(Comand,TapeIn,TapeNew),
	run(T,TapeNew,FinTape),!.
run(_,Tape,Tape) :- !.
brainfuck(Code) :-
	string_codes(Code, Program),
	convert(Comands, Program, []),
	run(Comands,[0]-0-[0],_),!.
