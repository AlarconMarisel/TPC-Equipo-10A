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

                // Validar que las contraseñas coincidan
                if (txtPassword.Text != txtConfirmarPassword.Text)
                {
                    lblMensaje.Text = "Las contraseñas no coinciden.";
                    lblMensaje.Visible = true;
                    return;
                }

                // Validar longitud mínima de contraseña
                if (txtPassword.Text.Length < 8)
                {
                    lblMensaje.Text = "La contraseña debe tener al menos 8 caracteres.";
                    lblMensaje.Visible = true;
                    return;
                }

                // Verifica que el email no existe usando ValidacionHelper
                if (!ValidacionHelper.ValidarEmailUnico(txtEmail.Text.Trim()))
                {
                    lblMensaje.Text = "El email ya está registrado. Por favor, use otro email.";
                    lblMensaje.Visible = true;
                    return;
                }

                // Validar DNI si se ingresó
                string dni = txtDNI.Text.Trim();
                if (!string.IsNullOrEmpty(dni))
                {
                    if (dni.Length != 8 || !System.Text.RegularExpressions.Regex.IsMatch(dni, @"^\d+$"))
                    {
                        lblMensaje.Text = "El DNI debe tener exactamente 8 dígitos numéricos.";
                        lblMensaje.Visible = true;
                        return;
                    }
                }

                // Validar Teléfono si se ingresó
                string telefono = txtTelefono.Text.Trim();
                if (!string.IsNullOrEmpty(telefono))
                {
                    if (telefono.Length < 10 || telefono.Length > 15 || !System.Text.RegularExpressions.Regex.IsMatch(telefono, @"^\d+$"))
                    {
                        lblMensaje.Text = "El teléfono debe tener entre 10 y 15 dígitos numéricos.";
                        lblMensaje.Visible = true;
                        return;
                    }
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
                        // Validar que la fecha sea futura
                        if (fecha.Date <= DateTime.Now.Date)
                        {
                            lblMensaje.Text = "La fecha de vencimiento debe ser futura.";
                            lblMensaje.Visible = true;
                            return;
                        }
                        fechaVencimiento = fecha;
                    }
                    else
                    {
                        lblMensaje.Text = "La fecha de vencimiento ingresada no es válida.";
                        lblMensaje.Visible = true;
                        return;
                    }
                }

                // Asignar fecha de vencimiento por defecto al nuevo administrador 
                if (nuevoAdmin.Activo){ 
                
                    if (fechaVencimiento== null)
                    {
                        DateTime fechacreacion = DateTime.Now;

                        fechaVencimiento = fechacreacion.AddMonths(1);
                    }
                }
                

                // Crea administrador con categorias por defecto
                UsuarioNegocio negocio = new UsuarioNegocio();
                int idAdministrador = negocio.CrearAdministradorConCategorias(nuevoAdmin, fechaVencimiento);

                if (idAdministrador > 0)
                {
                    //Envio de email de confirmación
                    EmailService email = new EmailService();
                    string asunto = "Administrador creado exitosamente";
                    string cuerpo = $"<h2> Estimado/a {nuevoAdmin.Nombre} {nuevoAdmin.Apellido},<h2/><br/>" +
                                    "<p>Su cuenta de administrador ha sido creada exitosamente.<p/>" +
                                    $"<p>Su ID de Administrador es: {idAdministrador}.<p/>" +
                                    $"<p>Ya podes comenzar a vender ingresando con tu email: {nuevoAdmin.Email}<p/>" +
                                    $"<p>Contraseña : {nuevoAdmin.Password}.<p/>" +
                                    $"<p>Su suscripcion tiene vigencia hasta el: {fechaVencimiento?.ToString("dd/MM/yyyy") ?? "No especificada"}.<p/><br/>" +
                                    "<p>Saludos cordiales.<p/>";
                    email.ArmarEmail(nuevoAdmin.Email, asunto, cuerpo);
                    email.EnviarEmail();

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

        // Validadores del lado del servidor
        protected void cvPasswordLength_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = txtPassword.Text.Length >= 8;
        }

        protected void cvDNI_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string dni = txtDNI.Text.Trim();
            if (string.IsNullOrEmpty(dni))
            {
                args.IsValid = true; // Es opcional
                return;
            }
            args.IsValid = dni.Length == 8 && System.Text.RegularExpressions.Regex.IsMatch(dni, @"^\d+$");
        }

        protected void cvTelefono_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string telefono = txtTelefono.Text.Trim();
            if (string.IsNullOrEmpty(telefono))
            {
                args.IsValid = true; // Es opcional
                return;
            }
            int length = telefono.Length;
            args.IsValid = length >= 10 && length <= 15 && System.Text.RegularExpressions.Regex.IsMatch(telefono, @"^\d+$");
        }

        protected void cvFechaVencimiento_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (string.IsNullOrEmpty(txtFechaVencimiento.Text))
            {
                args.IsValid = true; // Es opcional
                return;
            }
            if (DateTime.TryParse(txtFechaVencimiento.Text, out DateTime fecha))
            {
                args.IsValid = fecha.Date > DateTime.Now.Date;
            }
            else
            {
                args.IsValid = false;
            }
        }
    }
}

