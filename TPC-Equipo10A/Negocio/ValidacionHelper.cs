using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using Dominio;

namespace Negocio
{
    /// <summary>
    /// Helper para validaciones centralizadas del sistema
    /// </summary>
    public static class ValidacionHelper
    {
        /// <summary>
        /// Valida que el email sea único en la base de datos
        /// </summary>
        /// <param name="email">Email a validar</param>
        /// <param name="idUsuarioExcluir">ID del usuario a excluir de la validacion (para edicion)</param>
        /// <returns>true si el email es unico, false si ya existe</returns>
        public static bool ValidarEmailUnico(string email, int? idUsuarioExcluir = null)
        {
            if (string.IsNullOrWhiteSpace(email))
                return false;

            UsuarioNegocio usuarioNegocio = new UsuarioNegocio();
            
            // Si se esta editando un usuario, verifica que el email no exista en otros usuarios
            if (idUsuarioExcluir.HasValue)
            {
                List<Usuario> usuarios = usuarioNegocio.ListarUsuarios();
                return !usuarios.Any(u => u.IdUsuario != idUsuarioExcluir.Value &&
                                         u.Email != null &&
                                         u.Email.Equals(email.Trim(), StringComparison.OrdinalIgnoreCase) &&
                                         !u.Eliminado);
            }
            else
            {
                // Para nuevo usuario, usa el metodo existente
                return !usuarioNegocio.ExisteEmail(email);
            }
        }

        /// <summary>
        /// Valida que el nombre de tienda sea único en la base de datos
        /// </summary>
        /// <param name="nombreTienda">Nombre de tienda a validar</param>
        /// <param name="idAdministradorExcluir">ID del administrador a excluir de la validación (para edición)</param>
        /// <returns>true si el nombre es único, false si ya existe</returns>
        public static bool ValidarNombreTiendaUnico(string nombreTienda, int? idAdministradorExcluir = null)
        {
            if (string.IsNullOrWhiteSpace(nombreTienda))
                return true; // NULL es valido (opcional)

            UsuarioNegocio usuarioNegocio = new UsuarioNegocio();
            List<Usuario> administradores = usuarioNegocio.ListarAdministradores();

            // Verifica que no exista otro administrador con el mismo nombre de tienda
            return !administradores.Any(a => a.IdUsuario != (idAdministradorExcluir ?? 0) &&
                                            a.NombreTienda != null &&
                                            a.NombreTienda.Equals(nombreTienda.Trim(), StringComparison.OrdinalIgnoreCase) &&
                                            !a.Eliminado);
        }

        /// <summary>
        /// Valida que el formato del nombre de tienda sea URL-friendly
        /// Solo permite letras, numeros, guiones y guiones bajos
        /// No puede empezar o terminar con guion
        /// </summary>
        /// <param name="nombreTienda">Nombre de tienda a validar</param>
        /// <returns>true si el formato es valido, false si no</returns>
        public static bool ValidarFormatoNombreTienda(string nombreTienda)
        {
            if (string.IsNullOrWhiteSpace(nombreTienda))
                return true; // NULL es valido (opcional)

            string nombreLimpio = nombreTienda.Trim();
            
            // Longitud minima y maxima
            if (nombreLimpio.Length < 3 || nombreLimpio.Length > 50)
                return false;

            // Solo letras, numeros, guiones y guiones bajos
            Regex regex = new Regex(@"^[a-zA-Z0-9_-]+$");
            if (!regex.IsMatch(nombreLimpio))
                return false;

            // No puede empezar o terminar con guion
            if (nombreLimpio.StartsWith("-") || nombreLimpio.EndsWith("-"))
                return false;

            return true;
        }

        /// <summary>
        /// Valida que un administrador este activo y no vencido
        /// </summary>
        /// <param name="idAdministrador">ID del administrador a validar</param>
        /// <returns>true si esta activo y no vencido, false si no</returns>
        public static bool ValidarAdministradorActivo(int idAdministrador)
        {
            try
            {
                UsuarioNegocio usuarioNegocio = new UsuarioNegocio();
                Usuario administrador = usuarioNegocio.ObtenerPorId(idAdministrador);

                if (administrador == null)
                    return false;

                if (administrador.Tipo != TipoUsuario.ADMIN)
                    return false;

                // Debe estar activo
                if (!administrador.Activo)
                    return false;

                // No debe estar eliminado
                if (administrador.Eliminado)
                    return false;

                // Si tiene fecha de vencimiento, no debe estar vencida
                if (administrador.FechaVencimiento.HasValue && 
                    administrador.FechaVencimiento.Value < DateTime.Now)
                    return false;

                return true;
            }
            catch
            {
                return false;
            }
        }

        /// <summary>
        /// Sanitiza un input para evitar inyeccion SQL y XSS basico
        /// </summary>
        /// <param name="input">Texto a sanitizar</param>
        /// <returns>Texto sanitizado</returns>
        public static string SanitizarInput(string input)
        {
            if (string.IsNullOrEmpty(input))
                return string.Empty;

            // Remueve caracteres peligrosos para SQL
            string sanitizado = input.Trim();
            
            // Reemplaza comillas simples y dobles
            sanitizado = sanitizado.Replace("'", "''"); // Escapa comillas simples para SQL
            sanitizado = sanitizado.Replace("\"", "&quot;"); // Escapa comillas dobles para HTML
            
            // Remueve caracteres de control
            sanitizado = Regex.Replace(sanitizado, @"[\x00-\x1F\x7F]", "");
            
            return sanitizado;
        }

        /// <summary>
        /// Valida que un usuario este logueado
        /// </summary>
        /// <returns>true si hay un usuario en sesion, false si no</returns>
        public static bool ValidarUsuarioLogueado()
        {
            return TenantHelper.ObtenerUsuarioDesdeSesion() != null;
        }

        /// <summary>
        /// Valida que el usuario en sesion sea SuperAdmin
        /// </summary>
        /// <returns>true si es SuperAdmin, false si no</returns>
        public static bool ValidarEsSuperAdmin()
        {
            Usuario usuario = TenantHelper.ObtenerUsuarioDesdeSesion();
            return usuario != null && usuario.Tipo == TipoUsuario.SUPERADMIN;
        }

        /// <summary>
        /// Valida que el usuario en sesion sea un administrador activo
        /// </summary>
        /// <returns>true si es admin activo, false si no</returns>
        public static bool ValidarEsAdministradorActivo()
        {
            return TenantHelper.EsAdministradorActivo();
        }
    }
}

