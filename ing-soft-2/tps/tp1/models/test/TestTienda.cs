using NUnit.Framework;
using espacioProducto;
using espacioTienda;
using System.Runtime; // Reemplaza con el namespace de tus clases

namespace espacioTests
{
    [TestFixture]
    public class TiendaTest
    {
        [Test]
        public void agregarProductoDeberiaAnadirElProductoAlInventario()
        {
            // 1. Arrange (Preparar)
            var tienda = new Tienda();
            Producto producto = new Producto("cosa1", 100, "categoria1");

            // 2. Act (Actuar)
            tienda.agregarProducto(producto);

            // 3. Assert (Verificar)
            Assert.That(tienda.Productos, Does.Contain(producto)); //forma legible y moderna de NUnit para test
        }

        [Test]
        public void buscarProductoDeberiaEncontrarElProducto()
        {
            // 1. Arrange (Preparar)
            var tienda = new Tienda();
            Producto producto1 = new Producto("Telefono", 100, "categoria1");
            Producto producto2 = new Producto("PC", 1000, "categoria1");

            // 2. Act (Actuar)
            tienda.agregarProducto(producto1);
            tienda.agregarProducto(producto2);
            Producto resultado1 = tienda.buscarProducto("Telefono");

            // 3. Assert (Verificar)
            Assert.That(resultado1, Is.Not.Null); //forma legible y moderna de NUnit para test
            Assert.That(resultado1, Is.SameAs(producto1)); //comprobamos que lo que nos trajo el metodo sea igual al producto que buscamos
        }

        [Test]
        public void buscarProductoNoDeberiaEncontrarElProducto()
        {
            // 1. Arrange (Preparar)
            var tienda = new Tienda();
            Producto producto1 = new Producto("PC", 1000, "categoria1");

            // 2. Act (Actuar)
            tienda.agregarProducto(producto1);
            // 3. Assert (Verificar)
            Assert.Throws<InvalidOperationException>(()=>tienda.buscarProducto("Telefono"));
        }

        [Test]
        public void eliminarProductoDeberiaEliminarlo()
        {

            // 1. Arrange (Preparar)
            var tienda = new Tienda();
            Producto producto1 = new Producto("PC", 1000, "categoria1");

            // 2. Act (Actuar)
            tienda.agregarProducto(producto1);
            bool resultado = tienda.eliminarProducto("PC");

            // 3. Assert (Verificar)
            Assert.That(resultado, Is.True);
        }

        [Test]
        public void eliminarProductoNoDeberiaEliminarlo()
        {

            // 1. Arrange (Preparar)
            var tienda = new Tienda();
            Producto producto1 = new Producto("PC", 1000, "categoria1");

            // 2. Act (Actuar)
            tienda.agregarProducto(producto1);

            // 3. Assert (Verificar)
            Assert.Throws<InvalidOperationException>(() => tienda.eliminarProducto("Telefono"));
        }
        
    }
}
