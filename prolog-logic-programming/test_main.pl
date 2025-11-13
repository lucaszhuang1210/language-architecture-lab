:- begin_tests(my_length).

:- consult('main.pl').

test(empty_list) :-
    my_length([], 0).

test(one_element) :-
    my_length([a], 1).

test(multiple_elements) :-
    my_length([a,b,c,d], 4).

test(with_numbers) :-
    my_length([1,2,3], 3).

test(wrong_length, [fail]) :-
    my_length([x,y], 3).

:- end_tests(my_length).