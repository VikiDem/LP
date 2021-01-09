only_no([X,Y,0,_,0,0,0]):-% кто не может находиться на одном береге
X = 'волк', Y = 'коза';
Y = 'волк', X = 'коза';
X = 'капуста', Y = 'коза';
Y = 'капуста', X = 'коза'.

only_no([0,0,0,_,0,Y,X]):-
X = 'волк', Y = 'коза';
Y = 'волк', X = 'коза';
X = 'капуста', Y = 'коза';
Y = 'капуста', X = 'коза'.

go([X,Y,Z,0,0,0,0],[X,Y,0,Z,0,0,0]):- not(only_no([X,Y,0,Z,0,0,0])).%передвижения: 
go([X,Y,Z,0,0,0,0],[X,Z,0,Y,0,0,0]):- not(only_no([X,Z,0,Y,0,0,0])).%1-3 клетки - левый берег, 5-7 - правый
go([X,Y,Z,0,0,0,0],[Z,Y,0,X,0,0,0]):- not(only_no([Z,Y,0,X,0,0,0])).%4 клетка - лодка

go([X,Y,0,Z,0,0,0],[X,Y,0,0,0,0,Z]).

go([X,Y,0,0,0,0,Z],[X,0,0,Y,0,0,Z]).
go([X,Y,0,0,0,0,Z],[Y,0,0,X,0,0,Z]).

go([X,0,0,Y,0,0,Z],[X,0,0,0,0,Y,Z]).
go([X,0,0,Y,0,0,Z],[X,Y,0,0,0,0,Z]).

go([X,0,0,0,0,Y,Z],[0,0,0,X,0,Y,Z]):- not(only_no([0,0,0,X,0,Y,Z])).
go([X,0,0,0,0,Y,Z],[X,0,0,Y,0,0,Z]).
go([X,0,0,0,0,Y,Z],[X,0,0,Z,0,0,Y]).

go([0,0,0,X,0,Y,Z],[0,0,0,0,X,Y,Z]).

%reverse([],List,List).
%reverse([H|T],Res):- reverse(T,[H],Res).
%reverse([H|T],List,Res):- reverse(T,[H|List],Res).

who('волк','коза','капуста').
who('волк','капуста','коза').
who('коза','волк','капуста').
who('коза','капуста','волк').
who('капуста','коза','волк').
who('капуста','волк','коза').


res1(Res):-%поиск в глубину
path1([['волк','коза','капуста',0,0,0,0]],[0,0,0,0,X,Y,Z],Res),
who(X,Y,Z).

prolong([A|T],[B,A|T]):-
go(A,B),
not(member(B,[A|T])).

path1([A|T],A,Res):-
reverse([A|T], Res).

path1(A,B,Res):-
prolong(A,C), path1(C,B,Res).


res2(Res):-%поиск в ширину
path2(['волк','коза','капуста',0,0,0,0],[0,0,0,0,X,Y,Z],Res),
who(X,Y,Z).

path2(X,Y,Res):- bdth([[X]],Y,Res).

bdth([[X|T]|_],X,[X|T]).

bdth([A|Other],X,Res):-
findall(B,prolong(A,B),T),
append(Other,T,QO),!,
bdth(QO,X,Res).

bdth([_|T],B,Res):- bdth(T,B,Res).

res3(Res):-%поиск с итерационным заглублением
search_id(['волк','коза','капуста',0,0,0,0],[0,0,0,0,X,Y,Z],Res),
who(X,Y,Z).

search_id(Start, Finish, Path, DepthLimit):-
depth_id([Start], Finish, Path, DepthLimit).

depth_id([Finish|Tail], Finish, [Finish|Tail], 0). 
depth_id(Path, Finish, Res, N) :-
N > 0,
prolong(Path, NewPath),
N1 is N - 1,
depth_id(NewPath, Finish, Res, N1).

my_integer(1). 
my_integer(N) :- my_integer(N1), N is N1 + 1.

search_id(Start, Finish, Res) :- 
my_integer(Level),
search_id(Start, Finish, Res, Level).
