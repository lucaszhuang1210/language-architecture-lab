my_length([], 0).
my_length([_|T], R) :-
    my_length(T, R1),
    R is R1 + 1.