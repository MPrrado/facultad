using NUnit.Framework;
using espacioProducto;
using espacioTienda;
using System.Runtime;
using Moq; // Reemplaza con el namespace de tus clases

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
        
        [Test]
        public void AplicarDescuento_DeberiaLlamarACambiarPrecio_ConElPrecioOriginal()
        {
            // 1. Arrange (Preparar)
            var tienda = new Tienda();
            double precioOriginal = 200.0;
            double porcentajeDescuento = 25.0; // 25% de descuento
            double precioEsperado = 150.0; // 200 - (200 * 0.25) = 150

            // Simulación del Producto (El Mock)
            // Creamos una instancia de Moq para el Producto, pasando los parámetros del constructor
            var mockProducto = new Mock<Producto>("Monitor", precioOriginal, "Electronica");
            
            // Configuramos el mock para que cuando se pida la propiedad 'Precio' (get), devuelva el precio original.
            mockProducto.SetupGet(p => p.Precio).Returns(precioOriginal);

            // Configuramos el mock para que cuando se pida la propiedad 'Nombre' (get), devuelva el nombre.
            mockProducto.SetupGet(p => p.Nombre).Returns("Monitor");

            //  INYECCIÓN DEL MOCK: Agregamos el objeto simulado (mockProducto.Object) a la tienda.
            tienda.agregarProducto(mockProducto.Object);

            // 2. Act (Actuar)
            tienda.aplicarDescuento("Monitor", porcentajeDescuento);

            // 3. Assert (Verificar Interacción)
            // Usamos la aserción mágica de Moq: Verify.
            // Verificamos que el método 'cambiarPrecio' fue llamado EXACTAMENTE UNA VEZ (Times.Once)
            // y que el argumento pasado (el nuevo precio) es el precioEsperado.
            
            mockProducto.Verify(p => p.cambiarPrecio(
                It.Is<double>(nuevoPrecio => Math.Abs(nuevoPrecio - precioEsperado) < 0.001)
            ), 
                Times.Once(), 
                "El método cambiarPrecio no fue llamado, o el nuevo precio calculado era incorrecto."
            );
        }

    }
}
