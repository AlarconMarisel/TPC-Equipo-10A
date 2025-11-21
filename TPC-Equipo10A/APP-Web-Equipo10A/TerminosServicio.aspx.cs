using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace APP_Web_Equipo10A
{
    public partial class TerminosServicio : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblFecha.Text = DateTime.Now.ToString("MMMM yyyy", new System.Globalization.CultureInfo("es-ES"));
            }
        }
    }
}


