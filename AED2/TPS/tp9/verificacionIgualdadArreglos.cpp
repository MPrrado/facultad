#include "iostream"
using namespace std;
#include <stdlib.h>
#include <time.h>
#include <math.h>
#include <vector>
#include <algorithm>
#define NRO_COMPARACIONES 10

bool compararProbabilista(int v1[], int v2[], int izq, int der, int nroComparaciones); // se invoca compararProbabilista(v1,v2,0,dim(v1), nroComparaciones)

bool compararProbabilistaSinRepeticion(int v1[], int v2[], int izq, int der, int nroComparaciones); // se invoca compararProbabilista(v1,v2,0,dim(v1), nroComparaciones)

int main()
{
    srand(time(NULL));
    // arreglos iguales
    int arr1[] = {1, 2, 3, 4, 5, 1, 2, 3, 4, 5};
    int arr2[] = {1, 2, 3, 4, 5, 1, 2, 3, 4, 5};
    
    // arreglos distintos
    // int arr1[] = {1, 2, 3, 4, 5, 1, 2, 3, 4, 5};
    // int arr2[] = {1, 5, 7, 2, 5, 6, 7, 8, 1, 0};

    // arreglos distintos por una componente
    // int arr1[] = {1, 2, 3, 4, 5, 1, 2, 3, 4, 5};
    // int arr2[] = {1, 2, 3, 4, 5, 1, 7, 3, 4, 5};

    // bool sonIguales = compararProbabilista(arr1, arr2, 0, 10, sqrt(NRO_COMPARACIONES)); //raiz de n comparaciones (monte carlo)

    // bool sonIguales = compararProbabilista(arr1, arr2, 0, 10, NRO_COMPARACIONES); //n comparaciones con repeticion (monte carlo)

    bool sonIguales = compararProbabilistaSinRepeticion(arr1, arr2, 0, 10, NRO_COMPARACIONES); //n comparaciones sin repetcion (las vegas caso particular Sherwood)



    if (sonIguales)
    {
        cout << "SON IGUALES" << endl;
    }
    else
    {
        cout << "NO SON IGUALES" << endl;
    }

    return 0;
}

bool compararProbabilista(int v1[], int v2[], int izq, int der, int nroComparaciones)
{
    bool sonIguales = true;
    while (nroComparaciones > 0 && sonIguales != false)
    {
        int i = rand() % der;
        if (v1[i] != v2[i])
        {
            sonIguales = false;
        }
        nroComparaciones--;
    }
    return sonIguales;
}

bool compararProbabilistaSinRepeticion(int v1[], int v2[], int izq, int der, int nroComparaciones)
{
    bool sonIguales = true;
    vector<int> indices;
    int anterior = 0;
    while (nroComparaciones > 0 && sonIguales != false)
    {
        int i = rand() % der;
        while(*(find(indices.begin(), indices.end(), i)) == i) //funcion find nos devuelve un puntero el cual apunta al lugar donde esta alocado el valor i.
        {
            i = rand() % der;
        }
        if (v1[i] != v2[i])
        {
            sonIguales = false;
        }
        indices.push_back(i);
        nroComparaciones--;
    }
    return sonIguales;
}
