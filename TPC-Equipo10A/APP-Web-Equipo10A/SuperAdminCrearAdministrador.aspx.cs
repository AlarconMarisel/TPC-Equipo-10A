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
    public partial class SuperAdminCrearAdministrador : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Valida que el usuario es SuperAdmin
            if (!ValidarSuperAdmin())
            {
                Response.Redirect("Default.aspx");
                return;
            }
        }

        private bool ValidarSuperAdmin()
        {
            return ValidacionHelper.ValidarEsSuperAdmin();
        }

        protected void btnCrear_Click(object sender, EventArgs e)
        {
            try
            {
                if (!Page.IsValid)
                {
                    return;
                }

                // Verifica que el email no existe usando ValidacionHelper
                if (!ValidacionHelper.ValidarEmailUnico(txtEmail.Text.Trim()))
                {
                    lblMensaje.Text = "El email ya está registrado. Por favor, use otro email.";
                    lblMensaje.Visible = true;
                    return;
                }

                // Crea objeto Usuario
                Usuario nuevoAdmin = new Usuario
                {
                    Nombre = txtNombre.Text.Trim(),
                    Apellido = txtApellido.Text.Trim(),
                    Email = txtEmail.Text.Trim(),
                    Password = txtPassword.Text.Trim(),
                    Dni = string.IsNullOrEmpty(txtDNI.Text.Trim()) ? null : txtDNI.Text.Trim(),
                    Telefono = string.IsNullOrEmpty(txtTelefono.Text.Trim()) ? null : txtTelefono.Text.Trim(),
                    Domicilio = string.IsNullOrEmpty(txtDomicilio.Text.Trim()) ? null : txtDomicilio.Text.Trim(),
                    Tipo = TipoUsuario.ADMIN,
                    Activo = chkActivo.Checked,
                    Eliminado = false
                };

                // Obtiene fecha de vencimiento si se especifico
                DateTime? fechaVencimiento = null;
                if (!string.IsNullOrEmpty(txtFechaVencimiento.Text))
                {
                    if (DateTime.TryParse(txtFechaVencimiento.Text, out DateTime fecha))
                    {
                        fechaVencimiento = fecha;
                    }
                }

                // Crea administrador con categorias por defecto
                UsuarioNegocio negocio = new UsuarioNegocio();
                int idAdministrador = negocio.CrearAdministradorConCategorias(nuevoAdmin, fechaVencimiento);

                if (idAdministrador > 0)
                {
                    Response.Redirect("PanelSuperAdmin.aspx?mensaje=Administrador creado correctamente");
                }
                else
                {
                    lblMensaje.Text = "Error al crear el administrador. Por favor, intente nuevamente.";
                    lblMensaje.Visible = true;
                }
            }
            catch (Exception ex)
            {
                lblMensaje.Text = "Error: " + ex.Message;
                lblMensaje.Visible = true;
            }
        }
    }
}

