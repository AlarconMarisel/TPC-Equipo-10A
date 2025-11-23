using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace APP_Web_Equipo10A
{
    public partial class Registro : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void btnRegistrar_Click(object sender, EventArgs e)
        {
            if (!chkTerminos.Checked)
            {
                Response.Write("<script>alert('Debe aceptar los términos y condiciones para participar.');</script>");
                return;
            }
        }
    }

}
