;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname lab7-c211-su15) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
(require 2htdp/image)

;; lab7
;; Dylan Clements

;; 1.
;; a fraction is a : (make-fraction number number)
(define-struct fraction [numerator denominator])

;; 2. 
;; fraction->number
;; takes a fraction and does something to it.
;; (define (fraction->number frac)
;;         (... (fraction-numerator frac) ... (fraction-denominator frac))

;; 3.
;; frac-multiply : fraction fraction -> int
;; frac-multiply takes fractions and multiplies them 
;; (define (frac-multiply frac1 frac2)
;;      (... (fraction-numerator frac1) .. (fraction-denominator frac2))

(define (frac-multiply frac1 frac2)
  (/(* (fraction-numerator frac1) (fraction-numerator frac2))
    (* (fraction-denominator frac1) (fraction-denominator frac2))))

(check-expect (frac-multiply (make-fraction 1 1) (make-fraction 1 1)) 1)
(check-expect (frac-multiply (make-fraction 1 2) (make-fraction 1 1)) .5)

;; frac-add : fraction fraction -> int
;; frac-add takes fractions and adds them 
;; (define (frac-multiply frac1 frac2)
;;      (... (fraction-numerator frac1) .. (fraction-denominator frac2))

(define (frac-add frac1 frac2)
  (/(+ (fraction-numerator frac1) (fraction-numerator frac2))
    (fraction-denominator frac2)))

(check-expect (frac-add (make-fraction 2 6) (make-fraction 3 6)) (/ 5 6))
(check-expect (frac-add (make-fraction 1 3) (make-fraction 1 3)) (/ 2 3))

;; 4. - 6.
;; a circle is a : (make-circles (make-posn x y) int)

(define-struct circles [posn size])

(define circle1 (make-circles (make-posn 5 6) 5))
(define circle2 (make-circles (make-posn 3 4) 8))

;; (define (circle-something circle)
;;       (.. (posn-x (circle-posn circle))
;;           (posn-y (circle-posn circle))
;;           (circle-size circle)))

;; circle-area : circle -> int
;; circle area returns the area of a given circle
;; (define (circle-area circle)
;;       (.. (posn-x (circle-posn circle))
;;           (posn-y (circle-posn circle))
;;           (circle-size circle)))

(define (circles-area circle)
  (* (* (circles-size circle) 
        (circles-size circle))
     3.14))


(check-expect (circles-area circle1) 78.5)
(check-expect (circles-area circle2) 200.96)

(define (draw-circles circles)
  (place-image
   (circle (circles-size circles) "solid" "red")
   (posn-x (circles-posn circles))
   (posn-y (circles-posn circles))
   (empty-scene 100 100)))



