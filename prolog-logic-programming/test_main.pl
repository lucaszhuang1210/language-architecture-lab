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

test(subset_atom_case1) :-
    my_subset(atom, [a, [b], c], Y),
    Y = [a,c].

test(subset_atom_case2) :-
    my_subset(atom, [[a], [b], c, d, [e], f], Y),
    Y = [c,d,f].

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

:- begin_tests(my_sublist).

test(sublist_true_1) :-
    my_sublist([1,2,3], [1,2,3,4,5]).

test(sublist_true_2) :-
    my_sublist([3,4,5], [1,2,3,4,5]).

test(sublist_true_3) :-
    my_sublist([c,d], [a,b,c,d,e]).

test(sublist_false_1, [fail]) :-
    my_sublist([3,4], [1,2,3,5,6]).

test(sublist_false_2, [fail]) :-
    my_sublist([1,2,3,4,5], [3,4,5]).

test(sublist_false_3, [fail]) :-
    my_sublist([2,4], [1,2,3,4,5]).

test(sublist_false_4, [fail]) :-
    my_sublist([1,3,5], [1,2,3,4,5]).

test(sublist_with_variable) :-
    my_sublist([3,4,5], [1,2,3,4,X]),
    X = 5.

:- end_tests(my_sublist).

:- begin_tests(my_assoc).

test(assoc_empty, [fail]) :-
    my_assoc(a, [], _).

test(assoc_a) :-
    my_assoc(a, [a,b,c,e,f,b], R),
    R = b.

test(assoc_c) :-
    my_assoc(c, [a,b,c,e,f,b], R),
    R = e.

test(assoc_f) :-
    my_assoc(f, [a,b,c,e,f,b], R),
    R = b.

test(assoc_b, [fail]) :-
    my_assoc(b, [a,b,c,e,f,b], _).

:- end_tests(my_assoc).

:- begin_tests(my_replace).

test(replace_dna) :-
    my_replace(
        [g,c,c,g,t,a,a,u],
        [g,a,t,c,c,t,c,c,a,t,a,t,a,c,a,a,c,g,g,t],
        R
    ),
    R = [c,u,a,g,g,a,g,g,u,a,u,a,u,g,u,u,g,c,c,a].

test(replace_universities) :-
    my_replace(
        [ucb,ucla,ucsd,uci,basketball,tennis],
        [ucsd,is,playing,basketball,against,ucb],
        R
    ),
    R = [uci,is,playing,tennis,against,ucla].

test(replace_animals) :-
    my_replace(
        [dog,cat,fleas,kittens,sunday,friday],
        [my,dog,has,fleas,on,sunday],
        R
    ),
    R = [my,cat,has,kittens,on,friday].

:- end_tests(my_replace).

:- begin_tests(eval).

test(eval_case1) :-
    eval(5-6*18/3+2, Y),
    Y = -29.

test(eval_case2) :-
    eval(10*20-9/3+20, Y),
    Y = 217.

test(eval_case3) :-
    eval(10^3*9-1, Y),
    Y = 8999.

:- end_tests(eval).

:- begin_tests(simplify).
test(simplify_add_one) :-
    simplify(x+1, Y),
    Y = x+1.

test(simplify_cancel_unit) :-
    simplify(5-x*(3/3)+2, Y),
    Y = 5-x+2.

test(simplify_remove_zero) :-
    simplify(1*x-0/3+2, Y),
    Y = x+2.

:- end_tests(simplify).

:- begin_tests(deriv).

test(deriv_quadratic) :-
    deriv(x^2, Y),
    Y = 2*x.

test(deriv_cancel_x) :-
    deriv((x*2*x)/x, Y),
    Y = 2.

test(deriv_polynomial_plus) :-
    deriv(x^4+2*x^3-x^2+5*x-1/x, Y),
    Y = 4*x^3+6*x^2-2*x+5+1/x^2.

test(deriv_polynomial_next) :-
    deriv(4*x^3+6*x^2-2*x+5+1/x^2, Y),
    Y = 12*x^2+12*x-2-2/x^3.

test(deriv_polynomial_final) :-
    deriv(12*x^2+12*x-2-2/x^3, Y),
    Y = 24*x+12+6/x^4.

:- end_tests(deriv).

:- begin_tests(party).
% genders
male(klefstad).
male(bill).
male(mark).
male(isaac).
male(fred).

female(emily).
female(heidi).
female(beth).
female(susan).
female(jane).

% languages
speaks(klefstad, english).
speaks(bill, english).
speaks(emily, english).
speaks(heidi, english).
speaks(isaac, english).

speaks(beth, french).
speaks(mark, french).
speaks(susan, french).
speaks(isaac, french).

speaks(klefstad, spanish).
speaks(bill, spanish).
speaks(susan, spanish).
speaks(fred, spanish).
speaks(jane, spanish).

% share_language(A,B): true if A and B speak a common language
share_language(A, B) :-
    speaks(A, L),
    speaks(B, L),
    !.

% no_two_females(A,B): fails if both are female
no_two_females(A, B) :-
    \+ (female(A), female(B)).

% adjacent_ok(A,B): checks both constraints
adjacent_ok(A, B) :-
    share_language(A, B),
    no_two_females(A, B).

test(party_seating_basic) :-
    party_seating(L),
    is_list(L),
    length(L, 10).

:- end_tests(party).