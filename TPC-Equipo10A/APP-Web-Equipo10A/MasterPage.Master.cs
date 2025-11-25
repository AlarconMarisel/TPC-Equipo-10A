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
            Label lblTienda = FindControl("lblTienda") as Label;
            Label lblNombreUsuario = FindControl("lblNombreUsuario") as Label;
            Label lblNombreAdmin = FindControl("lblNombreAdmin") as Label;
            Label lblNombreSuperAdmin = FindControl("lblNombreSuperAdmin") as Label;
            
            // Buscar los divs contenedores
            System.Web.UI.HtmlControls.HtmlGenericControl divMiPerfil = FindControl("divMiPerfil") as System.Web.UI.HtmlControls.HtmlGenericControl;
            System.Web.UI.HtmlControls.HtmlGenericControl divAdmin = FindControl("divAdmin") as System.Web.UI.HtmlControls.HtmlGenericControl;
            System.Web.UI.HtmlControls.HtmlGenericControl divSuperAdmin = FindControl("divSuperAdmin") as System.Web.UI.HtmlControls.HtmlGenericControl;

            if (usuario != null)
            {
                // Usuario logueado: muestra botones de cerrar sesion y ocultar login
                if (lnkLogin != null) lnkLogin.Visible = false;
                if (lnkLoginMobile != null) lnkLoginMobile.Visible = false;
                if (btnCerrarSesion != null) btnCerrarSesion.Visible = true;
                if (btnCerrarSesionMobile != null) btnCerrarSesionMobile.Visible = true;
                
                // Cargar información de tienda y nombre de usuario
                CargarInformacionHeader(usuario, lblTienda, lblNombreUsuario, lblNombreAdmin, lblNombreSuperAdmin);
                
                // Si es SuperAdmin o Admin, oculta "Mi Perfil" y el carrito
                if (usuario.Tipo == TipoUsuario.SUPERADMIN || usuario.Tipo == TipoUsuario.ADMIN)
                {
                    if (lnkMiPerfil != null) lnkMiPerfil.Visible = false;
                    if (lnkMiPerfilMobile != null) lnkMiPerfilMobile.Visible = false;
                    if (lnkCarrito != null) lnkCarrito.Visible = false;
                    if (lnkCarritoMobile != null) lnkCarritoMobile.Visible = false;
                    // Ocultar el div contenedor de Mi Perfil
                    if (divMiPerfil != null) divMiPerfil.Visible = false;
                }
                else
                {
                    // Usuario normal: muestra "Mi Perfil" y el carrito
                    if (lnkMiPerfil != null) lnkMiPerfil.Visible = true;
                    if (lnkMiPerfilMobile != null) lnkMiPerfilMobile.Visible = true;
                    if (lnkCarrito != null) lnkCarrito.Visible = true;
                    if (lnkCarritoMobile != null) lnkCarritoMobile.Visible = true;
                    // Mostrar el div contenedor de Mi Perfil
                    if (divMiPerfil != null) divMiPerfil.Visible = true;
                }
                
                // Si es SuperAdmin, muestra solo link Super Admin
                if (usuario.Tipo == TipoUsuario.SUPERADMIN)
                {
                    if (lnkSuperAdmin != null) lnkSuperAdmin.Visible = true;
                    if (lnkSuperAdminMobile != null) lnkSuperAdminMobile.Visible = true;
                    if (lnkAdmin != null) lnkAdmin.Visible = false;
                    if (lnkAdminMobile != null) lnkAdminMobile.Visible = false;
                    // Ocultar label y div contenedor de Admin
                    if (lblNombreAdmin != null) lblNombreAdmin.Visible = false;
                    if (divAdmin != null) divAdmin.Visible = false;
                    // Mostrar div contenedor de SuperAdmin
                    if (divSuperAdmin != null) divSuperAdmin.Visible = true;
                }
                // Si es Admin, muestra solo link Admin
                else if (usuario.Tipo == TipoUsuario.ADMIN)
                {
                    if (lnkAdmin != null) lnkAdmin.Visible = true;
                    if (lnkAdminMobile != null) lnkAdminMobile.Visible = true;
                    if (lnkSuperAdmin != null) lnkSuperAdmin.Visible = false;
                    if (lnkSuperAdminMobile != null) lnkSuperAdminMobile.Visible = false;
                    // Ocultar label y div contenedor de SuperAdmin
                    if (lblNombreSuperAdmin != null) lblNombreSuperAdmin.Visible = false;
                    if (divSuperAdmin != null) divSuperAdmin.Visible = false;
                    // Mostrar div contenedor de Admin
                    if (divAdmin != null) divAdmin.Visible = true;
                }
                // Si es usuario normal, no muestra ninguno
                else
                {
                    if (lnkAdmin != null) lnkAdmin.Visible = false;
                    if (lnkAdminMobile != null) lnkAdminMobile.Visible = false;
                    if (lnkSuperAdmin != null) lnkSuperAdmin.Visible = false;
                    if (lnkSuperAdminMobile != null) lnkSuperAdminMobile.Visible = false;
                    // Ocultar labels y divs contenedores de Admin y SuperAdmin
                    if (lblNombreAdmin != null) lblNombreAdmin.Visible = false;
                    if (lblNombreSuperAdmin != null) lblNombreSuperAdmin.Visible = false;
                    if (divAdmin != null) divAdmin.Visible = false;
                    if (divSuperAdmin != null) divSuperAdmin.Visible = false;
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
                // Oculta "Mi Perfil" cuando no hay sesión iniciada
                if (lnkMiPerfil != null) lnkMiPerfil.Visible = false;
                if (lnkMiPerfilMobile != null) lnkMiPerfilMobile.Visible = false;
                // Oculta el div contenedor de Mi Perfil
                if (divMiPerfil != null) divMiPerfil.Visible = false;
                // Oculta labels de Mi Perfil
                if (lblNombreUsuario != null) lblNombreUsuario.Visible = false;
                // Muestra carrito para usuarios no logueados (pueden verlo pero al hacer clic los redirigirá a login)
                if (lnkCarrito != null) lnkCarrito.Visible = true;
                if (lnkCarritoMobile != null) lnkCarritoMobile.Visible = true;
                // Oculta labels y divs contenedores de Admin y SuperAdmin
                if (lblNombreAdmin != null) lblNombreAdmin.Visible = false;
                if (lblNombreSuperAdmin != null) lblNombreSuperAdmin.Visible = false;
                if (divAdmin != null) divAdmin.Visible = false;
                if (divSuperAdmin != null) divSuperAdmin.Visible = false;
                // Oculta label de tienda
                if (lblTienda != null) lblTienda.Visible = false;
            }
        }

        protected void btnCerrarSesion_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            
            Response.Redirect("Default.aspx", false);
        }

        /// <summary>
        /// Carga la información de tienda y nombre de usuario en el header
        /// </summary>
        private void CargarInformacionHeader(Usuario usuario, Label lblTienda, Label lblNombreUsuario, Label lblNombreAdmin, Label lblNombreSuperAdmin)
        {
            try
            {
                // Inicializar labels como vacíos y ocultos
                if (lblTienda != null)
                {
                    lblTienda.Text = "";
                    lblTienda.Visible = false;
                }
                if (lblNombreUsuario != null)
                {
                    lblNombreUsuario.Text = "";
                    lblNombreUsuario.Visible = false;
                }
                if (lblNombreAdmin != null)
                {
                    lblNombreAdmin.Text = "";
                    lblNombreAdmin.Visible = false;
                }
                if (lblNombreSuperAdmin != null)
                {
                    lblNombreSuperAdmin.Text = "";
                    lblNombreSuperAdmin.Visible = false;
                }
                // Cargar información de tienda (debajo de Home)
                if (lblTienda != null)
                {
                    string textoTienda = "";
                    
                    // Si el usuario es Admin o SuperAdmin, mostrar información de tienda
                    if (usuario.Tipo == TipoUsuario.ADMIN || usuario.Tipo == TipoUsuario.SUPERADMIN)
                    {
                        // Si tiene nombre de tienda configurado, mostrarlo
                        if (!string.IsNullOrWhiteSpace(usuario.NombreTienda))
                        {
                            textoTienda = "Tienda: " + usuario.NombreTienda;
                        }
                        // Si no, mostrar Admin-[ID]
                        else
                        {
                            textoTienda = "Admin-" + usuario.IdUsuario;
                        }
                    }
                    // Si es usuario normal, obtener información del administrador
                    else if (usuario.Tipo == TipoUsuario.NORMAL && usuario.IDAdministrador.HasValue)
                    {
                        // Buscar el administrador para obtener su nombre de tienda
                        Negocio.UsuarioNegocio usuarioNegocio = new Negocio.UsuarioNegocio();
                        Dominio.Usuario admin = usuarioNegocio.ObtenerPorId(usuario.IDAdministrador.Value);
                        
                        if (admin != null)
                        {
                            if (!string.IsNullOrWhiteSpace(admin.NombreTienda))
                            {
                                textoTienda = "Tienda: " + admin.NombreTienda;
                            }
                            else
                            {
                                textoTienda = "Admin-" + admin.IdUsuario;
                            }
                        }
                    }
                    
                    lblTienda.Text = textoTienda;
                    lblTienda.Visible = !string.IsNullOrEmpty(textoTienda);
                }
                
                // Cargar nombre y apellido del usuario (debajo de Mi Perfil)
                if (lblNombreUsuario != null)
                {
                    string nombreCompleto = "";
                    
                    if (!string.IsNullOrWhiteSpace(usuario.Nombre) && !string.IsNullOrWhiteSpace(usuario.Apellido))
                    {
                        nombreCompleto = usuario.Nombre + " " + usuario.Apellido;
                    }
                    else if (!string.IsNullOrWhiteSpace(usuario.Nombre))
                    {
                        nombreCompleto = usuario.Nombre;
                    }
                    else if (!string.IsNullOrWhiteSpace(usuario.Apellido))
                    {
                        nombreCompleto = usuario.Apellido;
                    }
                    
                    lblNombreUsuario.Text = nombreCompleto;
                    lblNombreUsuario.Visible = !string.IsNullOrEmpty(nombreCompleto);
                }
                
                // Cargar nombre y apellido para Admin
                if (lblNombreAdmin != null)
                {
                    // Por defecto, ocultar el label
                    lblNombreAdmin.Visible = false;
                    lblNombreAdmin.Text = "";
                    
                    // Solo mostrar si es Admin Y tiene nombre completo
                    if (usuario.Tipo == TipoUsuario.ADMIN)
                    {
                        string nombreCompletoAdmin = "";
                        
                        if (!string.IsNullOrWhiteSpace(usuario.Nombre) && !string.IsNullOrWhiteSpace(usuario.Apellido))
                        {
                            nombreCompletoAdmin = usuario.Nombre + " " + usuario.Apellido;
                        }
                        else if (!string.IsNullOrWhiteSpace(usuario.Nombre))
                        {
                            nombreCompletoAdmin = usuario.Nombre;
                        }
                        else if (!string.IsNullOrWhiteSpace(usuario.Apellido))
                        {
                            nombreCompletoAdmin = usuario.Apellido;
                        }
                        
                        // Solo mostrar si tiene nombre completo válido
                        if (!string.IsNullOrWhiteSpace(nombreCompletoAdmin))
                        {
                            lblNombreAdmin.Text = nombreCompletoAdmin;
                            lblNombreAdmin.Visible = true;
                        }
                    }
                }
                
                // Cargar nombre y apellido para Super Admin
                if (lblNombreSuperAdmin != null)
                {
                    // Por defecto, ocultar el label
                    lblNombreSuperAdmin.Visible = false;
                    lblNombreSuperAdmin.Text = "";
                    
                    // Solo mostrar si es SuperAdmin Y tiene nombre completo
                    if (usuario.Tipo == TipoUsuario.SUPERADMIN)
                    {
                        string nombreCompletoSuperAdmin = "";
                        
                        if (!string.IsNullOrWhiteSpace(usuario.Nombre) && !string.IsNullOrWhiteSpace(usuario.Apellido))
                        {
                            nombreCompletoSuperAdmin = usuario.Nombre + " " + usuario.Apellido;
                        }
                        else if (!string.IsNullOrWhiteSpace(usuario.Nombre))
                        {
                            nombreCompletoSuperAdmin = usuario.Nombre;
                        }
                        else if (!string.IsNullOrWhiteSpace(usuario.Apellido))
                        {
                            nombreCompletoSuperAdmin = usuario.Apellido;
                        }
                        
                        // Solo mostrar si tiene nombre completo válido
                        if (!string.IsNullOrWhiteSpace(nombreCompletoSuperAdmin))
                        {
                            lblNombreSuperAdmin.Text = nombreCompletoSuperAdmin;
                            lblNombreSuperAdmin.Visible = true;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // En caso de error, ocultar los labels
                if (lblTienda != null) lblTienda.Visible = false;
                if (lblNombreUsuario != null) lblNombreUsuario.Visible = false;
                if (lblNombreAdmin != null) lblNombreAdmin.Visible = false;
                if (lblNombreSuperAdmin != null) lblNombreSuperAdmin.Visible = false;
            }
        }
    }
}



