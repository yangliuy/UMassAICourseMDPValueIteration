;; This is the PDDL domain for problem 2(The towers of Hanoi problem)
;; of AI Homework 6
;;
;; The file contains two main lists, one defining the domain
;; and one defining the problem. The domain list describes the 
;; predicates and actions available. The problem list describes
;; the initial state, the objects that can be used to instantiate
;; variables and the goal.
;;
;; You can use the planner to solve this problem by 
;; calling ./laoplan directory/hanoi.pddl problem-hanoi
;; by Liu Yang

;; -------------------------------------------------------------- ;;
;;                        DOMAIN DESCRIPTION                      ;;
;; -------------------------------------------------------------- ;;
(define (domain example-hanoi)

  ;; The notation ?x means that x is a variable
  (:action move
    :parameters (?b ?x ?y)
    :precondition (and (on ?b ?x) (clear ?b) (clear ?y) (smaller ?b ?y))
    :effect (and (on ?b ?y) (clear ?x) (not (clear ?y)) (not (on ?b ?x)))
  ) 
)

;; -------------------------------------------------------------- ;;
;;                        PROBLEM DESCRIPTION                     ;;
;; -------------------------------------------------------------- ;;

(define (problem problem-hanoi)
  (:domain example-hanoi)
  (:objects disk1 disk2 disk3 peg1 peg2 peg3)
  (:init (smaller disk1 disk2) (smaller disk2 disk3) (smaller disk1
disk3) (smaller disk1 peg1) (smaller disk1 peg2) (smaller disk1 peg3)
(smaller disk2 peg1) (smaller disk2 peg2) (smaller disk2 peg3) (smaller
disk3 peg1) (smaller disk3 peg2) (smaller disk3 peg3) (on disk3 peg1)
(on disk2 disk3) (on disk1 disk2) (clear peg2) (clear peg3) (clear disk1))
  (:goal (and (on disk3 peg3) (on disk2 disk3) (on disk1 disk2)))
)
