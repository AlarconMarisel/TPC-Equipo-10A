using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public enum TipoUsuario
    { 
        NORMAL = 0,
        ADMIN = 1,
        SUPERADMIN = 2
    }
    public class Usuario
    {
        public int IdUsuario { get; set; }
        public string Email { get; set; }
        public string Password { get; set; }
        public string Dni { get; set; }
        public string Nombre { get; set; }
        public string Apellido { get; set; }
        public string Telefono { get; set; }
        public string Domicilio { get; set; }
        public TipoUsuario Tipo { get; set; }
        public int? IDAdministrador { get; set; }
        public string NombreTienda { get; set; }
        public DateTime? FechaAlta { get; set; }
        public DateTime? FechaVencimiento { get; set; }
        public bool Activo { get; set; }
        public bool Eliminado { get; set; }

        public string NombreCompleto
        {
            get { return $"{Nombre} {Apellido}"; }
        }


        public Usuario() { }

        public Usuario(string email, string password, int admin) { 
            
            Email = email;
            Password = password;
            if (admin == 1)
            {
                Tipo = TipoUsuario.ADMIN;
            }
            else if (admin == 2)
            {
                Tipo = TipoUsuario.SUPERADMIN;
            }
            else
            {
                Tipo = TipoUsuario.NORMAL;
            }





        }


    }
}
