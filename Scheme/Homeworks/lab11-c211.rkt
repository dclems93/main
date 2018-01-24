;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname lab11-c211-su15) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
;; lab11
;; Dylan Clements

;; exercise 166;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;1
(check-expect (cons "a" (cons "b" (cons "c" (cons "d" (cons "e" '())))))
              (list "a" "b" "c" "d" "e"))

;2
(check-expect (cons (cons 1 (cons 2 '())) '())
              (list (list 1 2)))
;3
(check-expect (cons "a" (cons (cons 1 '()) (cons #false '())))
              (list "a" (list 1) false))
;4
(check-expect (cons (cons 1 (cons 2 '())) (cons (cons 2 '()) '()))
              (list (list 1 2) (list 2)))
;5
(check-expect (cons (cons "a" (cons 2 '())) (cons "hello" '()))
              (list (list "a" 2) "hello"))

;; exercise 167;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; 1
(check-expect (list 0 1 2 3 4 5)
              (cons 0 (cons 1 (cons 2 (cons 3 (cons 4 (cons 5 '())))))))

; 2
(check-expect (list (list "adam" 0) (list "eve" 1) (list "louisXIV" 2))
              (cons 
               (cons "adam" (cons 0 '())) 
               (cons (cons "eve" (cons 1 '())) 
                     (cons 
                      (cons "louisXIV" 
                                 (cons 2 '()))
                      '()))))
; 3
(check-expect (list 1 (list 1 2) (list 1 2 3))
              (cons 1 
                    (cons 
                     (cons 1 (cons 2 '())) 
                     (cons (cons 1 (cons 2 (cons 3 '()))) '()))))

;; exercise 168;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; 1
(check-expect (cons "a" (list 0 #false))
              (cons "a" (cons 0 (cons false '()))))

; 2
(check-expect (list (cons 1 (cons 13 '())))
              (cons (cons 1 (cons 13 '())) '()))
;3
(check-expect (cons (list 1 (list 13 '())) '())
              (cons 
               (cons
                1
                (cons 
                 (cons 13 (cons '() '()))
                 '()))
               '()))

; 4
(check-expect (list '() '() (cons 1 '()))
              (cons '() 
                    (cons '() 
                          (cons 
                           (cons 1 '())
                           '()))))

; 5 
(check-expect (cons "a" (cons (list 1) (list #false '())))
              (cons "a"
                    (cons
                     (cons 1 '())
                     (cons  false (cons '() '())))))

;; exercise 169 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; 1
(check-expect (list (string=? "a" "b") (string=? "c" "c") #false)
              (cons false (cons true (cons false '()))))

; 2
(check-expect (list (+ 10 20) (* 10 20) (/ 10 20))
              (cons 30 (cons 200 (cons .5 empty))))

; 3

(check-expect (list "dana" "jane" "mary" "laura")
              (cons "dana" (cons "jane" (cons "mary" (cons "laura" '())))))

;; exercise 170 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;1
(check-expect (first (list 1 2 3))
              1)

;2
(check-expect (rest (list 1 2 3))
              (list 2 3))

;3
(check-expect (second (list 1 2 3))
              2)

;; exercise 171 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; I'm not sure what this problem wants me to do... 




                         

;; A ListOfNumber is one of:
;; - empty
;; - (cons Number ListOfNumber)

;; remove-given : ListOfNumber number -> ListOfNumber
;; remove-given removes a number from a ListOfNumber
;;(define (remove-given lon num)
;;  (cond
;;    [(empty? lon) ...]
;;    [(= (first lon) num) ...]
;;    [else (cons (first lon) ...)]))

(define (remove-given lon num)
  (cond
    [(empty? lon) empty]
    [(= (first lon) num) (remove-given (rest lon) num)]
    [else (cons (first lon) (remove-given (rest lon) num) )]))

(check-expect (remove-given (list 1 2 3 4 5) 5) (list 1 2 3 4))
(check-expect (remove-given (list 2 3 4) 2) (list 3 4))
(check-expect (remove-given (list 1) 1) empty)


;; add-n-all : ListOfNumber number -> ListOfNumber
;; add-n-all adds a number to every element in a ListOfNumber
;;(define (add-n-all lon num)
;;  (cond
;;    [(empty? lon) ...]
;;    [else (cons (+ num (first lon)) ...)]))


(define (add-n-all lon num)
  (cond
    [(empty? lon) empty]
    [else (cons (+ num (first lon)) (add-n-all (rest lon) num))]))

(check-expect (add-n-all (list 1 2 3 4 5) 1) (list 2 3 4 5 6))
(check-expect (add-n-all (list 12 13 14) 4) (list 16 17 18))