/*PUNTO - 2*/

/*a) definimos la base de conocimiento necesaria*/

masculino(luis).
masculino(juan).
masculino(pedro).
masculino(andres).
masculino(joaquin).
masculino(santiago).
masculino(carlos).

femenino(julia).
femenino(maria).
femenino(rocio).
femenino(cecilia).
femenino(felicia).
femenino(veronica).
femenino(eugenia).

edad(luis,20).
edad(juan,72).
edad(pedro,40).
edad(julia,17).
edad(maria,46).
edad(andres,50).
edad(rocio,67).
edad(joaquin,15).
edad(cecilia,35).
edad(felicia,60).
edad(santiago,45).
edad(veronica,34).
edad(eugenia,70).
edad(carlos,73).

estadoCivil(luis,soltero).
estadoCivil(juan,viudo).
estadoCivil(pedro,casado).
estadoCivil(julia,casada).
estadoCivil(maria,soltera).
estadoCivil(andres,casado).
estadoCivil(rocio,soltera).
estadoCivil(joaquin,soltero).
estadoCivil(cecilia,soltera).
estadoCivil(felicia,soltera).
estadoCivil(santiago,casado).
estadoCivil(veronica,casada).
estadoCivil(eugenia,viuda).
estadoCivil(carlos,casada).

/*b- regla para gente menor de edad*/
personaMenorDeEdad(PersonaMenor):- edad(PersonaMenor, X), X < 18.
/*c- regla para encontrar todas las personas con edad de jubilacion. ACLARACION: la regla de abajo puede funcionar con los parentesis en el ", (and)" como tambien agregando parentesis extras dentro del "; (or)"*/
personaConEdadParaJubilacion(PersonaParaJubilar):- edad(PersonaParaJubilar,X), (X>=65 , masculino(PersonaParaJubilar); X >= 60, femenino(PersonaParaJubilar)). 
/*d- relacion "X es mayor que Y"*/
esMayorQue(Persona1, Persona2) :- edad(Persona1, X) , edad(Persona2, Y), X > Y.
/*e- reglas para determinar quienes son coetáneos  (menos de 10 años de diferencia
de edad)*/
coetaneo(Persona1, Persona2):- edad(Persona1, X), edad(Persona2, Y), abs(X - Y) < 10.
