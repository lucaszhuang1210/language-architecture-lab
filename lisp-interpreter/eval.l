;; Initializes the global alist where global
;; settings, like those defined via setq and defun, go.

(defvar global-alist nil)
;; to push a new value, (setq global-alist (cons (cons 'newvar 'newval) global-alist))  

;; We will use association lists, alists, for the stack of variables and
;; their values to implement dynamic scoping.  An alist is a list of this form:
;; ((var1 . val1) (var2 . val2) ... (varN . valN))
;; where each vari is a symbol representing a variable (or parameter) name
;; and each vali is the value of the variable.  assoc returns the association
;; of a given symbol, e.g,
;; (assoc 'myvar '((a . 10)(b a b c)(myvar d e f)))
;; returns (myvar d e f) and you take the cdr of that to get myvar's value
;; (d e f)

;; my-assoc returns the association (binding) of a variable in the association
;; list. An association list may contain multiple definitions of a variable
;; with the same name, for example with parameters to a recursive function.
;; Assoc always finds the first association of a variable, and this is how we
;; implement dynamic scoping. 

;; As evaluation proceeds deeper into recursion, new variables are added onto
;; the front of the current association list.  New defintions of a variable 
;; will hide previously made definitions effectively hiding them from access.
;; The previously made definitions will come back into scope when
;; recursive evaluation unwinds.

;; We use a special global variable, called global-alist, for saving top-level
;; definitions made using defun or setq. Note the global-alist is passed in
;; to my-eval only in the call made by my-top defined below.

(defun my-assoc (v alist)
    (cond
        ((NULL alist)   nil)
        ((EQ v (car (car alist)))   (car alist))
        (T  (my-assoc v (cdr alist)))
    )
)

(defun my-eval (e alist)
    (cond ((atom e) (my-eval-atom e alist))
          (t (my-apply (car e) (cdr e) alist))
    )
)

(defun my-eval-atom (e alist)
    (cond
        ((eq e 't)  t)
        ((eq e nil) nil)
        ((numberp e)    e)
        ((stringp e)    e)
        (t  (cdr (my-assoc e alist)))
    )
)

(defun my-apply (fn args alist)
    (cond ((atom fn) (my-apply-atom fn args alist))
          ( t (my-apply-lambda fn args alist)))
)

(defun my-apply-atom (fn args alist)
    (cond 
        ((eq fn 'eq)
            (eq (my-eval (car args) alist) (my-eval (cadr args) alist))
        )
        ((eq fn 'car)
            (car (my-eval (car args) alist))
        )
        ((eq fn 'cdr)
            (cdr (my-eval (car args) alist))
        )
        ((eq fn 'cons)
            (cons (my-eval (car args) alist) (my-eval (cadr args) alist))
        )
        ((eq fn 'quote)
            (car args)
        )
        ((eq fn 'null)
            (null (my-eval (car args) alist))
        )
        ((eq fn 'listp)
            (listp (my-eval (car args) alist))
        )
        ((eq fn 'equal)
            (equal (my-eval (car args) alist) (my-eval (cadr args) alist))
        )
        ((eq fn '+)
            (+ (my-eval (car args) alist) (my-eval (cadr args) alist))
        )
        ((eq fn '-)
            (- (my-eval (car args) alist) (my-eval (cadr args) alist))
        )
        ((eq fn '*)
            (* (my-eval (car args) alist) (my-eval (cadr args) alist))
        )
        ((eq fn '/)
            (/ (my-eval (car args) alist) (my-eval (cadr args) alist))
        )
        ((eq fn 'print)
            (print (my-eval (car args) alist))
        )
        ((eq fn 'setq) 
            (my-eval-setq (car args) (cadr args))
        )
        ((eq fn 'cond) 
            (my-eval-cond args alist)
        )
        ((eq fn 'defun) 
            (my-eval-defun args alist)
        )
        ((eq fn 'eval) 
            (my-eval (my-eval (car args) alist) alist)
        )
        ;; in this last case, function must be a variable bound to a function
        ;; so get the lambda from the alist and then apply that to the arguments
        (T 
            (my-apply (cdr (my-assoc fn global-alist)) args alist)
        )
    )
)

;; Utility function for eval-cond and apply-lambda.  Evaluates each expression
;; in l and returns the value of the last expression

(defun my-eval-list (l alist)
    (cond
        ((null l) nil)
        ((null (cdr l)) (my-eval (car l) alist))
        (t 
            (my-eval (car l) alist)
            (my-eval-list (cdr l) alist)
        )
    )
)

;; bind the formals to the evaluated actuals then evaluate the body in that
;; new scoping context (i.e., that becomes the new alist for recursive
;; evaluation of the function body.  Return the value of the last 
;; expression in the body (using eval-list)).
(defun my-apply-lambda (fn args alist)
    (my-eval-list (cdr fn) (my-bind-formals (car fn) args alist))
)

(defun my-bind-formals (formals actuals alist)
    (cond
        ((null formals) alist)
        (t  (cons
                (cons (car formals) (my-eval (car actuals) alist))
                (my-bind-formals (cdr formals) (cdr actuals) alist)
            )
        )
    )
)

(defun my-eval-setq (var val)
    (setq global-alist (cons (cons var (my-eval val global-alist)) global-alist))
    (my-eval var global-alist)
)

(defun my-eval-defun (body alist)
    (setq global-alist (cons body global-alist))
    (car body)
)

(defun my-eval-cond (clauses alist)
    (cond 
        ((null clauses) nil)
        ((my-eval (caar clauses) alist)     
            (my-eval-list (cdar clauses) alist))
        (t 
            (my-eval-cond (cdr clauses) alist)))
)

(defun my-top ()
    (prog ()
        top
            ;; read an s-expression, evaluate it using my-eval passing in the global-alist,
            ;; then print the result, functions and global variables will be on global-alist

            (print (my-eval (read) global-alist))
            (terpri) ;; prints a newline
            (go top) ;; loops forever
    )
)
