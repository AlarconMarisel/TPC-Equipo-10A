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

    }
}
