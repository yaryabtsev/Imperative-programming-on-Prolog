block(cycle(Comands)) --> "[", convert(Comands), "]".
block(C) --> [C|_].
convert([]) --> "".
convert([I|L]) --> block(I), convert(L).
fill([0],[]):-!.
fill(T,T):-!.
ll([A],A):-!.
ll([_|H],V):-ll(H,V),!.
run(62,L-E-[H|T],[E|L]-H-T1):-fill(T1,T),!.
run(60,[H|T]-E-L,T1-H-[E|L]):-fill(T1,T),!.
run(43,L-E-R,L-E1-R) :- E1 is E + 1,!.
run(45,L-E-R,L-E1-R) :- E1 is E - 1,!.
run(44,L-_-R,L-C-R):-read(Ch), string_codes(Ch,A),ll(A,C),!.
run(46,L-C-R,L-C-R):-string_codes(W,[C]), write(W).
run(cycle(_),L-0-R,L-0-R) :- !.
run(cycle(Comands),L-E-R,TapeOut) :-
	run(Comands,L-E-R,TapeNew),
	run(cycle(Comands),TapeNew,TapeOut),!.
run([Comand|T],TapeIn,FinTape) :-
	run(Comand,TapeIn,TapeNew),
	run(T,TapeNew,FinTape),!.
run(_,Tape,Tape) :- !.
brainfuck(Code) :-
	string_codes(Code, Program),
	convert(Comands, Program, []),
	run(Comands,[0]-0-[0],_),!.
