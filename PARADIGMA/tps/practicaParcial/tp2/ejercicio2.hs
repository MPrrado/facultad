divisionEntera a b
    |b == 0 = 0
    |b == 1 = a
    |b > a  = 0
    |b == a = 1
    |otherwise = 1 + divisionEntera(a-b) b

contarMayoresG xs n
    |null xs = 0
    |head xs > n = 1 + contarMayoresG (tail xs)  n
    |otherwise = contarMayoresG (tail xs) n 

contarMayoresPM [] n =  0
contarMayoresPM (x:xs) n = if x > n then 1 + contarMayoresPM xs n else contarMayoresPM xs n

contarMayoresLC xs n = sum [1 | x<-xs, x > n]


