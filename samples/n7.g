- out succ 119 in

d<2>=(lambda (f) (lambda (x) ;; 関数fを2回適用
- (x f) out succ 119 in
        y=(f x) : 21
- y (x f) out succ 119 in
        (f y)  :31
ww WWw WWWw  v


- d<2> out succ 119 in

dd<2>=(lambda (f) (lambda (x) ;; 関数fを4回適用
- (x f) out succ 119 in
                g=(d f)  :3 2
- g (x f) out succ 119 in
                h=(d g)  :4 1
- h g (x f) out succ 119 in
                (h x)    :1 3
ww WWWww WWWWw Wwww  v


- dd d out succ 119 in

ddd<>=(lambda (f) (lambda (x) ;; 関数fを8回適用
- (x f) dd d out succ 119 in
                g=(dd f)  :3 2
- g (x f) dd d out succ 119 in
                h=(d g)  :5 1
- h g (x f) dd d out succ 119 in
                (h x)    :1 3
ww WWWww WWWWWw Wwww  v


- ddd dd d out succ 119 in

dddd<>=(lambda (f) (lambda (x) ;; 関数fを16回適用
- (x f) ddd dd d out succ 119 in
                g=(dd f)  :4 2
                h=(dd g)  :5 1
                (h x)    :1 3
ww WWWWww WWWWWw Wwww   v


- dddd ddd dd d out succ 119 in

p=(lambda (o s 119)
-: 119 s o | f
                                            (succ 119)= 2 1
                                            (out 1)   = 4 1

(lambda (x)
-: (x) dddd ddd dd d out succ 119 in
            j=(dddd succ) : 2 7
-: j (x) dddd ddd dd d out succ 119 in
            k=(ddd j) : 4 1
-: k j (x) dddd ddd dd d out succ 119 in
            y=(k 119) : 1 10
-: y k j (x) dddd ddd dd d out succ 119 in
            (out y) : 9 1
w
     WW ww ww ww w
  WW WW w
      W ww ww ww ww ww
      Vw
W WW WW WW WW w

