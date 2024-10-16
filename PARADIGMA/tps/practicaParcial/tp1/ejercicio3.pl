% Base de Conocimiento ALMACEN DON MANOLO

producto(lacteo, leche).
producto(lacteo, manteca).
producto(lacteo, crema).
producto(lacteo, yogurt).
producto(fiambre, queso).
producto(fiambre, jamonCrudo).
producto(fiambre, jamonCocido).
producto(fiambre, salame).
producto(panaderia, pan).
producto(panaderia, factura).
producto(panaderia, tortilla).
producto(panaderia, galleta).
producto(bebida, agua).
producto(bebida, gaseosa).
producto(bebida, jugo).
producto(bebida, soda).
producto(golosina, chocolate).
producto(golosina, caramelo).
producto(golosina, mantecol).
producto(golosina, bombones).
producto(golosina, nugaton).

precio(leche, 77).
precio(manteca, 62).
precio(crema, 95).
precio(yogurt, 53).
precio(queso, 80).
precio(jamonCrudo, 170).
precio(jamonCocido, 100).
precio(salame, 85).
precio(pan, 80).
precio(factura, 20).
precio(tortilla, 10).
precio(galleta, 75).
precio(agua, 86).
precio(gaseosa, 130).
precio(jugo, 98).
precio(soda, 100).
precio(chocolate, 116).
precio(caramelo, 35).
precio(mantecol, 87).
precio(bombones, 140).
precio(nugaton, 51).


/*Escriba una regla en Prolog que le permita obtener todas las bebidas cuyo precio
es mayor que un dado valor.*/

filtrarBebidasSegunPrecio(Precio, Lista) :- producto(bebida, Lista), precio(Lista,X), X > Precio.

/*
Escriba una regla en Prolog que permita determinar los productos que entran en la
PROMO SEMANAL. 
PROMO el 2do al 70%: Lleve 2 productos y el 2do con un 70% de descuento.
Condiciones: los productos de la promoción deben pertenecer a distintas
categorías y el precio de alguno de ellos debe ser mayor a 100. En ese
caso, el cliente lleva los 2 y paga el producto de menor valor con un 70%
de descuento. */

promo(P1, P2)  :- 
producto(Cat1, P1), 
producto(Cat2,P2), 
Cat1 \= Cat2, 
precio(P1, X),
precio(P2, Y),
(X>100 ; Y>100),
N1 is min(X,Y),
write('Precio '), write(P1), write(': '), write(X), nl,
write('Precio '), write(P2), write(': '), write(Y), nl,
Descuento is round(N1*0.3),
precio(ProductoMenorPrecio, N1),
write('Precio '), write(ProductoMenorPrecio), write(' con descuento (70%):'), write(Descuento), nl.

