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

        public void AgregarArticuloAlCarrito(int idCarrito, int idArticulo, int cantidad = 1)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.SetearConsulta(@"
            INSERT INTO CARRITOS_DETALLE (IDCarrito, IDArticulo, Cantidad)
            VALUES (@IDCarrito, @IDArticulo, @Cantidad)");

                datos.SetearParametro("@IDCarrito", idCarrito);
                datos.SetearParametro("@IDArticulo", idArticulo);
                datos.SetearParametro("@Cantidad", cantidad);

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
            DELETE FROM CARRITOS_DETALLE 
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
            FROM CARRITOS_DETALLE cd
            INNER JOIN ARTICULOS a ON a.IDArticulo = cd.IDArticulo
            OUTER APPLY (
                SELECT TOP 1 RutaImagen 
                FROM IMAGENES_ARTICULOS 
                WHERE IDArticulo = a.IDArticulo
            ) i");

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

  
    }

}



