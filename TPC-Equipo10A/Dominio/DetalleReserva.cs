using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class DetalleReserva
    {
        public int IdDetalleReserva { get; set; }
        public Reserva IdReserva { get; set; }
        public List<Articulo> Articulos { get; set; }
        public Decimal MontoSeña { get; set; }
    }

}
