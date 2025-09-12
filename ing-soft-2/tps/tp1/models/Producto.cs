using System.Security.Authentication;
using Newtonsoft.Json.Serialization;

namespace espacioProducto
{
    public class Producto
    {
        private string nombre;
        private double precio;
        private string categoria;

        public string Nombre { get => nombre; }
        public double Precio { get => precio; }
        public string Categoria { get => categoria; }

        public Producto()
        {

        }
        public Producto(string nombre, double precio, string categoria)
        {
            this.nombre = nombre;
            this.precio = precio;
            this.categoria = categoria;
        }

        public bool cambiarPrecio(double precio)
        {
            if (precio < 0)
            {
                throw new InvalidOperationException("ERROR EL PRECIO INGREASADO (" + precio + ") DEBE SER MAYOR POSITIVO");
            }
            this.precio = precio;
            return true;
        }
    }
}