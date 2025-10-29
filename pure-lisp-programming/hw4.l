(defun hello-world ()
    (print "Hello, World!")
)

(defun my-length (L)
    (cond   
        ((NULL L)   0)
        (T (+ 1 (my-length (cdr L))))
    )
)
