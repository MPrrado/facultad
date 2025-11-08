#!/bin/bash
clear
#3) Escribe un script llamado operaciones_basicas.sh que declare dos variables numéricas, a y b.
a=10
b=5

#a)Realiza la suma, resta, multiplicación y división entre esas variables.

((a+b))
((a-b))
((a*b))
((a/b))
((a%b))

#nota, si usamos $() bash interpreta que evalue el comando que esta adentro y luego guarde su valor
#en cambio si usamos $(()) es la forma en que la bash entiende que tiene que evaluar aritmeticamente

#b)Muestra los resultados en pantalla sin utilizar variables que almacenen los resultados.
echo 'La suma de' $a 'mas' $b 'es =' $((a+b))
echo 'La resta de' $a 'menos' $b 'es =' $((a-b))
echo 'La multiplicacion de' $a 'por' $b 'es =' $((a*b))
echo 'La division de' $a 'entre' $b 'es =' $((a/b))
echo 'El resto de' $a 'entre' $b 'es =' $((a%b))

#c)Declara dos variables más, c y d y realiza las operaciones
#i) (a+b)*(c-d)
#ii) ((a*b)+c)/d.

c=6
d=4

#i)

resultado1=$(((a+b)*(c-d)))
echo '----------------------------------------------------------------------------------------------------'
echo "a=$a"
echo "b=$b"
echo "c=$c"
echo "d=$d"
echo ""
echo 'el resultado de (a+b)*(c-d) es =' $resultado1

#ii)
resultado2=$((((a*b)+c)/d))
echo 'el resultado de ((a*b)+c)/d es =' $resultado2
