using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using Dominio;

namespace Negocio
{
    public class ArticuloNegocio
    {
        public List<Articulo> listarArticulo(int? idAdministrador = null)
        {
            List<Articulo> lista = new List<Articulo>();
            AccesoDatos datos = new AccesoDatos();
          
            try
            {
                // Si no se especifica idAdministrador, intentar obtenerlo de la sesión
                if (!idAdministrador.HasValue)
                {
                    idAdministrador = TenantHelper.ObtenerIDAdministradorDesdeSesion();
                }

                string whereClause = "WHERE a.Eliminado = 0";
                if (idAdministrador.HasValue)
                {
                    whereClause += " AND a.IDAdministrador = @IDAdministrador";
                }

                datos.SetearConsulta(@"
                    SELECT 
                        a.IDArticulo, 
                        a.Nombre, 
                        a.Descripcion, 
                        a.Precio,
                        a.IDAdministrador,
                        c.IDCategoria,
                        c.Nombre as CategoriaNombre,
                        e.IDEstado,
                        e.Nombre as EstadoNombre,
                        img.RutaImagen AS ImagenPrincipal
                    FROM ARTICULOS a
                    INNER JOIN CATEGORIAS c ON a.IDCategoria = c.IDCategoria
                    INNER JOIN ESTADOSARTICULO e ON a.IDEstado = e.IDEstado
                    OUTER APPLY (
                        SELECT TOP 1 RutaImagen
                        FROM IMAGENESARTICULO ii
                        WHERE ii.IDArticulo = a.IDArticulo
                        ORDER BY ii.IDImagen
                    ) img
                    " + whereClause + @"
                    ORDER BY a.IDArticulo DESC");

                if (idAdministrador.HasValue)
                {
                    datos.SetearParametro("@IDAdministrador", idAdministrador.Value);
                }

                datos.EjecutarLectura();

                while (datos.Lector.Read())
                {
                    Articulo art = new Articulo();

                    
                    art.IdArticulo = (int)datos.Lector["IDArticulo"];
                    art.Nombre = (string)datos.Lector["Nombre"];
                    art.Descripcion = (string)datos.Lector["Descripcion"];
                    art.Precio = (decimal)datos.Lector["Precio"];
                    art.IDAdministrador = datos.Lector["IDAdministrador"] != DBNull.Value ? Convert.ToInt32(datos.Lector["IDAdministrador"]) : 0;

                    
                    art.CategoriaArticulo = new Categoria();
                    art.CategoriaArticulo.IdCategoria = (int)datos.Lector["IDCategoria"];
                    art.CategoriaArticulo.Nombre = (string)datos.Lector["CategoriaNombre"];

                    
                    art.EstadoArticulo = new Estado();
                    art.EstadoArticulo.IdEstado = (int)datos.Lector["IDEstado"];
                    art.EstadoArticulo.Nombre = (string)datos.Lector["EstadoNombre"];

                    
                    art.Imagenes = new List<Imagen>();
                    var imagenPrincipal = datos.Lector["ImagenPrincipal"];
                    if (imagenPrincipal != DBNull.Value)
                    {
                        art.Imagenes.Add(new Imagen
                        {
                            IdArticulo = art.IdArticulo,
                            RutaImagen = (string)imagenPrincipal
                        });
                    }

                    
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

        public Articulo ObtenerPorId(int id)
        {
            Articulo art = null;
            AccesoDatos datos = new AccesoDatos();

            try
            {
                int? idAdministrador = TenantHelper.ObtenerIDAdministradorDesdeSesion();
                string whereClause = "WHERE a.IDArticulo = @IDArticulo AND a.Eliminado = 0";
                
                // Si hay un administrador en sesión, validar que el artículo le pertenece
                if (idAdministrador.HasValue)
                {
                    whereClause += " AND a.IDAdministrador = @IDAdministrador";
                }

                datos.SetearConsulta(@"
                    SELECT 
                        a.IDArticulo, 
                        a.Nombre, 
                        a.Descripcion, 
                        a.Precio,
                        a.IDAdministrador,
                        c.IDCategoria,
                        c.Nombre as CategoriaNombre,
                        e.IDEstado,
                        e.Nombre as EstadoNombre
                    FROM ARTICULOS a
                    INNER JOIN CATEGORIAS c ON a.IDCategoria = c.IDCategoria
                    INNER JOIN ESTADOSARTICULO e ON a.IDEstado = e.IDEstado
                    " + whereClause);

                datos.SetearParametro("@IDArticulo", id);
                if (idAdministrador.HasValue)
                {
                    datos.SetearParametro("@IDAdministrador", idAdministrador.Value);
                }
                datos.EjecutarLectura();

                if (datos.Lector.Read())
                {
                    art = new Articulo();
                    art.IdArticulo = (int)datos.Lector["IDArticulo"];
                    art.Nombre = (string)datos.Lector["Nombre"];
                    art.Descripcion = datos.Lector["Descripcion"] != DBNull.Value ? (string)datos.Lector["Descripcion"] : null;
                    art.Precio = (decimal)datos.Lector["Precio"];
                    art.IDAdministrador = datos.Lector["IDAdministrador"] != DBNull.Value ? Convert.ToInt32(datos.Lector["IDAdministrador"]) : 0;

                    art.CategoriaArticulo = new Categoria();
                    art.CategoriaArticulo.IdCategoria = (int)datos.Lector["IDCategoria"];
                    art.CategoriaArticulo.Nombre = (string)datos.Lector["CategoriaNombre"];

                    art.EstadoArticulo = new Estado();
                    art.EstadoArticulo.IdEstado = (int)datos.Lector["IDEstado"];
                    art.EstadoArticulo.Nombre = (string)datos.Lector["EstadoNombre"];

                    ImagenNegocio imagenNegocio = new ImagenNegocio();
                    art.Imagenes = imagenNegocio.ListarPorArticulo(id);
                }

                return art;
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

        public int Agregar(Articulo nuevo)
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

                // Validar precio mínimo
                if (nuevo.Precio <= 0)
                {
                    throw new Exception("El precio debe ser mayor a 0.");
                }

                // Validar nombre duplicado (solo para este administrador)
                if (ExisteNombre(nuevo.Nombre, null, idAdministrador.Value))
                {
                    throw new Exception($"Ya existe un artículo con el nombre '{nuevo.Nombre}'. Por favor, elija otro nombre.");
                }

                datos.SetearConsulta(@"INSERT INTO ARTICULOS (Nombre, Descripcion, Precio, IDCategoria, IDEstado, IDAdministrador, Eliminado) 
                                     VALUES (@Nombre, @Descripcion, @Precio, @IDCategoria, @IDEstado, @IDAdministrador, 0); 
                                     SELECT SCOPE_IDENTITY();");
                datos.SetearParametro("@Nombre", nuevo.Nombre);
                datos.SetearParametro("@Descripcion", (object)nuevo.Descripcion ?? DBNull.Value);
                datos.SetearParametro("@Precio", nuevo.Precio);
                datos.SetearParametro("@IDCategoria", nuevo.CategoriaArticulo.IdCategoria);
                datos.SetearParametro("@IDEstado", nuevo.EstadoArticulo.IdEstado);
                datos.SetearParametro("@IDAdministrador", idAdministrador.Value);

                object result = datos.EjecutarAccionScalar();
                return Convert.ToInt32(result);
            }
            catch (Exception ex)
            {
                // Si ya es una excepción con mensaje personalizado, relanzarla
                if (ex.Message.Contains("Ya existe") || ex.Message.Contains("precio"))
                {
                    throw;
                }
                throw new Exception("Error al agregar el artículo: " + ex.Message, ex);
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public void Modificar(Articulo articulo)
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

                // Verificar que el artículo existe y pertenece al administrador
                Articulo articuloExistente = ObtenerPorId(articulo.IdArticulo);
                if (articuloExistente == null)
                {
                    throw new Exception("No se pudo modificar el artículo. Puede que no exista, haya sido eliminado o no tenga permisos para acceder.");
                }

                // Validar que el artículo pertenece al administrador
                if (!TenantHelper.ValidarAccesoAdministrador(articuloExistente.IDAdministrador))
                {
                    throw new UnauthorizedAccessException("No tiene permisos para modificar este artículo.");
                }

                // Validar precio mínimo
                if (articulo.Precio <= 0)
                {
                    throw new Exception("El precio debe ser mayor a 0.");
                }

                // Validar nombre duplicado (excluyendo el artículo actual, solo para este administrador)
                if (ExisteNombre(articulo.Nombre, articulo.IdArticulo, idAdministrador.Value))
                {
                    throw new Exception($"Ya existe otro artículo con el nombre '{articulo.Nombre}'. Por favor, elija otro nombre.");
                }

                datos.SetearConsulta(@"UPDATE ARTICULOS 
                                     SET Nombre=@Nombre, Descripcion=@Descripcion, Precio=@Precio, 
                                         IDCategoria=@IDCategoria, IDEstado=@IDEstado 
                                     WHERE IDArticulo=@IDArticulo AND IDAdministrador=@IDAdministrador AND Eliminado = 0");
                datos.SetearParametro("@IDArticulo", articulo.IdArticulo);
                datos.SetearParametro("@Nombre", articulo.Nombre);
                datos.SetearParametro("@Descripcion", (object)articulo.Descripcion ?? DBNull.Value);
                datos.SetearParametro("@Precio", articulo.Precio);
                datos.SetearParametro("@IDCategoria", articulo.CategoriaArticulo.IdCategoria);
                datos.SetearParametro("@IDEstado", articulo.EstadoArticulo.IdEstado);
                datos.SetearParametro("@IDAdministrador", idAdministrador.Value);

                datos.EjecutarAccion();
            }
            catch (Exception ex)
            {
                // Si ya es una excepción con mensaje personalizado, relanzarla
                if (ex.Message.Contains("Ya existe") || ex.Message.Contains("precio") || ex.Message.Contains("No se pudo modificar"))
                {
                    throw;
                }
                throw new Exception("Error al modificar el artículo: " + ex.Message, ex);
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

                // Verificar que el artículo existe y pertenece al administrador
                Articulo articulo = ObtenerPorId(id);
                if (articulo == null)
                {
                    throw new Exception("No se pudo eliminar el artículo. Puede que no exista, haya sido eliminado o no tenga permisos para acceder.");
                }

                // Validar que el artículo pertenece al administrador
                if (!TenantHelper.ValidarAccesoAdministrador(articulo.IDAdministrador))
                {
                    throw new UnauthorizedAccessException("No tiene permisos para eliminar este artículo.");
                }

                datos.SetearConsulta("UPDATE ARTICULOS SET Eliminado = 1 WHERE IDArticulo=@IDArticulo AND IDAdministrador=@IDAdministrador");
                datos.SetearParametro("@IDArticulo", id);
                datos.SetearParametro("@IDAdministrador", idAdministrador.Value);
                datos.EjecutarAccion();
            }
            catch (Exception ex)
            {
                throw new Exception("Error al eliminar el artículo: " + ex.Message, ex);
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public bool ExisteNombre(string nombre, int? idArticuloExcluir = null, int? idAdministrador = null)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                // Si no se especifica idAdministrador, intentar obtenerlo de la sesión
                if (!idAdministrador.HasValue)
                {
                    idAdministrador = TenantHelper.ObtenerIDAdministradorDesdeSesion();
                }

                string consulta = "SELECT COUNT(*) FROM ARTICULOS WHERE Nombre = @Nombre AND Eliminado = 0";
                
                if (idAdministrador.HasValue)
                {
                    consulta += " AND IDAdministrador = @IDAdministrador";
                }
                
                if (idArticuloExcluir.HasValue)
                {
                    consulta += " AND IDArticulo != @IDArticulo";
                }

                datos.SetearConsulta(consulta);
                datos.SetearParametro("@Nombre", nombre);
                
                if (idAdministrador.HasValue)
                {
                    datos.SetearParametro("@IDAdministrador", idAdministrador.Value);
                }
                
                if (idArticuloExcluir.HasValue)
                {
                    datos.SetearParametro("@IDArticulo", idArticuloExcluir.Value);
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

        public List<Articulo> Buscar(string criterio, int? idAdministrador = null)
        {
            List<Articulo> lista = new List<Articulo>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                // Si no se especifica idAdministrador, intentar obtenerlo de la sesión
                if (!idAdministrador.HasValue)
                {
                    idAdministrador = TenantHelper.ObtenerIDAdministradorDesdeSesion();
                }

                string whereClause = "WHERE a.Eliminado = 0 AND (a.Nombre LIKE @Criterio OR a.Descripcion LIKE @Criterio OR c.Nombre LIKE @Criterio)";
                if (idAdministrador.HasValue)
                {
                    whereClause += " AND a.IDAdministrador = @IDAdministrador";
                }

                datos.SetearConsulta(@"
                    SELECT 
                        a.IDArticulo, 
                        a.Nombre, 
                        a.Descripcion, 
                        a.Precio,
                        a.IDAdministrador,
                        c.IDCategoria,
                        c.Nombre as CategoriaNombre,
                        e.IDEstado,
                        e.Nombre as EstadoNombre,
                        img.RutaImagen AS ImagenPrincipal
                    FROM ARTICULOS a
                    INNER JOIN CATEGORIAS c ON a.IDCategoria = c.IDCategoria
                    INNER JOIN ESTADOSARTICULO e ON a.IDEstado = e.IDEstado
                    OUTER APPLY (
                        SELECT TOP 1 RutaImagen
                        FROM IMAGENESARTICULO ii
                        WHERE ii.IDArticulo = a.IDArticulo
                        ORDER BY ii.IDImagen
                    ) img
                    " + whereClause + @"
                    ORDER BY a.IDArticulo DESC");

                string criterioBusqueda = "%" + criterio + "%";
                datos.SetearParametro("@Criterio", criterioBusqueda);
                if (idAdministrador.HasValue)
                {
                    datos.SetearParametro("@IDAdministrador", idAdministrador.Value);
                }
                datos.EjecutarLectura();

                while (datos.Lector.Read())
                {
                    Articulo art = new Articulo();
                    art.IdArticulo = (int)datos.Lector["IDArticulo"];
                    art.Nombre = (string)datos.Lector["Nombre"];
                    art.Descripcion = datos.Lector["Descripcion"] != DBNull.Value ? (string)datos.Lector["Descripcion"] : null;
                    art.Precio = (decimal)datos.Lector["Precio"];
                    art.IDAdministrador = datos.Lector["IDAdministrador"] != DBNull.Value ? Convert.ToInt32(datos.Lector["IDAdministrador"]) : 0;

                    art.CategoriaArticulo = new Categoria();
                    art.CategoriaArticulo.IdCategoria = (int)datos.Lector["IDCategoria"];
                    art.CategoriaArticulo.Nombre = (string)datos.Lector["CategoriaNombre"];

                    art.EstadoArticulo = new Estado();
                    art.EstadoArticulo.IdEstado = (int)datos.Lector["IDEstado"];
                    art.EstadoArticulo.Nombre = (string)datos.Lector["EstadoNombre"];

                    art.Imagenes = new List<Imagen>();
                    var imagenPrincipal = datos.Lector["ImagenPrincipal"];
                    if (imagenPrincipal != DBNull.Value)
                    {
                        art.Imagenes.Add(new Imagen
                        {
                            IdArticulo = art.IdArticulo,
                            RutaImagen = (string)imagenPrincipal
                        });
                    }

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

        public List<Articulo> ListarConPaginacion(int pagina, int registrosPorPagina, int? idAdministrador = null)
        {
            List<Articulo> lista = new List<Articulo>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                // Si no se especifica idAdministrador, intentar obtenerlo de la sesión
                if (!idAdministrador.HasValue)
                {
                    idAdministrador = TenantHelper.ObtenerIDAdministradorDesdeSesion();
                }

                int offset = (pagina - 1) * registrosPorPagina;
                string whereClause = "WHERE a.Eliminado = 0";
                if (idAdministrador.HasValue)
                {
                    whereClause += " AND a.IDAdministrador = @IDAdministrador";
                }

                datos.SetearConsulta(@"
                    SELECT 
                        a.IDArticulo, 
                        a.Nombre, 
                        a.Descripcion, 
                        a.Precio,
                        a.IDAdministrador,
                        c.IDCategoria,
                        c.Nombre as CategoriaNombre,
                        e.IDEstado,
                        e.Nombre as EstadoNombre,
                        img.RutaImagen AS ImagenPrincipal
                    FROM ARTICULOS a
                    INNER JOIN CATEGORIAS c ON a.IDCategoria = c.IDCategoria
                    INNER JOIN ESTADOSARTICULO e ON a.IDEstado = e.IDEstado
                    OUTER APPLY (
                        SELECT TOP 1 RutaImagen
                        FROM IMAGENESARTICULO ii
                        WHERE ii.IDArticulo = a.IDArticulo
                        ORDER BY ii.IDImagen
                    ) img
                    " + whereClause + @"
                    ORDER BY a.IDArticulo DESC
                    OFFSET @Offset ROWS
                    FETCH NEXT @RegistrosPorPagina ROWS ONLY");

                datos.SetearParametro("@Offset", offset);
                datos.SetearParametro("@RegistrosPorPagina", registrosPorPagina);
                if (idAdministrador.HasValue)
                {
                    datos.SetearParametro("@IDAdministrador", idAdministrador.Value);
                }
                datos.EjecutarLectura();

                while (datos.Lector.Read())
                {
                    Articulo art = new Articulo();
                    art.IdArticulo = (int)datos.Lector["IDArticulo"];
                    art.Nombre = (string)datos.Lector["Nombre"];
                    art.Descripcion = datos.Lector["Descripcion"] != DBNull.Value ? (string)datos.Lector["Descripcion"] : null;
                    art.Precio = (decimal)datos.Lector["Precio"];
                    art.IDAdministrador = datos.Lector["IDAdministrador"] != DBNull.Value ? Convert.ToInt32(datos.Lector["IDAdministrador"]) : 0;

                    art.CategoriaArticulo = new Categoria();
                    art.CategoriaArticulo.IdCategoria = (int)datos.Lector["IDCategoria"];
                    art.CategoriaArticulo.Nombre = (string)datos.Lector["CategoriaNombre"];

                    art.EstadoArticulo = new Estado();
                    art.EstadoArticulo.IdEstado = (int)datos.Lector["IDEstado"];
                    art.EstadoArticulo.Nombre = (string)datos.Lector["EstadoNombre"];

                    art.Imagenes = new List<Imagen>();
                    var imagenPrincipal = datos.Lector["ImagenPrincipal"];
                    if (imagenPrincipal != DBNull.Value)
                    {
                        art.Imagenes.Add(new Imagen
                        {
                            IdArticulo = art.IdArticulo,
                            RutaImagen = (string)imagenPrincipal
                        });
                    }

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

        public int ContarTotal(string criterio = null, int? idAdministrador = null)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                // Si no se especifica idAdministrador, intentar obtenerlo de la sesión
                if (!idAdministrador.HasValue)
                {
                    idAdministrador = TenantHelper.ObtenerIDAdministradorDesdeSesion();
                }

                string consulta = "SELECT COUNT(*) FROM ARTICULOS a INNER JOIN CATEGORIAS c ON a.IDCategoria = c.IDCategoria WHERE a.Eliminado = 0";
                
                if (idAdministrador.HasValue)
                {
                    consulta += " AND a.IDAdministrador = @IDAdministrador";
                }
                
                if (!string.IsNullOrEmpty(criterio))
                {
                    consulta += " AND (a.Nombre LIKE @Criterio OR a.Descripcion LIKE @Criterio OR c.Nombre LIKE @Criterio)";
                }

                datos.SetearConsulta(consulta);
                
                if (idAdministrador.HasValue)
                {
                    datos.SetearParametro("@IDAdministrador", idAdministrador.Value);
                }
                
                if (!string.IsNullOrEmpty(criterio))
                {
                    string criterioBusqueda = "%" + criterio + "%";
                    datos.SetearParametro("@Criterio", criterioBusqueda);
                }

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

        public List<Articulo> ListarConFiltrosYPaginacion(int pagina, int registrosPorPagina, string criterio = null, int? idCategoria = null, int? idEstado = null, int? idAdministrador = null)
        {
            List<Articulo> lista = new List<Articulo>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                // Si no se especifica idAdministrador, intentar obtenerlo de la sesión
                if (!idAdministrador.HasValue)
                {
                    idAdministrador = TenantHelper.ObtenerIDAdministradorDesdeSesion();
                }

                int offset = (pagina - 1) * registrosPorPagina;
                string whereClause = "WHERE a.Eliminado = 0";

                if (idAdministrador.HasValue)
                {
                    whereClause += " AND a.IDAdministrador = @IDAdministrador";
                }

                if (!string.IsNullOrEmpty(criterio))
                {
                    whereClause += " AND (a.Nombre LIKE @Criterio OR a.Descripcion LIKE @Criterio OR c.Nombre LIKE @Criterio)";
                }

                if (idCategoria.HasValue)
                {
                    whereClause += " AND a.IDCategoria = @IDCategoria";
                }

                if (idEstado.HasValue)
                {
                    whereClause += " AND a.IDEstado = @IDEstado";
                }

                string consulta = @"
                    SELECT 
                        a.IDArticulo, 
                        a.Nombre, 
                        a.Descripcion, 
                        a.Precio,
                        a.IDAdministrador,
                        c.IDCategoria,
                        c.Nombre as CategoriaNombre,
                        e.IDEstado,
                        e.Nombre as EstadoNombre,
                        img.RutaImagen AS ImagenPrincipal
                    FROM ARTICULOS a
                    INNER JOIN CATEGORIAS c ON a.IDCategoria = c.IDCategoria
                    INNER JOIN ESTADOSARTICULO e ON a.IDEstado = e.IDEstado
                    OUTER APPLY (
                        SELECT TOP 1 RutaImagen
                        FROM IMAGENESARTICULO ii
                        WHERE ii.IDArticulo = a.IDArticulo
                        ORDER BY ii.IDImagen
                    ) img
                    " + whereClause + @"
                    ORDER BY a.IDArticulo DESC
                    OFFSET @Offset ROWS
                    FETCH NEXT @RegistrosPorPagina ROWS ONLY";
                
                datos.SetearConsulta(consulta);

                datos.SetearParametro("@Offset", offset);
                datos.SetearParametro("@RegistrosPorPagina", registrosPorPagina);

                if (idAdministrador.HasValue)
                {
                    datos.SetearParametro("@IDAdministrador", idAdministrador.Value);
                }

                if (!string.IsNullOrEmpty(criterio))
                {
                    string criterioBusqueda = "%" + criterio + "%";
                    datos.SetearParametro("@Criterio", criterioBusqueda);
                }

                if (idCategoria.HasValue)
                {
                    datos.SetearParametro("@IDCategoria", idCategoria.Value);
                }

                if (idEstado.HasValue)
                {
                    datos.SetearParametro("@IDEstado", idEstado.Value);
                }

                datos.EjecutarLectura();

                while (datos.Lector.Read())
                {
                    Articulo art = new Articulo();
                    art.IdArticulo = (int)datos.Lector["IDArticulo"];
                    art.Nombre = (string)datos.Lector["Nombre"];
                    art.Descripcion = datos.Lector["Descripcion"] != DBNull.Value ? (string)datos.Lector["Descripcion"] : null;
                    art.Precio = (decimal)datos.Lector["Precio"];
                    art.IDAdministrador = datos.Lector["IDAdministrador"] != DBNull.Value ? Convert.ToInt32(datos.Lector["IDAdministrador"]) : 0;

                    art.CategoriaArticulo = new Categoria();
                    art.CategoriaArticulo.IdCategoria = (int)datos.Lector["IDCategoria"];
                    art.CategoriaArticulo.Nombre = (string)datos.Lector["CategoriaNombre"];

                    art.EstadoArticulo = new Estado();
                    art.EstadoArticulo.IdEstado = (int)datos.Lector["IDEstado"];
                    art.EstadoArticulo.Nombre = (string)datos.Lector["EstadoNombre"];

                    art.Imagenes = new List<Imagen>();
                    var imagenPrincipal = datos.Lector["ImagenPrincipal"];
                    if (imagenPrincipal != DBNull.Value)
                    {
                        art.Imagenes.Add(new Imagen
                        {
                            IdArticulo = art.IdArticulo,
                            RutaImagen = (string)imagenPrincipal
                        });
                    }

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

        public int ContarConFiltros(string criterio = null, int? idCategoria = null, int? idEstado = null, int? idAdministrador = null)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                // Si no se especifica idAdministrador, intentar obtenerlo de la sesión
                if (!idAdministrador.HasValue)
                {
                    idAdministrador = TenantHelper.ObtenerIDAdministradorDesdeSesion();
                }

                string consulta = "SELECT COUNT(*) FROM ARTICULOS a INNER JOIN CATEGORIAS c ON a.IDCategoria = c.IDCategoria WHERE a.Eliminado = 0";

                if (idAdministrador.HasValue)
                {
                    consulta += " AND a.IDAdministrador = @IDAdministrador";
                }

                if (!string.IsNullOrEmpty(criterio))
                {
                    consulta += " AND (a.Nombre LIKE @Criterio OR a.Descripcion LIKE @Criterio OR c.Nombre LIKE @Criterio)";
                }

                if (idCategoria.HasValue)
                {
                    consulta += " AND a.IDCategoria = @IDCategoria";
                }

                if (idEstado.HasValue)
                {
                    consulta += " AND a.IDEstado = @IDEstado";
                }

                datos.SetearConsulta(consulta);

                if (idAdministrador.HasValue)
                {
                    datos.SetearParametro("@IDAdministrador", idAdministrador.Value);
                }

                if (!string.IsNullOrEmpty(criterio))
                {
                    string criterioBusqueda = "%" + criterio + "%";
                    datos.SetearParametro("@Criterio", criterioBusqueda);
                }

                if (idCategoria.HasValue)
                {
                    datos.SetearParametro("@IDCategoria", idCategoria.Value);
                }

                if (idEstado.HasValue)
                {
                    datos.SetearParametro("@IDEstado", idEstado.Value);
                }

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
