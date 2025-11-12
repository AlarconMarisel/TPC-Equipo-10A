using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dominio;

namespace Negocio
{
    public class EstadoNegocio
    {
        public List<Estado> ListarEstados()
        {
            List<Estado> lista = new List<Estado>();
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.SetearConsulta("SELECT IDEstado, Nombre FROM ESTADOSARTICULO ORDER BY IDEstado");
                datos.EjecutarLectura();
                while (datos.Lector.Read())
                {
                    Estado estado = new Estado();
                    estado.IdEstado = (int)datos.Lector["IDEstado"];
                    estado.Nombre = (string)datos.Lector["Nombre"];
                    lista.Add(estado);
                }
                return lista;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
    }
}
