pares(0, []). % tengo este caso base para poder obtener una lista vacia para el caso que quiera los  "primero 0 numeros pares"
pares(N, L) :-
    N > 0,
    N1 is N - 1,
    pares(N1, L1),
    P is N1 * 2,
    append(L1, [P], L). % añade al final de una lista los elementos entre cochetes

suma(0,0). % caso base
suma(N,S):-
    N > 0,
    N1 is N mod 10,
    N2 is N div 10,
    suma(N2, S1),
    S is S1 + N1.

menor_digito(0, 9). % Caso base para comparación, para el caso en el que digitos sea 0 entonces se compara con 9 el digito, pues no puede haber alguno mas grande que este

menor_digito(N, Menor) :- % Regla para encontrar el dígito de menor valor en un número
    N > 0,
    Digito is N mod 10,
    N1 is N // 10,
    menor_digito(N1, Menor1),
    Menor is min(Digito, Menor1). % utilzacion de la funcion "min"





