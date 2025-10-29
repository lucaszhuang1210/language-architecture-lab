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


