using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dominio;

namespace Negocio
{
    public class CarritoNegocio
    {
        public int CrearCarritoSiNoExiste(int idUsuario, int idAdministrador)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.SetearConsulta("SELECT IDCarrito FROM CARRITOS WHERE IDUsuario = @idUsuario AND Activo = 1");
                datos.SetearParametro("@idUsuario", idUsuario);
                datos.EjecutarLectura();

                if (datos.Lector.Read())
                {
                    return (int)datos.Lector["IDCarrito"];
                }

                datos.cerrarConexion();

                datos = new AccesoDatos();
                datos.SetearConsulta(@"
                    INSERT INTO CARRITOS (IDUsuario, IDAdministrador) 
                    VALUES (@idUsuario, @idAdministrador);
                    SELECT SCOPE_IDENTITY();");

                datos.SetearParametro("@idUsuario", idUsuario);
                datos.SetearParametro("@idAdministrador", idAdministrador);

                object result = datos.EjecutarAccionScalar();
                return Convert.ToInt32(result);
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public void AgregarArticuloAlCarrito(int idCarrito, int idArticulo)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {

                datos.SetearConsulta(@"
                SELECT A.IDEstado, AC.IDArticulo
                FROM ARTICULOS A
                LEFT JOIN ARTICULOSXCARRITO AC ON A.IDArticulo = AC.IDArticulo AND AC.IDCarrito = @IDCarrito
                WHERE A.IDArticulo = @IDArticulo");

                datos.SetearParametro("@IDCarrito", idCarrito);
                datos.SetearParametro("@IDArticulo", idArticulo);
                datos.EjecutarLectura();

                if (datos.Lector.Read())
                {
                    int estadoArticulo = (int)datos.Lector["IDEstado"];
                    object idArticuloEnCarrito = datos.Lector["IDArticulo"];
                    
                    // Si el estado no es 1, lanzar una excepción o simplemente salir.
                    if (estadoArticulo != 1)
                    {
                        // Puedes lanzar una excepción personalizada o manejar el error como prefieras.
                        throw new InvalidOperationException("El artículo se encuentra reservado.");
                        // O simplemente: return;
                    }

                    // Si el artículo ya está en el carrito (IDArticuloXCARRITO no es DBNull), no hacer nada y salir.
                    if (idArticuloEnCarrito != DBNull.Value)
                    {
                        return;
                    }
                }
                else
                {
                    // Si no se encuentra el artículo con el ID especificado, puedes manejar el error aquí.
                    throw new ArgumentException("No se encontró el artículo especificado.");
                }

                datos.cerrarConexion();


                datos = new AccesoDatos();
                datos.SetearConsulta(@"
                INSERT INTO ARTICULOSXCARRITO (IDCarrito, IDArticulo, FechaAgregado)
                VALUES (@IDCarrito, @IDArticulo, GETDATE())");

                datos.SetearParametro("@IDCarrito", idCarrito);
                datos.SetearParametro("@IDArticulo", idArticulo);

                datos.EjecutarAccion();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public void QuitarArticuloDelCarrito(int idCarrito, int idArticulo)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.SetearConsulta(@"
                DELETE FROM ARTICULOSXCARRITO 
                WHERE IDCarrito = @IDCarrito AND IDArticulo = @IDArticulo");
                datos.SetearParametro("@IDCarrito", idCarrito);
                datos.SetearParametro("@IDArticulo", idArticulo);

                datos.EjecutarAccion();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public List<Articulo> ListarArticulosDelCarrito(int idCarrito)
        {
            List<Articulo> lista = new List<Articulo>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.SetearConsulta(@"
            SELECT a.IDArticulo, a.Nombre, a.Precio, i.RutaImagen
            FROM ARTICULOSXCARRITO c
            INNER JOIN ARTICULOS a ON a.IDArticulo = c.IDArticulo
            OUTER APPLY (
                SELECT TOP 1 RutaImagen
                FROM IMAGENESARTICULO
                WHERE IDArticulo = a.IDArticulo
            ) i
            WHERE c.IDCarrito = @IDCarrito");

                datos.SetearParametro("@IDCarrito", idCarrito);
                datos.EjecutarLectura();

                while (datos.Lector.Read())
                {
                    Articulo art = new Articulo();
                    art.IdArticulo = (int)datos.Lector["IDArticulo"];
                    art.Nombre = (string)datos.Lector["Nombre"];
                    art.Precio = (decimal)datos.Lector["Precio"];

                    string ruta = datos.Lector["RutaImagen"] != DBNull.Value
                        ? (string)datos.Lector["RutaImagen"]
                        : "/Images/no-image.png";

                    art.Imagenes = new List<Imagen> {
                new Imagen { RutaImagen = ruta }
            };

                    lista.Add(art);
                }

                return lista;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public void VaciarCarrito(int idCarrito)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.SetearConsulta("DELETE FROM ARTICULOSXCARRITO WHERE IDCarrito = @idCarrito");
                datos.SetearParametro("@idCarrito", idCarrito);
                datos.EjecutarAccion();
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

    }

}



