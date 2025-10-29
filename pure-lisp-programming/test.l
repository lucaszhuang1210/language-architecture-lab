(load "../pure-lisp-programming/hw4.l")

(hello-world)

; MY-LENGTH
(print (my-length nil))             ; → 0
(print (my-length '(b (a b c))))    ; → 2
(print (my-length '(a (((b))) c)))  ; → 3
(print (my-length '(a b c)))        ; → 3


(terpri)

