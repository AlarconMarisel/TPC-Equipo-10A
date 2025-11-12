using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Negocio;

namespace APP_Web_Equipo10A
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                
                CargarArticulosRecientes();

                
                var query = Request["q"];
                if (!string.IsNullOrWhiteSpace(query))
                {
                    txtBusqueda.Text = query;
                    BuscarArticulos(query);
                }
            }
        }

        private void CargarTodosLosArticulos()
        {
            try
            {
                var negocio = new ArticuloNegocio();
                var articulos = negocio.listarArticulo();

                if (articulos != null && articulos.Count > 0)
                {
                    pnlResultados.Visible = true;
                    litResumen.Text = $"<p class='text-muted mb-3'>Mostrando {articulos.Count} artículos disponibles</p>";
                    rptResultados.DataSource = articulos;
                    rptResultados.DataBind();
                }
                else
                {
                    pnlResultados.Visible = true;
                    litResumen.Text = "<p class='text-muted mb-3'>No hay artículos disponibles por el momento.</p>";
                }
            }
            catch (Exception ex)
            {
                litResumen.Text = $"<p class='text-danger'>Error al cargar artículos: {Server.HtmlEncode(ex.Message)}</p>";
                pnlResultados.Visible = true;
            }
        }


        private void BuscarArticulos(string query)
        {
            try
            {
                var negocio = new ArticuloNegocio();
                var articulos = negocio.listarArticulo();

                var filtrados = articulos
                    .Where(a =>
                        (a.Nombre ?? string.Empty).IndexOf(query, System.StringComparison.OrdinalIgnoreCase) >= 0 ||
                        (a.Descripcion ?? string.Empty).IndexOf(query, System.StringComparison.OrdinalIgnoreCase) >= 0 ||
                        (a.CategoriaArticulo?.Nombre ?? string.Empty).IndexOf(query, System.StringComparison.OrdinalIgnoreCase) >= 0)
                    .ToList();

                pnlResultados.Visible = true;
                litResumen.Text = $"<p class=\"text-muted mb-3\">Se encontraron {filtrados.Count} resultado(s) para \"{Server.HtmlEncode(query)}\"</p>";
                rptResultados.DataSource = filtrados;
                rptResultados.DataBind();
            }
            catch (Exception ex)
            {
                litResumen.Text = $"<p class=\"text-danger\">Error al buscar: {Server.HtmlEncode(ex.Message)}</p>";
                pnlResultados.Visible = true;
            }
        }

        private void CargarArticulosRecientes()
        {
            try
            {
                var negocio = new ArticuloNegocio();
                var articulos = negocio.listarArticulo();

                if (articulos.Count > 0)
                {
                    rptResultados.DataSource = articulos;
                    rptResultados.DataBind();
                    pnlResultados.Visible = true;
                    litResumen.Text = "<p class='text-muted mb-3'>Mostrando los artículos más recientes</p>";
                }
                else
                {
                    pnlResultados.Visible = true;
                    litResumen.Text = "<p class='text-muted'>No hay artículos disponibles.</p>";
                }
            }
            catch (Exception ex)
            {
                pnlResultados.Visible = true;
                litResumen.Text = $"<p class='text-danger'>Error al cargar artículos: {Server.HtmlEncode(ex.Message)}</p>";
            }
        }


        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            var q = (txtBusqueda.Text ?? string.Empty).Trim();
            if (string.IsNullOrEmpty(q))
            {
                Response.Redirect("Default.aspx", false);
                return;
            }
            Response.Redirect("Default.aspx?q=" + Server.UrlEncode(q), false);
        }
    }
}



