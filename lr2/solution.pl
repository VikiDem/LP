lang(ger).
lang(it).

langs([eng,fr,ger,it]).

translate(eng, 'английский').
translate(fr, 'французкий').
translate(ger, 'немецкий').
translate(it, 'итальянский').

delegat(Lang1, Lang2).

speak(delegat(Lang,_), Lang).
speak(delegat(_,Lang), Lang).

delegats([F,M,H,B]):-
speak(F, Lang),
speak(M, Lang),
speak(H, Lang),
speak(B, Lang).

four_speak([F,M,H,B]):- %все (не) могут говорить на одном языке
speak(F, Lang), speak(M, Lang), speak(H, Lang), speak(B, Lang).


three_speak([F,M,H,B]):- %трое могут говорить на одном языке(но это не физик, математик и химик)
speak(F, Lang), speak(M, Lang), speak(B, Lang);
speak(F, Lang), speak(H, Lang), speak(B, Lang);
speak(M, Lang), speak(H, Lang), speak(B, Lang).

fmh_speak([F,M,H,B]):-
speak(M, Lang), speak(H, Lang), speak(F, Lang).%(но это не физик, математик и химик)

ger_fr([F,M,H,B]):- %(никто не) говорит на немецком и французком одновременно
speak(F, fr),speak(F, ger);
speak(M, fr),speak(M, ger);
speak(H, fr),speak(H, ger);
speak(B, fr),speak(B, ger).

b_and_h([_,_,H,B]):- %биолог может говорить с химиком,но не на немецком, хоть и знает его
speak(H, Lang), speak(B, Lang).

m_and_f([F,M,_,_]):- %физик может быть переводчиком между математиком и биологом
speak(F, Lang), speak(M, Lang).
b_and_f([F,_,_,B]):-
speak(F, Lang), speak(B, Lang).
b_and_m([_,M,_,B]):- %биолог и математик не говорят на одном языке, тк им нужен переводчик
speak(M, Lang), speak(B, Lang).

not_double(Lang1, Lang2, [Lang1|Res]) :-
member(Lang2, Res).
not_double(Lang1, Lang2, [X|Res]) :-
not_double(Lang1, Lang2, Res).


solve():-
Delegats = [F,M,H,B],
F = delegat(LangF1, LangF2),
M = delegat(LangM1, LangM2),
H = delegat(LangH1, LangH2),
B = delegat(LangB1, LangB2),

langs(Langs),
lang(LangF1),lang(LangF2), not_double(LangF1,LangF2, Langs),
lang(LangM1),lang(LangM2), not_double(LangM1,LangM2, Langs), 
lang(LangH1),lang(LangH2), not_double(LangH1,LangH2, Langs), 
lang(LangB1),lang(LangB2), not_double(LangB1,LangB2, Langs),  

not(speak(F, eng)),
not(speak(H, ger)),
speak(B, ger),

not(four_speak(Delegats)),
three_speak(Delegats),
not(fmh_speak(Delegats)),
not(ger_fr(Delegats)),
not(b_and_m(Delegats)),
b_and_f(Delegats),
m_and_f(Delegats),
b_and_h(Delegats),

translate(LangF1, F1), translate(LangF2, F2),
translate(LangM1, M1), translate(LangM2, M2),
translate(LangH1, H1), translate(LangH2, H2),
translate(LangB1, B1), translate(LangB2, B2),

write('Физик: '), write(F1), write(', '), write(F2), nl,
write('Математик: '), write(M1), write(', '), write(M2), nl,
write('Химик: '), write(H1), write(', '), write(H2), nl,
write('Биолог: '), write(B1), write(', '), write(B2), nl.
