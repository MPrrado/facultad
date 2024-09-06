-- 2 a)
-- GUARDS

divisionEnteraG x y
    | y == 0 =  0
    | y > x = 0
    | x == y = 1
    |otherwise = 1 + divisionEnteraG (x-y) y

-- PATTERN MATCHING
divisionEnteraPM x 0 = 0
divisionEnteraPM x y =  if y > x then 0 else 1 + divisionEnteraPM (x-y) y

-- LIST COMPREHENSION
-- divisionEnteraLC xs y = [1 | x <-xs, x] no se como plantearla para poder hacer los controles de que si y= 0, y>x y que si si x = y

-- b)

--GUARDS
contarMayoresG xs y
    | null xs = 0
    | head xs > y = 1 + contarMayoresG (tail xs) y
    | otherwise = contarMayoresG (tail xs) y

-- PATTERN MATCHING
contarMayoresPM [] y = 0
contarMayoresPM (x:xs) y = if x > y then 1 + contarMayoresPM xs y else contarMayoresPM xs y

-- LIST COMPREHENSION
contarMayoresLC xs y = sum [1 | x<-xs, x > y]

-- c)

--GUARDS

subListaG xs n
    | null xs = []
    | n <= 0 = []
    | n>= length xs = xs
    | otherwise = head xs : subListaG (tail xs) (n-1)

--PATTERN MATCHING

subListaPM xs 0 = []
subListaPM [] n = []
subListaPM xs n = if n<=length xs then head xs : subListaPM (tail xs) (n-1) else xs

--LIST COMPREHENSION

subListaLC xs n = [x | (x, i) <- zip xs [1..n]] -- zip lo que hace es generar pares de dos listas dadas, entonces lo uso en este caso de manera tal que solo obtengo los pares de elementos hasta el indice n, luego solo tomo los valores de x de esa lista de pares, logrando asi obtener los n primero elementos de la lista.

--d)

--GUARDS

sonIgualesG xs ys
    | null xs && null ys = True --este es nuestro caso base, si se llega hasta aqui en la comparacion recursiva entonces se determinará su valor
    | null xs || null ys = False
    | head xs /= head ys = False
    | otherwise = sonIgualesG (tail xs) (tail ys)

-- PATTERN MATCHING

sonIgualesPM [] [] = True
sonIgualesPM [] _ = False -- usar "_" nos ayuda a determinar que la lista no es vacia y asi comparamos una lista vacia con una que no lo es
sonIgualesPM _ [] = False
sonIgualesPM (x:xs) (y:ys) = if x == y then sonIgualesPM (xs) (ys) else False

--list comprehension

sonIgualesLC xs ys = length xs == length ys && all (uncurry (==)) (zip xs ys) -- uncurry(==) recibe una lista de pares y compara esos pares viendo si son iguales y retorna el booleano correspondiente.

--e)

--guards

interseccionG xs ys --ghci> interseccionG [2,3,4,5,6,7,8,8] [1,2,3,4,9,8,6,6,6,7]  --------> [2,3,4,6,7,8,8] esto sucede porque el 8 lo considera como unico a pesar de que en ys esta una sola vez
    | null xs || null ys = []
    | elem (head xs) ys = head xs : interseccionG(tail xs) ys
    | otherwise = interseccionG (tail xs) ys

--patter matching

interseccionPM [] _ = []
interseccionPM _ [] = []
interseccionPM xs ys = if elem(head xs) ys then head xs : interseccionPM (tail xs) ys else interseccionPM (tail xs) ys

-- list comprehension

interseccionLC xs ys = [x | x <-xs, elem x ys]

--f) esta bien planteada cada metodologia?

--guards

esVocalG c 
    | elem c ['a','e','i','o','u', 'A','E','I','O','U'] = True
    | otherwise = False

--patter matching

esVocalPM c = if elem c ['a','e','i','o','u', 'A','E','I','O','U'] then True else False

--list comprehension

esVocalLC c = elem c ['a','e','i','o','u', 'A','E','I','O','U']

--g)

-- para resolver esta funcion usamos la composicion a traves de la funcion esVocal definida anteriormente

--guards

contarVocalesG f cc 
    | null cc = 0
    | f (head cc) == True = 1 + contarVocalesG f (tail cc)
    | otherwise = contarVocalesG f (tail cc)

--patter matching

contarVocalesPM f [] = 0
contarVocalesPM f cc = if f (head cc) then 1 + contarVocalesPM f (tail cc) else contarVocalesPM f (tail cc)

--list comprehension

-- como seria?

--h)

--guards


