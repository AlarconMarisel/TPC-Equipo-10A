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
    public partial class AdminGestionReserva : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Valida acceso de administrador
            if (!ValidarAccesoAdministrador())
            {
                Response.Redirect("Default.aspx");
                return;
            }

            if (!IsPostBack)
            {
                CargarNombreTienda();
            }
        }

        /// <summary>
        /// Valida que el usuario es administrador activo
        /// </summary>
        private bool ValidarAccesoAdministrador()
        {
            if (!ValidacionHelper.ValidarEsAdministradorActivo())
            {
                Response.Write("<script>alert('Su cuenta de administrador está inactiva o ha vencido. Contacte al super administrador.');</script>");
                return false;
            }
            return true;
        }

        /// <summary>
        /// Carga el nombre de la tienda o el email del administrador
        /// </summary>
        private void CargarNombreTienda()
        {
            try
            {
                Usuario usuario = TenantHelper.ObtenerUsuarioDesdeSesion();
                
                if (usuario != null)
                {
                    string textoMostrar = "";
                    
                    // Si tiene nombre de tienda configurado, mostrarlo
                    if (!string.IsNullOrWhiteSpace(usuario.NombreTienda))
                    {
                        textoMostrar = "\"" + usuario.NombreTienda + "\"";
                    }
                    // Si no, mostrar el email
                    else if (!string.IsNullOrWhiteSpace(usuario.Email))
                    {
                        textoMostrar = "\"" + usuario.Email + "\"";
                    }
                    
                    lblNombreTienda.Text = textoMostrar;
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error al cargar nombre de tienda: " + ex.Message);
            }
        }
    }
}


