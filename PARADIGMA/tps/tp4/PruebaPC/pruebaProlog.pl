% Prueba PROLOG

administrativo(juan).
administrativo(patricia).
administrativo(ana).

tecnico(pedro).
tecnico(patricia).
mujer(carolina).
mujer(patricia).
mujer(ana).

varon(juan).
varon(pedro).

equipo(X,Y):- varon(X), tecnico(X),mujer(Y), administrativo(Y).
equipo(X,Y):- varon(X), administrativo(X), mujer(Y), tecnico(Y).
