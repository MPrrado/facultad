#include "iostream"
using namespace std;
#include <math.h>
#include <stdlib.h>
#include <time.h>
#define RADIO 2
#define LADO_CUADRADO (2 * RADIO)
#define NRO_DARDOS_TIRADOS 10000
#define NRO_EXPERIMENTOS 2000

double EstimacionPi(int radio, int nroDardosTirados, int ladoCuadrado);
bool CumpleEcCircunferencia(double x, double y, int radio);
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
        double x = ((double) rand() / RAND_MAX) * ladoCuadrado - ladoCuadrado / 2;
        double y = ((double) rand() / RAND_MAX) * ladoCuadrado - ladoCuadrado / 2;
        if(CumpleEcCircunferencia(x, y, radio))
        {
            k++;
        }
    }
    double pi = (double(ladoCuadrado * ladoCuadrado) * k) / (double(radio * radio) * nroDardosTirados);
    return pi;
}

bool CumpleEcCircunferencia(double x, double y, int radio)
{
    return (x*x + y*y <= radio*radio);
}


// #include <iostream>
// #include <cmath>
// #include <cstdlib>
// #include <ctime>

// #define RADIO 2
// #define LADO_CUADRADO (2 * RADIO)
// #define NRO_DARDOS_TIRADOS 10000000
// #define NRO_EXPERIMENTOS 200

// double EstimacionPi(int radio, int nroDardosTirados, int ladoCuadrado);
// bool CumpleEcCircunferencia(double x, double y, int radio);

// int main()
// {
//     srand(time(NULL));
//     for(int i = 0; i < NRO_EXPERIMENTOS; i++)
//     {
//         double pi = EstimacionPi(RADIO, NRO_DARDOS_TIRADOS, LADO_CUADRADO);
//         std::cout << pi << std::endl;
//     }
//     return 0;
// }

// double EstimacionPi(int radio, int nroDardosTirados, int ladoCuadrado)
// {
//     int k = 0;
//     for(int i = 0; i < nroDardosTirados; i++)
//     {
//         double x = ((double) rand() / RAND_MAX) * ladoCuadrado - ladoCuadrado / 2;
//         double y = ((double) rand() / RAND_MAX) * ladoCuadrado - ladoCuadrado / 2;
//         if(CumpleEcCircunferencia(x, y, radio))
//         {
//             k++;
//         }
//     }
//     double pi = (4.0 * k) / nroDardosTirados;
//     return pi;
// }

// bool CumpleEcCircunferencia(double x, double y, int radio)
// {
//     return (x*x + y*y <= radio*radio);
// }

// #include <iostream>
// #include <cmath>
// #include <cstdlib>
// #include <ctime>

// #define RADIO 2
// #define LADO_CUADRADO (2 * RADIO)
// #define NRO_DARDOS_TIRADOS 100
// #define NRO_EXPERIMENTOS 20

// using namespace std;

// double EstimacionPi(int radio, int nroDardosTirados, int ladoCuadrado);
// bool CumpleEcCircunferencia(double x, double y, int radio);

// int main()
// {
//     srand(time(NULL));
//     for(int i = 0; i < NRO_EXPERIMENTOS; i++)
//     {
//         double pi = EstimacionPi(RADIO, NRO_DARDOS_TIRADOS, LADO_CUADRADO);
//         cout << pi << std::endl;
//     }
//     return 0;
// }

// double EstimacionPi(int radio, int nroDardosTirados, int ladoCuadrado)
// {
//     int k = 0;
//     for(int i = 0; i < nroDardosTirados; i++)
//     {
//         double x = ((double) rand() / RAND_MAX) * ladoCuadrado - ladoCuadrado / 2;
//         double y = ((double) rand() / RAND_MAX) * ladoCuadrado - ladoCuadrado / 2;
//         if(CumpleEcCircunferencia(x, y, radio))
//         {
//             k++;
//         }
//     }
//     double pi = (double(ladoCuadrado * ladoCuadrado) * k) / (double(radio * radio) * nroDardosTirados);
//     return pi;
// }

// bool CumpleEcCircunferencia(double x, double y, int radio)
// {
//     radio = pow(radio,2);
//     double suma = double(pow(x,2)) + double(pow(y,2));
//     if(suma <= radio)
//     {
//         return true;
//     }else
//     {
//         return false;
//     }
// }
