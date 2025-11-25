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
                // Valida acceso de administrador
                if (!ValidarAccesoAdministrador())
                {
                    Response.Redirect("Default.aspx");
                    return;
                }

                // Carga nombre de la tienda o email
                CargarNombreTienda();
                
                // Carga datos actuales
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

                // Carga nombre de tienda actual
                if (!string.IsNullOrEmpty(usuario.NombreTienda))
                {
                    txtNombreTienda.Text = usuario.NombreTienda;
                }

                // Muestra ID de administrador
                litIDAdministrador.Text = usuario.IdUsuario.ToString();

                // Actualiza preview de URL
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

                // Valida formato usando ValidacionHelper
                if (!string.IsNullOrEmpty(nombreTienda) && !ValidacionHelper.ValidarFormatoNombreTienda(nombreTienda))
                {
                    lblMensaje.Text = "El nombre de tienda no es válido. Debe contener solo letras, números y guiones, tener entre 3 y 50 caracteres, y no puede empezar o terminar con guión.";
                    lblMensaje.CssClass = "alert alert-danger";
                    lblMensaje.Visible = true;
                    return;
                }

                // Normaliza (trim) pero mantiene el formato original del usuario
                if (!string.IsNullOrEmpty(nombreTienda))
                {
                    nombreTienda = nombreTienda.Trim();
                }

                // Valida que el nombre de tienda sea unico usando ValidacionHelper (comparación case-insensitive)
                if (!string.IsNullOrEmpty(nombreTienda) && !ValidacionHelper.ValidarNombreTiendaUnico(nombreTienda, usuario.IdUsuario))
                {
                    lblMensaje.Text = "El nombre de tienda ya está en uso. Por favor, elija otro nombre.";
                    lblMensaje.CssClass = "alert alert-danger";
                    lblMensaje.Visible = true;
                    return;
                }

                // Guarda cambios
                UsuarioNegocio negocio = new UsuarioNegocio();
                negocio.ActualizarNombreTienda(usuario.IdUsuario, nombreTienda);

                // Actualiza sesion - recargar usuario desde BD para obtener el valor actualizado
                Usuario usuarioActualizado = negocio.ObtenerPorId(usuario.IdUsuario);
                if (usuarioActualizado != null)
                {
                    Session["Usuario"] = usuarioActualizado;
                }
                else
                {
                    // Fallback: actualizar manualmente
                    usuario.NombreTienda = string.IsNullOrEmpty(nombreTienda) ? null : nombreTienda;
                    Session["Usuario"] = usuario;
                }

                // Actualiza el nombre en el sidebar
                CargarNombreTienda();

                lblMensaje.Text = "Configuración guardada correctamente.";
                lblMensaje.CssClass = "alert alert-success";
                lblMensaje.Visible = true;

                // Actualiza preview
                ActualizarPreviewURL();
            }
            catch (Exception ex)
            {
                lblMensaje.Text = "Error: " + ex.Message;
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

