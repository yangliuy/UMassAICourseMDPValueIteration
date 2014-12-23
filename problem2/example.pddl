;; This is an example PDDL domain involving a car traveling
;; on a directed graph. 
;;
;; The file contains two main lists, one defining the domain
;; and one defining the problem. The domain list describes the 
;; predicates and actions available. The problem list describes
;; the initial state, the objects that can be used to instantiate
;; variables and the goal.
;;
;; You can use the planner to solve this problem by 
;; calling ./laoplan directory/example.pddl problem-01

;; -------------------------------------------------------------- ;;
;;                        DOMAIN DESCRIPTION                      ;;
;; -------------------------------------------------------------- ;;
(define (domain example-domain)

  ;; The notation ?x means that x is a variable
  (:predicates (car-at ?x) (engine-on) (road ?x ?y) (parked) )
  
  (:action turn-on
    :parameters ()
    :precondition (not (engine-on))
    :effect (engine-on)
  )
  
  (:action park
    :parameters ()
    :precondition (not (engine-on))
    :effect (parked)
  )
  
  (:action turn-off
    :parameters ()
    :precondition (engine-on)
    :effect (not (engine-on))
  )
  
  (:action move-car 
    :parameters (?from ?to)
    :precondition (and (car-at ?from) (road ?from ?to) )
    :effect (and (not (car-at ?from)) (car-at ?to))
  )  
)

;; -------------------------------------------------------------- ;;
;;                        PROBLEM DESCRIPTION                     ;;
;; -------------------------------------------------------------- ;;
;;                                                                ;;
;; The car is initially at location 1 with the engine turned off. ;;
;; The goal is to bring it to location 4 and park it there.       ;;
;; -------------------------------------------------------------- ;;
(define (problem problem-01)
  (:domain example-domain)
  (:objects loc1 loc2 loc3 loc4)
  (:init (car-at loc1) (road loc1 loc2) (road loc2 loc3) (road loc3 loc4))
  (:goal (and (car-at loc4) (parked)))
)
