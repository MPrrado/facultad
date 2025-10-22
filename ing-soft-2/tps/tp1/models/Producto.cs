using System.Security.Authentication;
using Newtonsoft.Json.Serialization;

namespace espacioProducto
{
    public class Producto
    {
        private string nombre;
        private double precio;
        private string categoria;

        //necesitamos que tanto las propiedaes como los metodos que usara el mock para simular el comportamiento sean virtuales
        //para que Moq pueda sobreescribirlos y definir su propio comportamiento
        public virtual string Nombre { get => nombre; }
        public virtual double Precio { get => precio; }
        public virtual string Categoria { get => categoria; }

        public Producto()
        {

        }
        public Producto(string nombre, double precio, string categoria)
        {
            this.nombre = nombre;
            this.precio = precio;
            this.categoria = categoria;
        }

        public virtual bool cambiarPrecio(double precio)
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