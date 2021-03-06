
(in-package :kenzo-test)

(in-suite :kenzo)

(defun ccn ()
  (the cat:chain-complex
       (cat:build-chcm
	:cmpr #'cat:f-cmpr
	:basis #'(lambda (n)
		   (cat:<a-b< (* 10 n) (* 10 (1+ n))))
	:bsgn 0
	:intr-dffr #'(lambda (dgr gnr)
		       (if (evenp (+ dgr gnr))
			   (cat:cmbn (1- dgr) 1 (- gnr 10))
			   (cat:cmbn (1- dgr))))
	:strt :gnrt
	:orgn '(ccn))))


(test ccn
      (progn
	(cat:cat-init)
	(let* ((ccn (ccn))
	       (upper-shift (cat:build-mrph
			     :sorc ccn :trgt ccn :strt :gnrt :degr 1
			     :intr #'(lambda (d gn) (cat:cmbn (1+ d)
							      1 (+ gn 10)))
			     :orgn '(ccn shift +10)))
	       (lower-shift (cat:build-mrph
			     :sorc ccn :trgt ccn :strt :gnrt :degr -1
			     :intr #'(lambda (d gn) (cat:cmbn (1- d)
							      1 (- gn 10)))
			     :orgn '(ccn shift -10)))
	       (comb1 (cat:? ccn 2 22))
	       (combn (cat:cmbn 5 1 50 5 55 9 59))
	       (d-combn (cat:? ccn combn))
	       (dd-combn (cat:? ccn d-combn))
	       (comb2 (cat:? upper-shift 0 6))
	       (comb3 (cat:? lower-shift 5 51))
	       (comb4 (cat:? lower-shift comb3))
	       (identity? (cat:cmps upper-shift lower-shift))
	       (comb5 (cat:cmbn 1 1 10 2 11 3 12 4 13))
	       (comb6 (cat:? identity? comb5))
	       (comb7 (cat:2cmbn-sbtr (cat:cmpr ccn) comb5 comb6))
	       (upper2-shift (cat:cmps upper-shift upper-shift))
	       (comb8 (cat:? upper2-shift comb5))
	       (twice-up-shift (cat:add upper-shift upper-shift))
	       (comb9 (cat:? twice-up-shift comb5))
	       (up-d (cat:cmps upper-shift (cat:dffr1 ccn)))
	       (d-up (cat:cmps (cat:dffr1 ccn) upper-shift))
	       (comb10 (cat:? up-d 1 11))
	       (comb11 (cat:? d-up 1 11))
	       (comb12 (cat:cmbn 1 1 10 2 11 3 12 4 13 5 14 6 15))
	       (comb13 (cat:? up-d comb12))
	       (comb14 (cat:? d-up comb12))
	       )
	  (is (equal (cat:cmbn-degr comb1) 1))
	  (is (equal (cat:cmbn-list comb1) '((1 . 12))))
	  (is (null (cat:cmbn-non-zero-p (cat:? ccn comb1))))
	  (is (equal (cat:cmbn-degr d-combn) 4))
	  (is (equal (cat:cmbn-list d-combn) '((5 . 45) (9 . 49))))
	  (is (equal (cat:cmbn-degr dd-combn) 3))
	  (is (equal (cat:cmbn-list dd-combn) nil))
	  (is (equal (cat:cmbn-degr comb2) 1))
	  (is (equal (cat:cmbn-list comb2) '((1 . 16))))
	  (is (equal (cat:cmbn-degr comb3) 4))
	  (is (equal (cat:cmbn-list comb3) '((1 . 41))))
	  (is (equal (cat:cmbn-degr comb4) 3))
	  (is (equal (cat:cmbn-list comb4) '((1 . 31))))
	  (is (equal (cat:degr identity?) 0))
	  (is (equal (cat:cmbn-degr comb6) 1))
	  (is (equal (cat:cmbn-list comb6) '((1 . 10) (2 . 11) (3 . 12)
					     (4 . 13))))
	  (is (equal (cat:cmbn-degr comb7) 1))
	  (is (equal (cat:cmbn-list comb7) nil))
	  (is (equal (cat:degr upper2-shift) 2))
	  (is (equal (cat:cmbn-degr comb8) 3))
	  (is (equal (cat:cmbn-list comb8) '((1 . 30) (2 . 31) (3 . 32)
					     (4 . 33))))
	  (is (equal (cat:degr twice-up-shift) 1))
	  (is (equal (cat:cmbn-degr comb9) 2))
	  (is (equal (cat:cmbn-list comb9) '((2 . 20) (4 . 21) (6 . 22)
					     (8 . 23))))
	  (is (equal (cat:cmbn-degr comb10) 1))
	  (is (equal (cat:cmbn-list comb10) '((1 . 11))))
	  (is (equal (cat:cmbn-degr comb11) 1))
	  (is (equal (cat:cmbn-list comb11) nil))
	  (is (equal (cat:cmbn-degr comb13) 1))
	  (is (equal (cat:cmbn-list comb13) '((2 . 11) (4 . 13) (6 . 15))))
	  (is (equal (cat:cmbn-degr comb14) 1))
	  (is (equal (cat:cmbn-list comb14) '((1 . 10) (3 . 12) (5 . 14)))))))
