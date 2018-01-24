;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |assignment 5|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
(require 2htdp/universe)
(require 2htdp/image)

; Homework 5 
; Dylan Clements 


; Problem 140

(define-struct layer [color doll])
; An RD is one of:
; - string
; - (make-layr String RD)

; colors :: RD -> string
; colors takes an RD and produces a string based on that RD that states 
; all of the colors of all the layers in that doll.

(define rd (make-layer "red" (make-layer "green" 
                                         (make-layer "green" 
                                                     (make-layer "blue" "red")))))
(rest (list (make-layer "red" (make-layer "blue" "green"))))
(check-expect (colors rd) "red, green, green, blue, red")

(define (colors rd)
  (cond
    [(string? (layer-doll rd)) 
     (string-append (layer-color rd)
                    (string-append ", " (layer-doll rd)))]
    [(layer? (layer-doll rd))
     (string-append (layer-color rd)
                    (string-append ", " (colors (layer-doll rd))))]))

;exercise 141

; inner :: RD -> string
; inner consumes an RD and produces the color of the inntermost doll

(check-expect (inner rd) "red")

(define (inner rd)
  (cond
    [(string? (layer-doll rd)) 
     (layer-doll rd)]
    [(layer? (layer-doll rd))
     (inner (layer-doll rd))]))

; exercise 4

(define-struct ManyNumbers [ls mn])

; ManyNumbers
; -empty
; -number
; -ManyNumbers

(define-struct ManyPairs [p mp])
;Manypairs
;-empty
;-pairs
;-manypairs

(define-struct pair [x y])

; pair
; - contains an x and y coordinate

; Exercise 5

; pairplot :: ManyPairs -> Image
; pairplot takes a list of ManyPairs and produces an image with all of the pairs plotted

(define lop1 (make-ManyPairs (make-pair 50 55) (make-ManyPairs (make-pair 50 10) (make-ManyPairs (make-pair 50 90) (make-pair 50 100))))) 

(define (place-dot-at x y z)
  (place-image (circle 10 "solid" "red") x y z))

(define (pairplot lop)
  (cond
    [(pair? (ManyPairs-mp lop)) (place-dot-at (pair-x (ManyPairs-p lop)) (pair-y (ManyPairs-p lop))
                                              (place-dot-at (pair-x (ManyPairs-mp lop)) (pair-y (ManyPairs-mp lop))
                                              (empty-scene 400 400)))]
    [else (place-dot-at (pair-x (ManyPairs-p lop)) (pair-y (ManyPairs-p lop)) (pairplot (ManyPairs-mp lop)))]))

; Exercise 6
; addpair :: NumX NumY Lop -> LoP
; addpair takes a list of pairs and extends it with a new pair

(check-expect (addpair 50 70 lop1) (make-ManyPairs
 (make-pair 50 70)
 (make-ManyPairs (make-pair 50 55) (make-ManyPairs (make-pair 50 10) (make-ManyPairs (make-pair 50 90) (make-pair 50 100))))))

(define (addpair x y lop)
  (make-ManyPairs (make-pair x y) lop))

; Exercise 7

; circlescene :: int -> bigbang
; circlescene takes an int and returns a big bang program that will place dots
; whenever you place click on the screen.

(define (circlescene x)
  (circlehelp lop3))


; had a bit of trouble getting this to work without feeding it a premade LoP,
; so I had to make a helpter that fed it this. The int that you call doesn't 
; do anything, but this is the only way I could get it to work...

(define (circlehelp pair)
  (big-bang pair
            [on-mouse mousehandler]
            [to-draw pairplot] 
            [state true]
            ))

(define (mousehandler world x y event)
  (if (string=? event "button-down") (addpair x y world) world))



(define lop3 (make-ManyPairs (make-pair -50 0) (make-pair -50 0)))