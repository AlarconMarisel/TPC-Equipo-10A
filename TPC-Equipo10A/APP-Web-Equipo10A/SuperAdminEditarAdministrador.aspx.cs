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
            // Validar que el usuario es SuperAdmin
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
            Usuario usuario = Session["Usuario"] as Usuario;
            if (usuario == null || usuario.Tipo != TipoUsuario.SUPERADMIN)
            {
                return false;
            }
            return true;
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

                // Mostrar información de solo lectura
                lblNombre.Text = admin.Nombre ?? "-";
                lblApellido.Text = admin.Apellido ?? "-";
                lblEmail.Text = admin.Email ?? "-";
                lblFechaAlta.Text = admin.FechaAlta?.ToString("dd/MM/yyyy") ?? "-";

                // Cargar valores editables
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

                // Actualizar estado activo/inactivo
                negocio.ActivarDesactivarAdministrador(idAdministrador, chkActivo.Checked);

                // Actualizar fecha de vencimiento
                DateTime? fechaVencimiento = null;
                if (!string.IsNullOrEmpty(txtFechaVencimiento.Text))
                {
                    if (DateTime.TryParse(txtFechaVencimiento.Text, out DateTime fecha))
                    {
                        fechaVencimiento = fecha;
                    }
                }
                negocio.ActualizarFechaVencimiento(idAdministrador, fechaVencimiento);

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


