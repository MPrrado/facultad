administrativo(juan).
administrativo(carolina).
administrativo(ana).
tecnico(pedro).
tecnico(patricia).

mujer(patricia).
mujer(carolina).
mujer(ana).

varon(pedro).
varon(juan).

equipo(X,Y):- varon(X), tecnico(X),mujer(Y), administrativo(Y).
equipo(X,Y):- varon(X), administrativo(X), mujer(Y), tecnico(Y).