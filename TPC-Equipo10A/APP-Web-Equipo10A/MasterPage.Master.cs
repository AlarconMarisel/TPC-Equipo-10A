using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Dominio;

namespace APP_Web_Equipo10A
{
    public partial class Site : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ConfigurarNavegacion();
        }

        private void ConfigurarNavegacion()
        {
            Usuario usuario = Session["Usuario"] as Usuario;

            // Buscar controles usando FindControl
            HyperLink lnkAdmin = FindControl("lnkAdmin") as HyperLink;
            HyperLink lnkSuperAdmin = FindControl("lnkSuperAdmin") as HyperLink;
            HyperLink lnkAdminMobile = FindControl("lnkAdminMobile") as HyperLink;
            HyperLink lnkSuperAdminMobile = FindControl("lnkSuperAdminMobile") as HyperLink;
            HyperLink lnkLogin = FindControl("lnkLogin") as HyperLink;
            HyperLink lnkLoginMobile = FindControl("lnkLoginMobile") as HyperLink;
            LinkButton btnCerrarSesion = FindControl("btnCerrarSesion") as LinkButton;
            LinkButton btnCerrarSesionMobile = FindControl("btnCerrarSesionMobile") as LinkButton;

            if (usuario != null)
            {
                // Usuario logueado: mostrar botones de cerrar sesión y ocultar login
                if (lnkLogin != null) lnkLogin.Visible = false;
                if (lnkLoginMobile != null) lnkLoginMobile.Visible = false;
                if (btnCerrarSesion != null) btnCerrarSesion.Visible = true;
                if (btnCerrarSesionMobile != null) btnCerrarSesionMobile.Visible = true;
                // Si es SuperAdmin, mostrar solo link Super Admin
                if (usuario.Tipo == TipoUsuario.SUPERADMIN)
                {
                    if (lnkSuperAdmin != null) lnkSuperAdmin.Visible = true;
                    if (lnkSuperAdminMobile != null) lnkSuperAdminMobile.Visible = true;
                    if (lnkAdmin != null) lnkAdmin.Visible = false;
                    if (lnkAdminMobile != null) lnkAdminMobile.Visible = false;
                }
                // Si es Admin, mostrar solo link Admin
                else if (usuario.Tipo == TipoUsuario.ADMIN)
                {
                    if (lnkAdmin != null) lnkAdmin.Visible = true;
                    if (lnkAdminMobile != null) lnkAdminMobile.Visible = true;
                    if (lnkSuperAdmin != null) lnkSuperAdmin.Visible = false;
                    if (lnkSuperAdminMobile != null) lnkSuperAdminMobile.Visible = false;
                }
                // Si es usuario normal, no mostrar ninguno
                else
                {
                    if (lnkAdmin != null) lnkAdmin.Visible = false;
                    if (lnkAdminMobile != null) lnkAdminMobile.Visible = false;
                    if (lnkSuperAdmin != null) lnkSuperAdmin.Visible = false;
                    if (lnkSuperAdminMobile != null) lnkSuperAdminMobile.Visible = false;
                }
            }
            else
            {
                // Si no hay usuario logueado, mostrar botones de login y ocultar cerrar sesión
                if (lnkLogin != null) lnkLogin.Visible = true;
                if (lnkLoginMobile != null) lnkLoginMobile.Visible = true;
                if (btnCerrarSesion != null) btnCerrarSesion.Visible = false;
                if (btnCerrarSesionMobile != null) btnCerrarSesionMobile.Visible = false;
                // Ocultar links de admin
                if (lnkAdmin != null) lnkAdmin.Visible = false;
                if (lnkAdminMobile != null) lnkAdminMobile.Visible = false;
                if (lnkSuperAdmin != null) lnkSuperAdmin.Visible = false;
                if (lnkSuperAdminMobile != null) lnkSuperAdminMobile.Visible = false;
            }
        }

        protected void btnCerrarSesion_Click(object sender, EventArgs e)
        {
            // Limpiar la sesión
            Session.Clear();
            Session.Abandon();
            
            // Redirigir a la página principal
            Response.Redirect("Default.aspx", false);
        }
    }
}



