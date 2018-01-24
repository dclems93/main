;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname lab4) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
(require 2htdp/batch-io)
(require 2htdp/universe)
(require 2htdp/image)


; Lab 4
; Dylan Clements

; exercise 1

; A Frosting is one of:
;  - "chocolate"
;  - "vanilla"
 
; A Dessert is one of:
;  (make-cupcake Frosting)
;  (make-pie String Number)
 
(define-struct cupcake (frosting))
(define-struct pie (filling slices))

;(define (processdesert des)
;  (cond
;    [(cupcake? des) ... (cupcake-frosting des)]
;    [(pie? des) ... (pie-filling des) ... (pie-slices des)]))

; exercise 2

(define pie1 (make-pie "apple" 1))
(define cupcake1 (make-cupcake "chocolate"))
(define pie2 (make-pie "strawberry" 3))

; exercise 3

; calories :: Dessert -> int
; calories takes a dessert and returns an int that calculates the calorie
; content of that dessert.

(check-expect (calories pie1) 175)
(check-expect (calories pie2) 525)
(check-expect (calories cupcake1) 150)

(define (calories des)
  (cond
    [(pie? des)
     (* (pie-slices des) 175)]
    [(cupcake? des)
     (cond
       [(string=? (cupcake-frosting des) "chocolate") 150]
       [(string=? (cupcake-frosting des) "vanilla" ) 125])]))

;exercise 4

(define-struct CaseOfDesserts [dessert cod])
; a cod is one of:
; -empty
; -CaseOfDesserts

; exercise 5

(define cod1 (make-CaseOfDesserts
              pie1
              (make-CaseOfDesserts
               pie1
               (make-CaseOfDesserts
                pie2
                (make-CaseOfDesserts
                 cupcake1
                 empty)))))

(define cod2 (make-CaseOfDesserts
              cupcake1
              (make-CaseOfDesserts
               cupcake1
               (make-CaseOfDesserts
                cupcake1
                (make-CaseOfDesserts
                 cupcake1
                 (make-CaseOfDesserts
                  cupcake1
                  empty))))))
(define cod3 (make-CaseOfDesserts pie1 empty))

; exercise 6

;(define (processcod cod)
;  (cond
;    [(empty? (CaseOfDesserts cod)) ...]
;    [else (CaseOfDesserts-dessert cod) ... (CaseOfDesserts-dessert cod)]))


; exercise 7

; total-calories :: cod -> int
; total-calories takes a CaseOfDesserts and calculates the calories of all of 
; the items within this CaseOfDesserts.

(check-expect (total-calories cod1) 1025)
(check-expect (total-calories cod2) 750)
(check-expect (total-calories cod3) 175)
              
              
(define (total-calories cod)
  (cond
    [(empty? (CaseOfDesserts-cod cod))
     (calories (CaseOfDesserts-dessert cod))]
    [else (+ (calories (CaseOfDesserts-dessert cod))
             (total-calories (CaseOfDesserts-cod cod)))]))


; exercise 8

(define-struct world [width color x y])

; exercise 9

;(define (worldprocess world)
;  (.... (world-height world) ... (world-width world) ... (world-posn world)))


; exercose 10

;;;;;;;;Run (main x) where x is the size of the world that you want


; main :: int -> bigbang
; main takes an int and returns a bigbang program of that size.

(define (main x)
  (clickcircle (make-world x "red" empty empty)))


;processworld :: world-> image
; processworld takes a world and turns it to an image.

(define (processworld world)
  (cond
    [(empty? (world-x world)) (empty-scene (world-width world)
                                      (world-width world))]
    [else (place-image (circle (* 10 (/ (world-width world) 100))
                               "solid"
                               (world-color world))
                       (world-x world)
                       (world-y world)
                       (empty-scene (world-width world)
                                    (world-width world)))]))
;mousehandler world ke x y -> world
;mouse handler takes a world, key event, and an x y position of the mouse and returns
; a world with a new circledrawn.

(define (mousehandler world x y me)
  (cond
    [(string=? "button-down" me)
     (make-world (world-width world) 
                 (world-color world)
                 x
                 y)]
    [else world]))

; ticker :: world->world
; ticker does not modify the world, but returns the same workd to satisfy the 
; big bang requirements.

(define (ticker world)
  (make-world (world-width world) 
              (world-color world)
              (world-x world)
              (world-y world)))

;clickcircle :: world -> bigbang 
; this is the main bigbang function

(define (clickcircle world)
  (big-bang world
            ;[on-tick tock]
            [on-mouse mousehandler]
            [to-draw processworld]))






