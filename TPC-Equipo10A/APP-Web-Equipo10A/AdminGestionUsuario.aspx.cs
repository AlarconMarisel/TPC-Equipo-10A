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
    public partial class AdminGestionUsuario : System.Web.UI.Page
    {
        private const int USUARIOS_POR_PAGINA = 10;

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
                
                // Carga usuarios
                CargarUsuarios();
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
        /// Carga los usuarios normales del administrador
        /// </summary>
        private void CargarUsuarios()
        {
            try
            {
                int? idAdministrador = TenantHelper.ObtenerIDAdministradorDesdeSesion();

                if (!idAdministrador.HasValue)
                {
                    lblMensaje.Text = "Error: No se pudo determinar el administrador.";
                    lblMensaje.Visible = true;
                    return;
                }

                UsuarioNegocio negocio = new UsuarioNegocio();
                List<Usuario> usuarios = negocio.ListarUsuariosNormales(idAdministrador.Value);

                // Crear lista con datos formateados para el GridView
                var usuariosFormateados = usuarios.Select(u => new
                {
                    u.IdUsuario,
                    NombreCompleto = $"{u.Nombre} {u.Apellido}",
                    u.Email,
                    FechaAltaFormateada = u.FechaAlta.HasValue ? u.FechaAlta.Value.ToString("dd/MM/yyyy") : "N/A",
                    u.Eliminado
                }).ToList();

                gvUsuarios.DataSource = usuariosFormateados;
                gvUsuarios.DataBind();
                
                // Muestra paginacion solo si hay mas usuarios que el maximo por pagina
                pnlPaginacion.Visible = usuariosFormateados.Count > USUARIOS_POR_PAGINA;
            }
            catch (Exception ex)
            {
                lblMensaje.Text = "Error al cargar usuarios: " + ex.Message;
                lblMensaje.Visible = true;
            }
        }

        /// <summary>
        /// Maneja los comandos del GridView (Dar de Baja, Reactivar)
        /// </summary>
        protected void gvUsuarios_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                int idUsuario = Convert.ToInt32(e.CommandArgument);
                int? idAdministrador = TenantHelper.ObtenerIDAdministradorDesdeSesion();

                if (!idAdministrador.HasValue)
                {
                    lblMensaje.Text = "Error: No se pudo determinar el administrador.";
                    lblMensaje.Visible = true;
                    return;
                }

                UsuarioNegocio negocio = new UsuarioNegocio();

                if (e.CommandName == "DarDeBaja")
                {
                    negocio.DarDeBajaUsuario(idUsuario, idAdministrador.Value);
                    lblMensaje.Text = "Usuario dado de baja correctamente.";
                    lblMensaje.CssClass = "alert alert-success";
                }
                else if (e.CommandName == "Reactivar")
                {
                    negocio.ReactivarUsuario(idUsuario, idAdministrador.Value);
                    lblMensaje.Text = "Usuario reactivado correctamente.";
                    lblMensaje.CssClass = "alert alert-success";
                }

                lblMensaje.Visible = true;

                // Recarga usuarios
                CargarUsuarios();
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
