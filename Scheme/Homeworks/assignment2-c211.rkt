;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname assignment2-c211-su15) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
(require 2htdp/universe)
(require 2htdp/image)

; Assignment 2
; Dylan Clements 

; Exercise 140

(define-struct layer [color doll])

; An RD is one of:
; - string
; - (make-layer String RD)

(define rd1 (make-layer "red" (make-layer "blue" 
                                         (make-layer "orange" 
                                                     (make-layer "red" "red")))))

(define rd2 (make-layer "red" (make-layer "green" 
                                         (make-layer "green" 
                                                     (make-layer "blue" (make-layer "red" "purple"))))))


; colors :: RD -> string
; colors takes an RD and produces a string that contains
; all of the colors ofthe layers within that doll.
; (define (colors rd)
;   (cond
;      [(string? (layer-doll rd)) ..]
;      [(layer? (layer-doll rd)) ...(colors (layer-doll rd))]))


(check-expect (colors rd1) "red, blue, orange, red, red")
(check-expect (colors rd2) "red, green, green, blue, red, purple")

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
; (define (inner rd)
;    (cond
;      [(string? (layer-doll rd)) ...]
;      [(layer? (layer-doll rd)) ... 
;         (inner (layer-doll rd))])))

(check-expect (inner rd1) "red")
(check-expect (inner rd2) "purple")

(define (inner rd)
  (cond
    [(string? (layer-doll rd)) 
     (layer-doll rd)]
    [(layer? (layer-doll rd))
     (inner (layer-doll rd))]))
