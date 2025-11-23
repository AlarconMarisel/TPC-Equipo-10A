using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

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
    }
}


