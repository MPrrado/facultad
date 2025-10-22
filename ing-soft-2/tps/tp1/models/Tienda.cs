using System.Diagnostics;
using espacioProducto;
namespace espacioTienda
{
    public class Tienda
    {
        private List<Producto> productos;

        public List<Producto> Productos { get => productos; }

        public Tienda()
        {
            this.productos = new List<Producto>();
        }
        public void agregarProducto(Producto producto)
        {
            this.productos.Add(producto);
        }

        public Producto buscarProducto(string nombre)
        {
            Producto producto = null;
            producto = this.productos.Find(p => p.Nombre == nombre);
            if (producto == null)
            {
                throw new InvalidOperationException("ERROR NO SE A ENCONTRADO EL PRODUCTO");
            }
            else
            {
                return producto;
            }
        }

        public bool eliminarProducto(string nombre)
        {
            if (this.productos.Exists(p => p.Nombre == nombre)) //comprobamos que el producto exista
            {
                if (this.productos.Remove(this.productos.Find(p => p.Nombre == nombre)))
                {
                    return true;
                }
            }
            throw new InvalidOperationException("ERROR, NO SE PUDO ELIMINAR PORQUE NO SE ENCONTRO EL PRODUCTO: " + nombre);
        }

        public bool aplicarDescuento(string nombreProducto, double porcentaje)
        {
            if(porcentaje < 0 || porcentaje > 100) //chequeamos que el porcentaje este entre 0 y 100
            {
                throw new InvalidOperationException("ERROR, EL PORCENTAJE DEBE ESTAR ENTRE 0 Y 100");
            }
            Producto producto = this.buscarProducto(nombreProducto); //si no lo encuentra tira excepcion
            return producto.cambiarPrecio(producto.Precio - (producto.Precio * porcentaje / 100));
        }


    }
}