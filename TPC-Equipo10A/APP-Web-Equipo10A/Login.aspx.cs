using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using Dominio;
using Negocio;

namespace APP_Web_Equipo10A
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            try
            {
                string email = txtEmail.Text.Trim();
                string password = txtPassword.Text.Trim();

                if (string.IsNullOrEmpty(email) || string.IsNullOrEmpty(password))
                {
                    lblError.Text = "Por favor, complete email y contraseña.";
                    lblError.Visible = true;
                    return;
                }

                UsuarioNegocio negocio = new UsuarioNegocio();

                // Buscar usuario (comparación case-insensitive para email)
                Usuario usuario = negocio.ListarUsuarios()
                    .Find(u => u.Email != null && 
                               u.Email.Equals(email, StringComparison.OrdinalIgnoreCase) && 
                               u.Password == password);

                if (usuario == null)
                {
                    lblError.Text = "Email o contraseña incorrectos.";
                    lblError.Visible = true;
                    return;
                }

                // Validar que el usuario no esté eliminado
                if (usuario.Eliminado)
                {
                    lblError.Text = "Su cuenta ha sido desactivada. Contacte al administrador.";
                    lblError.Visible = true;
                    return;
                }

                // Validar si es ADMIN que esté activo y no vencido
                if (usuario.Tipo == TipoUsuario.ADMIN)
                {
                    if (!usuario.Activo)
                    {
                        lblError.Text = "Su cuenta de administrador está inactiva. Contacte al super administrador.";
                        lblError.Visible = true;
                        return;
                    }

                    if (usuario.FechaVencimiento.HasValue && usuario.FechaVencimiento.Value < DateTime.Now)
                    {
                        lblError.Text = "Su cuenta de administrador ha vencido. Contacte al super administrador.";
                        lblError.Visible = true;
                        return;
                    }
                }

                // Guardar usuario en sesión
                Session["Usuario"] = usuario;

                // Crear carrito del usuario (solo si es usuario normal)
                if (usuario.Tipo == TipoUsuario.NORMAL)
                {
                    try
                    {
                        CarritoNegocio carritoNegocio = new CarritoNegocio();
                        // Por ahora usar IDAdministrador = 0, se actualizará en Fase 3
                        carritoNegocio.CrearCarritoSiNoExiste(usuario.IdUsuario, 0);
                    }
                    catch
                    {
                        // Si falla crear carrito, no es crítico, continuar con el login
                    }
                }

                // Carrito de sesión temporal
                if (Session["CarritoReserva"] == null)
                    Session["CarritoReserva"] = new List<Articulo>();

                // Redirigir según tipo de usuario
                if (usuario.Tipo == TipoUsuario.SUPERADMIN)
                {
                    Response.Redirect("PanelSuperAdmin.aspx", false);
                }
                else if (usuario.Tipo == TipoUsuario.ADMIN)
                {
                    Response.Redirect("PanelAdministrador.aspx", false);
                }
                else
                {
                    Response.Redirect("Default.aspx", false);
                }
            }
            catch (Exception ex)
            {
                // Mostrar error detallado para debugging
                lblError.Text = "Error al iniciar sesión: " + ex.Message;
                if (ex.InnerException != null)
                {
                    lblError.Text += " - " + ex.InnerException.Message;
                }
                lblError.Visible = true;
            }
        }


        private void CrearCarritoSiNoExiste(int idUsuario)
        {
            try
            {
                CarritoNegocio carritoNegocio = new CarritoNegocio();

                // Admin = 0 por ahora hasta definir Multi-Tenancy
                int idCarrito = carritoNegocio.CrearCarritoSiNoExiste(idUsuario, 0);

                // Si querés guardar el IDCarrito en la sesión:
                Session["IDCarrito"] = idCarrito;
            }
            catch (Exception ex)
            {
                // Log futuro
            }
        }

    }
}
