my_length([], 0).
my_length([_|T], R) :-
    my_length(T, R1),
    R is R1 + 1.

my_member(A, [A|_]) :- !.
my_member(A, [_|T]) :-
    my_member(A, T).

my_append([], L2, L2).
my_append([H|T], L2, [H|R]) :-
    my_append(T, L2, R).

my_reverse([], []).
my_reverse([H|T], R) :-
    my_reverse(T, R1),
    my_append(R1, [H], R).

my_nth([], _, []) :- !.
my_nth(L, 1, L) :- !.
my_nth([_|T], N, R) :-
    N > 1,
    N1 is N - 1,
    my_nth(T, N1, R).