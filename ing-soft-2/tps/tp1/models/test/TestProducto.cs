using NUnit.Framework;
using espacioProducto;
using espacioTienda;
using System.Runtime; // Reemplaza con el namespace de tus clases

namespace espacioTests
{
    [TestFixture]
    public class ProductoTest
    {
        [Test]
        public void cambiarPrecioDeberiaCambiar()
        {
            // 1. Arrange (Preparar)
            Producto producto = new Producto("cosa1", 100, "categoria1");

            // 2. Act (Actuar)
            var respuesta = producto.cambiarPrecio(1500);
            // 3. Assert (Verificar)
            Assert.That(respuesta, Is.True); //forma legible y moderna de NUnit para test
        }

        [Test]
        public void cambiarPrecioNoDeberiaCambiar()
        {
            // 1. Arrange (Preparar)
            Producto producto = new Producto("cosa1", 100, "categoria1");

            // 2. Act (Actuar)
            // 3. Assert (Verificar)
            Assert.Throws<InvalidOperationException>(()=> producto.cambiarPrecio(-1500)); //forma legible y moderna de NUnit para test
        }
    
    }
}
