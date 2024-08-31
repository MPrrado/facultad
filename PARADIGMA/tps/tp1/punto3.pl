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

/*regla que permite traer todos las bebidas que tienen un valor mayor a uno dado*/

productosConValorMayor(Valor, X):-producto(bebida,X), precio(X,Y), Y>Valor.

/*productos que entran en promo semanal. Regla*/
promoSemanal(Producto1, Producto2) :-
    precio(Producto1, X),
    precio(Producto2, Y),
    ((X > 100; Y > 100)), % me tengo que asegurar que los valores esten inicializados antes de ser operados, es decir primero evaluo los precios para poder preguntar sobre su valor y ademas operar mas abajo a la hora de hacer la regla "is"
    producto(Cate1, Producto1),
    producto(Cate2, Producto2),
    Cate1 \= Cate2,
    write('Precio '), write(Producto1), write(': '), write(X), nl,
    write('Precio '), write(Producto2), write(': '), write(Y), nl,
    Descuento is Y * 0.3,
    write('Precio '), write(Producto2), write(' con descuento (70%): '), write(Descuento), nl.



po(Producto1):-(precio(Producto1,X), X>100).