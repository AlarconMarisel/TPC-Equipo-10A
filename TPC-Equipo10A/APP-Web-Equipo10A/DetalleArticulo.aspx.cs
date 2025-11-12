using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Security.Principal;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Dominio;

using Negocio;


namespace APP_Web_Equipo10A
{
    public partial class DetalleArticulo : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["id"] != null)
                {
                    int id = int.Parse(Request.QueryString["id"]);
                    CargarArticulo(id);
                }
            }
        }

        private void CargarArticulo(int id)
        {
            try
            {
                ArticuloNegocio negocio = new ArticuloNegocio();
                Articulo art = negocio.ObtenerPorId(id);

                if (art != null)
                {
                    lblNombre.Text = art.Nombre;
                    lblDescripcion.Text = art.Descripcion;
                    lblPrecio.Text = art.Precio.ToString("C2", new CultureInfo("es-AR"));

                    if (art.Imagenes != null && art.Imagenes.Count > 0)
                        imgPrincipal.ImageUrl = art.Imagenes[0].RutaImagen;
                    else
                        imgPrincipal.ImageUrl = "https://via.placeholder.com/600x600?text=Sin+Imagen";
                }
                else
                {
                    lblNombre.Text = "Artículo no encontrado";
                }
            }
            catch (Exception ex)
            {
                lblNombre.Text = "Error al cargar el artículo: " + ex.Message;
            }
        }
    }
}
