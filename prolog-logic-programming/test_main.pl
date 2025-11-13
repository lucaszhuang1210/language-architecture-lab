:- consult('main.pl').

:- begin_tests(my_length).

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

:- begin_tests(my_member).

test(member_empty_list, [fail]) :-
    my_member(a, []).

test(member_middle_true) :-
    my_member(b, [a,b,c]).

test(member_long_list_true) :-
    my_member(d, [a,b,c,d,e,f,g]).

test(member_exact_true) :-
    my_member(d, [a,b,c,d]).

test(member_not_found, [fail]) :-
    my_member(d, [a,b,c]).

:- end_tests(my_member).