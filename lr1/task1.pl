length([], 0) . ​
length([_|Y], N) :- length(Y, N1), N is N1 + 1. %длина списка

member(A, [A|_]).​
member(A, [_|Z]) :- member(A, Z). %принадлежность списку

append([], X, X).​
append([A|X], Y, [A|Z]) :- append(X,Y,Z). %конкатенация(объединение) списков

remove(X,[X|T],T).​
remove(X,[Y|T],[Y|T1]):-remove(X,T,T1). %удаление из списка

permute([],[]).​
permute(L,[X|T]):-remove(X,L,R),permute(R,T). %перестановка списка

sublist(S,L):-append(_,L1,L),append(S,_,L1). %реализация подсписка



last([], Val, Val).​  %добавление элемента в конец(без использования стандартных предикатов)
last([H|A], Val, [H,B]):- last(A,Val,B).

last2(A, Val, X):- append(A, [Val], X). %добавление элемента в конец(с использованием стандартных предикатов)


prograssion([]). % проверка списка на арифметическую прогрессию(без использования стандартных предикатов)
prograssion(N, D, [N]).
prograssion(N, D, [N|T]):- N1 is N + D, prograssion(N1, D, T).
prograssion([A,B|T]):- D is B - A, prograssion(A, D, [A, B|T]).

prograssion2([]). % проверка списка на арифметическую прогрессию(с использованием стандартных предикатов)
prograssion2(N, D, [N]).
prograssion2(N, D, [A, B|T]):-member(N, [A]), D1 is N+D, prograssion2(D1, D, [B|T]).
prograssion2([A, B|T]):- D is B - A, prograssion2(A, D, [A, B|T]).


%переместить заданный элемент списка в конец(совместное использование предикатов)
f(A, Val, Res):- remove(Val, A, B), last(B, Val, Res).
