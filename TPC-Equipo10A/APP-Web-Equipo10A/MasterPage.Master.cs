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

            // Busca controles usando FindControl
            HyperLink lnkAdmin = FindControl("lnkAdmin") as HyperLink;
            HyperLink lnkSuperAdmin = FindControl("lnkSuperAdmin") as HyperLink;
            HyperLink lnkAdminMobile = FindControl("lnkAdminMobile") as HyperLink;
            HyperLink lnkSuperAdminMobile = FindControl("lnkSuperAdminMobile") as HyperLink;
            HyperLink lnkLogin = FindControl("lnkLogin") as HyperLink;
            HyperLink lnkLoginMobile = FindControl("lnkLoginMobile") as HyperLink;
            LinkButton btnCerrarSesion = FindControl("btnCerrarSesion") as LinkButton;
            LinkButton btnCerrarSesionMobile = FindControl("btnCerrarSesionMobile") as LinkButton;
            HyperLink lnkMiPerfil = FindControl("lnkMiPerfil") as HyperLink;
            HyperLink lnkMiPerfilMobile = FindControl("lnkMiPerfilMobile") as HyperLink;
            HyperLink lnkCarrito = FindControl("lnkCarrito") as HyperLink;
            HyperLink lnkCarritoMobile = FindControl("lnkCarritoMobile") as HyperLink;

            if (usuario != null)
            {
                // Usuario logueado: muestra botones de cerrar sesion y ocultar login
                if (lnkLogin != null) lnkLogin.Visible = false;
                if (lnkLoginMobile != null) lnkLoginMobile.Visible = false;
                if (btnCerrarSesion != null) btnCerrarSesion.Visible = true;
                if (btnCerrarSesionMobile != null) btnCerrarSesionMobile.Visible = true;
                
                // Si es SuperAdmin o Admin, oculta "Mi Perfil" y el carrito
                if (usuario.Tipo == TipoUsuario.SUPERADMIN || usuario.Tipo == TipoUsuario.ADMIN)
                {
                    if (lnkMiPerfil != null) lnkMiPerfil.Visible = false;
                    if (lnkMiPerfilMobile != null) lnkMiPerfilMobile.Visible = false;
                    if (lnkCarrito != null) lnkCarrito.Visible = false;
                    if (lnkCarritoMobile != null) lnkCarritoMobile.Visible = false;
                }
                else
                {
                    // Usuario normal: muestra "Mi Perfil" y el carrito
                    if (lnkMiPerfil != null) lnkMiPerfil.Visible = true;
                    if (lnkMiPerfilMobile != null) lnkMiPerfilMobile.Visible = true;
                    if (lnkCarrito != null) lnkCarrito.Visible = true;
                    if (lnkCarritoMobile != null) lnkCarritoMobile.Visible = true;
                }
                
                // Si es SuperAdmin, muestra solo link Super Admin
                if (usuario.Tipo == TipoUsuario.SUPERADMIN)
                {
                    if (lnkSuperAdmin != null) lnkSuperAdmin.Visible = true;
                    if (lnkSuperAdminMobile != null) lnkSuperAdminMobile.Visible = true;
                    if (lnkAdmin != null) lnkAdmin.Visible = false;
                    if (lnkAdminMobile != null) lnkAdminMobile.Visible = false;
                }
                // Si es Admin, muestra solo link Admin
                else if (usuario.Tipo == TipoUsuario.ADMIN)
                {
                    if (lnkAdmin != null) lnkAdmin.Visible = true;
                    if (lnkAdminMobile != null) lnkAdminMobile.Visible = true;
                    if (lnkSuperAdmin != null) lnkSuperAdmin.Visible = false;
                    if (lnkSuperAdminMobile != null) lnkSuperAdminMobile.Visible = false;
                }
                // Si es usuario normal, no muestra ninguno
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
                // Si no hay usuario logueado, muestra botones de login y oculta cerrar sesion
                if (lnkLogin != null) lnkLogin.Visible = true;
                if (lnkLoginMobile != null) lnkLoginMobile.Visible = true;
                if (btnCerrarSesion != null) btnCerrarSesion.Visible = false;
                if (btnCerrarSesionMobile != null) btnCerrarSesionMobile.Visible = false;
                // Oculta links de admin
                if (lnkAdmin != null) lnkAdmin.Visible = false;
                if (lnkAdminMobile != null) lnkAdminMobile.Visible = false;
                if (lnkSuperAdmin != null) lnkSuperAdmin.Visible = false;
                if (lnkSuperAdminMobile != null) lnkSuperAdminMobile.Visible = false;
                // Muestra "Mi Perfil" y carrito para usuarios no logueados (pueden verlos pero al hacer clic los redirigirá a login)
                if (lnkMiPerfil != null) lnkMiPerfil.Visible = true;
                if (lnkMiPerfilMobile != null) lnkMiPerfilMobile.Visible = true;
                if (lnkCarrito != null) lnkCarrito.Visible = true;
                if (lnkCarritoMobile != null) lnkCarritoMobile.Visible = true;
            }
        }

        protected void btnCerrarSesion_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            
            Response.Redirect("Default.aspx", false);
        }
    }
}



