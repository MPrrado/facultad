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
    





