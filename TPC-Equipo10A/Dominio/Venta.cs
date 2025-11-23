using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class Venta
    {
        public int IdVenta { get; set; }
        public Reserva Reserva { get; set; }
        public DateTime FechaVenta { get; set; }
        public Decimal MontoTotal { get; set; }
        public int IDAdministrador { get; set; }
    }
}
