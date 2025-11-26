using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Threading;
using System.Web.UI;
using Dominio;
using Negocio;

namespace APP_Web_Equipo10A
{
    public partial class CarritoReserva : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Thread.CurrentThread.CurrentCulture = new CultureInfo("es-AR");
            Thread.CurrentThread.CurrentUICulture = new CultureInfo("es-AR");

            if (!IsPostBack)
                CargarCarrito();
        }

        private void CargarCarrito()
        {
            var usuario = Session["Usuario"] as Usuario;
            if (usuario == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            int idCarrito = Session["IDCarrito"] != null
                ? (int)Session["IDCarrito"]
                : 0;

            CarritoNegocio carritoNegocio = new CarritoNegocio();

            if (idCarrito == 0)
            {
                idCarrito = carritoNegocio.CrearCarritoSiNoExiste(usuario.IdUsuario, usuario.IdUsuario);
                Session["IDCarrito"] = idCarrito;
            }

            List<Articulo> carrito = carritoNegocio.ListarArticulosDelCarrito(idCarrito);

            if (carrito == null || carrito.Count == 0)
            {
                repCarrito.DataSource = null;
                repCarrito.DataBind();
                lblSubtotal.Text = "$0.00";
                lblSeña.Text = "$0.00";

                pnlCarritoVacio.Visible = true;

                btnConfirmarReserva.Visible = false;

                return;
            }



            CultureInfo culturaAR = new CultureInfo("es-AR");

            pnlCarritoVacio.Visible = false;

            repCarrito.DataSource = carrito;
            repCarrito.DataBind();

            decimal subtotal = carrito.Sum(a => a.Precio);
            decimal seña = subtotal * 0.10m;

            lblSubtotal.Text = subtotal.ToString("C2", culturaAR);
            lblSeña.Text = seña.ToString("C2", culturaAR);
        }

        protected void repCarrito_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Eliminar")
            {
                int idArticulo = int.Parse(e.CommandArgument.ToString());
                int idCarrito = (int)Session["IDCarrito"];

                CarritoNegocio neg = new CarritoNegocio();
                neg.QuitarArticuloDelCarrito(idCarrito, idArticulo);

                CargarCarrito();
            }
        }

        protected void btnConfirmarReserva_Click(object sender, EventArgs e)
        {
            try
            {
                var usuario = Session["Usuario"] as Usuario;
                if (usuario == null)
                {
                    Response.Redirect("Login.aspx");
                    return;
                }

                int idCarrito = (int)Session["IDCarrito"];

                CarritoNegocio carritoNegocio = new CarritoNegocio();
                List<Articulo> articulos = carritoNegocio.ListarArticulosDelCarrito(idCarrito);

                if (articulos.Count == 0)
                {
                    Response.Write("<script>alert('No hay artículos en el carrito.');</script>");
                    return;
                }

                decimal subtotal = articulos.Sum(a => a.Precio);
                decimal montoSeña = subtotal * 0.10m;

                Reserva reserva = new Reserva
                {
                    IdUsuario = usuario,
                    FechaReserva = DateTime.Now,
                    FechaVencimiento = DateTime.Now.AddDays(7),
                    MontoSeña = montoSeña,
                    EstadoReserva = true,
                    ArticulosReservados = articulos
                };

                ReservaNegocio negocio = new ReservaNegocio();
                int idReserva = negocio.AgregarReservaConArticulos(reserva, articulos);


                if (idReserva > 0)
                {
                    Session["IdReserva"] = idReserva;
                    Response.Redirect("PagoSeña.aspx?id=" + idReserva +
                                      "&monto=" + montoSeña.ToString());
                }
                else
                {
                    Response.Write("<script>alert('Error al generar reserva.');</script>");
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
            }
        }
    }
}
