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



