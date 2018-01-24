;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname lab12-c211-su15) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
;; lab12
;; Dylan Clements



;; a ListOfBoolean is a (cons boolean ListOfBoolean)
;; a boolean is one of:
;; -boolean
;; -empty

(define lob (cons true (cons true (cons true empty))))
(define lob2 (cons true (cons false (cons true empty))))


;; all-true? : ListOfBoolean -> boolean
;; all-true? takes a list of boolean and returns true of 
;; all of the elements in the list are true. otherwise false.
;; (define (all-true? ls)
;;    (.. (andmap ... ls) ..)) 

(define (all-true? ls)
  (andmap (lambda (x) (not (false? x))) ls))
(check-expect (all-true? lob) true)
(check-expect (all-true? lob2) false)

;; a ManyNumber is a (cons number ManyNumber)
;; a number is one of:
;; -number
;; -empty

;; filter-even : manynumber -> manynumber
;; filter takes a manynumber and returns a manynumber of all of the even
;; numbers withing the manynumber
;; (define (filter-even mn)
;;    (... (filter ... mn ) ..))

(define mn1 (cons 1 (cons 2 (cons 3 (cons 4 empty)))))
(define mn2 (cons 4 (cons 6 (cons 8 (cons 10 empty)))))

(define (filter-even mn)
  (filter even? mn))

(check-expect (filter-even mn1) (list 2 4))
(check-expect (filter-even mn2) mn2)

;; add-n-all : int manynumber -> manynumber
;; add-n-all tales a number and a manynumber and returns a manynumber
;; with the number added to every element.
;; (define (add-n-all mn)
;;    (... (map ... mn ) ..))

(define (add-n-all num mn)
  (map (lambda (x) (+ num x)) mn))

(check-expect (add-n-all 3 mn1) (list 4 5 6 7))
(check-expect (add-n-all 1 mn2) (list 5 7 9 11))