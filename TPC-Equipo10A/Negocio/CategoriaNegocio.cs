using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dominio;

namespace Negocio
{
    public class CategoriaNegocio
    {
        public List<Categoria> ListarCategorias()
        {
            List<Categoria> lista = new List<Categoria>();
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.SetearConsulta("SELECT IdCategoria, Nombre FROM CATEGORIAS WHERE Eliminado = 0 ORDER BY Nombre");
                datos.EjecutarLectura();
                while (datos.Lector.Read())
                {
                    Categoria categoria = new Categoria();
                    categoria.IdCategoria = (int)datos.Lector["IdCategoria"];
                    categoria.Nombre = (string)datos.Lector["Nombre"];
                    lista.Add(categoria);
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

        public Categoria ObtenerPorId(int id)
        {
            Categoria categoria = null;
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.SetearConsulta("SELECT IdCategoria, Nombre FROM CATEGORIAS WHERE IdCategoria = @IdCategoria AND Eliminado = 0");
                datos.SetearParametro("@IdCategoria", id);
                datos.EjecutarLectura();

                if (datos.Lector.Read())
                {
                    categoria = new Categoria();
                    categoria.IdCategoria = (int)datos.Lector["IdCategoria"];
                    categoria.Nombre = (string)datos.Lector["Nombre"];
                }

                return categoria;
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

        public List<Categoria> Buscar(string criterio)
        {
            List<Categoria> lista = new List<Categoria>();
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.SetearConsulta("SELECT IdCategoria, Nombre FROM CATEGORIAS WHERE Eliminado = 0 AND Nombre LIKE @Criterio ORDER BY Nombre");
                string criterioBusqueda = "%" + criterio + "%";
                datos.SetearParametro("@Criterio", criterioBusqueda);
                datos.EjecutarLectura();

                while (datos.Lector.Read())
                {
                    Categoria categoria = new Categoria();
                    categoria.IdCategoria = (int)datos.Lector["IdCategoria"];
                    categoria.Nombre = (string)datos.Lector["Nombre"];
                    lista.Add(categoria);
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

        public bool AgregarCategoria(Categoria nueva, out bool fueReactivada)
        {
            AccesoDatos datos = new AccesoDatos();
            fueReactivada = false;
            try
            {
                if (ExisteNombre(nueva.Nombre))
                {
                    throw new Exception($"Ya existe una categoría activa con el nombre '{nueva.Nombre}'. Por favor, elija otro nombre.");
                }

                int? idCategoriaEliminada = ObtenerIdCategoriaEliminadaPorNombre(nueva.Nombre);
                if (idCategoriaEliminada.HasValue)
                {
                    ReactivarCategoria(idCategoriaEliminada.Value);
                    fueReactivada = true;
                }
                else
                {
                    datos.SetearConsulta("INSERT INTO CATEGORIAS (Nombre, Eliminado) VALUES (@Nombre, 0)");
                    datos.SetearParametro("@Nombre", nueva.Nombre);
                    datos.EjecutarAccion();
                    fueReactivada = false;
                }
                return true;
            }
            catch (Exception ex)
            {
                if (ex.Message.Contains("Ya existe") || ex.Message.Contains("reactivada"))
                {
                    throw;
                }
                throw new Exception("Error al agregar la categoría: " + ex.Message, ex);
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public void ModificarCategoria(Categoria categoria)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                if (ExisteNombre(categoria.Nombre, categoria.IdCategoria))
                {
                    throw new Exception($"Ya existe otra categoría con el nombre '{categoria.Nombre}'. Por favor, elija otro nombre.");
                }

                Categoria categoriaExistente = ObtenerPorId(categoria.IdCategoria);
                if (categoriaExistente == null)
                {
                    throw new Exception("No se pudo modificar la categoría. Puede que no exista o haya sido eliminada.");
                }

                datos.SetearConsulta("UPDATE CATEGORIAS SET Nombre = @Nombre WHERE IdCategoria = @IdCategoria AND Eliminado = 0");
                datos.SetearParametro("@Nombre", categoria.Nombre);
                datos.SetearParametro("@IdCategoria", categoria.IdCategoria);
                datos.EjecutarAccion();
            }
            catch (Exception ex)
            {
                if (ex.Message.Contains("Ya existe") || ex.Message.Contains("No se pudo modificar"))
                {
                    throw;
                }
                throw new Exception("Error al modificar la categoría: " + ex.Message, ex);
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public void Eliminar(int id)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                if (TieneArticulosAsociados(id))
                {
                    throw new Exception("No se puede eliminar la categoría porque tiene artículos asociados. Primero debe eliminar o cambiar la categoría de los artículos relacionados.");
                }

                datos.SetearConsulta("UPDATE CATEGORIAS SET Eliminado = 1 WHERE IdCategoria = @IdCategoria");
                datos.SetearParametro("@IdCategoria", id);
                datos.EjecutarAccion();
            }
            catch (Exception ex)
            {
                if (ex.Message.Contains("No se puede eliminar"))
                {
                    throw;
                }
                throw new Exception("Error al eliminar la categoría: " + ex.Message, ex);
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public bool TieneArticulosAsociados(int idCategoria)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.SetearConsulta("SELECT COUNT(*) FROM ARTICULOS WHERE IDCategoria = @IDCategoria AND Eliminado = 0");
                datos.SetearParametro("@IDCategoria", idCategoria);

                object result = datos.EjecutarAccionScalar();
                int count = Convert.ToInt32(result);
                return count > 0;
            }
            catch (Exception ex)
            {
                throw new Exception("Error al verificar artículos asociados: " + ex.Message, ex);
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public bool ExisteNombre(string nombre, int? idCategoriaExcluir = null)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                string consulta = "SELECT COUNT(*) FROM CATEGORIAS WHERE Nombre = @Nombre AND Eliminado = 0";
                if (idCategoriaExcluir.HasValue)
                {
                    consulta += " AND IdCategoria != @IdCategoria";
                }

                datos.SetearConsulta(consulta);
                datos.SetearParametro("@Nombre", nombre);
                if (idCategoriaExcluir.HasValue)
                {
                    datos.SetearParametro("@IdCategoria", idCategoriaExcluir.Value);
                }

                object result = datos.EjecutarAccionScalar();
                int count = Convert.ToInt32(result);
                return count > 0;
            }
            catch (Exception ex)
            {
                throw new Exception("Error al verificar si el nombre existe: " + ex.Message, ex);
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public int? ObtenerIdCategoriaEliminadaPorNombre(string nombre)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.SetearConsulta("SELECT TOP 1 IdCategoria FROM CATEGORIAS WHERE Nombre = @Nombre AND Eliminado = 1");
                datos.SetearParametro("@Nombre", nombre);
                datos.EjecutarLectura();

                if (datos.Lector.Read())
                {
                    return (int)datos.Lector["IdCategoria"];
                }

                return null;
            }
            catch (Exception ex)
            {
                throw new Exception("Error al buscar categoría eliminada: " + ex.Message, ex);
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public void ReactivarCategoria(int idCategoria)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.SetearConsulta("UPDATE CATEGORIAS SET Eliminado = 0 WHERE IdCategoria = @IdCategoria");
                datos.SetearParametro("@IdCategoria", idCategoria);
                datos.EjecutarAccion();
            }
            catch (Exception ex)
            {
                throw new Exception("Error al reactivar la categoría: " + ex.Message, ex);
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

    }
}
