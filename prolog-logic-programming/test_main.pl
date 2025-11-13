:- begin_tests(my_length).

:- consult('main.pl').

test(empty_list) :-
    my_length([], R),
    R = 0.

test(nested_list_level1) :-
    my_length([b, [a,b,c]], R),
    R = 2.

test(nested_list_level2) :-
    my_length([a, [[[b]]], c], R),
    R = 3.

test(simple_list) :-
    my_length([a,b,c], R),
    R = 3.

:- end_tests(my_length).