using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
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
                int idReserva = int.Parse(Request.QueryString["id"]);
                ReservaNegocio negocio = new ReservaNegocio();

                string rutaComprobante = null;

                if (fileComprobante.HasFile)
                {
                    string carpeta = Server.MapPath("~/Content/Comprobantes/");
                    if (!Directory.Exists(carpeta))
                        Directory.CreateDirectory(carpeta);

                    string nombreArchivo = "reserva_" + idReserva + "_" + DateTime.Now.Ticks + Path.GetExtension(fileComprobante.FileName);
                    string rutaFisica = Path.Combine(carpeta, nombreArchivo);

                    fileComprobante.SaveAs(rutaFisica);

                    rutaComprobante = "Content/Comprobantes/" + nombreArchivo;
                }

                negocio.ConfirmarPagoSeña(idReserva, rutaComprobante);

                Response.Write("<script>alert('¡Seña confirmada! El administrador revisará tu comprobante.'); window.location='Default.aspx';</script>");
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
            }
        }

    }
}


