(load "../pure-lisp-programming/hw4.l")

; HELLO-WORLD
(hello-world)
(terpri)


; MY-LENGTH
(print (my-length nil))             ; → 0
(print (my-length '(b (a b c))))    ; → 2
(print (my-length '(a (((b))) c)))  ; → 3
(print (my-length '(a b c)))        ; → 3
(terpri)


; MY-MEMQ
(print (my-memq 'A nil))             ; → NIL
(print (my-memq 'B '(A B C)))        ; → (B C)
(print (my-memq 'D '(A B C D E F G))); → (D E F G)
(print (my-memq 'D '(A B C D)))      ; → (D)
(print (my-memq 'D '(A B C)))        ; → NIL
(terpri)


; MY-APPEND
(print (my-append '(A B C) '(D E F)))             ; → (A B C D E F)
(print (my-append '((A) (B) (C)) '((D) (E) (F)))) ; → ((A) (B) (C) (D) (E) (F))
(print (my-append nil '(D E F)))                  ; → (D E F)
(print (my-append '(A B C) nil))                  ; → (A B C)
(terpri)


; MY-REVERSE
(print (my-reverse nil))                          ; → NIL
(print (my-reverse '(A)))                         ; → (A)
(print (my-reverse '(1 2 3 4 5)))                 ; → (5 4 3 2 1)
(print (my-reverse '((1 2 3) 4 ((5 6)))))         ; → (((5 6)) 4 (1 2 3))
(terpri)


; MY-MAPCAR
(print (my-mapcar 'car '((A B C) (X Y Z) (1 2 3)))) ; → (A X 1)
(print (my-mapcar 'cdr '((A B C) (X Y Z) (1 2 3)))) ; → ((B C) (Y Z) (2 3))
(print (my-mapcar '1+ '(1 3 5 7)))                  ; → (2 4 6 8)
(print (my-mapcar 'atom '(A (B) C (D) E)))          ; → (T NIL T NIL T)
(terpri)


; MY-COPY
(print (my-copy '(A B ((C 1)) 2 3)))        ; → (A B ((C 1)) 2 3)
(print (my-copy '(1 2 3)))                  ; → (1 2 3)
(print (my-copy '(A B . C)))                ; → (A B . C)
(defvar L)
(setq L '(A (B) C))
(print (eq L (my-copy L)))                  ; → NIL
(terpri)


; MY-NTH
(print (my-nth '(A B C D E) 1))  ; → (A B C D E)
(print (my-nth '(A B C D E) 3))  ; → (C D E)
(print (my-nth '(A B C D E) 30)) ; → NIL
(print (my-nth '(A B C D E) 0))  ; → (NIL A B C D E)
(terpri)


; MY-REMOVE
(print (my-remove '(A B) '(A B (A B) A A B (A B)))) ; → (A B A A B)
(print (my-remove 'A '(A B (A B) A B)))             ; → (B (A B) B)
(terpri)


; MY-SUBST
(print (my-subst 'B 'A '(A B (A B) (C (A B))))) ; → (A A (A A) (C (A A)))
(terpri)


; MY-SUBSET
(print (my-subset 'atom '(A (B) (C D) E F G))) ; → (A E F G)
(print (my-subset 'listp '(A (B) (C D) E F G))) ; → ((B) (C D))
(terpri)


; MY-ADD
(print (my-add '(0) '(0)))                               ; → (0)
(print (my-add '(1) '(1)))                               ; → (2)
(print (my-add '(9) '(9)))                               ; → (8 1)
(print (my-add '(1 1 1 1 1 1 1 1 1 1) '(9 9 9 9 9 9 9 9 9 9))) ; → (0 1 1 1 1 1 1 1 1 1 1)
(print (my-add '(1) '(9 9 9 9 9 9 9 9 9 9)))              ; → (0 0 0 0 0 0 0 0 0 0 1)
(terpri)


; MY-MERGE
(print (my-merge '(1 3 5 7 9) '(2 4 6 8 10)))     ; → (1 2 3 4 5 6 7 8 9 10)
(print (my-merge '(1 2 3 7 8 9) '(4 5 6 10)))     ; → (1 2 3 4 5 6 7 8 9 10)
(print (my-merge '(1 2 3) '(4 5 6 7 8 9 10)))     ; → (1 2 3 4 5 6 7 8 9 10)
(print (my-merge '(1 3 5 6 7 8 9 10) '(2 4)))     ; → (1 2 3 4 5 6 7 8 9 10)
(print (my-merge nil '(1 2 3 4 5 6 7 8 9 10)))    ; → (1 2 3 4 5 6 7 8 9 10)
(terpri)


; MY-SUBLIST
(print (my-sublist '(1 2 3) '(1 2 3 4 5))) ; → T
(print (my-sublist '(3 4 5) '(1 2 3 4 5))) ; → T
(print (my-sublist '(C D) '(A B C D E)))   ; → T
(print (my-sublist '(3 4) '(1 2 3 5 6)))   ; → NIL
(print (my-sublist '(1 2 3 4 5) '(3 4 5))) ; → NIL
(print (my-sublist '(2 4) '(1 2 3 4 5)))   ; → NIL
(print (my-sublist '(1 3 5) '(1 2 3 4 5))) ; → NIL
(terpri)