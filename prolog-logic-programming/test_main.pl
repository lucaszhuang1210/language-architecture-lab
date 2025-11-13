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

:- begin_tests(my_append).

test(append_basic) :-
    my_append([a,b,c], [d,e,f], R),
    R = [a,b,c,d,e,f].

test(append_nested_lists) :-
    my_append([[a],[b],[c]], [[d],[e],[f]], R),
    R = [[a],[b],[c],[d],[e],[f]].

test(append_empty_left) :-
    my_append([], [d,e,f], R),
    R = [d,e,f].

test(append_empty_right) :-
    my_append([a,b,c], [], R),
    R = [a,b,c].

:- end_tests(my_append).

:- begin_tests(my_reverse).

test(reverse_empty) :-
    my_reverse([], R),
    R = [].

test(reverse_two_elements) :-
    my_reverse([a,b], R),
    R = [b,a].

test(reverse_numbers) :-
    my_reverse([1,2,3,4,5], R),
    R = [5,4,3,2,1].

test(reverse_nested) :-
    my_reverse([[1,2,3],4,[[5,6]]], R),
    R = [[[5,6]],4,[1,2,3]].

:- end_tests(my_reverse).

:- begin_tests(my_nth).

test(nth_first) :-
    my_nth([a,b,c,d,e], 1, R),
    R = [a,b,c,d,e].

test(nth_third) :-
    my_nth([a,b,c,d,e], 3, R),
    R = [c,d,e].

test(nth_fifth) :-
    my_nth([a,b,c,d,e], 5, R),
    R = [e].

test(nth_out_of_range) :-
    my_nth([a,b,c,d,e], 30, R),
    R = [].

:- end_tests(my_nth).

:- begin_tests(my_remove).

test(remove_list_pattern) :-
    my_remove([a,b], [a,b,[a,b],a,a,b,[a,b]], R),
    R = [a,b,a,a,b].

test(remove_atom) :-
    my_remove(a, [a,b,[a,b],a,b], R),
    R = [b,[a,b],b].

:- end_tests(my_remove).

:- begin_tests(my_subst).

test(subst_b_to_a) :-
    my_subst(b, a, [a,b,a,b,c,a,b], R),
    R = [a,a,a,a,c,a,a].

test(subst_c_to_d) :-
    my_subst(c, d, [a,b,a,b,c,a,b], R),
    R = [a,b,a,b,d,a,b].

:- end_tests(my_subst).

:- begin_tests(my_subset).

test(subset_atomic) :-
    my_subset(atomic, [a,[b],[c,d],e,f,g], R),
    R = [a,e,f,g].

test(subset_compound) :-
    my_subset(compound, [a,[b],[c,d],e,f,g], R),
    R = [[b],[c,d]].

:- end_tests(my_subset).

:- begin_tests(my_add).

test(add_zero_zero) :-
    my_add([0], [0], R),
    R = [0].

test(add_1_1) :-
    my_add([1], [1], R),
    R = [2].

test(add_9_9) :-
    my_add([9], [9], R),
    R = [8,1].

test(add_large_equal_length) :-
    my_add(
        [1,1,1,1,1,1,1,1,1,1],
        [9,9,9,9,9,9,9,9,9,9],
        R
    ),
    R = [0,1,1,1,1,1,1,1,1,1,1].

test(add_one_to_big) :-
    my_add([1], [9,9,9,9,9,9,9,9,9,9], R),
    R = [0,0,0,0,0,0,0,0,0,0,1].

:- end_tests(my_add).

:- begin_tests(my_merge).

test(merge_case1) :-
    my_merge([1,3,5,7,9], [2,4,6,8,10], R),
    R = [1,2,3,4,5,6,7,8,9,10].

test(merge_case2) :-
    my_merge([1,2,3,7,8,9], [4,5,6,10], R),
    R = [1,2,3,4,5,6,7,8,9,10].

test(merge_case3) :-
    my_merge([1,2,3], [4,5,6,7,8,9,10], R),
    R = [1,2,3,4,5,6,7,8,9,10].

test(merge_case4) :-
    my_merge([1,3,5,6,7,8,9,10], [2,4], R),
    R = [1,2,3,4,5,6,7,8,9,10].

test(merge_case5) :-
    my_merge([], [1,2,3,4,5,6,7,8,9,10], R),
    R = [1,2,3,4,5,6,7,8,9,10].

:- end_tests(my_merge).