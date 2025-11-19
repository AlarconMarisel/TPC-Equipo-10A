using System;
using System.Globalization;
using System.Web.UI;
using Dominio;
using Negocio;

namespace APP_Web_Equipo10A
{
    public partial class AdminDetalleArticulo : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (int.TryParse(Request.QueryString["id"], out int idArticulo))
                {
                    CargarArticulo(idArticulo);
                }
                else
                {
                    MostrarError("ID de artículo no válido.");
                }
            }
        }

        private void CargarArticulo(int idArticulo)
        {
            try
            {
                ArticuloNegocio articuloNegocio = new ArticuloNegocio();
                Articulo articulo = articuloNegocio.ObtenerPorId(idArticulo);

                if (articulo == null)
                {
                    MostrarError("Artículo no encontrado.");
                    return;
                }

                CargarInformacionGeneral(articulo);

                CargarImagenes(articulo);

                string estadoNombre = articulo.EstadoArticulo?.Nombre?.ToLower() ?? "";

                if (estadoNombre.Contains("reservado") || estadoNombre.Contains("reserva"))
                {
                    CargarInformacionReserva(idArticulo);
                }
                else if (estadoNombre.Contains("vendido") || estadoNombre.Contains("venta"))
                {
                    CargarInformacionVenta(idArticulo);
                }
            }
            catch (Exception ex)
            {
                MostrarError("Error al cargar el artículo: " + ex.Message);
            }
        }

        private void CargarInformacionGeneral(Articulo articulo)
        {
            lblNombre.Text = articulo.Nombre ?? "Sin nombre";
            lblIdArticulo.Text = $"ID-{articulo.IdArticulo}";
            lblPrecio.Text = articulo.Precio.ToString("C2", new CultureInfo("es-AR"));
            lblCategoria.Text = articulo.CategoriaArticulo?.Nombre ?? "Sin categoría";
            lblDescripcion.Text = !string.IsNullOrEmpty(articulo.Descripcion) ? articulo.Descripcion : "Sin descripción";

            string estadoNombre = articulo.EstadoArticulo?.Nombre ?? "Desconocido";
            string estadoClass = "status-available";
            
            if (estadoNombre.ToLower().Contains("reservado") || estadoNombre.ToLower().Contains("reserva"))
            {
                estadoClass = "status-reserved";
            }
            else if (estadoNombre.ToLower().Contains("vendido") || estadoNombre.ToLower().Contains("venta"))
            {
                estadoClass = "status-sold";
            }

            lblEstado.Text = $"<span class='status-badge {estadoClass}'>{estadoNombre}</span>";
        }

        private void CargarImagenes(Articulo articulo)
        {
            if (articulo.Imagenes != null && articulo.Imagenes.Count > 0)
            {
                imgPrincipal.ImageUrl = ResolveUrl(articulo.Imagenes[0].RutaImagen);
                repThumbnails.DataSource = articulo.Imagenes;
                repThumbnails.DataBind();
                pnlImagenes.Visible = true;
            }
            else
            {
                imgPrincipal.ImageUrl = "https://via.placeholder.com/350x350?text=Sin+Imagen";
                pnlImagenes.Visible = true;
            }
        }

        private void CargarInformacionReserva(int idArticulo)
        {
            try
            {
                ReservaNegocio reservaNegocio = new ReservaNegocio();
                Reserva reserva = reservaNegocio.ObtenerReservaPorArticulo(idArticulo);

                if (reserva != null)
                {
                    lblFechaReserva.Text = reserva.FechaReserva.ToString("dd/MM/yyyy HH:mm", new CultureInfo("es-AR"));
                    lblFechaVencimiento.Text = reserva.FechaVencimiento.ToString("dd/MM/yyyy HH:mm", new CultureInfo("es-AR"));
                    lblMontoSena.Text = reserva.MontoSeña.ToString("C2", new CultureInfo("es-AR"));

                    string estadoPagoClass = reserva.EstadoReserva ? "payment-confirmed" : "payment-pending";
                    string estadoPagoTexto = reserva.EstadoReserva ? "Confirmado" : "Pendiente";
                    string icono = reserva.EstadoReserva ? "check_circle" : "pending";
                    
                    lblEstadoPago.Text = $"<span class='payment-status {estadoPagoClass}'>" +
                                        $"<span class='material-symbols-outlined' style='font-size: 1rem;'>{icono}</span>" +
                                        $"{estadoPagoTexto}</span>";

                    if (reserva.IdUsuario != null)
                    {
                        string nombreCompleto = $"{reserva.IdUsuario.Nombre ?? ""} {reserva.IdUsuario.Apellido ?? ""}".Trim();
                        lblUsuarioReservaNombre.Text = !string.IsNullOrEmpty(nombreCompleto) ? nombreCompleto : "No disponible";
                        lblUsuarioReservaEmail.Text = reserva.IdUsuario.Email ?? "No disponible";
                        lblUsuarioReservaTelefono.Text = !string.IsNullOrEmpty(reserva.IdUsuario.Telefono) ? reserva.IdUsuario.Telefono : "No disponible";
                    }
                    else
                    {
                        lblUsuarioReservaNombre.Text = "No disponible";
                        lblUsuarioReservaEmail.Text = "No disponible";
                        lblUsuarioReservaTelefono.Text = "No disponible";
                    }

                    pnlReserva.Visible = true;
                }
            }
            catch (Exception ex)
            {

            }
        }

        private void CargarInformacionVenta(int idArticulo)
        {
            try
            {
                VentaNegocio ventaNegocio = new VentaNegocio();
                Venta venta = ventaNegocio.ObtenerVentaPorArticulo(idArticulo);

                if (venta != null)
                {
                    lblFechaVenta.Text = venta.FechaVenta.ToString("dd/MM/yyyy HH:mm", new CultureInfo("es-AR"));
                    lblPrecioFinal.Text = venta.MontoTotal.ToString("C2", new CultureInfo("es-AR"));

                    if (venta.Reserva != null && venta.Reserva.IdUsuario != null)
                    {
                        string nombreCompleto = $"{venta.Reserva.IdUsuario.Nombre ?? ""} {venta.Reserva.IdUsuario.Apellido ?? ""}".Trim();
                        lblUsuarioVentaNombre.Text = !string.IsNullOrEmpty(nombreCompleto) ? nombreCompleto : "No disponible";
                        lblUsuarioVentaEmail.Text = venta.Reserva.IdUsuario.Email ?? "No disponible";
                        lblUsuarioVentaTelefono.Text = !string.IsNullOrEmpty(venta.Reserva.IdUsuario.Telefono) ? venta.Reserva.IdUsuario.Telefono : "No disponible";
                    }
                    else
                    {
                        lblUsuarioVentaNombre.Text = "No disponible";
                        lblUsuarioVentaEmail.Text = "No disponible";
                        lblUsuarioVentaTelefono.Text = "No disponible";
                    }

                    pnlVenta.Visible = true;
                }
            }
            catch (Exception ex)
            {

            }
        }

        private void MostrarError(string mensaje)
        {
            pnlError.Visible = true;
            lblError.Text = mensaje;
            pnlImagenes.Visible = false;
            pnlInfoGeneral.Visible = false;
            pnlReserva.Visible = false;
            pnlVenta.Visible = false;
        }
    }
}

