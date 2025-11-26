using System;
using System.Web.UI;
using Dominio;
using Negocio;

namespace APP_Web_Equipo10A
{
    public partial class AdminMiPerfil : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Valida acceso de administrador
                if (!ValidarAccesoAdministrador())
                {
                    Response.Redirect("Default.aspx");
                    return;
                }

                // Carga nombre de la tienda o email
                CargarNombreTienda();
                
                // Carga datos del usuario
                CargarDatos();
            }
        }

        /// <summary>
        /// Valida que el usuario es administrador activo
        /// </summary>
        private bool ValidarAccesoAdministrador()
        {
            if (!ValidacionHelper.ValidarEsAdministradorActivo())
            {
                Response.Write("<script>alert('Su cuenta de administrador está inactiva o ha vencido. Contacte al super administrador.');</script>");
                return false;
            }
            return true;
        }

        /// <summary>
        /// Carga los datos del administrador actual
        /// </summary>
        private void CargarDatos()
        {
            try
            {
                Usuario usuario = TenantHelper.ObtenerUsuarioDesdeSesion();

                if (usuario == null)
                {
                    Response.Redirect("Default.aspx");
                    return;
                }

                // Cargar informacion de cuenta (solo lectura)
                lblEmail.Text = usuario.Email ?? "-";
                lblIdAdministrador.Text = usuario.IdUsuario.ToString();
                lblFechaAlta.Text = usuario.FechaAlta.HasValue ? usuario.FechaAlta.Value.ToString("dd/MM/yyyy") : "-";
                
                if (usuario.FechaVencimiento.HasValue)
                {
                    lblFechaVencimiento.Text = usuario.FechaVencimiento.Value.ToString("dd/MM/yyyy");
                    
                    // Muestra advertencia si esta proxima a vencer (30 dias)
                    if (usuario.FechaVencimiento.Value <= DateTime.Now.AddDays(30) && usuario.FechaVencimiento.Value > DateTime.Now)
                    {
                        lblFechaVencimiento.Text += " <span class='badge badge-warning'>Próxima a vencer</span>";
                    }
                    else if (usuario.FechaVencimiento.Value <= DateTime.Now)
                    {
                        lblFechaVencimiento.Text += " <span class='badge badge-danger'>Vencida</span>";
                    }
                }
                else
                {
                    lblFechaVencimiento.Text = "Sin fecha de vencimiento";
                }

                // Estado de cuenta
                if (usuario.Activo)
                {
                    lblEstado.Text = "<span class='badge badge-success'>Activo</span>";
                }
                else
                {
                    lblEstado.Text = "<span class='badge badge-danger'>Inactivo</span>";
                }

                // Nombre de tienda
                if (!string.IsNullOrWhiteSpace(usuario.NombreTienda))
                {
                    lblNombreTiendaInfo.Text = "\"" + usuario.NombreTienda + "\"";
                }
                else
                {
                    lblNombreTiendaInfo.Text = "No configurado";
                }

                // Carga datos personales editables
                txtNombre.Text = usuario.Nombre ?? "";
                txtApellido.Text = usuario.Apellido ?? "";
                txtDNI.Text = usuario.Dni ?? "";
                txtTelefono.Text = usuario.Telefono ?? "";
                txtDomicilio.Text = usuario.Domicilio ?? "";
            }
            catch (Exception ex)
            {
                lblMensaje.Text = "Error al cargar datos: " + ex.Message;
                lblMensaje.CssClass = "alert alert-danger";
                lblMensaje.Visible = true;
            }
        }

        /// <summary>
        /// Maneja el evento de guardar datos personales
        /// </summary>
        protected void btnGuardarDatos_Click(object sender, EventArgs e)
        {
            try
            {
                Usuario usuario = TenantHelper.ObtenerUsuarioDesdeSesion();

                if (usuario == null)
                {
                    Response.Redirect("Default.aspx");
                    return;
                }

                // Valida campos requeridos
                if (string.IsNullOrWhiteSpace(txtNombre.Text))
                {
                    lblMensaje.Text = "El nombre es requerido.";
                    lblMensaje.CssClass = "alert alert-danger";
                    lblMensaje.Visible = true;
                    return;
                }

                if (string.IsNullOrWhiteSpace(txtApellido.Text))
                {
                    lblMensaje.Text = "El apellido es requerido.";
                    lblMensaje.CssClass = "alert alert-danger";
                    lblMensaje.Visible = true;
                    return;
                }

                // Actualiza datos personales
                UsuarioNegocio negocio = new UsuarioNegocio();
                negocio.ActualizarDatosPersonales(
                    usuario.IdUsuario,
                    txtNombre.Text.Trim(),
                    txtApellido.Text.Trim(),
                    string.IsNullOrWhiteSpace(txtDNI.Text) ? null : txtDNI.Text.Trim(),
                    string.IsNullOrWhiteSpace(txtTelefono.Text) ? null : txtTelefono.Text.Trim(),
                    string.IsNullOrWhiteSpace(txtDomicilio.Text) ? null : txtDomicilio.Text.Trim()
                );

                // Actualiza sesion - recarga usuario desde BD
                Usuario usuarioActualizado = negocio.ObtenerPorId(usuario.IdUsuario);
                if (usuarioActualizado != null)
                {
                    Session["Usuario"] = usuarioActualizado;
                }

                lblMensaje.Text = "Datos personales actualizados correctamente.";
                lblMensaje.CssClass = "alert alert-success";
                lblMensaje.Visible = true;

                // Recarga datos para mostrar cambios
                CargarDatos();
            }
            catch (Exception ex)
            {
                lblMensaje.Text = "Error al actualizar datos: " + ex.Message;
                lblMensaje.CssClass = "alert alert-danger";
                lblMensaje.Visible = true;
            }
        }

        /// <summary>
        /// Maneja el evento de cambiar contraseña
        /// </summary>
        protected void btnCambiarPassword_Click(object sender, EventArgs e)
        {
            try
            {
                Usuario usuario = TenantHelper.ObtenerUsuarioDesdeSesion();

                if (usuario == null)
                {
                    Response.Redirect("Default.aspx");
                    return;
                }

                // Valida campos
                if (string.IsNullOrWhiteSpace(txtPasswordActual.Text))
                {
                    lblMensaje.Text = "Debe ingresar la contraseña actual.";
                    lblMensaje.CssClass = "alert alert-danger";
                    lblMensaje.Visible = true;
                    return;
                }

                if (string.IsNullOrWhiteSpace(txtPasswordNuevo.Text))
                {
                    lblMensaje.Text = "Debe ingresar la nueva contraseña.";
                    lblMensaje.CssClass = "alert alert-danger";
                    lblMensaje.Visible = true;
                    return;
                }

                if (txtPasswordNuevo.Text.Length < 8)
                {
                    lblMensaje.Text = "La nueva contraseña debe tener al menos 8 caracteres.";
                    lblMensaje.CssClass = "alert alert-danger";
                    lblMensaje.Visible = true;
                    return;
                }

                if (txtPasswordNuevo.Text != txtPasswordConfirmar.Text)
                {
                    lblMensaje.Text = "Las contraseñas no coinciden.";
                    lblMensaje.CssClass = "alert alert-danger";
                    lblMensaje.Visible = true;
                    return;
                }

                // Cambia contraseña
                UsuarioNegocio negocio = new UsuarioNegocio();
                negocio.CambiarPassword(
                    usuario.IdUsuario,
                    txtPasswordActual.Text,
                    txtPasswordNuevo.Text
                );

                // Limpia campos de contraseña
                txtPasswordActual.Text = "";
                txtPasswordNuevo.Text = "";
                txtPasswordConfirmar.Text = "";

                lblMensaje.Text = "Contraseña cambiada correctamente.";
                lblMensaje.CssClass = "alert alert-success";
                lblMensaje.Visible = true;
            }
            catch (Exception ex)
            {
                lblMensaje.Text = "Error al cambiar contraseña: " + ex.Message;
                lblMensaje.CssClass = "alert alert-danger";
                lblMensaje.Visible = true;
            }
        }

        /// <summary>
        /// Carga el nombre de la tienda o el email del administrador
        /// </summary>
        private void CargarNombreTienda()
        {
            try
            {
                Usuario usuario = TenantHelper.ObtenerUsuarioDesdeSesion();
                
                if (usuario != null)
                {
                    string textoMostrar = "";
                    
                    // Si tiene nombre de tienda configurado, mostrarlo
                    if (!string.IsNullOrWhiteSpace(usuario.NombreTienda))
                    {
                        textoMostrar = "\"" + usuario.NombreTienda + "\"";
                    }
                    // Si no, mostrar el email
                    else if (!string.IsNullOrWhiteSpace(usuario.Email))
                    {
                        textoMostrar = "\"" + usuario.Email + "\"";
                    }
                    
                    lblNombreTienda.Text = textoMostrar;
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error al cargar nombre de tienda: " + ex.Message);
            }
        }
    }
}

