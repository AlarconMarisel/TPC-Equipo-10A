using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dominio;

namespace Negocio
{
    public class ImagenNegocio
    {
        public void AgregarImagen(Imagen imagen)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.SetearConsulta("INSERT INTO IMAGENESARTICULO (IDArticulo, RutaImagen) VALUES (@IDArticulo, @RutaImagen)");
                datos.SetearParametro("@IDArticulo", imagen.IdArticulo);
                datos.SetearParametro("@RutaImagen", imagen.RutaImagen);
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

        public void EliminarImagen(int idImagen)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.SetearConsulta("DELETE FROM IMAGENESARTICULO WHERE IDImagen=@IDImagen");
                datos.SetearParametro("@IDImagen", idImagen);
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

        public List<Imagen> ListarPorArticulo(int idArticulo)
        {
            List<Imagen> lista = new List<Imagen>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.SetearConsulta("SELECT IDImagen, IDArticulo, RutaImagen FROM IMAGENESARTICULO WHERE IDArticulo=@IDArticulo ORDER BY IDImagen");
                datos.SetearParametro("@IDArticulo", idArticulo);
                datos.EjecutarLectura();

                while (datos.Lector.Read())
                {
                    Imagen img = new Imagen();
                    img.IdImagen = (int)datos.Lector["IDImagen"];
                    img.IdArticulo = (int)datos.Lector["IDArticulo"];
                    img.RutaImagen = datos.Lector["RutaImagen"] != DBNull.Value ? (string)datos.Lector["RutaImagen"] : null;
                    lista.Add(img);
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

        public void EliminarImagenesPorArticulo(int idArticulo)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.SetearConsulta("DELETE FROM IMAGENESARTICULO WHERE IDArticulo=@IDArticulo");
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

        public int ContarPorArticulo(int idArticulo)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.SetearConsulta("SELECT COUNT(*) FROM IMAGENESARTICULO WHERE IDArticulo=@IDArticulo");
                datos.SetearParametro("@IDArticulo", idArticulo);
                object result = datos.EjecutarAccionScalar();
                return Convert.ToInt32(result);
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
