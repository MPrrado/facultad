#include "iostream"
using namespace std;
#include <math.h>
#include <stdlib.h>
#include <time.h>
#define RADIO 2
#define LADO_CUADRADO 2 * RADIO
#define NRO_DARDOS_TIRADOS 100
#define NRO_EXPERIMENTOS 20

double EstimacionPi(int radio, int nroDardosTirados, int ladoCuadrado);
bool CumpleEcCircunferencia(int x, int y, int radio);
int main()
{
    srand(time(NULL));
    for(int i = 0; i<NRO_EXPERIMENTOS;i++)
    {
        double pi = EstimacionPi(RADIO,NRO_DARDOS_TIRADOS,LADO_CUADRADO);
        cout<<pi<<endl;
    }
    return 0;
}

double EstimacionPi(int radio, int nroDardosTirados, int ladoCuadrado)
{
    int k = 0;
    for(int i = 0; i < nroDardosTirados; i++)
    {
        int x = 1 + rand() % (ladoCuadrado/2);
        int y = 1 + rand() % (ladoCuadrado/2);
        if(CumpleEcCircunferencia(x,y,radio))
        {
            k++;
        }
    }
    int ladoAlCuadrado = pow(ladoCuadrado,2);
    int radioAlCuadrado = pow(radio,2);
    double pi = (ladoAlCuadrado* k) / double(radioAlCuadrado*nroDardosTirados);
    return pi;
}

bool CumpleEcCircunferencia(int x, int y, int radio)
{
    radio = pow(radio,2);
    int suma = pow(x,2) + pow(y,2);
    if(suma <= radio)
    {
        return true;
    }else
    {
        return false;
    }
}
