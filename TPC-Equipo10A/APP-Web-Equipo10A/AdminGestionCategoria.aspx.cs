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
    public partial class AdminGestionCategoria : System.Web.UI.Page
    {
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

            if (!IsPostBack)
            {
                string exito = Request.QueryString["exito"];
                if (!string.IsNullOrEmpty(exito))
                {
                    string mensaje = "";
                    switch (exito.ToLower())
                    {
                        case "creado":
                            mensaje = "La categoría se ha creado exitosamente.";
                            break;
                        case "reactivado":
                            mensaje = "La categoría se ha reactivado exitosamente (existía previamente eliminada).";
                            break;
                        case "editado":
                            mensaje = "La categoría se ha actualizado exitosamente.";
                            break;
                        case "eliminado":
                            mensaje = "La categoría se ha eliminado exitosamente.";
                            break;
                    }
                    if (!string.IsNullOrEmpty(mensaje))
                    {
                        MostrarExito(mensaje);
                    }
                }
            }
            CargarCategorias();
        }

        private void CargarCategorias()
        {
            try
            {
                string criterio = string.IsNullOrWhiteSpace(txtBusqueda.Text) ? null : txtBusqueda.Text.Trim();

                CategoriaNegocio categoriaNegocio = new CategoriaNegocio();
                List<Categoria> categorias;

                if (string.IsNullOrEmpty(criterio))
                {
                    categorias = categoriaNegocio.ListarCategorias();
                }
                else
                {
                    categorias = categoriaNegocio.Buscar(criterio);
                }

                if (categorias != null && categorias.Count > 0)
                {
                    repCategorias.DataSource = categorias;
                    repCategorias.DataBind();
                    lblSinCategorias.Visible = false;
                    repCategorias.Visible = true;
                }
                else
                {
                    repCategorias.Visible = false;
                    lblSinCategorias.Visible = true;
                }
            }
            catch (Exception ex)
            {
                MostrarError("Error al cargar categorías: " + ex.Message);
                lblSinCategorias.Text = "<tr><td colspan='3' class='text-center text-muted' style='padding: 2rem;'>No se pudieron cargar las categorías.</td></tr>";
                lblSinCategorias.Visible = true;
                repCategorias.Visible = false;
            }
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            try
            {
                CargarCategorias();
            }
            catch (Exception ex)
            {
                MostrarError("Error al buscar: " + ex.Message);
                CargarCategorias();
            }
        }

        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            try
            {
                LinkButton btn = (LinkButton)sender;
                int idCategoria = int.Parse(btn.CommandArgument);

                CategoriaNegocio categoriaNegocio = new CategoriaNegocio();
                categoriaNegocio.Eliminar(idCategoria);

                // Redirige con mensaje de exito
                Response.Redirect("AdminGestionCategoria.aspx?exito=eliminado", false);
            }
            catch (Exception ex)
            {
                MostrarError(ex.Message);
                CargarCategorias();
            }
        }

        private void MostrarError(string mensaje)
        {
            string script = $@"
                <div id='mensajeError' style='position: fixed; top: 1rem; right: 1rem; z-index: 9999; padding: 1rem 1.5rem; background-color: #fee; border: 1px solid #fcc; border-radius: 0.5rem; color: #c33; box-shadow: 0 4px 6px rgba(0,0,0,0.1); max-width: 400px;'>
                    <strong>Error:</strong> {Server.HtmlEncode(mensaje)}
                    <button onclick='document.getElementById(""mensajeError"").remove()' style='float: right; background: none; border: none; color: #c33; font-size: 1.2rem; cursor: pointer; margin-left: 1rem;'>&times;</button>
                </div>
                <script>
                    setTimeout(function() {{
                        var el = document.getElementById('mensajeError');
                        if (el) el.remove();
                    }}, 5000);
                </script>";
            ClientScript.RegisterStartupScript(this.GetType(), "ErrorScript", script, false);
        }

        private void MostrarExito(string mensaje)
        {
            string script = $@"
                <div id='mensajeExito' style='position: fixed; top: 1rem; right: 1rem; z-index: 9999; padding: 1rem 1.5rem; background-color: #efe; border: 1px solid #cfc; border-radius: 0.5rem; color: #3c3; box-shadow: 0 4px 6px rgba(0,0,0,0.1); max-width: 400px;'>
                    <strong>Éxito:</strong> {Server.HtmlEncode(mensaje)}
                    <button onclick='document.getElementById(""mensajeExito"").remove()' style='float: right; background: none; border: none; color: #3c3; font-size: 1.2rem; cursor: pointer; margin-left: 1rem;'>&times;</button>
                </div>
                <script>
                    setTimeout(function() {{
                        var el = document.getElementById('mensajeExito');
                        if (el) el.remove();
                    }}, 5000);
                </script>";
            ClientScript.RegisterStartupScript(this.GetType(), "ExitoScript", script, false);
        }
    }
}

