# language-architecture-lab

Exploration of programming language design and architecture — includes building a Lisp interpreter, converting Java to non-OOP native execution, and studying compiler and runtime design fundamentals.

---

## Projects

### java-object-model
A deep dive into Java’s core object-oriented mechanisms — analyzing inheritance, polymorphism, abstract data types, and dynamic binding to understand how language design shapes execution and extensibility.

---

### java-to-procedural
Acts as a compiler that translates Java source into low-level, non–object-oriented intermediate code. Implemented in C with C++ iostreams for clarity, this project explores how modern object-oriented languages are compiled into procedural representations, transforming inheritance, polymorphism, and dynamic binding into fundamental control and data structures.

---

### template-adt-scoping
Explores the design of parameterized abstract data types and variable scoping mechanisms in programming languages. Implemented using a C++ template `Vector` class, this project examines how languages support generic ADTs, contrasts static vs. dynamic scoping, and demonstrates the behavior of shallow and deep copies in memory management.

---

### lisp-programming
Builds a simple Lisp program to explore functional programming concepts. Pure functional programming relies entirely on recursion, without using variables, loops, or mutable state. Focuses on purely functional language design, first-class and higher-order functions, and the foundations of functional computation and evaluation.

#### How to Run Lisp
To run a Lisp file using SBCL (Steel Bank Common Lisp):

**Command line:**
```bash
sbcl --script filename.lisp
```

**Interactive mode:**
```bash
sbcl
(load "filename.lisp")
```
You can then call any function defined in your file directly within the Lisp REPL.

---

### lisp-interpreter
Implements a simple Lisp interpreter to explore how programming languages evaluate code. This project highlights how evaluation follows clear, algorithmic rules rather than arbitrary behavior. By using functional decomposition and recursion, it strengthens understanding of interpreter structure, predictable evaluation, and recursive program execution.

---

### prolog-logic-programming
Explores declarative programming using Prolog, where computation is expressed through facts and rules rather than step-by-step instructions. This project demonstrates how Prolog answers queries using unification, backtracking, and logical inference. By solving problems parallel to the Lisp section, it highlights the contrast between functional recursion and logic-based reasoning, showing how Prolog enables rule-driven computation and supports AI-style reasoning systems.