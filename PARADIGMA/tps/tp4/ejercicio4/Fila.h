typedef int Item;

class Nodo
{
    Item dato;
    Nodo* siguiente;
    public:
        Nodo();
        void setDato(Item dato);
        int getDato();
        void setSiguiente(Nodo* nodoSiguiente);
        Nodo* getSiguiente();
        ~Nodo();

};

class Fila
{
    int longitud;
    Nodo* finalFila;
    Nodo* frenteFila;
    public:
        Fila();
        void Mostrar();
        int Longitud();
        bool Pertenece(Item datoBuscado);
        void Enfila(Item dato);
        void Defila();
        Item Frente();
        bool EsFilaVacia();
        ~Fila();
};


