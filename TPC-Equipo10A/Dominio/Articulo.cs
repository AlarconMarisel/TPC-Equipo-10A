using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class Articulo
    {
        public int IdArticulo { get; set; }
        public string Nombre { get; set; }
        public string Descripcion { get; set; }
        public decimal Precio { get; set; }
        public Categoria IdCategoriaArticulo { get; set; }
        public Estado IdEstadoArticulo { get; set; }
        public List<Imagen> Imagenes { get; set; }
    }
}
