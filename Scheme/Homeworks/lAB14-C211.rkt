;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname lAB14-C211-su15) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
(define (generate size low high)
  (make-list size (lambda (x) (+ (random (- high low)) low))))

;; prob 213

;; the data definition for nested was easily abstracted to one definition.

; A layer is a (make-layer nested)
(define-struct layer [nested])

; A Nested-string is one of: 
; – String
; – (make-layer Nested-string)

(define nesstring (make-layer "this"))
(check-expect (layer-nested nesstring) "this")
     
; A Nested-number is one of: 
; – Number
; – (make-layer Nested-number)

(define nesnum (make-layer 55))
(check-expect (layer-nested nesnum) 55)

;; prob 214

; A NEList-of-temperatures is one of: 
; – (cons CTemperature '())
; – (cons CTemperature NEList-of-temperatures)
; interpretation non-empty lists of measured temperatures 

; A NEList-of-Booleans is one of:
; - (cons Boolean empty)
; - (cons Boolean NEList-of-Booleans

; both of these data definitions contain one element cons-ed to another
; element, meaning they can be abstracted easily into one data definition
; as the actual datatype is irrelivant in SCHEME

;  A NEList-of is one of:
; (cons data empty)
; (cons data NEList-of)



; prob 216

; A [Maybe String] is one of: 
; – #false 
; – string

; A [Maybe [List-of String]] is one of:
; - false
; - (cons String ListOfString)
; - (cons String empty)

; A [List-of [Maybe String]] is one of:
; - (cons false [List-of [Maybe String]])
; - (cons string [List-of [Maybe String]])


; occurs :; String [List-of String] -> [Maybe [List-of String]]
; returns the remainder of the list los if it contains s 
; #false otherwise 
; (define (occurs str los)
;     (cond
;        [(empty? los) ...]
;        [(equal? (car los) str) ...]
;        [ else ... ]))

(define (occurs str los)
  (cond
    [(empty? los) false]
    [(equal? (car los) str) (cdr los)]
    [else (occurs str (cdr los))]))

(check-expect (occurs "a" (list "a" "b" "c" "d")) (list "b" "c" "d"))
(check-expect (occurs "r" (list "a" "b" "r")) empty)

; prob 220


 

; tab : Number proc -> [List-of Number]
; tabulates a procedure between n 
; and 0 (inclusive) in a list
;(define (tab proc n)
;  (cond
;    [(= n 0) (list ...)]
;    [else
;     (cons ...
;           (tab proc (sub1 n)))]))
   

(define (tab proc n)
  (cond
    [(= n 0) (list (proc 0))]
    [else
     (cons (proc n)
           (tab proc (sub1 n)))]))

; this function will already work with tan and sqr

 (check-expect (tab sqr 5) (list 25 16 9 4 1 0))
 (check-within (tab tan 5) (list
 #i-3.380515006246586
 #i1.1578212823495777
 #i-0.1425465430742778
 #i-2.185039863261519
 #i1.5574077246549023
 0) .02)
 
 ; prob 221
 
 ; foldl : proc [List-of Number] -> Number
; computes the given procedure of 
; the numbers on l 
(define (fold1 proc l)
  (cond
    [(empty? l) 1]
    [else
     (proc (first l)
        (fold1 proc (rest l)))]))

 

