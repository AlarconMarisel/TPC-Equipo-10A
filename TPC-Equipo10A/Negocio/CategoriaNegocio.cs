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
        public List<Categoria> ListarCategorias(int? idAdministrador = null)
        {
            List<Categoria> lista = new List<Categoria>();
            AccesoDatos datos = new AccesoDatos();
            try
            {
                // Si no se especifica idAdministrador, intentar obtenerlo de la sesión
                if (!idAdministrador.HasValue)
                {
                    idAdministrador = TenantHelper.ObtenerIDAdministradorDesdeSesion();
                }

                string whereClause = "WHERE Eliminado = 0";
                if (idAdministrador.HasValue)
                {
                    whereClause += " AND IDAdministrador = @IDAdministrador";
                }

                datos.SetearConsulta("SELECT IdCategoria, Nombre, IDAdministrador FROM CATEGORIAS " + whereClause + " ORDER BY Nombre");
                
                if (idAdministrador.HasValue)
                {
                    datos.SetearParametro("@IDAdministrador", idAdministrador.Value);
                }
                
                datos.EjecutarLectura();
                while (datos.Lector.Read())
                {
                    Categoria categoria = new Categoria();
                    categoria.IdCategoria = (int)datos.Lector["IdCategoria"];
                    categoria.Nombre = (string)datos.Lector["Nombre"];
                    categoria.IDAdministrador = datos.Lector["IDAdministrador"] != DBNull.Value ? Convert.ToInt32(datos.Lector["IDAdministrador"]) : 0;
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
                int? idAdministrador = TenantHelper.ObtenerIDAdministradorDesdeSesion();
                string whereClause = "WHERE IdCategoria = @IdCategoria AND Eliminado = 0";
                
                // Si hay un administrador en sesión, validar que la categoría le pertenece
                if (idAdministrador.HasValue)
                {
                    whereClause += " AND IDAdministrador = @IDAdministrador";
                }

                datos.SetearConsulta("SELECT IdCategoria, Nombre, IDAdministrador FROM CATEGORIAS " + whereClause);
                datos.SetearParametro("@IdCategoria", id);
                
                if (idAdministrador.HasValue)
                {
                    datos.SetearParametro("@IDAdministrador", idAdministrador.Value);
                }
                
                datos.EjecutarLectura();

                if (datos.Lector.Read())
                {
                    categoria = new Categoria();
                    categoria.IdCategoria = (int)datos.Lector["IdCategoria"];
                    categoria.Nombre = (string)datos.Lector["Nombre"];
                    categoria.IDAdministrador = datos.Lector["IDAdministrador"] != DBNull.Value ? Convert.ToInt32(datos.Lector["IDAdministrador"]) : 0;
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

        public List<Categoria> Buscar(string criterio, int? idAdministrador = null)
        {
            List<Categoria> lista = new List<Categoria>();
            AccesoDatos datos = new AccesoDatos();
            try
            {
                // Si no se especifica idAdministrador, intentar obtenerlo de la sesión
                if (!idAdministrador.HasValue)
                {
                    idAdministrador = TenantHelper.ObtenerIDAdministradorDesdeSesion();
                }

                string whereClause = "WHERE Eliminado = 0 AND Nombre LIKE @Criterio";
                if (idAdministrador.HasValue)
                {
                    whereClause += " AND IDAdministrador = @IDAdministrador";
                }

                datos.SetearConsulta("SELECT IdCategoria, Nombre, IDAdministrador FROM CATEGORIAS " + whereClause + " ORDER BY Nombre");
                string criterioBusqueda = "%" + criterio + "%";
                datos.SetearParametro("@Criterio", criterioBusqueda);
                
                if (idAdministrador.HasValue)
                {
                    datos.SetearParametro("@IDAdministrador", idAdministrador.Value);
                }
                
                datos.EjecutarLectura();

                while (datos.Lector.Read())
                {
                    Categoria categoria = new Categoria();
                    categoria.IdCategoria = (int)datos.Lector["IdCategoria"];
                    categoria.Nombre = (string)datos.Lector["Nombre"];
                    categoria.IDAdministrador = datos.Lector["IDAdministrador"] != DBNull.Value ? Convert.ToInt32(datos.Lector["IDAdministrador"]) : 0;
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
                // Obtener IDAdministrador desde sesión
                int? idAdministrador = TenantHelper.ObtenerIDAdministradorDesdeSesion();
                
                if (!idAdministrador.HasValue)
                {
                    throw new Exception("No se puede determinar el administrador. Debe estar logueado como administrador.");
                }

                // Validar nombre duplicado (solo para este administrador)
                if (ExisteNombre(nueva.Nombre, null, idAdministrador.Value))
                {
                    throw new Exception($"Ya existe una categoría activa con el nombre '{nueva.Nombre}'. Por favor, elija otro nombre.");
                }

                int? idCategoriaEliminada = ObtenerIdCategoriaEliminadaPorNombre(nueva.Nombre, idAdministrador.Value);
                if (idCategoriaEliminada.HasValue)
                {
                    ReactivarCategoria(idCategoriaEliminada.Value);
                    fueReactivada = true;
                }
                else
                {
                    datos.SetearConsulta("INSERT INTO CATEGORIAS (Nombre, IDAdministrador, Eliminado) VALUES (@Nombre, @IDAdministrador, 0)");
                    datos.SetearParametro("@Nombre", nueva.Nombre);
                    datos.SetearParametro("@IDAdministrador", idAdministrador.Value);
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
                // Obtener IDAdministrador desde sesión
                int? idAdministrador = TenantHelper.ObtenerIDAdministradorDesdeSesion();
                
                if (!idAdministrador.HasValue)
                {
                    throw new Exception("No se puede determinar el administrador. Debe estar logueado como administrador.");
                }

                Categoria categoriaExistente = ObtenerPorId(categoria.IdCategoria);
                if (categoriaExistente == null)
                {
                    throw new Exception("No se pudo modificar la categoría. Puede que no exista, haya sido eliminada o no tenga permisos para acceder.");
                }

                // Validar que la categoría pertenece al administrador
                if (!TenantHelper.ValidarAccesoAdministrador(categoriaExistente.IDAdministrador))
                {
                    throw new UnauthorizedAccessException("No tiene permisos para modificar esta categoría.");
                }

                // Validar nombre duplicado (solo para este administrador)
                if (ExisteNombre(categoria.Nombre, categoria.IdCategoria, idAdministrador.Value))
                {
                    throw new Exception($"Ya existe otra categoría con el nombre '{categoria.Nombre}'. Por favor, elija otro nombre.");
                }

                datos.SetearConsulta("UPDATE CATEGORIAS SET Nombre = @Nombre WHERE IdCategoria = @IdCategoria AND IDAdministrador = @IDAdministrador AND Eliminado = 0");
                datos.SetearParametro("@Nombre", categoria.Nombre);
                datos.SetearParametro("@IdCategoria", categoria.IdCategoria);
                datos.SetearParametro("@IDAdministrador", idAdministrador.Value);
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
                // Obtener IDAdministrador desde sesión
                int? idAdministrador = TenantHelper.ObtenerIDAdministradorDesdeSesion();
                
                if (!idAdministrador.HasValue)
                {
                    throw new Exception("No se puede determinar el administrador. Debe estar logueado como administrador.");
                }

                // Verificar que la categoría existe y pertenece al administrador
                Categoria categoria = ObtenerPorId(id);
                if (categoria == null)
                {
                    throw new Exception("No se pudo eliminar la categoría. Puede que no exista, haya sido eliminada o no tenga permisos para acceder.");
                }

                // Validar que la categoría pertenece al administrador
                if (!TenantHelper.ValidarAccesoAdministrador(categoria.IDAdministrador))
                {
                    throw new UnauthorizedAccessException("No tiene permisos para eliminar esta categoría.");
                }

                if (TieneArticulosAsociados(id))
                {
                    throw new Exception("No se puede eliminar la categoría porque tiene artículos asociados. Primero debe eliminar o cambiar la categoría de los artículos relacionados.");
                }

                datos.SetearConsulta("UPDATE CATEGORIAS SET Eliminado = 1 WHERE IdCategoria = @IdCategoria AND IDAdministrador = @IDAdministrador");
                datos.SetearParametro("@IdCategoria", id);
                datos.SetearParametro("@IDAdministrador", idAdministrador.Value);
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

        public bool ExisteNombre(string nombre, int? idCategoriaExcluir = null, int? idAdministrador = null)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                // Si no se especifica idAdministrador, intentar obtenerlo de la sesión
                if (!idAdministrador.HasValue)
                {
                    idAdministrador = TenantHelper.ObtenerIDAdministradorDesdeSesion();
                }

                string consulta = "SELECT COUNT(*) FROM CATEGORIAS WHERE Nombre = @Nombre AND Eliminado = 0";
                
                if (idAdministrador.HasValue)
                {
                    consulta += " AND IDAdministrador = @IDAdministrador";
                }
                
                if (idCategoriaExcluir.HasValue)
                {
                    consulta += " AND IdCategoria != @IdCategoria";
                }

                datos.SetearConsulta(consulta);
                datos.SetearParametro("@Nombre", nombre);
                
                if (idAdministrador.HasValue)
                {
                    datos.SetearParametro("@IDAdministrador", idAdministrador.Value);
                }
                
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

        public int? ObtenerIdCategoriaEliminadaPorNombre(string nombre, int? idAdministrador = null)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                // Si no se especifica idAdministrador, intentar obtenerlo de la sesión
                if (!idAdministrador.HasValue)
                {
                    idAdministrador = TenantHelper.ObtenerIDAdministradorDesdeSesion();
                }

                string whereClause = "WHERE Nombre = @Nombre AND Eliminado = 1";
                if (idAdministrador.HasValue)
                {
                    whereClause += " AND IDAdministrador = @IDAdministrador";
                }

                datos.SetearConsulta("SELECT TOP 1 IdCategoria FROM CATEGORIAS " + whereClause);
                datos.SetearParametro("@Nombre", nombre);
                
                if (idAdministrador.HasValue)
                {
                    datos.SetearParametro("@IDAdministrador", idAdministrador.Value);
                }
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


        // METODO PARA SUPERADMIN - Crea categorias por defecto

        public void CrearCategoriasPorDefecto(int idAdministrador)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                string[] categoriasPorDefecto = {
                    "Sin Categoria",
                    "Mueble",
                    "Electrodomestico",
                    "Juguetes",
                    "Electronica",
                    "Herramientas",
                    "Jardineria",
                    "Vajilla",
                    "Deporte"
                };

                foreach (string nombreCategoria in categoriasPorDefecto)
                {
                    // Verifica si la categoria ya existe para este administrador
                    datos = new AccesoDatos();
                    datos.SetearConsulta(@"
                        SELECT COUNT(*) 
                        FROM CATEGORIAS 
                        WHERE Nombre = @Nombre 
                        AND IDAdministrador = @IDAdministrador 
                        AND Eliminado = 0");
                    datos.SetearParametro("@Nombre", nombreCategoria);
                    datos.SetearParametro("@IDAdministrador", idAdministrador);
                    object result = datos.EjecutarAccionScalar();
                    int existe = Convert.ToInt32(result);
                    datos.cerrarConexion();

                    // Solo insertar si no existe
                    if (existe == 0)
                    {
                        datos = new AccesoDatos();
                        datos.SetearConsulta("INSERT INTO CATEGORIAS (Nombre, IDAdministrador, Eliminado) VALUES (@Nombre, @IDAdministrador, 0)");
                        datos.SetearParametro("@Nombre", nombreCategoria);
                        datos.SetearParametro("@IDAdministrador", idAdministrador);
                        datos.EjecutarAccion();
                        datos.cerrarConexion();
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error al crear categorías por defecto: " + ex.Message, ex);
            }
        }

    }
}
