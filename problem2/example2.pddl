;
; This is an example of a PDDL file describing a simple planning problem.
;
; To create your own PDDL file you first need to provide the domain definition (see lines 28-46). 
; This definition must include all the possible predicates and action schemas in 
; the problem domain. Predicates consist of a name and an optional list of variables
; (e.g., (box-at ?loc). Action schemas consists of a name, a list of preconditions and a 
; list of effects. 
;
; After providing the domain definition you must define a problem instance of this domain.
; (see lines 48-53). The problem definition specifies the variables in the domain (:objects), 
; the initial state (:init) consisting of a set of predicates that are true at the start of 
; the problem, and the goal condition (:goal) specifying the list of predicates that must be 
; true at the goal. 
;
; The example below shows a very simple problem in which a robot must move to a location, pick 
; up a box, bring it back to the robot's initial location and drop it there.
;
; You can solve this problem using the provided planner by running
;
;      ./planner683 example.ppddl problem-01
;
; Running that program should list all the actions in the optimal plan, with 
; a total cost of 4 actions.
;
; - Luis Pineda, Kyle Wray, Shlomo Zilberstein - 2014.
;
(define (domain example-domain)
  (:requirements :negative-preconditions)
  (:predicates (box-at ?loc) (robot-at ?loc) (has-box))
  
  (:action move
    :parameters (?l1 ?l2)
    :precondition (and (robot-at ?l1) (not (robot-at ?l2)) )
    :effect (and (robot-at ?l2) (not (robot-at ?l1))))
    
  (:action pick-up-box
    :parameters (?l1)
    :precondition (and (box-at ?l1) (robot-at ?l1))
    :effect (and (has-box) (not (box-at ?l1))))
    
  (:action put-down-box
    :parameters (?l1)
    :precondition (and (has-box) (robot-at ?l1))
    :effect (and (not (has-box)) (box-at ?l1)))
)

(define (problem problem-01)
  (:domain example-domain)
  (:objects l1 l2)
  (:init (robot-at l1) (box-at l2)) 
  (:goal (and (box-at l1)))
)