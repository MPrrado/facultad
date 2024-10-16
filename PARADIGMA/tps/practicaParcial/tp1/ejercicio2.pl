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


/* Las reglas para encontrar las personas menores de edad. */

listadoMenores(Lista) :- edad(Lista, X), X <18.

/*Las reglas para encontrar a todas las personas que están en condiciones de
acceder a la jubilación */


listaAccesoJubilacion(Lista) :- edad(Lista, X), X>=65, masculino(Lista); edad(Lista, Y), Y>= 60, femenino(Lista).

/*Una regla que le permita establecer la relación “X es mayor que Y”. */

esMayorQue(Persona1,Persona2) :- edad(Persona1,X), edad(Persona2,Y), X>Y.

/*Una regla para determinar quiénes son coetáneos (menos de 10 años de diferencia
de edad)*/

sonCoetaneos(Persona1, Persona2) :- edad(Persona1, X), edad(Persona2, Y), N is abs(X-Y), N < 10.
