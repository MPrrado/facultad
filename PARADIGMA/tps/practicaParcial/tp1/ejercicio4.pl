escribirNPares(1, []).
escribirNPares(N, Lista) :- 
    N > 0,
    N1 is N-1,
    escribirNPares(N1, L1),
    Par is N1 * 2,
    append(L1, [Par], Lista).
    
sumaDigitos(0,0).
sumaDigitos(N, S):-
    N > 0,
    D is N mod 10,
    N1 is N // 10,
    sumaDigitos(N1, Suma1),
    S is Suma1 + D.

digitoMenor(N,N):-
    N<10.
digitoMenor(N,M):-
    N >= 10,
    D is N mod 10,
    N1 is N // 10,
    digitoMenor(N1,M1),
    M is min(M1, D).

/*b. Dada una lista de elementos se pueda: 
i. Crear una lista con los n primeros números enteros. 

*/

listaNEnteros2(_, [], []).
listaNEnteros2(0, _, []).
listaNEnteros2(N, [H|T], [H|L]):-
    N > 0,
    N1 is N - 1,
    listaNEnteros2(N1, T, L). 

/*
iii. Determinar si los elementos de la lista están ordenados de menor a mayor. 
*/

estaOrdenada([]).
estaOrdenada([_]).
estaOrdenada([X,Y|R]):-
    X =< Y,
    estaOrdenada([Y|R]).

