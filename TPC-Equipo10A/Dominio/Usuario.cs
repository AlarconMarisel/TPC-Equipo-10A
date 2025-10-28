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
        ADMIN = 1
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
        public Usuario(string email, string password, bool admin) { 
            
            Email = email;
            Password = password;
            Tipo = admin ? TipoUsuario.ADMIN : TipoUsuario.NORMAL;

        }


    }
}
