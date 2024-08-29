progenitor(carlos,isabelII).
progenitor(diana,isabelII).

progenitor(carlos,felipe).
progenitor(diana,felipe).

progenitor(william,carlos).
progenitor(harry,carlos).

progenitor(william,diana).
progenitor(harry,diana).

progenitor(george,william).
progenitor(charlotte,william).
progenitor(louis,william).

progenitor(george,catherine).
progenitor(charlotte,catherine).
progenitor(louis,catherine).


progenitor(archie,harry).
progenitor(lilibet,harry).

progenitor(archie,meghan).
progenitor(lilibet,meghan).

femenino(isabelII).
femenino(diana).
femenino(catherine).
femenino(meghan).
femenino(charlotte).
femenino(lilibet).

masculino(felipe).
masculino(carlos).
masculino(william).
masculino(harry).
masculino(george).
masculino(louis).
masculino(archie).
masculino(lilibet).


abuelos(A,N):- progenitor(N,X), progenitor(X,A).
abuelo(A,N):- progenitor(N,X), progenitor(X,A), masculino(A).
abuela(A,N):- progenitor(N,X), progenitor(X,A), femenino(A).
padreDe(X, H) :- progenitor(H, X), masculino(X).
madreDe(X, H) :- progenitor(H, X), femenino(X).
hijo(Padre,X) :- progenitor(X,Padre), masculino(X).
hija(Padre,X) :- progenitor(X, Padre), femenino(X).

hermanos(Persona,H) :- padreDe(X, Persona), madreDe(Y,Persona),padreDe(X, H), madreDe(Y,H), H\=Persona.

primo(Chabon, Primo) :- progenitor(Chabon,X), hermanos(X,Y), progenitor(Primo,Y).




/*
    b)

    ?- progenitor(carlos, X). ---> nos da los progenitores de carlos
    ?- progenitor(X, carlos). ---> nos devuelve los hijos de carlos
    progenitor(X, carlos), progenitor(charlotte, X). ---> nos devuelve el hijo de carlos cuya hija es charlotte
    progenitor(william, X), progenitor(harry, X).

    c)
        quienes son los progenitores de Harry?
        progenitor(harry, X).

        tiene algun hijo William?
        progenitor(X, william).

        quienes son los abuelos de Louis?
        abuelos(A,N):- progenitor(N,X), progenitor(X,A).


*/