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

subListaPM [] n = []
subListaPM (x:xs) n = if n>0 then x: subListaPM xs (n-1) else subListaPM xs n


sonIgualesG xs1 xs2
    | null xs1 && null xs2 = True
    | null xs1 || null xs2 = False
    | otherwise =  sonIgualesG (tail xs1) (tail xs2)

intersecciónLC xs1 xs2 = [z | z <-xs1, y<- xs2, z == y]