;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname assignment3-c211-su15) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
;; Assignment 3
;; Dylan Clements


;; A Language is a :
;; - "Spanish"
;; - "English"
;; - "Portugese"
;; ...more

;; A ListOfLanguages is a :
;; (cons Language empty)


(define lol1 (cons "Portugese" (cons "Spanish" (cons "Greek" empty))))

(define lol2 (cons "Hungarian" empty))

(define lol3 (cons "Hungarian" (cons "Greek" (cons "Polish" (cons "Spanish" empty)))))

;; is-Spanish? :: Language -> Boolean
;; is-Spanish? takes a Language (string) and returns true if that language
;; happens to be spanish.
;; (define (is-Spanish? language)
;;    (equal? language "Spanish") ...))

(define (is-Spanish? language)
  (equal? "Spanish" language))

(check-expect (is-Spanish? "Spanish") true)
(check-expect (is-Spanish? "Aragonese") false)


;; enough-languages? :: ListOfLanguages ->  boolean
;; enough-languages? takes a ListOfLanguages and returns a boolean if
;; that ListOfLanguages is longer than 3.
;; (define (enough-languages? LoL)
;;       (>= (count-languages lol) ...)))

(define (enough-languages? LoL)
  (>= (count-languages LoL) 3))

(check-expect (enough-languages? lol1) true)
(check-expect (enough-languages? (cons "Portugese" empty)) false)


;; count-languages :: ListOfLanguage -> int
;; count-languages takes a ListOfLanguage and counts the number of languages within
;; that LoL
;; (define (enough-languages LoL)
;;    (cond
;;       [(empty? (first LoL)) ...]
;;       [else ... (enough-languages? (rest lol))])))

(define (count-languages LoL)
  (cond
    [(empty? (rest LoL)) 1]
    [else (+ 1 (count-languages (rest LoL)))]))

(check-expect (count-languages lol1) 3)
(check-expect (count-languages (list "Spanish")) 1)


;; remove-spanish :: ListOfLanguage -> ListOfLanguage
;; remove-spanish takes a ListOfLanguage and produces a new ListOfLanguage based
;; on that list and removing "Spanish"
;; (define (remove-spanish LoL)
;;    (cond
;;       [(empty? (rest LoL)) ...]
;;       [(equal? (first LoL) "Spanish") ...]
;;       [else ... (remove-spanish (rest LoL))])))

(define (remove-spanish LoL) 
  (cond
    [(empty? (rest LoL)) (if (equal? (first LoL) "Spanish")
                             empty
                             LoL)]
    [(equal? (first LoL) "Spanish") (remove-spanish (rest LoL))]
    [else (cons (first LoL) (remove-spanish (rest LoL)))]))

(check-expect (remove-spanish lol1) (list "Portugese" "Greek"))
(check-expect (remove-spanish lol3) (list "Hungarian" "Greek" "Polish"))



;; a DayTrip is one of:
;; -guided
;; -unguided

;; a destination is one of:
;; -"Lille"
;; -"Maastricht"
;; -"Monschau"
;; ...more

;; a guided is a (make-guided destination int int int)

(define-struct guided [destination train-hours guide-hours admission-tokens])

;; an unguided is a (make-unguided destination int)
(define-struct unguided [destination car-hours])

(define lille (make-guided "Lille" 1 6 20))

(define maastricht (make-guided "Maastricht" 3 4 15))

(define monschau (make-unguided "Monschau" 4))



;; total-cost :: DayTrip -> number
;; total coast tales a DayTrip and returns the total cost of the day trip
;; (define (total-cost dt)
;;    (cond
;;      [(guided? dt) ...(guided-train-hours dt) ..(guided-guide-hours dt)
;;                        (guided-admission-tokens dt)]
;;      [else ... (unguided-car-hours dt)])))

(define (total-cost dt)
    (cond
      [(guided? dt) (+ (* (guided-train-hours dt) 3.25)
                       (* (guided-guide-hours dt) 4.25)
                       (* (guided-admission-tokens dt) 2.75))]
      [else (* (unguided-car-hours dt) 1.75)]))

(check-expect (total-cost lille) 83.75)
(check-expect (total-cost maastricht) 68)
(check-expect (total-cost monschau) 7)

;; new data definition for a DayTrip

;; a DayTrip is one of:
;; -guided
;; -unguided
;; -special

;; a special is a (make-special destination fee int)

;; a fee is a:
;; -flat-rate fee (25)

(define-struct special [destination fee heli-min])

(define luxembourg (make-special "Luxembourg" 25 90))


;; total-cost-modified :: DayTrip -> number
;; total-cost-modified takes a DayTrip and returns the total cost of the day trip
;; (define (total-cost-modified dt)
;;    (cond
;;      [(guided? dt) ...(guided-train-hours dt) ..(guided-guide-hours dt)
;;                        (guided-admission-tokens dt)]
;;      [(special? dt) ... (special-fee dt) (special-heli-min dt)]
;;      [else ... (unguided-car-hours dt)])))

(define (total-cost-modified dt)
    (cond
      [(guided? dt) (+ (* (guided-train-hours dt) 3.25)
                       (* (guided-guide-hours dt) 4.25)
                       (* (guided-admission-tokens dt) 2.75))]
      [(special? dt) (+ (* (/ (special-heli-min dt) 30) 10)
                        (special-fee dt))]
      [else (* (unguided-car-hours dt) 1.75)]))

(check-expect (total-cost-modified luxembourg) 55)

;; register-runner : runner ListOfRunner -> ListOfRunner
;; register-runner takes a runner and returns a ListOfRuner with the 
;; new runner at the end
;;(define (register-runner runner LoR)
;;  (cond
;;   [(empty? (rest LoR)) ...]
;;    [else ... (first LoR) (register-runner (rest LoR))]))

(define (register-runner runner LoR)
  (cond
    [(empty? LoR) (cons runner empty)]
    [else (cons (first LoR) (register-runner runner (rest LoR)))]))

(check-expect (register-runner "schackb" empty)
(list "schackb"))
(check-expect (register-runner "samth" (list "earldean" "eeleonha"))
(list "earldean" "eeleonha" "samth"))

(check-expect (register-runner "smith" (list "sam" "sarah" "solo"))
              (list "sam" "sarah" "solo" "smith"))


;; Cambiar : ListOfRunner -> ListOfRunner
;; Cambiar takes a ListOfRunner and returns that LoR in reverse
;; (define (cambiar LoR)
;;    (cond
;;      [(empty? LoR) ...]
;;      [else (register-runner ... (cambiar(rest LoR)))])))

(define (cambiar LoR)
  (cond
    [(empty? LoR) empty]
    [else (register-runner (first LoR) (cambiar (rest LoR))) ]))

(check-expect (cambiar empty) empty)
(check-expect (cambiar (list "earldean" "eeleonha" "samth"))
(list "samth" "eeleonha" "earldean"))

(check-expect (cambiar (list "sam" "sarah" "solo" "smith"))
              (list "smith" "solo" "sarah" "sam"))





