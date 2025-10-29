(defun hello-world ()
    (print "Hello, World!")
)

(defun my-length (L)
    (cond   
        ((NULL L)   0)
        (T (+ 1 (my-length (cdr L))))
    )
)

(defun my-memq (A L)
    (cond
        ((NULL L)   nil)
        ((EQ A (car L)) L)
        (T  (my-memq A (cdr L)))
    )
)

(defun my-append (L1 L2)
    (cond
        ((NULL L1)  L2)
        (T (cons (car L1) (my-append (cdr L1) L2)))
    )
)