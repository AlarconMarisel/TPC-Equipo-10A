using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Dominio;
using Negocio;

namespace APP_Web_Equipo10A
{
    public partial class PagoSeña : System.Web.UI.Page
    {
        protected decimal MontoSeña = 0;
        protected int IdReserva = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                // validar sesión
                var usuario = Session["Usuario"];
                if (usuario == null)
                {
                    Response.Redirect("Login.aspx");
                    return;
                }

                // leer parámetros
                if (!IsPostBack)
                {
                    string id = Request.QueryString["id"];
                    string monto = Request.QueryString["monto"];

                    if (string.IsNullOrEmpty(id) || string.IsNullOrEmpty(monto))
                    {
                        Response.Write("<script>alert('Faltan datos de la reserva.');</script>");
                        return;
                    }

                    IdReserva = int.Parse(id);
                    MontoSeña = decimal.Parse(monto.Replace(".", ",")); // seguridad para formatos

                    // mostrar en pantalla
                    MostrarMonto();
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
            }
        }

        private void MostrarMonto()
        {
            lblMontoSeña.Text = MontoSeña.ToString("C2", new System.Globalization.CultureInfo("es-AR"));
        }

        protected void btnConfirmarPago_Click(object sender, EventArgs e)
        {
            try
            {

                var usuario = Session["Usuario"] as Usuario;
                if (usuario == null)
                {
                    Response.Redirect("Login.aspx");
                    return;

                }
                
                int idReserva = Convert.ToInt32(Request.QueryString["id"]);

                // Actualizar estado
                ReservaNegocio negocio = new ReservaNegocio();
                negocio.MarcarSeniaComoPagada(idReserva);

                List<Articulo> articulos = negocio.ListarArticulosDeReserva(idReserva);
                int idEstadoReservado = 2;

                foreach (var articulo in articulos)
                {
                    ArticuloNegocio articuloNegocio = new ArticuloNegocio();
                    articuloNegocio.ActualizarEstadoArticuloIndividual(articulo.IdArticulo, idEstadoReservado);
                }

                //Envio de email al administrador para informar que tiene una reserva a confirmar.
                int idAminitrador = negocio.ObtenerPorId(idReserva).IDAdministrador;
                UsuarioNegocio usuarioNegocio = new UsuarioNegocio();

                EmailService emailService = new EmailService();
                string asunto = "Confirmar Cobro de Reserva";
                string cuerpo = $"<h2>Estimado/a {usuarioNegocio.ObtenerPorId(idAminitrador).NombreCompleto}<h2/>" +
                                $"<p>El Usuario {usuario.NombreCompleto} ha realizado una reserva.<p/>" +
                                $"<p>Confirmar la misma.<p/><br/>" +
                                "<p>Saludos cordiales.<p/>";
                emailService.ArmarEmail(usuarioNegocio.ObtenerPorId(idAminitrador).Email, asunto, cuerpo);
                emailService.EnviarEmail();


                string script = @"
                alert('¡Tu seña fue confirmada exitosamente! La reserva quedó registrada.');
                window.location.href='PanelUsuario.aspx';
                ";
                ClientScript.RegisterStartupScript(this.GetType(), "redirigir", script, true);
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(),
                "error", $"alert('Error: {ex.Message}');", true);
            }
        }

    }
}


