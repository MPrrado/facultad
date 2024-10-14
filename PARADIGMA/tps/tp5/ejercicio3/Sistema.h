#include "Encomienda.cpp"
#include <vector>
class Sistema
{
    vector<Encomienda> listaEncomiendas;
    public:
        void RegistrarEncomienda(string origen, string destino, double peso, Vehiculo autoAcargo);
        void CargarFechaEntrega(int codigoEncomienda, Fecha fechaEntrega);
        void ListarEntregas (Fecha fecha);
        vector<Encomienda> GetListaEncomiendas();
        Sistema()
        {

        }
        ~Sistema();
        
};