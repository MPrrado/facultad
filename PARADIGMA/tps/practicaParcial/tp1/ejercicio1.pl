progenitor(carlos, isabelII).
progenitor(carlos, felipe).
progenitor(william, diana).
progenitor(william, carlos).
progenitor(harry, diana).
progenitor(harry, carlos).
progenitor(george, catherine).
progenitor(george, william).
progenitor(charlotte, catherine).
progenitor(charlotte, william).
progenitor(louis, catherine).
progenitor(louis, william).
progenitor(archie, meghan).
progenitor(archie, harry).
progenitor(lilibet, meghan).
progenitor(lilibet, harry).
/*
?- progenitor(carlos, X). --> devuelve los padres de carlos     
?- progenitor(X, carlos). ---> devuelve los hijos de carlos
?- progenitor(X, carlos), ---> no me funciona
progenitor(charlotte, X). ---> devuelve los padres de charlotte
?- progenitor(william, X), ----> devuelve los padres de william
progenitor(harry, X). 
*/
masculino(felipe).
masculino(carlos).
masculino(william).
masculino(harry).
masculino(george).
masculino(louis).
masculino(archie).

femenino(isabelII).
femenino(diana).
femenino(catherine).
femenino(meghan).
femenino(charlotte).
femenino(lilibet).

padreDe(Hijo, Padre) :- progenitor(Hijo,Padre), masculino(Padre).
madreDe(Hijo, Madre) :- progenitor(Hijo, Madre), femenino(Madre).
hijo(Progenitor, Hijo) :- progenitor(Hijo, Progenitor), masculino(Hijo).
hija(Progenitor, Hija) :- progenitor(Hija, Progenitor), femenino(Hija).
abuelo(Nieto, Abuelo) :- progenitor(Nieto, PadreNieto), progenitor(PadreNieto, Abuelo), masculino(Abuelo).
abuela(Nieto, Abuela) :- progenitor(Nieto, PadreNieto), progenitor(PadreNieto, Abuela), femenino(Abuela).
hermanos(Persona, Hermanos) :- progenitor(Persona, X), !, progenitor(Hermanos,X),  Hermanos \= Persona.
primo(Persona, Primos) :- progenitor(Persona, X), hermanos(X, Y), progenitor(Primos, Y).
bisAbueloDe(BisNieto, BisAbuelo) :- progenitor(BisNieto, Padre), abuelo(Padre, BisAbuelo).
bisAbuelaDe(BisNieto, BisAbuela) :- progenitor(BisNieto, Padre), abuela(Padre, BisAbuela).

