﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class Venta
    {
        public int IdVenta { get; set; }
        public Reserva IdReserva { get; set; }
        public DateTime FechaVenta { get; set; }
        public Decimal MontoTotal { get; set; }
    }
}
