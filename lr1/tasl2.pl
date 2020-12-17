:- ['one.pl'].

group(X,L) :- findall(Z,student(X,Z),L). %для вывода таблицы групп

sum([], 0). %сумма элементов списка
sum([H|T], Sum):- sum(T, Sum1), Sum is Sum1 + H.

length([], 0). %длина списка ​
length([_|Y], N) :- length(Y, N1), N is N1 + 1. 

member(A, [A|_]).​ %принадлежность списку
member(A, [_|Z]) :- member(A, Z).




%Получить таблицу групп и средний балл по каждой из групп
marks_of_group(Group, Mark):- student(Group,Student), grade(Student,_,Mark). %перевод в функцию(группа, оценка) 

mean_group(Group, Res):- %средний балл группы
findall(Mark,marks_of_group(Group, Mark),Marks),
sum(Marks, A),
length(Marks, B),
Res is A / B.


first():-
group(101,X1),
write('Группа 101: '), write(X1), nl,
mean_group(101, Y1),
write('Средний балл: '), write(Y1), nl,

group(102,X2),
write('Группа 102: '), write(X2), nl,
mean_group(102, Y2),
write('Средний балл: '), write(Y2), nl,

group(103,X3),
write('Группа 103: '), write(X3), nl,
mean_group(103, Y3),
write('Средний балл: '), write(Y3), nl,

group(104,X4),
write('Группа 104: '), write(X4), nl,
mean_group(104, Y4),
write('Средний балл: '), write(Y4), nl.



%Для каждого предмета получить список студентов, не сдавших экзамен (grade=2)
fail_subject(Sub, Res):- 
findall(Student,grade(Student,Sub,2),Res).


second():-
write('Студенты не сдавшие экзамен:  '), nl,

fail_subject('LP', St1),
write('Логическое программирование - '), write(St1), nl,

fail_subject('MTH', St2),
write('Математический анализ - '), write(St2), nl,

fail_subject('FP', St3),
write('Функциональное программирование - '), write(St3), nl,

fail_subject('INF', St4),
write('Информатика - '), write(St4), nl,

fail_subject('ENG', St5),
write('Английский язык - '), write(St5), nl,

fail_subject('PSY', St6),
write('Психология - '), write(St6), nl.



%Найти количество не сдавших студентов в каждой из групп
fail_in_group(Group, 2, Student):- grade(Student,_,2), student(Group, Student).%для удобства 

remove_copy([], []). %удаляет повторы 
remove_copy([A|B], C):- member(A, B), !, remove_copy(B, C).
remove_copy([A|B], [A|C]):- !, remove_copy(B, C).


n_fail_in_group(Group, N):-
findall(Student,fail_in_group(Group, 2, Student),Students),
remove_copy(Students, Res),
length(Res, N).

third():-
n_fail_in_group(101, N1),
write('Не сдавших в 101 группе: '), write(N1), nl,

n_fail_in_group(102, N2),
write('Не сдавших в 102 группе: '), write(N2), nl,

n_fail_in_group(103, N3),
write('Не сдавших в 103 группе: '), write(N3), nl,

n_fail_in_group(104, N4),
write('Не сдавших в 104 группе: '), write(N4), nl.
