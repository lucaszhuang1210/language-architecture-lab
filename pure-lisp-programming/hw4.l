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

(defun my-reverse (L)
    (my-reverse2 L nil)
)

(defun my-reverse2 (L R)
    (cond
        ((NULL L)   R)
        (T (my-reverse2 (cdr L) (cons (car L) R)))
    )
)

(defun my-mapcar (F L)
    (cond
        ((NULL L) nil)
        (T (cons  (apply F (cons (car L) nil)) (my-mapcar F (cdr L))))
    )
)

(defun my-copy (L)
    (cond
        ((NULL L)   nil)
        ((atom L)   L)
        (T (cons (car L) (my-copy (cdr L))))
    )
)

(defun my-nth (L N)
    (cond
        ((EQ N 0)   (cons nil L))
        ((EQ N 1)   L)
        (T (my-nth (cdr L) (- N 1)))
    )
)

(defun my-remove (X L)
    (cond
        ((NULL L)   nil)
        ((EQUAL X (car L))  (my-remove X (cdr L)))
        (T  (cons (car L) (my-remove X (cdr L))))
    )
)

(defun my-subst (X Y Z)
    (cond
        ((NULL Z)   nil)
        ((EQUAL X (car Z))  (cons Y (my-subst X Y (cdr Z))))
        ((listp (car Z))    (cons (my-subst X Y (car Z)) (my-subst X Y (cdr Z))))
        (T  (cons (car Z) (my-subst X Y (cdr Z))))
    )
)

(defun my-subset (FN L)
    (cond
        ((NULL L)   nil)
        ((apply FN (cons (car L) nil))  (cons (car L) (my-subset FN (cdr L))))
        (T  (my-subset FN (cdr L)))
    )
)

(defun my-add (N1 N2)
    (my-add2 N1 N2 0)
)

(defun my-add2 (N1 N2 C)
    (cond
        ((and (NULL N1) (NULL N2) (EQ C 0))   nil)
        ((and (NULL N1) (NULL N2) (EQ C 1))   (cons 1 nil))
        ((NULL N1)   (my-add2 (cons 0 nil) N2 C))
        ((NULL N2)   (my-add2 (cons 0 nil) N1 C))
        ((> (+ (car N1) (car N2) C) 9)    (cons   (- (+ (car N1) (car N2) C) 10)    (my-add2 (cdr N1) (cdr N2) 1)))
        (T  (cons   (+ (car N1) (car N2) C)    (my-add2 (cdr N1) (cdr N2) 0)))
    )
)