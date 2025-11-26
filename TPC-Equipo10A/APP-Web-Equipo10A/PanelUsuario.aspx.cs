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
    public partial class PanelUsuario : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarReservas();
            }

        }
        private void CargarReservas()
        {
            var usuario = Session["Usuario"] as Usuario;

            if (usuario == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            ReservaNegocio negocio = new ReservaNegocio();
            var reservas = negocio.ListarReservasPorUsuario(usuario.IdUsuario);

            rptReservas.DataSource = reservas;
            rptReservas.DataBind();
        }
        protected string GetCountdownColor(DateTime fechaVencimiento)
        {
            TimeSpan restante = fechaVencimiento - DateTime.Now;

            if (restante.TotalHours <= 6)
                return "red";
            if (restante.TotalHours <= 48)
                return "amber";

            return "green";
        }
        // Devuelve el tiempo restante en formato HH:mm:ss
        protected string ObtenerTiempoRestante(DateTime fechaVencimiento)
        {
            TimeSpan restante = fechaVencimiento - DateTime.Now;

            if (restante.TotalSeconds <= 0)
                return "00:00:00";

            return $"{(int)restante.TotalHours:D2}:{restante.Minutes:D2}:{restante.Seconds:D2}";
        }

    }
}


