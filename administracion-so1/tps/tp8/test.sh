#!/bin/bash

clear

function multiplicar
{

	echo $(( $1*$2 ))

}

resultado=$(multiplicar 5 4) #es como capturar lo que va a imprimir, evitando que salga por la pantalla
echo ""
multiplicar 5 4
echo ""
echo "resultado: "$resultado
