using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Dominio;
using Negocio;
using System.Text.RegularExpressions;

namespace APP_Web_Equipo10A
{
    public partial class AdminConfiguracionTienda : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Validar acceso de administrador
                if (!ValidarAccesoAdministrador())
                {
                    Response.Redirect("Default.aspx");
                    return;
                }

                // Cargar datos actuales
                CargarDatos();
            }
        }

        /// <summary>
        /// Valida que el usuario es administrador activo
        /// </summary>
        private bool ValidarAccesoAdministrador()
        {
            Usuario usuario = TenantHelper.ObtenerUsuarioDesdeSesion();

            if (usuario == null)
                return false;

            if (usuario.Tipo != TipoUsuario.ADMIN)
                return false;

            if (!TenantHelper.EsAdministradorActivo())
            {
                Response.Write("<script>alert('Su cuenta de administrador está inactiva o ha vencido. Contacte al super administrador.');</script>");
                return false;
            }

            return true;
        }

        /// <summary>
        /// Carga los datos actuales del administrador
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

                // Cargar nombre de tienda actual
                if (!string.IsNullOrEmpty(usuario.NombreTienda))
                {
                    txtNombreTienda.Text = usuario.NombreTienda;
                }

                // Mostrar ID de administrador
                litIDAdministrador.Text = usuario.IdUsuario.ToString();

                // Actualizar preview de URL
                ActualizarPreviewURL();
            }
            catch (Exception ex)
            {
                lblMensaje.Text = "Error al cargar datos: " + ex.Message;
                lblMensaje.CssClass = "alert alert-danger";
                lblMensaje.Visible = true;
            }
        }

        /// <summary>
        /// Actualiza el preview de la URL
        /// </summary>
        private void ActualizarPreviewURL()
        {
            string nombreTienda = txtNombreTienda.Text.Trim();
            Usuario usuario = TenantHelper.ObtenerUsuarioDesdeSesion();

            if (!string.IsNullOrEmpty(nombreTienda))
            {
                urlPreview.InnerText = $"tudominio.com/{nombreTienda}";
            }
            else
            {
                urlPreview.InnerText = $"tudominio.com/admin-{usuario.IdUsuario}";
            }
        }

        /// <summary>
        /// Valida el formato del nombre de tienda
        /// </summary>
        private bool ValidarFormatoNombreTienda(string nombreTienda)
        {
            if (string.IsNullOrWhiteSpace(nombreTienda))
            {
                return true; // Vacío es válido (usará admin-{ID})
            }

            // Solo letras, números y guiones
            Regex regex = new Regex(@"^[a-z0-9-]+$", RegexOptions.IgnoreCase);
            if (!regex.IsMatch(nombreTienda))
            {
                return false;
            }

            // No puede empezar o terminar con guión
            if (nombreTienda.StartsWith("-") || nombreTienda.EndsWith("-"))
            {
                return false;
            }

            // Longitud mínima y máxima
            if (nombreTienda.Length < 3 || nombreTienda.Length > 50)
            {
                return false;
            }

            return true;
        }

        /// <summary>
        /// Maneja el evento de guardar
        /// </summary>
        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            try
            {
                Usuario usuario = TenantHelper.ObtenerUsuarioDesdeSesion();

                if (usuario == null)
                {
                    Response.Redirect("Default.aspx");
                    return;
                }

                string nombreTienda = txtNombreTienda.Text.Trim();

                // Validar formato
                if (!string.IsNullOrEmpty(nombreTienda) && !ValidarFormatoNombreTienda(nombreTienda))
                {
                    lblMensaje.Text = "El nombre de tienda no es válido. Debe contener solo letras, números y guiones, tener entre 3 y 50 caracteres, y no puede empezar o terminar con guión.";
                    lblMensaje.CssClass = "alert alert-danger";
                    lblMensaje.Visible = true;
                    return;
                }

                // Convertir a minúsculas y normalizar
                if (!string.IsNullOrEmpty(nombreTienda))
                {
                    nombreTienda = nombreTienda.ToLower().Trim();
                }

                // Guardar cambios
                UsuarioNegocio negocio = new UsuarioNegocio();
                negocio.ActualizarNombreTienda(usuario.IdUsuario, nombreTienda);

                // Actualizar sesión
                usuario.NombreTienda = string.IsNullOrEmpty(nombreTienda) ? null : nombreTienda;
                Session["Usuario"] = usuario;

                lblMensaje.Text = "Configuración guardada correctamente.";
                lblMensaje.CssClass = "alert alert-success";
                lblMensaje.Visible = true;

                // Actualizar preview
                ActualizarPreviewURL();
            }
            catch (Exception ex)
            {
                lblMensaje.Text = "Error: " + ex.Message;
                lblMensaje.CssClass = "alert alert-danger";
                lblMensaje.Visible = true;
            }
        }
    }
}

