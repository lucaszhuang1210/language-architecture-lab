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


/* =====================================================
   Higher Level Functions: Symbolic Differentiation
   ===================================================== */
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

simplify(X, X) :- 
    atomic(X).
simplify(X+Y, R) :-
    simplify(X, XR), 
    simplify(Y, YR), 
    simplify_add(XR+YR, R).
simplify(X-Y, R) :-
    simplify(X, XR), 
    simplify(Y, YR), 
    simplify_sub(XR-YR, R).
simplify(X*Y, R) :-
    simplify(X, XR), 
    simplify(Y, YR), 
    simplify_mul(XR*YR, R).
simplify(X/Y, R) :-
    simplify(X, XR), 
    simplify(Y, YR), 
    simplify_div(XR/YR, R).
simplify(X^Y, R) :-
    simplify(X, XR), 
    simplify(Y, YR), 
    simplify_pow(XR^YR, R).

simplify_add(X+0, X).
simplify_add(0+X, X).
simplify_add(X+Y, R) :-
    number(X), number(Y),
    R is X + Y, !.
simplify_add(X+Y, X+Y).

simplify_sub(X-0, X).
simplify_sub(0-X, -X).
simplify_sub(X-X, 0).
simplify_sub(X-Y, R) :-
    number(X), number(Y),
    R is X - Y, !.
simplify_sub(X-Y, X-Y).

simplify_mul(_*0, 0).
simplify_mul(0*_, 0).
simplify_mul(X*1, X).
simplify_mul(1*X, X).
simplify_mul(X*Y, R) :-
    number(X), number(Y),
    R is X * Y, !.
simplify_mul(X*Y, X*Y).

simplify_div(0/_, 0).
simplify_div(X/1, X).
simplify_div(X/X, 1).
simplify_div((A*B)/B, A).
simplify_div((A*B)/A, B).
simplify_div(X/Y, R) :-
    number(X), number(Y),
    R is X / Y, !.
simplify_div(X/Y, X/Y).

simplify_pow(_^0, 1).
simplify_pow(X^1, X).
simplify_pow(X^Y, R) :-
    number(X), number(Y),
    R is X ^ Y, !.
simplify_pow(X^Y, X^Y).

deriv(X, X) :- 
    number(X).
deriv(X, 1) :- 
    atom(X).
deriv(X+Y, R) :-
    deriv(X, XR),
    deriv(Y, YR),
    simplify(XR + YR, R).
deriv(X-Y, R) :-
    deriv(X, XR),
    deriv(Y, YR),
    simplify(XR - YR, R).
deriv(X*Y, R) :-
    deriv(X, XR),
    deriv(Y, YR),
    simplify(XR * YR, R).
deriv(X*Y, R) :-
    deriv(X, XR),
    deriv(Y, YR),
    simplify(XR * YR, R).
deriv(X/Y^Z, R) :-
    deriv(X, XR),
    Z1 is Z + 1,
    simplify(X*Z/Y^Z1, R).
deriv(X/Y, R) :-
    deriv(X, XR),
    deriv(Y, YR),
    simplify(XR / YR, R).
deriv(X^Y, R) :-
    atom(X),
    number(Y), Y \= 0,
    Y1 is Y - 1,
    simplify(Y * X ^ Y1, R).

deriv2(X, X^2) :- 
    atom(X).
deriv2(X^Y, X) :- 
    atom(X),
    number(Y), Y \= 0,
    Y1 is Y + 1,
    simplify(Y / X ^ Y1, R).

collect_people(Acc, People) :-
    male(X),
    \+ my_member(X, Acc),
    collect_people([X|Acc], People).
collect_people(Acc, People) :-
    female(X),
    \+ my_member(X, Acc),
    collect_people([X|Acc], People).
collect_people(People, People).

all_people(People) :-
    collect_people([], P0),
    my_reverse(P0, People).   % keep stable order

share_language(A, B) :-
    speaks(A, L),
    speaks(B, L),
    !.

no_two_females(A, B) :-
    \+ (female(A), female(B)).

adjacent_ok(A, B) :-
    share_language(A, B),
    no_two_females(A, B).

valid_round_seating([A,B|Rest]) :-
    adjacent_ok(A, B),
    valid_round_seating([B|Rest]).
valid_round_seating([_]).   % end

wrap_ok([First|Rest]) :-
    last_element(Rest, Last),
    adjacent_ok(Last, First).

last_element([X], X).
last_element([_|T], X) :- last_element(T, X).

select(X, [X|T], T).
select(X, [H|T], [H|R]) :- select(X, T, R).

perm([], []).
perm(L, [X|R]) :-
    select(X, L, T),
    perm(T, R).

party_seating(L) :-
    all_people(People),
    perm(People, L),
    valid_round_seating(L),
    wrap_ok(L),
    !.  

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
