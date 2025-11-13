my_length([], 0).
my_length([_|T], R) :-
    my_length(T, R1),
    R is R1 + 1.

my_member(A, [A|_]) :- !.
my_member(A, [_|T]) :-
    my_member(A, T).
