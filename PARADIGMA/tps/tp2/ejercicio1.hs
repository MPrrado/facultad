calcularCuadrado x
 | x <= 0 = 0
 | x == 1 = 1
 | otherwise = 2*x + calcularCuadrado (x - 1) - 1

{-
lo que hace la funcion es elevar al cuadrado a la x, basicamente calcula el cuadrado de un numero
-}