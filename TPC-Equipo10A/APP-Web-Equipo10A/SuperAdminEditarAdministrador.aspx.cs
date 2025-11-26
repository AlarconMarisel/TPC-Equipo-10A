using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Dominio;
using Negocio;

namespace APP_Web_Equipo10A
{
    public partial class SuperAdminEditarAdministrador : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Valida que el usuario es SuperAdmin
            if (!ValidarSuperAdmin())
            {
                Response.Redirect("Default.aspx");
                return;
            }

            if (!IsPostBack)
            {
                CargarAdministrador();
            }
        }

        private bool ValidarSuperAdmin()
        {
            return ValidacionHelper.ValidarEsSuperAdmin();
        }

        private void CargarAdministrador()
        {
            try
            {
                if (Request.QueryString["id"] == null || !int.TryParse(Request.QueryString["id"], out int idAdministrador))
                {
                    lblMensaje.Text = "ID de administrador no válido";
                    lblMensaje.Visible = true;
                    return;
                }

                UsuarioNegocio negocio = new UsuarioNegocio();
                Usuario admin = negocio.ObtenerPorId(idAdministrador);

                if (admin == null || admin.Tipo != TipoUsuario.ADMIN)
                {
                    lblMensaje.Text = "Administrador no encontrado";
                    lblMensaje.Visible = true;
                    return;
                }

                // Muestra informacion de solo lectura
                lblNombre.Text = admin.Nombre ?? "-";
                lblApellido.Text = admin.Apellido ?? "-";
                lblEmail.Text = admin.Email ?? "-";
                lblFechaAlta.Text = admin.FechaAlta?.ToString("dd/MM/yyyy") ?? "-";

                // Carga valores editables
                chkActivo.Checked = admin.Activo;
                if (admin.FechaVencimiento.HasValue)
                {
                    txtFechaVencimiento.Text = admin.FechaVencimiento.Value.ToString("yyyy-MM-dd");
                }

                hdnIdAdministrador.Value = admin.IdUsuario.ToString();
            }
            catch (Exception ex)
            {
                lblMensaje.Text = "Error al cargar administrador: " + ex.Message;
                lblMensaje.Visible = true;
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrEmpty(hdnIdAdministrador.Value) || !int.TryParse(hdnIdAdministrador.Value, out int idAdministrador))
                {
                    lblMensaje.Text = "ID de administrador no válido";
                    lblMensaje.Visible = true;
                    return;
                }

                UsuarioNegocio negocio = new UsuarioNegocio();

                // Actualiza estado activo/inactivo
                negocio.ActivarDesactivarAdministrador(idAdministrador, chkActivo.Checked);

                // Actualiza fecha de vencimiento
                DateTime? fechaVencimiento = null;
                if (!string.IsNullOrEmpty(txtFechaVencimiento.Text))
                {
                    if (DateTime.TryParse(txtFechaVencimiento.Text, out DateTime fecha))
                    {
                        fechaVencimiento = fecha;
                    }
                }
                // Si se activa y no hay fecha, asigna 1 mes desde la fecha de activacion
                if (chkActivo.Checked)
                {
                    if (fechaVencimiento == null)
                    {
                        DateTime fechacreacion = DateTime.Now;

                        fechaVencimiento = fechacreacion.AddMonths(1);
                    }
                }
                // Si se inactiva, no hay fecha de vencimiento
                if (!chkActivo.Checked)
                {
                    fechaVencimiento = null; 
                }
                // Actualiza en la base la fecha de vencimiento
                negocio.ActualizarFechaVencimiento(idAdministrador, fechaVencimiento);

                //Envio de email de Modificacion
                if(chkActivo.Checked && fechaVencimiento!=null)
                {
                    EmailService email = new EmailService();
                    string asunto = "Actualizacion de cuenta";
                    string cuerpo = $"<h2> Estimado/a {negocio.ObtenerPorId(idAdministrador).Nombre} {negocio.ObtenerPorId(idAdministrador).Apellido},<h2/><br/>" +
                                    "<p>Su cuenta se encuentra Activa.<p/>" +
                                    $"<p>Su suscripcion tiene vigencia hasta el: {fechaVencimiento?.ToString("dd/MM/yyyy") ?? "No especificada"}.<p/><br/>" +
                                    "<p>Saludos cordiales.<p/>";
                    email.ArmarEmail(negocio.ObtenerPorId(idAdministrador).Email, asunto, cuerpo);
                    email.EnviarEmail();

                }
                else
                {
                    EmailService email = new EmailService();
                    string asunto = "Inhabilitacion de cuenta";
                    string cuerpo = $"<h2> Estimado/a {negocio.ObtenerPorId(idAdministrador).Nombre} {negocio.ObtenerPorId(idAdministrador).Apellido},<h2/><br/>" +
                                    "<p>Su cuenta se encuentra Inactiva.<p/>" +
                                    $"<p>Comuniquese con el Administrador Principal para reactivarla.<p/><br/>" +
                                    "<p>Saludos cordiales.<p/>";
                    email.ArmarEmail(negocio.ObtenerPorId(idAdministrador).Email, asunto, cuerpo);
                    email.EnviarEmail();
                }

                Response.Redirect("PanelSuperAdmin.aspx?mensaje=Administrador actualizado correctamente");
            }
            catch (Exception ex)
            {
                lblMensaje.Text = "Error al guardar cambios: " + ex.Message;
                lblMensaje.Visible = true;
            }
        }
    }
}


