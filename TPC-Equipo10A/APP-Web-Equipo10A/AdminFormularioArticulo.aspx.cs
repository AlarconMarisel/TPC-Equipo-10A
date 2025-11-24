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

        /// <summary>
        /// Valida que el usuario es administrador activo
        /// </summary>
        private bool ValidarAccesoAdministrador()
        {
            if (!ValidacionHelper.ValidarEsAdministradorActivo())
            {
                Response.Write("<script>alert('Su cuenta de administrador está inactiva o ha vencido. Contacte al super administrador.');</script>");
                return false;
            }
            return true;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            // Valida acceso de administrador
            if (!ValidarAccesoAdministrador())
            {
                Response.Redirect("Default.aspx");
                return;
            }

            try
            {
                if (Page.Form != null)
                {
                    Page.Form.Enctype = "multipart/form-data";
                }

                if (!IsPostBack)
                {
                    CargarCategorias();
                    CargarEstados();

                    string idParam = Request.QueryString["id"];
                    if (!string.IsNullOrEmpty(idParam) && int.TryParse(idParam, out int id))
                    {
                        IdArticuloActual = id;
                        CargarArticuloParaEdicion(id);
                    }
                    else
                    {
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
                if (!Page.IsValid)
                {
                    return;
                }

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

                if (imagenesNuevas > 0)
                {
                    string errorValidacion = ValidarArchivos(fileUploadImagenes.PostedFiles);
                    if (!string.IsNullOrEmpty(errorValidacion))
                    {
                        MostrarError(errorValidacion);
                        return;
                    }
                }

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
                    articulo.IdArticulo = IdArticuloActual.Value;
                    articuloNegocio.Modificar(articulo);
                    idArticulo = IdArticuloActual.Value;
                }
                else
                {
                    idArticulo = articuloNegocio.Agregar(articulo);
                }

                if (imagenesNuevas > 0)
                {
                    GuardarImagenes(idArticulo, fileUploadImagenes.PostedFiles);
                }

                string mensaje = IdArticuloActual.HasValue ? "editado" : "creado";
                Response.Redirect($"AdminGestionArticulo.aspx?exito={mensaje}", false);
            }
            catch (Exception ex)
            {
                MostrarError(ex.Message);
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

                string extension = Path.GetExtension(archivo.FileName).ToLower();
                if (!extensionesPermitidas.Contains(extension))
                {
                    return $"El archivo '{archivo.FileName}' tiene una extensión no permitida. Use: JPG, PNG, GIF o WEBP.";
                }

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
            
            if (!Directory.Exists(carpetaImagenes))
            {
                Directory.CreateDirectory(carpetaImagenes);
            }

            ImagenNegocio imagenNegocio = new ImagenNegocio();

            foreach (HttpPostedFile archivo in archivos)
            {
                if (archivo.ContentLength == 0)
                    continue;

                string extension = Path.GetExtension(archivo.FileName);
                string nombreArchivo = $"articulo_{idArticulo}_{DateTime.Now.Ticks}_{Path.GetFileNameWithoutExtension(archivo.FileName)}{extension}";
                string rutaCompleta = Path.Combine(carpetaImagenes, nombreArchivo);

                archivo.SaveAs(rutaCompleta);

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

                ImagenNegocio imagenNegocio = new ImagenNegocio();
                var imagenes = imagenNegocio.ListarPorArticulo(IdArticuloActual ?? 0);
                var imagenAEliminar = imagenes.FirstOrDefault(img => img.IdImagen == idImagen);

                if (imagenAEliminar != null)
                {
                    string rutaFisica = Server.MapPath("~/" + imagenAEliminar.RutaImagen);
                    if (File.Exists(rutaFisica))
                    {
                        File.Delete(rutaFisica);
                    }

                    imagenNegocio.EliminarImagen(idImagen);
                }

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
            lblMensaje.Text = $"<div style='padding: 1rem; background-color: #fee; border: 1px solid #fcc; border-radius: 0.5rem; color: #c33;'>{Server.HtmlEncode(mensaje)}</div>";
            lblMensaje.Visible = true;
            lblMensaje.CssClass = "mt-2";
        }

        private void MostrarExito(string mensaje)
        {
            lblMensaje.Text = $"<div style='padding: 1rem; background-color: #efe; border: 1px solid #cfc; border-radius: 0.5rem; color: #3c3;'>{Server.HtmlEncode(mensaje)}</div>";
            lblMensaje.Visible = true;
            lblMensaje.CssClass = "mt-2";
        }
    }
}
