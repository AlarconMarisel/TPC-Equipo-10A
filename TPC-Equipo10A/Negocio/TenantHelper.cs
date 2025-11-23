using System;
using System.Web;
using Dominio;

namespace Negocio
{
    /// <summary>
    /// Helper para manejo de multi-tenancy (separación de datos por administrador)
    /// </summary>
    public static class TenantHelper
    {
        /// <summary>
        /// Obtiene el IDAdministrador del usuario actual en sesión
        /// </summary>
        /// <returns>
        /// - Si es SuperAdmin: retorna null (no tiene IDAdministrador)
        /// - Si es Admin: retorna su propio IdUsuario (él es el administrador)
        /// - Si es Usuario Normal: retorna su IDAdministrador (al que pertenece)
        /// - Si no hay sesión: retorna null
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
        /// Obtiene el IDAdministrador desde la URL (para futuro routing)
        /// Por ahora retorna null, se implementará en Fase 5
        /// </summary>
        /// <returns>IDAdministrador o null si no se puede determinar</returns>
        public static int? ObtenerIDAdministradorDesdeURL()
        {
            // TODO: Implementar en Fase 5 (Routing)
            // Por ahora retornamos null
            return null;
        }

        /// <summary>
        /// Valida que el administrador en sesión tiene acceso a los datos del IDAdministrador especificado
        /// </summary>
        /// <param name="idAdministrador">ID del administrador al que pertenecen los datos</param>
        /// <returns>true si tiene acceso, false si no</returns>
        public static bool ValidarAccesoAdministrador(int idAdministrador)
        {
            int? idAdminSesion = ObtenerIDAdministradorDesdeSesion();

            // Si no hay sesión, no tiene acceso
            if (!idAdminSesion.HasValue)
                return false;

            // Si el IDAdministrador de la sesión coincide con el que se quiere acceder
            return idAdminSesion.Value == idAdministrador;
        }

        /// <summary>
        /// Obtiene el usuario actual de la sesión
        /// </summary>
        /// <returns>Usuario en sesión o null</returns>
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
        /// Valida que el usuario en sesión es un administrador activo
        /// </summary>
        /// <returns>true si es admin activo, false si no</returns>
        public static bool EsAdministradorActivo()
        {
            Usuario usuario = ObtenerUsuarioDesdeSesion();

            if (usuario == null)
                return false;

            if (usuario.Tipo != TipoUsuario.ADMIN)
                return false;

            // Validar que esté activo
            if (!usuario.Activo)
                return false;

            // Validar que no esté vencido
            if (usuario.FechaVencimiento.HasValue && usuario.FechaVencimiento.Value < DateTime.Now)
                return false;

            return true;
        }
    }
}

