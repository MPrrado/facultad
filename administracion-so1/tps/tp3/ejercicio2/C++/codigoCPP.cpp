#include <iostream>
using namespace std;
int main ()
{
    int variable, ciclos;

    cout<<"INGRESE UN NUMERO ENTRE 1 Y 20: "<<endl;;
    cin>>variable;
    while ((variable < 1) || (variable > 20))
    {
        cout<<"ERROR EL NUMERO INGRESADO DEBE ESTAR ENTRE 1 Y 20: "<<endl;
        cin>>variable;
        cout<<endl;
    }
    
    int anterior = 0, comienzo = 1, resultado;
    ciclos = variable;
    cout<<"LOS PRIMEROS ("<<variable<< ") NUMEROS DE LA SECUNCIA DE FIBONACCI SON: "<<endl;
    for (int i = 0; i < ciclos; i++)
    {
        if(i == 0)
        {
            cout<<anterior<<endl;    
        }else if(i == 1)
        {
            cout<<comienzo<<endl;
        }else
        {

            resultado = comienzo + anterior;
            anterior = comienzo;
            comienzo = resultado;
            cout<<resultado<<endl;
        }
    }
    
    getchar();
    getchar();
    
    return 0;

}