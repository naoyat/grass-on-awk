- out succ 119 in

+3(x)
  (succ x)
  (succ 1)
  (succ 1)

+3(w): WWWw WWWWw WWWWWw  //v

- +3 out succ 119 in

qt( f x )
-: x f ...
  y=(f x)
-: y x f ...
  z=(f y)
-: z y x f ...
  a=(f z)
-: a z y x f ...
  (f a)
<2> 21 31 41 51

qt(ww): WWw WWWw WWWWw WWWWWw //v

- qt +3 out succ 119 in

ch1(ww): WWw WWWw //v
  (21) (31)

- ch1 qt +3 out succ 119 in

ch2(ww): WWWwww Wwwww Wwww www www Wwwwww //v
        (x y) : 
-: y x ch1 qt +3, out succ 119 in
        z=(ch1 ch1) : 3 3
-: z y x ch1 qt, +3 out succ 119 in
        a=(z ch1) : 1 4
-: a z y x ch1, qt +3 out succ 119, in
        b=(a succ) : 1 9
-: b a z y x, ch1 qt +3 out succ, 119 in
        (b x) : 1 5

- ch2 ch1 qt +3 out succ 119 in

+16(x)
-: x ch2 ch1 qt +3 out succ 119 in
    ch3=ch2(x) : 21
-: ch3 x ch2 ch1 qt +3 out succ 119 in
    (ch3 ch3) : 11
w/ WWwWw //v

- +16 ch2 ch1 qt +3 out succ 119 in

(qt +16 119)
WWWWw Wwwwwwwwww //v

- 183 +64 +16 ch2 ch1 qt +3 out succ 119 in

commaspace( S ) ;; print ", "
-: S 183 +64 +16 ch2 ch1 qt +3 out succ 119 in
  f=(qt +3) : 78
-: f S 135 +16 ch2 ch1 qt +3 out succ 119 in
  C=(f S) : 12
-: C f S 135 +16, ch2 ch1 qt +3 out, succ 119 in
  (out C) : 11 1
-: C C f S 135 +16 ch2 ch1 qt +3 out succ 119 in
  (out S) : 12 4
<1> 63 12 A1 B4
w/ WWWWWWWwwwwwwww Www WWWWWWWWWWWw WWWWWWWWWWWWwwww //v

- commaspace 135 +16 ch2 ch1 qt +3 out succ 119 in

main(x)
-: x commaspace 135 +16 ch2 ch1 qt +3 out succ 119 in
  commaspace(135) : 2 3

w/ WWwww


