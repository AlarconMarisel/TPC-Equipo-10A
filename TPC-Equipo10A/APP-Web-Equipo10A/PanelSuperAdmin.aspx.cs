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
    public partial class PanelSuperAdmin : System.Web.UI.Page
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
                CargarAdministradores();
                
                // Muestra mensaje si viene de otra pagina
                if (Request.QueryString["mensaje"] != null)
                {
                    lblMensaje.Text = Request.QueryString["mensaje"];
                    lblMensaje.CssClass = "text-success mt-3";
                    lblMensaje.Visible = true;
                }
            }
        }

        private bool ValidarSuperAdmin()
        {
            return ValidacionHelper.ValidarEsSuperAdmin();
        }

        private void CargarAdministradores()
        {
            try
            {
                UsuarioNegocio negocio = new UsuarioNegocio();
                List<Usuario> administradores = negocio.ListarAdministradores();

                // Prepara datos para el GridView
                var datosParaMostrar = administradores.Select(a => new
                {
                    a.IdUsuario,
                    NombreCompleto = $"{a.Nombre} {a.Apellido}",
                    a.Email,
                    NombreTienda = a.NombreTienda ?? "",
                    FechaAltaFormateada = a.FechaAlta?.ToString("dd/MM/yyyy") ?? "-",
                    FechaVencimientoFormateada = a.FechaVencimiento?.ToString("dd/MM/yyyy"),
                    a.Activo,
                    a.FechaVencimiento
                }).ToList();

                gvAdministradores.DataSource = datosParaMostrar;
                gvAdministradores.DataBind();
            }
            catch (Exception ex)
            {
                lblMensaje.Text = "Error al cargar administradores: " + ex.Message;
                lblMensaje.Visible = true;
            }
        }

        protected void gvAdministradores_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                if (e.CommandName == "ToggleActivo")
                {
                    int idAdministrador = Convert.ToInt32(e.CommandArgument);
                    UsuarioNegocio negocio = new UsuarioNegocio();
                    Usuario admin = negocio.ObtenerPorId(idAdministrador);

                    if (admin != null && admin.Tipo == TipoUsuario.ADMIN)
                    {
                        negocio.ActivarDesactivarAdministrador(idAdministrador, !admin.Activo);
                        if (admin.Activo)
                        {
                            // Enviar email de desactivacion
                            EmailService emailService = new EmailService();
                            string asunto = "Cuenta de Administrador Desactivada";
                            string cuerpo = $"<h2>Estimado/a {admin.Nombre} {admin.Apellido},<h2/><br/>" +
                                 "<p>Tu cuenta de administrador ha sido desactivada por el Administrador Principal.<p/>" +
                                 "<p> Si crees que esto es un error, por favor contacta con soporte.<p/><br/>" +
                                 "<p> Saludos Cordiales.<p/>";
                            emailService.ArmarEmail(admin.Email, asunto, cuerpo);
                            emailService.EnviarEmail();
                        }
                        else {
                            // Actualiza fecha de vencimiento al activar
                            DateTime? fechaVencimiento = null;
                            if (fechaVencimiento == null)
                            {
                                DateTime fechacreacion = DateTime.Now;

                                fechaVencimiento = fechacreacion.AddMonths(1);
                            }
                            negocio.ActualizarFechaVencimiento(idAdministrador, fechaVencimiento);
                            // Enviar email de activacion
                            EmailService emailService = new EmailService();
                            string asunto = "Cuenta de Administrador Activada";
                            string cuerpo = $"<h2>Estimado/a {admin.Nombre} {admin.Apellido},<h2/><br/>" +
                                 "<p>Tu cuenta de administrador ha sido activada por el Administrador Principal.<p/>" +
                                 "<p> Ya puedes iniciar sesión y gestionar tu tienda.<p/>" +
                                 $"<p> Su suscripcion tiene vigencia hasta el: {fechaVencimiento?.ToString("dd/MM/yyyy") ?? "No especificada"}.<p/><br/>" +
                                 "<p> Saludos Cordiales.<p/>";
                            emailService.ArmarEmail(admin.Email, asunto, cuerpo);
                            emailService.EnviarEmail();
                        }
                        CargarAdministradores();
                        lblMensaje.Text = admin.Activo ? "Administrador desactivado correctamente" : "Administrador activado correctamente";
                        lblMensaje.CssClass = "text-success mt-3";
                        lblMensaje.Visible = true;
                    }
                }
                else if (e.CommandName == "Editar")
                {
                    int idAdministrador = Convert.ToInt32(e.CommandArgument);
                    Response.Redirect($"SuperAdminEditarAdministrador.aspx?id={idAdministrador}");
                }
            }
            catch (Exception ex)
            {
                lblMensaje.Text = "Error: " + ex.Message;
                lblMensaje.CssClass = "text-danger mt-3";
                lblMensaje.Visible = true;
            }
        }

        public string GetEstadoCssClass(object activo, object fechaVencimiento)
        {
            bool esActivo = activo != null && (bool)activo;
            DateTime? fechaVenc = fechaVencimiento as DateTime?;

            if (!esActivo)
            {
                return "badge badge-inactivo";
            }

            if (fechaVenc.HasValue && fechaVenc.Value < DateTime.Now)
            {
                return "badge badge-vencido";
            }

            return "badge badge-activo";
        }

        public string GetEstadoTexto(object activo, object fechaVencimiento)
        {
            bool esActivo = activo != null && (bool)activo;
            DateTime? fechaVenc = fechaVencimiento as DateTime?;

            if (!esActivo)
            {
                return "Inactivo";
            }

            if (fechaVenc.HasValue && fechaVenc.Value < DateTime.Now)
            {
                return "Vencido";
            }

            return "Activo";
        }
    }
}

