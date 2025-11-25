using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Negocio;
using Dominio;

namespace APP_Web_Equipo10A
{
    public partial class Registro : System.Web.UI.Page
    {
        private int? idAdministradorTienda = null;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Obtener IDAdministrador desde la URL o query string (Fase 5)
                string tiendaParam = Request.QueryString["tienda"];
                if (!string.IsNullOrWhiteSpace(tiendaParam))
                {
                    UsuarioNegocio usuarioNegocio = new UsuarioNegocio();
                    idAdministradorTienda = usuarioNegocio.BuscarAdministradorPorIdentificador(tiendaParam);
                    
                    if (idAdministradorTienda.HasValue)
                    {
                        // Mostrar información de la tienda si se desea
                        // Por ahora solo guardamos el IDAdministrador
                    }
                }
                else
                {
                    // Intentar obtener desde la URL (routing)
                    idAdministradorTienda = TenantHelper.ObtenerIDAdministradorDesdeURL();
                }
            }
        }

        protected void btnRegistrar_Click(object sender, EventArgs e)
        {
            try
            {
                // Validar términos y condiciones
                if (!chkTerminos.Checked)
                {
                    MostrarMensaje("Debe aceptar los términos y condiciones para registrarse.", true);
                    return;
                }

                // Validar que las contraseñas coincidan
                if (txtPassword.Text != txtConfirmarPassword.Text)
                {
                    MostrarMensaje("Las contraseñas no coinciden.", true);
                    return;
                }

                // Validar longitud mínima de contraseña
                if (txtPassword.Text.Length < 8)
                {
                    MostrarMensaje("La contraseña debe tener al menos 8 caracteres.", true);
                    return;
                }

                // Validar que el email no exista
                UsuarioNegocio usuarioNegocio = new UsuarioNegocio();
                if (usuarioNegocio.ExisteEmail(txtEmail.Text.Trim()))
                {
                    MostrarMensaje("El email ya está registrado. Por favor, use otro email.", true);
                    return;
                }

                // Obtener IDAdministrador si no se obtuvo en Page_Load
                if (!idAdministradorTienda.HasValue)
                {
                    string tiendaParam = Request.QueryString["tienda"];
                    if (!string.IsNullOrWhiteSpace(tiendaParam))
                    {
                        idAdministradorTienda = usuarioNegocio.BuscarAdministradorPorIdentificador(tiendaParam);
                    }
                    else
                    {
                        idAdministradorTienda = TenantHelper.ObtenerIDAdministradorDesdeURL();
                    }
                }

                // Crear objeto Usuario
                Usuario nuevoUsuario = new Usuario
                {
                    Nombre = txtNombre.Text.Trim(),
                    Apellido = txtApellido.Text.Trim(),
                    Email = txtEmail.Text.Trim(),
                    Password = txtPassword.Text.Trim(),
                    Dni = string.IsNullOrEmpty(txtDNI.Text.Trim()) ? null : txtDNI.Text.Trim(),
                    Telefono = string.IsNullOrEmpty(txtTelefono.Text.Trim()) ? null : txtTelefono.Text.Trim(),
                    Domicilio = string.IsNullOrEmpty(txtDomicilio.Text.Trim()) ? null : txtDomicilio.Text.Trim(),
                    Tipo = TipoUsuario.NORMAL,
                    Activo = true,
                    Eliminado = false
                };

                // Crear usuario con IDAdministrador
                // Si no hay IDAdministrador, el usuario se crea sin tienda asignada
                int idUsuarioCreado = usuarioNegocio.AgregarUsuarioNormal(nuevoUsuario, idAdministradorTienda);

                if (idUsuarioCreado > 0)
                {
                    // Redirigir al login con mensaje de éxito
                    string redirectUrl = "Login.aspx?registro=exitoso";
                    if (idAdministradorTienda.HasValue)
                    {
                        // Mantener el contexto de la tienda si existe
                        redirectUrl += "&tienda=" + Server.UrlEncode(Request.QueryString["tienda"] ?? "");
                    }
                    Response.Redirect(redirectUrl, false);
                }
                else
                {
                    MostrarMensaje("Error al crear la cuenta. Por favor, intente nuevamente.", true);
                }
            }
            catch (Exception ex)
            {
                MostrarMensaje("Error al registrarse: " + ex.Message, true);
            }
        }

        private void MostrarMensaje(string mensaje, bool esError)
        {
            lblMensaje.Text = mensaje;
            lblMensaje.Visible = true;
            lblMensaje.CssClass = esError ? "validacion" : "alert alert-success";
        }


    }

}
