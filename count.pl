next(Code,Code,K,K1) :-K1 is K + 1,!.
next(_,_,K,K) :- !.

run([Code|Array],Num,K,K2) :-next(Code,Num,K,K1),run(Array,Num,K1,K2),!.
run([],_,K,K) :-write(K), !.

count(String,Char) :-string_codes(String, List),string_codes(Char, [Num]),run(List,Num,0,_),!.

