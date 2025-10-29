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
                var query = Request["q"];
                if (!string.IsNullOrWhiteSpace(query))
                {
                    txtBusqueda.Text = query;
                    BuscarArticulos(query);
                }
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
                        (a.IdCategoriaArticulo?.Nombre ?? string.Empty).IndexOf(query, System.StringComparison.OrdinalIgnoreCase) >= 0)
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



