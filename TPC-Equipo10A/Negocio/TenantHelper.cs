using System;
using System.Web;
using Dominio;

namespace Negocio
{
    /// <summary>
    /// Helper para manejo de multi-tenancy (separacion de datos por administrador)
    /// </summary>
    public static class TenantHelper
    {
        /// <summary>
        /// Obtiene el IDAdministrador del usuario actual en sesion
        /// </summary>
        /// <returns>
        /// - Si es SuperAdmin: retorna null (no tiene IDAdministrador)
        /// - Si es Admin: retorna su propio IdUsuario (él es el administrador)
        /// - Si es Usuario Normal: retorna su IDAdministrador (al que pertenece)
        /// - Si no hay sesion: retorna null
        /// </returns>
        public static int? ObtenerIDAdministradorDesdeSesion()
        {
            try
            {
                if (HttpContext.Current?.Session == null)
                    return null;

                Usuario usuario = HttpContext.Current.Session["Usuario"] as Usuario;

                if (usuario == null)
                    return null;

                // SuperAdmin no tiene IDAdministrador
                if (usuario.Tipo == TipoUsuario.SUPERADMIN)
                    return null;

                // Si es ADMIN, su propio ID es su IDAdministrador
                if (usuario.Tipo == TipoUsuario.ADMIN)
                    return usuario.IdUsuario;

                // Si es NORMAL, retorna su IDAdministrador
                if (usuario.Tipo == TipoUsuario.NORMAL)
                    return usuario.IDAdministrador;

                return null;
            }
            catch
            {
                return null;
            }
        }

        /// <summary>
        /// Obtiene el IDAdministrador desde la URL
        /// Soporta formatos: /nombre-tienda o /admin-{ID} (URL rewriting)
        /// También soporta query string: ?tienda=nombre-tienda (fallback)
        /// </summary>
        /// <returns>IDAdministrador o null si no se puede determinar</returns>
        public static int? ObtenerIDAdministradorDesdeURL()
        {
            try
            {
                if (HttpContext.Current?.Request == null)
                    return null;

                string identificador = null;

                // Primero intentar obtener desde HttpContext.Items (guardado por Global.asax en URL rewriting)
                if (HttpContext.Current.Items.Contains("TiendaIdentificador"))
                {
                    identificador = HttpContext.Current.Items["TiendaIdentificador"] as string;
                }

                // Si no está en Items, intentar desde RawUrl (URL original antes del rewriting)
                if (string.IsNullOrWhiteSpace(identificador))
                {
                    string rawUrl = HttpContext.Current.Request.RawUrl;
                    if (!string.IsNullOrWhiteSpace(rawUrl))
                    {
                        // Remover query string y fragmentos
                        if (rawUrl.Contains("?"))
                            rawUrl = rawUrl.Split('?')[0];
                        if (rawUrl.Contains("#"))
                            rawUrl = rawUrl.Split('#')[0];

                        // Remover la barra inicial
                        if (rawUrl.StartsWith("/"))
                            rawUrl = rawUrl.Substring(1);

                        // Si no es una página conocida, puede ser un identificador de tienda
                        if (!string.IsNullOrWhiteSpace(rawUrl) && 
                            !rawUrl.Equals("default.aspx", StringComparison.OrdinalIgnoreCase) &&
                            !rawUrl.StartsWith("default.aspx", StringComparison.OrdinalIgnoreCase) &&
                            !rawUrl.Contains(".aspx") &&
                            !rawUrl.StartsWith("admin", StringComparison.OrdinalIgnoreCase) &&
                            !rawUrl.StartsWith("panel", StringComparison.OrdinalIgnoreCase) &&
                            !rawUrl.StartsWith("login", StringComparison.OrdinalIgnoreCase) &&
                            !rawUrl.StartsWith("registro", StringComparison.OrdinalIgnoreCase) &&
                            !rawUrl.StartsWith("carrito", StringComparison.OrdinalIgnoreCase) &&
                            !rawUrl.StartsWith("detalle", StringComparison.OrdinalIgnoreCase))
                        {
                            // Tomar solo la primera parte si hay "/"
                            if (rawUrl.Contains("/"))
                            {
                                identificador = rawUrl.Split('/')[0];
                            }
                            else
                            {
                                identificador = rawUrl;
                            }
                        }
                    }
                }

                // Si no se encontró, intentar desde query string (fallback)
                if (string.IsNullOrWhiteSpace(identificador))
                {
                    string tiendaParam = HttpContext.Current.Request.QueryString["tienda"];
                    if (!string.IsNullOrWhiteSpace(tiendaParam))
                    {
                        identificador = tiendaParam;
                    }
                }

                // Si aún no hay identificador, retornar null
                if (string.IsNullOrWhiteSpace(identificador))
                {
                    return null;
                }

                // Limpiar el identificador
                identificador = identificador.Trim();

                // Buscar administrador por identificador
                UsuarioNegocio usuarioNegocio = new UsuarioNegocio();
                return usuarioNegocio.BuscarAdministradorPorIdentificador(identificador);
            }
            catch
            {
                return null;
            }
        }

        /// <summary>
        /// Valida que el administrador en sesión tiene acceso a los datos del IDAdministrador especificado
        /// </summary>
        /// <param name="idAdministrador">ID del administrador al que pertenecen los datos</param>
        /// <returns>true si tiene acceso, false si no</returns>
        public static bool ValidarAccesoAdministrador(int idAdministrador)
        {
            int? idAdminSesion = ObtenerIDAdministradorDesdeSesion();

            // Si no hay sesion, no tiene acceso
            if (!idAdminSesion.HasValue)
                return false;

            // Si el IDAdministrador de la sesion coincide con el que se quiere acceder
            return idAdminSesion.Value == idAdministrador;
        }

        /// <summary>
        /// Obtiene el usuario actual de la sesion
        /// </summary>
        /// <returns>Usuario en sesion o null</returns>
        public static Usuario ObtenerUsuarioDesdeSesion()
        {
            try
            {
                if (HttpContext.Current?.Session == null)
                    return null;

                return HttpContext.Current.Session["Usuario"] as Usuario;
            }
            catch
            {
                return null;
            }
        }

        /// <summary>
        /// Valida que el usuario en sesion es un administrador activo
        /// </summary>
        /// <returns>true si es admin activo, false si no</returns>
        public static bool EsAdministradorActivo()
        {
            Usuario usuario = ObtenerUsuarioDesdeSesion();

            if (usuario == null)
                return false;

            if (usuario.Tipo != TipoUsuario.ADMIN)
                return false;

            // Valida que este activo
            if (!usuario.Activo)
                return false;

            // Valida que no este vencido
            if (usuario.FechaVencimiento.HasValue && usuario.FechaVencimiento.Value < DateTime.Now)
                return false;

            return true;
        }
    }
}

