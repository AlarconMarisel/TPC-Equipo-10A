using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class Carrito
    {
        public int IDCarrito { get; set; }
        public Usuario Usuario { get; set; }
        public int IDAdministrador { get; set; }
        public DateTime FechaUltimaActualizacion { get; set; }
        public bool Activo { get; set; }
    }
}