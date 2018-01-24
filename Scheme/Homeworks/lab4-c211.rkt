;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname lab4-c211-su15) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
;; Lab Four
;; Dylan Clements


;;leapyear :: int -> boolean
;;leapyear takes a year (int) and returns true if that int is a leap year
;;(leapyear 1580)-> true
;;(leapyear 1581 -> false
;;(leapyear 2400 -> true

(define (leapyearif year)
  (if(integer? (/ year 4))
     (if (> year 1582)
         (if(integer? (/ year 100))
            (if (integer? (/ year 400))
                true
                false)
            true)
         true)
     false))

(define (leapyearcond year)
  (cond
    [(and (< year 1582) (integer? (/ year 4))) true]
    [(and (integer? (/ year 4)) (not (integer? (/ year 100)))) true]
    [(and (integer? (/ year 4)) (integer? (/ year 400))) true]
    [else false]))

(check-expect (leapyearif 1580) true)
(check-expect (leapyearif 1581) false)
(check-expect (leapyearif 1900) false)

(check-expect (leapyearcond 1580) true)
(check-expect (leapyearcond 1581) false)
(check-expect (leapyearcond 1900) false)



;; letter-translate : String -> int
;; letter translate takes a string that is a letter grade and 
;; converts that letter grade into a numerical form
;; (letter-translate "A") -> 4.0



(check-expect (letter-translate "A") 4.0)
(check-expect (letter-translate "B-") 2.7)
(check-expect (letter-translate "F") 0.0)




(define (letter-translate grade)
  (cond
    [(equal? grade "A+") 4.0]
    [(equal? grade "A") 4.0]
    [(equal? grade "A-") 3.7]
    [(equal? grade "B+") 3.3]
    [(equal? grade "B") 3.0]
    [(equal? grade "B-") 2.7]
    [(equal? grade "C+") 2.3]
    [(equal? grade "C") 2.0]
    [(equal? grade "C-") 1.7]
    [(equal? grade "D+") 1.3]
    [(equal? grade "D") 1.0]
    [(equal? grade "D-") 0.7]
    [(equal? grade "F") 0.0]))


;; number-convert : int -> string
;; number convert converts a numerical data form of a grade
;; and converts it to the nearest letter grade for that number
;; (number-convert 3.8) -> "A"

(check-expect (number-convert 4.0) "A")
(check-expect (number-convert 2.85) "B")
(check-expect (number-convert 1.3) "D+")


(define (number-convert grade)
  (cond
    [(>= grade 3.65) "A"]
    [(>= grade 3.45) "A-"]
    [(>= grade 3.15) "B+"]
    [(>= grade 2.85) "B"]
    [(>= grade 2.45) "B-"]
    [(>= grade 2.15) "C+"]
    [(>= grade 1.85) "C"]
    [(>= grade 1.45) "C-"]
    [(>= grade 1.15) "D+"]
    [(>= grade 0.85) "D"]
    [(>= grade 0.45) "D-"]
    [else "F"]))



    



