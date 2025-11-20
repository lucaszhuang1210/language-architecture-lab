my_length([], 0).
my_length([_|T], R) :-
    my_length(T, R1),
    R is R1 + 1.

my_member(A, [A|_]).
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

my_remove(_, [], []).
my_remove(X, [X|L], R) :-
    my_remove(X, L, R).
my_remove(X, [H|T], [H|R]) :-
    X \= H,
    my_remove(X, T, R).

my_subst(_, _, [], []).
my_subst(X, Y, [X|T], [Y|R]) :-
    my_subst(X, Y, T, R).
my_subst(X, Y, [H|T], [H|R]) :-
    X \= H,
    my_subst(X, Y, T, R).

my_subset(_, [], []).
my_subset(Type, [H|T], R) :-
    keep(Type, H, R, R1),
    my_subset(Type, T, R1).

keep(atomic, H, [H|R], R) :- atomic(H), !.
keep(atom, H, [H|R], R) :- atom(H), !.
keep(compound, H, [H|R], R) :- compound(H), !.
keep(_, _, R, R).

my_add(N1, N2, R) :-
    my_add2(N1, N2, 0, R).
my_add2([], [], 0, []).
my_add2([], [], 1, [1]).
my_add2([], N2, C, R) :-
    my_add2([0], N2, C, R).
my_add2(N1, [], C, N1) :-
    my_add2(N1, [0], C, N1).
my_add2([H1|T1], [H2|T2], C, [D|R]) :-
    S is H1 + H2 + C,
    D is S mod 10,
    C1 is S // 10,
    my_add2(T1, T2, C1, R).

my_merge([], L2, L2).
my_merge(L1, [], L1).
my_merge([H1|T1], [H2|T2], [H1|R]) :-
    H1 =< H2,
    my_merge(T1, [H2|T2], R).
my_merge([H1|T1], [H2|T2], [H2|R]) :-
    H1 > H2,
    my_merge([H1|T1], T2, R).

my_sublist([], _).
my_sublist([H|T], [H|T2]) :-
    my_sublist_match(T, T2).
my_sublist([H|T], [_|T2]) :-
    my_sublist([H|T], T2).

my_sublist_match([], _).
my_sublist_match([H|T], [H|T2]) :- !,
    my_sublist_match(T, T2).

my_assoc(A, [A|[R|T]], R).
my_assoc(A, [_|[_|T]], R) :-
    my_assoc(A, T, R).

my_replace(_, [], []).
my_replace(ALIST, [H|T], [R|RT]) :-
    my_assoc(H, ALIST, R), !,
    my_replace(ALIST, T, RT).
my_replace(ALIST, [H|T], [H|RT]) :-
    my_replace(ALIST, T, RT).

eval(C, C) :- 
    integer(C).
eval(X+Y, R) :-
    eval(X, XR), 
    eval(Y, YR), 
    R is XR + YR.
eval(X-Y, R) :-
    eval(X, XR), 
    eval(Y, YR), 
    R is XR - YR.
eval(X*Y, R) :-
    eval(X, XR), 
    eval(Y, YR), 
    R is XR * YR.
eval(X/Y, R) :-
    eval(X, XR), 
    eval(Y, YR), 
    R is XR / YR.
eval(X^Y, R) :-
    eval(X, XR), 
    eval(Y, YR), 
    R is XR ^ YR.