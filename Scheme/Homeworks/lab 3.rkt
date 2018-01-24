;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |lab 3|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
(require 2htdp/image)
(require 2htdp/universe)

; Lab 3 
; Dylan Clements 

; exercise 1

; The data definition makes the following functions:
; (make-photo)
; (make-3d)
; (photo-image)
; (photo-tag)
; (3d-x)
; (3d-y)
; (3d-z)

; exercise 2

(define-struct item (tag price))
; An Item is a structure:
;   (make-item String PositiveNumber)
 
(define-struct AI (name field pay-rate))
; An AI is (represented by) a structure:
;   (make-AI String Field PositiveNumber)
; A Field is one of:
; – "biology"
; – "english"
; – "computer science"
; - "business"

(define eggs (make-item "eggs" 3))
(define bread (make-item "bread" 2))
(define Steve (make-AI "Steve" "biology" 10))
(define Roger (make-AI "Roger" "computer science" 12))

; exercise 3

(define-struct cat [name species age feedtime])
; -a name is a string

; A species is one of:
; --"tiger"
; --"lion"
; -- "ocelot"
; -- "leopard"

; -an age is a positive int
; -a feedtime is a positive int

(define babou (make-cat "Babou" "ocelot" 5 1230))

; exercise 4

; processitems :: Items -> int
; process int takes an item and and a number and 
; returns the cost of that item in the quantity if the number.


;(define (processitems item num)
;  (*... (Items-price item) ... num ))

; exercise 5

; ai-info :: AI -> string
; ai-info takes an AI and returns a string listing their information.

;(define (ai-info ai)
;  (... (string-append ... (AI-name ai) ... (AI-field) ... (AI-payrate))))

; exercise 6

; catinfo :: cat -> string
; catinfo takes a cat and returns a string of all of the info you need 
; to know about that cat.

;(define (catinfo cat)
;  (... (string-append ... (cat-name cat) ... (cat-species cat) ... 
;                      (cat-age cat) ... (cat-feedtime cat))))


; exercise 7

; pay-raise :: AI num -> AI
; pay-raise takes an AI and a number and returns a new AI with a new payrate
; that is multiplied by that number (must be a good AI).
(check-expect (pay-raise Roger 3) (make-AI "Roger" "computer science" 36))

(define (pay-raise ai num)
  (make-AI (AI-name ai) (AI-field ai) (* num (AI-pay-rate ai))))

; exercise 8

; bonus :: AI -> AI
; bonus takes an AI and produces an AI with a pay-rate which is twice the pay rate
; if the AI is in English or Biology, three times the pay rate if the AI is in Business,
; and four times the pay rate if the AI is in computer science (maybe a little conceited..).

(check-expect (bonus Roger) (make-AI "Roger" "computer science" 48))

(define (bonus ai)
  (cond
    [(or (string=? (AI-field ai) "biology") 
         (string=? (AI-field ai) "english"))
         (make-AI (AI-name ai) (AI-field ai) (* 2 (AI-pay-rate ai)))]
    [(string=? (AI-field ai) "business")
         (make-AI (AI-name ai) (AI-field ai) (* 3 (AI-pay-rate ai)))]
    [(string=? (AI-field ai) "computer science")
         (make-AI (AI-name ai) (AI-field ai) (* 4 (AI-pay-rate ai)))]))

; exercise 9

(define-struct Shape [ type size color x y])
; A type is one of:
; -"box"
; -"pointy shape"
; -"round shape"

; A color is one of:
; - "red"
; - "green"
; - "blue"

(define circle1 (make-Shape "round shape" 10 "red" 50 50))
(define triangle1 (make-Shape "pointy shape" 15 "green" 30 30))
(define square1 (make-Shape "box" 20 "blue" 10 10))

; exercise 10

; shape-pic :: Shape -> image
; shape-pic takes a shape and produces an image where that shape has been
; drawn on a white background

(define (shape-pic shape)
  (cond
    [(string=? (Shape-type shape) "round shape")
     (place-image 
      (circle (Shape-size shape) "solid" (Shape-color shape))
      (Shape-x shape)
      (Shape-y shape)
      (empty-scene 100 100))]
    [(string=? (Shape-type shape) "pointy shape")
     (place-image 
      (triangle (Shape-size shape) "solid" (Shape-color shape))
      (Shape-x shape)
      (Shape-y shape)
      (empty-scene 100 100))]
    [(string=? (Shape-type shape) "box")
     (place-image 
      (square (Shape-size shape) "solid" (Shape-color shape))
      (Shape-x shape)
      (Shape-y shape)
      (empty-scene 100 100))]))

; exercise 11

; move-shape :: Shape -> image
; move-shape takes a shape and moves that shape 5 to the right on the x axis

(check-expect (move-shape circle1) (make-Shape "round shape" 10 "red" 55 50))

(define (move-shape shape)
  (make-Shape (Shape-type shape)
              (Shape-size shape)
              (Shape-color shape)
              (+ (Shape-x shape) 5)
              (Shape-y shape)))

; exercise 12

; shapescene :: Shape -> moving scene
; shapescene takes a shape and moves it across the scene.

(define (stop? shape)
  (= (Shape-x shape) (+ 100 (Shape-size shape))))

(define (shapescene shape)
  (big-bang shape
            [on-tick move-shape]
            [to-draw shape-pic]
            [stop-when stop?]
            
            ))
            


















