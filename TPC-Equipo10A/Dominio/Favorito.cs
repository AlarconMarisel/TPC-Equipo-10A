using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class Favorito
    {
        public int IdFavorito { get; set; }
        public Usuario Usuario { get; set; }
        public Articulo Articulo { get; set; }
        public DateTime FechaAgregado { get; set; }
        public int IDAdministrador { get; set; }
    }
}