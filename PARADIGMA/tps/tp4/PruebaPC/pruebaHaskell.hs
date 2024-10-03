-- Prueba HASKELL

misterio x 
   |  x <= 0   =  0
   |  x == 1   =  1
   | otherwise =  2*x + misterio (x - 1) - 1
