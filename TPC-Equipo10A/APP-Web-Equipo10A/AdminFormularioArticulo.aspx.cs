using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Negocio;
using Dominio;
using System.IO;

namespace APP_Web_Equipo10A
{
    public partial class AdminFormularioArticulo : System.Web.UI.Page
    {
        private int? IdArticuloActual
        {
            get
            {
                if (ViewState["IdArticuloActual"] != null)
                    return (int?)ViewState["IdArticuloActual"];
                return null;
            }
            set
            {
                ViewState["IdArticuloActual"] = value;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                // Establecer enctype para permitir subida de archivos
                if (Page.Form != null)
                {
                    Page.Form.Enctype = "multipart/form-data";
                }

                if (!IsPostBack)
                {
                    CargarCategorias();
                    CargarEstados();

                    // Verificar si es modo edición
                    string idParam = Request.QueryString["id"];
                    if (!string.IsNullOrEmpty(idParam) && int.TryParse(idParam, out int id))
                    {
                        IdArticuloActual = id;
                        CargarArticuloParaEdicion(id);
                    }
                    else
                    {
                        // Modo creación
                        IdArticuloActual = null;
                    }
                }
            }
            catch (Exception ex)
            {
                MostrarError("Error al cargar la página: " + ex.Message);
            }
        }

        private void CargarCategorias()
        {
            CategoriaNegocio categoriaNegocio = new CategoriaNegocio();
            ddlCategoria.DataSource = categoriaNegocio.ListarCategorias();
            ddlCategoria.DataTextField = "Nombre";
            ddlCategoria.DataValueField = "IdCategoria";
            ddlCategoria.DataBind();
            ddlCategoria.Items.Insert(0, new ListItem("Seleccione una categoría", "0"));
        }

        private void CargarEstados()
        {
            EstadoNegocio estadoNegocio = new EstadoNegocio();
            ddlEstado.DataSource = estadoNegocio.ListarEstados();
            ddlEstado.DataTextField = "Nombre";
            ddlEstado.DataValueField = "IdEstado";
            ddlEstado.DataBind();
            ddlEstado.Items.Insert(0, new ListItem("Seleccione un estado", "0"));
        }

        private void CargarArticuloParaEdicion(int id)
        {
            ArticuloNegocio articuloNegocio = new ArticuloNegocio();
            Articulo articulo = articuloNegocio.ObtenerPorId(id);

            if (articulo != null)
            {
                txtNombre.Text = articulo.Nombre;
                txtDescripcion.Text = articulo.Descripcion ?? "";
                txtPrecio.Text = articulo.Precio.ToString("F2");
                ddlCategoria.SelectedValue = articulo.CategoriaArticulo.IdCategoria.ToString();
                ddlEstado.SelectedValue = articulo.EstadoArticulo.IdEstado.ToString();

                // Cargar imágenes existentes
                if (articulo.Imagenes != null && articulo.Imagenes.Count > 0)
                {
                    repImagenes.DataSource = articulo.Imagenes;
                    repImagenes.DataBind();
                    pnlImagenesExistentes.Visible = true;
                }

                btnGuardar.Text = "Actualizar Artículo";
            }
            else
            {
                MostrarError("El artículo no existe o fue eliminado.");
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            try
            {
                // Validar página
                if (!Page.IsValid)
                {
                    return;
                }

                // Validar imágenes
                int imagenesExistentes = 0;
                if (IdArticuloActual.HasValue)
                {
                    ImagenNegocio imagenNegocio = new ImagenNegocio();
                    imagenesExistentes = imagenNegocio.ContarPorArticulo(IdArticuloActual.Value);
                }

                int imagenesNuevas = fileUploadImagenes.PostedFiles.Count;
                int totalImagenes = imagenesExistentes + imagenesNuevas;

                if (totalImagenes > 5)
                {
                    MostrarError($"El artículo puede tener máximo 5 imágenes. Actualmente tiene {imagenesExistentes} y está intentando agregar {imagenesNuevas}.");
                    return;
                }

                // Validar archivos
                if (imagenesNuevas > 0)
                {
                    string errorValidacion = ValidarArchivos(fileUploadImagenes.PostedFiles);
                    if (!string.IsNullOrEmpty(errorValidacion))
                    {
                        MostrarError(errorValidacion);
                        return;
                    }
                }

                // Crear objeto Artículo
                Articulo articulo = new Articulo
                {
                    Nombre = txtNombre.Text.Trim(),
                    Descripcion = string.IsNullOrWhiteSpace(txtDescripcion.Text) ? null : txtDescripcion.Text.Trim(),
                    Precio = decimal.Parse(txtPrecio.Text),
                    CategoriaArticulo = new Categoria
                    {
                        IdCategoria = int.Parse(ddlCategoria.SelectedValue)
                    },
                    EstadoArticulo = new Estado
                    {
                        IdEstado = int.Parse(ddlEstado.SelectedValue)
                    }
                };

                ArticuloNegocio articuloNegocio = new ArticuloNegocio();
                int idArticulo;

                if (IdArticuloActual.HasValue)
                {
                    // Modo edición
                    articulo.IdArticulo = IdArticuloActual.Value;
                    articuloNegocio.Modificar(articulo);
                    idArticulo = IdArticuloActual.Value;
                }
                else
                {
                    // Modo creación
                    idArticulo = articuloNegocio.Agregar(articulo);
                }

                // Procesar imágenes
                if (imagenesNuevas > 0)
                {
                    GuardarImagenes(idArticulo, fileUploadImagenes.PostedFiles);
                }

                // Redirigir al listado
                Response.Redirect("AdminGestionArticulo.aspx", false);
            }
            catch (Exception ex)
            {
                MostrarError("Error al guardar el artículo: " + ex.Message);
            }
        }

        private string ValidarArchivos(IList<HttpPostedFile> archivos)
        {
            string[] extensionesPermitidas = { ".jpg", ".jpeg", ".png", ".gif", ".webp" };
            long tamanoMaximo = 10 * 1024 * 1024; // 10MB

            foreach (HttpPostedFile archivo in archivos)
            {
                if (archivo.ContentLength == 0)
                    continue;

                // Validar extensión
                string extension = Path.GetExtension(archivo.FileName).ToLower();
                if (!extensionesPermitidas.Contains(extension))
                {
                    return $"El archivo '{archivo.FileName}' tiene una extensión no permitida. Use: JPG, PNG, GIF o WEBP.";
                }

                // Validar tamaño
                if (archivo.ContentLength > tamanoMaximo)
                {
                    return $"El archivo '{archivo.FileName}' excede el tamaño máximo de 10MB.";
                }
            }

            return null;
        }

        private void GuardarImagenes(int idArticulo, IList<HttpPostedFile> archivos)
        {
            string carpetaImagenes = Server.MapPath("~/Content/Uploads/Articulos/");
            
            // Crear carpeta si no existe
            if (!Directory.Exists(carpetaImagenes))
            {
                Directory.CreateDirectory(carpetaImagenes);
            }

            ImagenNegocio imagenNegocio = new ImagenNegocio();

            foreach (HttpPostedFile archivo in archivos)
            {
                if (archivo.ContentLength == 0)
                    continue;

                // Generar nombre único
                string extension = Path.GetExtension(archivo.FileName);
                string nombreArchivo = $"articulo_{idArticulo}_{DateTime.Now.Ticks}_{Path.GetFileNameWithoutExtension(archivo.FileName)}{extension}";
                string rutaCompleta = Path.Combine(carpetaImagenes, nombreArchivo);

                // Guardar archivo físicamente
                archivo.SaveAs(rutaCompleta);

                // Guardar ruta en BD (ruta relativa)
                string rutaRelativa = $"Content/Uploads/Articulos/{nombreArchivo}";
                Imagen imagen = new Imagen
                {
                    IdArticulo = idArticulo,
                    RutaImagen = rutaRelativa
                };

                imagenNegocio.AgregarImagen(imagen);
            }
        }

        protected void btnEliminarImagen_Click(object sender, EventArgs e)
        {
            try
            {
                LinkButton btn = (LinkButton)sender;
                int idImagen = int.Parse(btn.CommandArgument);

                // Obtener la imagen para eliminar el archivo físico
                ImagenNegocio imagenNegocio = new ImagenNegocio();
                var imagenes = imagenNegocio.ListarPorArticulo(IdArticuloActual ?? 0);
                var imagenAEliminar = imagenes.FirstOrDefault(img => img.IdImagen == idImagen);

                if (imagenAEliminar != null)
                {
                    // Eliminar archivo físico
                    string rutaFisica = Server.MapPath("~/" + imagenAEliminar.RutaImagen);
                    if (File.Exists(rutaFisica))
                    {
                        File.Delete(rutaFisica);
                    }

                    // Eliminar de BD
                    imagenNegocio.EliminarImagen(idImagen);
                }

                // Recargar página para actualizar imágenes
                if (IdArticuloActual.HasValue)
                {
                    Response.Redirect($"AdminFormularioArticulo.aspx?id={IdArticuloActual.Value}", false);
                }
            }
            catch (Exception ex)
            {
                MostrarError("Error al eliminar la imagen: " + ex.Message);
            }
        }

        private void MostrarError(string mensaje)
        {
            lblMensaje.Text = mensaje;
            lblMensaje.Visible = true;
        }
    }
}
