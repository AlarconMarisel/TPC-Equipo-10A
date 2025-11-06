using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Dominio;
using Negocio;

namespace APP_Web_Equipo10A
{
    public partial class CarritoReserva : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // carrito de prueba
                if (Session["CarritoReserva"] == null)
                {
                    List<Articulo> carritoDemo = new List<Articulo>
            {
                new Articulo { IdArticulo = 1, Nombre = "Silla Ergonómica", Precio = 25000, Imagenes = new List<Imagen> { new Imagen { RutaImagen = "https://picsum.photos/100?1" } } },
                new Articulo { IdArticulo = 2, Nombre = "Monitor Dell 24\"", Precio = 150000, Imagenes = new List<Imagen> { new Imagen { RutaImagen = "https://picsum.photos/100?2" } } },
                new Articulo { IdArticulo = 3, Nombre = "Teclado Mecánico RGB", Precio = 80000, Imagenes = new List<Imagen> { new Imagen { RutaImagen = "https://picsum.photos/100?3" } } }
            };

                    Session["CarritoReserva"] = carritoDemo;
                }

                CargarCarrito();
            }
        }



        protected void btnConfirmarReserva_Click(object sender, EventArgs e)
        {
            try
            {
                Usuario usuario = new Usuario
                {
                    IdUsuario = 1,
                };
                List<Articulo> articulosSeleccionados = Session["CarritoReserva"] as List<Articulo>;
                if (articulosSeleccionados == null || articulosSeleccionados.Count == 0)
                {
                    Response.Write("<script>alert('No hay artículos en la reserva.');</script>");
                    return;
                }
                decimal montoTotal = 0;
                foreach (var art in articulosSeleccionados)
                    montoTotal += art.Precio;

                decimal montoSeña = montoTotal * 0.10m;


                Reserva nuevaReserva = new Reserva
                {
                    IdUsuario = usuario,
                    FechaReserva = DateTime.Now,
                    FechaVencimiento = DateTime.Now.AddDays(7),
                    MontoSeña = montoSeña,
                    EstadoReserva = true,
                    ArticulosReservados = articulosSeleccionados
                };

                ReservaNegocio negocio = new ReservaNegocio();
                int idReserva = negocio.AgregarReserva(nuevaReserva);


                if (idReserva > 0)
                {
                    Session["IdReserva"] = idReserva;
                    Response.Redirect("PagoSeña.aspx");
                }
                else
                {
                    Response.Write("<script>alert('Error al crear la reserva.');</script>");
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Ocurrió un error al confirmar la reserva: " + ex.Message + "');</script>");
            }
        }


        private void CargarCarrito()
        {

            List<Articulo> carrito = Session["CarritoReserva"] as List<Articulo>;

            if (carrito == null || carrito.Count == 0)
            {
                repCarrito.DataSource = null;
                repCarrito.DataBind();
                lblSubtotal.Text = "$0.00";
                lblSeña.Text = "$0.00";

                litCarritoVacio.Text = @"
        <div class='text-center'>
            <h3>Tu carrito está vacío</h3>
            <p>Agregá productos desde la página principal para hacer una reserva.</p>
            <a href='Default.aspx' class='btn btn-primary mt-3'> Volver a la Tienda</a>
        </div>";

                return;
            }

            repCarrito.DataSource = carrito;
            repCarrito.DataBind();


            decimal subtotal = carrito.Sum(a => a.Precio);
            decimal seña = subtotal * 0.10m;

            lblSubtotal.Text = subtotal.ToString("C2", new System.Globalization.CultureInfo("es-AR"));
            lblSeña.Text = seña.ToString("C2", new System.Globalization.CultureInfo("es-AR"));

            pnlCarritoVacio.Visible = false;
        }

        protected void repCarrito_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Eliminar")
            {
                int idArticulo = int.Parse(e.CommandArgument.ToString());
                List<Articulo> carrito = Session["CarritoReserva"] as List<Articulo>;

                if (carrito != null)
                {
                    carrito.RemoveAll(a => a.IdArticulo == idArticulo);
                    Session["CarritoReserva"] = carrito;
                    CargarCarrito();
                }
            }
        }


    }
}
