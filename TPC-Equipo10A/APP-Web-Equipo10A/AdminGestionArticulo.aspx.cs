using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Negocio;

namespace APP_Web_Equipo10A
{
    public partial class AdminGestionArticulo : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarArticulos();
            }
        }

        private void CargarArticulos()
        {
            try
            {
                ArticuloNegocio articuloNegocio = new ArticuloNegocio();
                var articulos = articuloNegocio.listarArticulo();

                if (articulos != null && articulos.Count > 0)
                {
                    repArticulos.DataSource = articulos;
                    repArticulos.DataBind();
                    lblSinArticulos.Visible = false;
                }
                else
                {
                    repArticulos.Visible = false;
                    lblSinArticulos.Visible = true;
                }
            }
            catch (Exception ex)
            {
                // En caso de error, mostrar mensaje
                lblSinArticulos.Text = $"<tr><td colspan='7' class='text-center text-danger' style='padding: 2rem;'>Error al cargar artículos: {Server.HtmlEncode(ex.Message)}</td></tr>";
                lblSinArticulos.Visible = true;
                repArticulos.Visible = false;
            }
        }

        protected string GetImagenUrl(object dataItem)
        {
            if (dataItem is Dominio.Articulo articulo)
            {
                if (articulo.Imagenes != null && articulo.Imagenes.Count > 0 && !string.IsNullOrEmpty(articulo.Imagenes[0].RutaImagen))
                {
                    return ResolveUrl(articulo.Imagenes[0].RutaImagen);
                }
            }
            return "https://via.placeholder.com/100?text=Sin+Imagen";
        }
    }
}


