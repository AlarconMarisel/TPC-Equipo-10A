using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace APP_Web_Equipo10A
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Lógica de la página de inicio
            if (!IsPostBack)
            {
                // Aquí puedes cargar datos iniciales si es necesario
                // Por ejemplo, estadísticas, artículos destacados, etc.
            }
        }
    }
}



