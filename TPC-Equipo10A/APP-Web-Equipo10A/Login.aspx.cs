using System;
using System.Collections.Generic;
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

                UsuarioNegocio negocio = new UsuarioNegocio();

                Usuario usuario = negocio.ListarUsuarios()
                    .Find(u => u.Email == email && u.Password == password);

                if (usuario == null)
                {
                    lblError.Text = "Email o contraseña incorrectos.";
                    lblError.Visible = true;
                    return;
                }

                Session["Usuario"] = usuario;

                // Crear carrito del usuario (Admin = 0 por ahora)
                CarritoNegocio carritoNegocio = new CarritoNegocio();
                carritoNegocio.CrearCarritoSiNoExiste(usuario.IdUsuario, 0);

                // Carrito de sesión temporal
                if (Session["CarritoReserva"] == null)
                    Session["CarritoReserva"] = new List<Articulo>();

                Response.Redirect("Default.aspx", false);
            }
            catch
            {
                lblError.Text = "Ocurrió un error al iniciar sesión.";
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



