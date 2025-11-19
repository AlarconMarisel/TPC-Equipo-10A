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
                if (int.TryParse(Request.QueryString["id"], out int id))
                {
                    CargarArticulo(id);
                }
                else
                {
                    lblNombre.Text = "Artículo no encontrado";
                }
            }
        }

        private void CargarArticulo(int id)
        {
            try
            {
                var negocio = new ArticuloNegocio();
                var art = negocio.ObtenerPorId(id);

                if (art != null)
                {
                    lblNombre.Text = art.Nombre;
                    lblDescripcion.Text = art.Descripcion;
                    lblPrecio.Text = art.Precio.ToString("C2", new CultureInfo("es-AR"));

                    if (art.Imagenes != null && art.Imagenes.Count > 0)
                        imgPrincipal.ImageUrl = art.Imagenes[0].RutaImagen;
                    else
                        imgPrincipal.ImageUrl = "https://via.placeholder.com/600x600?text=Sin+Imagen";


                    if (art.Imagenes != null && art.Imagenes.Count > 0)
                    {
                        Repeater1.DataSource = art.Imagenes;
                        Repeater1.DataBind();
                    }


                    if (art.CategoriaArticulo != null)
                    {
                        lnkCategoria.Text = art.CategoriaArticulo.Nombre;
                        lnkCategoria.NavigateUrl = $"Default.aspx?categoria={art.CategoriaArticulo.IdCategoria}";
                    }


                    CargarTePuedeInteresar(id);
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

        private void CargarTePuedeInteresar(int idArticuloActual)
        {
            try
            {
                var negocio = new ArticuloNegocio();
                var todosLosArticulos = negocio.listarArticulo();

                var articulosMasCaros = todosLosArticulos
                    .Where(a => a.IdArticulo != idArticuloActual)
                    .OrderByDescending(a => a.Precio)
                    .Take(4)
                    .ToList();

                if (articulosMasCaros.Count > 0)
                {
                    rptTePuedeInteresar.DataSource = articulosMasCaros;
                    rptTePuedeInteresar.DataBind();
                }
            }
            catch (Exception ex)
            {

            }
        }

        protected void btnAgregarCarrito_Click(object sender, EventArgs e)
        {
            try
            {
                // Verificamos que haya un ID de artículo en el query string
                if (Request.QueryString["id"] != null)
                {
                    int id = int.Parse(Request.QueryString["id"]);
                    ArticuloNegocio negocio = new ArticuloNegocio();
                    Articulo articulo = negocio.ObtenerPorId(id);

                    if (articulo != null)
                    {
                        // Si no existe aún el carrito, lo creamos
                        List<Articulo> carrito = Session["CarritoReserva"] as List<Articulo>;
                        if (carrito == null)
                            carrito = new List<Articulo>();

                        // Evitamos duplicados
                        if (!carrito.Any(a => a.IdArticulo == articulo.IdArticulo))
                            carrito.Add(articulo);

                        // Guardamos el carrito actualizado
                        Session["CarritoReserva"] = carrito;

                        // Redirigimos al carrito
                        Response.Redirect("CarritoReserva.aspx", false);
                    }
                }
            }
            catch (Exception ex)
            {
                lblNombre.Text = "Error al agregar al carrito: " + ex.Message;
            }
        }



    }
}
