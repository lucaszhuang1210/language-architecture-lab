(load "eval.l")

(defun my-error (msg)
  (princ "Error: ")
  (princ msg)
  (terpri)
  nil)

(defun my-test (exp)
  (princ "==============================")
  (terpri)
  (princ "Expression: ")
  (print exp)
  (terpri)
  (princ "Result:    ")
  (print (my-eval exp global-alist))
  (terpri))

(defun testall ()
  ;; atoms
  (my-test 't)
  (my-test 'nil)
  (my-test '"Hello")
  (my-test '10)

 ;; primitive functions
  (my-test '(eq t t))
  (my-test '(eq nil nil))
  (my-test '(eq t nil))

  (my-test '(null nil))
  (my-test '(null t))

  (my-test '(quote (a b c)))    ;; same as '(a b c)
  (my-test '(eq 'a 'a))
  (my-test '(eq '(a b) '(a b))) ;; should be nil

  (my-test '(car '(a b c)))
  (my-test '(cdr '(a b c)))
  (my-test '(cons 'foo '(a b c)))

  (my-test '(print '(a b c)))

  ;; giving symbols a value and evaluation of symbols
  (my-test '(setq a '(a b c)))
  (my-test 'a)

  ;; cond - the conditional expression
  (my-test '(cond (nil 2 3 4 5 1)
                  (t   1 3 4 2)
                  (t   1 3 4 5 3)))

  (my-test '(cond ((eq t nil) 1)
                  ((eq t t)  2)
                  (t         3)))

  ;; defining a function and calling that function
  (my-test '(defun rev (L R)
              (cond ((null L) R)
                    (t (rev (cdr L) (cons (car L) R))))))
  (my-test '(rev a nil))
  (my-test '(rev (rev a nil) nil))

  ;; define and call another function in nested combination
  (my-test '(defun app (L R)
              (cond ((null L) R)
                    (t (cons (car L) (app (cdr L) R))))))
  (my-test '(app (app a a) (app a a)))
)

(testall)