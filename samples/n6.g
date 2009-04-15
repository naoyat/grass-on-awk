
- out succ 119 in

+2=(lambda (x)
-:  (x) out succ 119 in
		y=(succ x)  3 1
-:  y (x) out succ 119 in
		z=(succ y)  4 1
wWWWwWWWWw  v

- +2 out succ 119 in

+3=(lambda (x)
-:  (x) +2 out succ 119 in
		y=(succ x)  4 1
-:  y (x) +2 out succ 119 in
		z=(+2 y)    3 1
wWWWWwWWWw  v

- +3 +2 out succ 119 in

+5=(lambda (x)
-:  (x) +3 +2 out succ 119 in
		y=(+2 x)   3 1
-:  y (x) +3 +2 out succ 119 in
		z=(+3 y)   3 1
wWWWwWWWw  v

- +5 +3 +2 out succ 119 in

+8=(lambda (x)
-:  (x) +5 +3 +2 out succ 119 in
		y=(+3 x)   3 1
-:  y (x) +5 +3 +2 out succ 119 in
		z=(+5 y)   3 1
wWWWwWWWw  v

- +8 +5 +3 +2 out succ 119 in

+13=(lambda (x)
-:  (x) +8 +5 +3 +2 out succ 119 in
		y=(+5 x)   3 1
-:  y (x) +8 +5 +3 +2 out succ 119 in
		z=(+8 y)   3 1
wWWWwWWWw  v

- +13 +8 +5 +3 +2 out succ 119 in

f^2=(lambda (f x)
-: x f +13 +8 +5 +3 +2 out succ 119 in
        y=(f x)   2 1
-: y x f +13 +8 +5 +3 +2 out succ 119 in
        (f y)     3 1
ww WWw WWWw  v

- f^2 +13 +8 +5 +3 +2 out succ 119 in

f^4=(lambda (f x)
-: x f f^2 +13 +8 +5 +3 +2 out succ 119 in
        F=(f^2 f)    3 1
-: F x f f^2 +13 +8 +5 +3 +2 out succ 119 in
        G=(f^2 F)    4 1
-: G F x f f^2 +13 +8 +5 +3 +2 out succ 119 in
        a=(G x)      1 3
ww WWWw WWWWw Wwww  v

-----
- f^4 f^2 +13 +8 +5 +3 +2 out succ 119 in

F=(lambda (x)
#-: x f^4 f^2 +13 +8 +5 +3 +2 out succ 119 in
#//		a=((f^4 +13) x):
#        C=(f^4 f^4)  2 2
-: x f^4 f^2 +13 +8 +5 +3 +2 out succ 119 in
		D=(f^4 +13)    2 4
-: D C x f^4 f^2, +13 +8 +5 +3 +2, out succ 119 in
        y=(D x)      1 3
w WWwwww WWwww  v

- F f^4 f^2 +13 +8 +5 +3 +2 out succ 119 in

(lambda (x)
-: x F f^4 f^2 +13, +8 +5 +3 +2 out, succ 119 in
		y=(F succ)  2 11
-: y x F f^4 f^2, +13 +8 +5 +3 +2, out succ 119 in
        z=(y 119) ; 1 13
-: z y x F f^4, f^2 +13 +8 +5 +3, +2 out succ 119 in
		(out z)  ; 12 1
w
WW wwwww.wwwww.w
W wwwww.wwwww.www
Vw
WWWWW.WWWWW.WW w
