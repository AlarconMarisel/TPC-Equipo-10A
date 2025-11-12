using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Negocio;
using Dominio;

namespace APP_Web_Equipo10A
{
    public partial class AdminFormularioCategoria : System.Web.UI.Page
    {
        private int? IdCategoriaActual
        {
            get
            {
                if (ViewState["IdCategoriaActual"] != null)
                    return (int?)ViewState["IdCategoriaActual"];
                return null;
            }
            set
            {
                ViewState["IdCategoriaActual"] = value;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string idParam = Request.QueryString["id"];
                if (!string.IsNullOrEmpty(idParam) && int.TryParse(idParam, out int id))
                {
                    IdCategoriaActual = id;
                    CargarCategoriaParaEdicion(id);
                }
                else
                {
                    IdCategoriaActual = null;
                }
            }
        }

        private void CargarCategoriaParaEdicion(int id)
        {
            try
            {
                CategoriaNegocio categoriaNegocio = new CategoriaNegocio();
                Categoria categoria = categoriaNegocio.ObtenerPorId(id);

                if (categoria != null)
                {
                    txtNombre.Text = categoria.Nombre;
                    btnGuardar.Text = "Actualizar Categoría";
                    lblTitulo.Text = "Editar Categoría";
                }
                else
                {
                    MostrarError("La categoría no existe o fue eliminada.");
                }
            }
            catch (Exception ex)
            {
                MostrarError("Error al cargar la categoría: " + ex.Message);
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

                Categoria categoria = new Categoria
                {
                    Nombre = txtNombre.Text.Trim()
                };

                CategoriaNegocio categoriaNegocio = new CategoriaNegocio();

                if (IdCategoriaActual.HasValue)
                {
                    categoria.IdCategoria = IdCategoriaActual.Value;
                    categoriaNegocio.ModificarCategoria(categoria);
                    Response.Redirect("AdminGestionCategoria.aspx?exito=editado", false);
                }
                else
                {
                    bool fueReactivada;
                    categoriaNegocio.AgregarCategoria(categoria, out fueReactivada);
                    string mensaje = fueReactivada ? "reactivado" : "creado";
                    Response.Redirect($"AdminGestionCategoria.aspx?exito={mensaje}", false);
                }
            }
            catch (Exception ex)
            {
                MostrarError(ex.Message);
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

