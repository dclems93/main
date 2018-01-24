;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Lab2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
;Problem 1 

(define (solutionOne b1)
  (and (false? b1) (not (false? b1))))
 
(define (solutionTwo b1)
   false)


(check-expect (solutionOne true)  (solutionTwo true))
(check-expect (solutionOne false) (solutionTwo false))


;Problem 2
 

(define (solutionThree b1)
  (and b1 true))
 
(define (solutionFour b1)
   (if (false? b1) false true))


(check-expect (solutionFour true)  (solutionThree true))
(check-expect (solutionFour false) (solutionThree false))

;Problem 3 

(define (solutionFive b1)
  (and b1 false))
 
(define (solutionSix b1)
   false)


(check-expect (solutionSix true)  (solutionFive true))
(check-expect (solutionSix false) (solutionFive false))

;Problem 4 

(define (solutionSeven b1)
  (false? b1))
 
(define (solutionEight b1)
   (not b1))


(check-expect (solutionEight true)  (solutionSeven true))
(check-expect (solutionEight false) (solutionSeven false))


;Problem 5 

(define (solutionNine b1)
  (if b1 false true))
 
(define (solutionTen b1)
   (not b1))


(check-expect (solutionTen true)  (solutionNine true))
(check-expect (solutionTen false) (solutionNine false))

;Problem 6 

(define (solutionEleven b1)
  (or (not b1) b1))
 
(define (solutionTwelve b1)
   true)


(check-expect (solutionTwelve true)  (solutionEleven true))
(check-expect (solutionTwelve false) (solutionEleven false))


;Problem 7 

(define (solutionThrtn b1)
  (or b1 true))
 
(define (solutionFrtn b1)
   true)


(check-expect (solutionFrtn true)  (solutionThrtn true))
(check-expect (solutionFrtn false) (solutionThrtn false))

;Problem 8 

(define (solutionFtn b1)
  (or b1 false))
 
(define (solutionStn b1)
   (not (false? b1)))


(check-expect (solutionStn true)  (solutionFtn true))
(check-expect (solutionStn false) (solutionFtn false))

;Problem 9 

;(define (solutionFtn b1)
 ; (or b1 false))
 
;(define (solutionStn b1)
 ;  (not (false? b1)))


;(check-expect (solutionStn true)  (solutionFtn true))
;(check-expect (solutionStn false) (solutionFtn false))









