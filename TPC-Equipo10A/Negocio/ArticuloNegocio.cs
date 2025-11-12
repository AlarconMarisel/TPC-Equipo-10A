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
        public List<Articulo> listarArticulo()
        {
            List<Articulo> lista = new List<Articulo>();
            AccesoDatos datos = new AccesoDatos();
          
            try
            {
                datos.SetearConsulta(@"
                    SELECT 
                        a.IDArticulo, 
                        a.Nombre, 
                        a.Descripcion, 
                        a.Precio,
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
                    WHERE a.Eliminado = 0
                    ORDER BY a.IDArticulo DESC");

                datos.EjecutarLectura();

                while (datos.Lector.Read())
                {
                    Articulo art = new Articulo();

                    
                    art.IdArticulo = (int)datos.Lector["IDArticulo"];
                    art.Nombre = (string)datos.Lector["Nombre"];
                    art.Descripcion = (string)datos.Lector["Descripcion"];
                    art.Precio = (decimal)datos.Lector["Precio"];

                    
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
                datos.SetearConsulta(@"
                    SELECT 
                        a.IDArticulo, 
                        a.Nombre, 
                        a.Descripcion, 
                        a.Precio,
                        c.IDCategoria,
                        c.Nombre as CategoriaNombre,
                        e.IDEstado,
                        e.Nombre as EstadoNombre
                    FROM ARTICULOS a
                    INNER JOIN CATEGORIAS c ON a.IDCategoria = c.IDCategoria
                    INNER JOIN ESTADOSARTICULO e ON a.IDEstado = e.IDEstado
                    WHERE a.IDArticulo = @IDArticulo AND a.Eliminado = 0");

                datos.SetearParametro("@IDArticulo", id);
                datos.EjecutarLectura();

                if (datos.Lector.Read())
                {
                    art = new Articulo();
                    art.IdArticulo = (int)datos.Lector["IDArticulo"];
                    art.Nombre = (string)datos.Lector["Nombre"];
                    art.Descripcion = datos.Lector["Descripcion"] != DBNull.Value ? (string)datos.Lector["Descripcion"] : null;
                    art.Precio = (decimal)datos.Lector["Precio"];

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
                datos.SetearConsulta(@"INSERT INTO ARTICULOS (Nombre, Descripcion, Precio, IDCategoria, IDEstado, Eliminado) 
                                     VALUES (@Nombre, @Descripcion, @Precio, @IDCategoria, @IDEstado, 0); 
                                     SELECT SCOPE_IDENTITY();");
                datos.SetearParametro("@Nombre", nuevo.Nombre);
                datos.SetearParametro("@Descripcion", (object)nuevo.Descripcion ?? DBNull.Value);
                datos.SetearParametro("@Precio", nuevo.Precio);
                datos.SetearParametro("@IDCategoria", nuevo.CategoriaArticulo.IdCategoria);
                datos.SetearParametro("@IDEstado", nuevo.EstadoArticulo.IdEstado);

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

        public void Modificar(Articulo articulo)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.SetearConsulta(@"UPDATE ARTICULOS 
                                     SET Nombre=@Nombre, Descripcion=@Descripcion, Precio=@Precio, 
                                         IDCategoria=@IDCategoria, IDEstado=@IDEstado 
                                     WHERE IDArticulo=@IDArticulo AND Eliminado = 0");
                datos.SetearParametro("@IDArticulo", articulo.IdArticulo);
                datos.SetearParametro("@Nombre", articulo.Nombre);
                datos.SetearParametro("@Descripcion", (object)articulo.Descripcion ?? DBNull.Value);
                datos.SetearParametro("@Precio", articulo.Precio);
                datos.SetearParametro("@IDCategoria", articulo.CategoriaArticulo.IdCategoria);
                datos.SetearParametro("@IDEstado", articulo.EstadoArticulo.IdEstado);

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

        public void Eliminar(int id)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.SetearConsulta("UPDATE ARTICULOS SET Eliminado = 1 WHERE IDArticulo=@IDArticulo");
                datos.SetearParametro("@IDArticulo", id);
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

        public List<Articulo> Buscar(string criterio)
        {
            List<Articulo> lista = new List<Articulo>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.SetearConsulta(@"
                    SELECT 
                        a.IDArticulo, 
                        a.Nombre, 
                        a.Descripcion, 
                        a.Precio,
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
                    WHERE a.Eliminado = 0 
                    AND (a.Nombre LIKE @Criterio OR a.Descripcion LIKE @Criterio OR c.Nombre LIKE @Criterio)
                    ORDER BY a.IDArticulo DESC");

                string criterioBusqueda = "%" + criterio + "%";
                datos.SetearParametro("@Criterio", criterioBusqueda);
                datos.EjecutarLectura();

                while (datos.Lector.Read())
                {
                    Articulo art = new Articulo();
                    art.IdArticulo = (int)datos.Lector["IDArticulo"];
                    art.Nombre = (string)datos.Lector["Nombre"];
                    art.Descripcion = datos.Lector["Descripcion"] != DBNull.Value ? (string)datos.Lector["Descripcion"] : null;
                    art.Precio = (decimal)datos.Lector["Precio"];

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

        public List<Articulo> ListarConPaginacion(int pagina, int registrosPorPagina)
        {
            List<Articulo> lista = new List<Articulo>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                int offset = (pagina - 1) * registrosPorPagina;

                datos.SetearConsulta(@"
                    SELECT 
                        a.IDArticulo, 
                        a.Nombre, 
                        a.Descripcion, 
                        a.Precio,
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
                    WHERE a.Eliminado = 0
                    ORDER BY a.IDArticulo DESC
                    OFFSET @Offset ROWS
                    FETCH NEXT @RegistrosPorPagina ROWS ONLY");

                datos.SetearParametro("@Offset", offset);
                datos.SetearParametro("@RegistrosPorPagina", registrosPorPagina);
                datos.EjecutarLectura();

                while (datos.Lector.Read())
                {
                    Articulo art = new Articulo();
                    art.IdArticulo = (int)datos.Lector["IDArticulo"];
                    art.Nombre = (string)datos.Lector["Nombre"];
                    art.Descripcion = datos.Lector["Descripcion"] != DBNull.Value ? (string)datos.Lector["Descripcion"] : null;
                    art.Precio = (decimal)datos.Lector["Precio"];

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

        public int ContarTotal(string criterio = null)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                string consulta = "SELECT COUNT(*) FROM ARTICULOS a INNER JOIN CATEGORIAS c ON a.IDCategoria = c.IDCategoria WHERE a.Eliminado = 0";
                
                if (!string.IsNullOrEmpty(criterio))
                {
                    consulta += " AND (a.Nombre LIKE @Criterio OR a.Descripcion LIKE @Criterio OR c.Nombre LIKE @Criterio)";
                }

                datos.SetearConsulta(consulta);
                
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

        public List<Articulo> ListarConFiltrosYPaginacion(int pagina, int registrosPorPagina, string criterio = null, int? idCategoria = null, int? idEstado = null)
        {
            List<Articulo> lista = new List<Articulo>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                int offset = (pagina - 1) * registrosPorPagina;
                string whereClause = "WHERE a.Eliminado = 0";

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

        public int ContarConFiltros(string criterio = null, int? idCategoria = null, int? idEstado = null)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                string consulta = "SELECT COUNT(*) FROM ARTICULOS a INNER JOIN CATEGORIAS c ON a.IDCategoria = c.IDCategoria WHERE a.Eliminado = 0";

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
