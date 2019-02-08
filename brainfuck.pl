loop([Program]) --> "[", convert(Program), "]".
loop(Command) --> [Command|_].
convert([]) --> "".
convert([Command|Program]) --> loop(Command), convert(Program).
zero([0],[]):-!.
zero(T,T):-!.
last([Char],Char):-!.
last([_|Chars],Char):-last(Chars,Char),!.
next(62,L-A-[H|R],[A|L]-H-R1):-zero(R1,R),!.	% "<"
next(60,[H|L]-A-R,L1-H-[A|R]):-zero(L1,L),!.	% ">"
next(43,L-A-R,L-A1-R) :- A1 is A + 1,!.		% "+"
next(45,L-A-R,L-A1-R) :- A1 is A - 1,!.		% "-"
next(44,L-_-R,L-A-R):-		% ","
    read(String),
    string_codes(String,Array),
    last(Array,A),!.
next(46,L-A-R,L-A-R):-		% "."
    string_codes(Char,[A]),
    write(Char),!.
next([_],L-0-R,L-0-R) :- !.
next([Program],L-A-R,TapeOut) :-	% loop
	run(Program,L-A-R,TapeNew),
	next([Program],TapeNew,TapeOut),!.
next(_,Tape,Tape) :- !.
run([Command|Program],TapeIn,FinTape) :-
	next(Command,TapeIn,TapeNew),
	run(Program,TapeNew,FinTape),!.
run(_,Tape,Tape) :- !.
brainfuck(Code) :-
	string_codes(Code, Simple),
	convert(Program, Simple, []),
	run(Program,[0]-0-[0],_),!.
