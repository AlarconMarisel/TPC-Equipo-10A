using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dominio;

namespace Negocio
{
    public class ReservaNegocio
    {
        public List<Reserva> ListarReservas()
        {
            List<Reserva> lista = new List<Reserva>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.SetearConsulta("SELECT IDReserva, IDUsuario, FechaReserva, FechaVencimientoReserva, MontoSeña, EstadoReserva FROM RESERVAS");
                datos.EjecutarLectura();

                while (datos.Lector.Read())
                {
                    Reserva aux = new Reserva();
                    aux.IdReserva = (int)datos.Lector["IDReserva"];
                    aux.IdUsuario = new Usuario { IdUsuario = (int)datos.Lector["IDUsuario"] };
                    aux.FechaReserva = (DateTime)datos.Lector["FechaReserva"];
                    aux.FechaVencimiento = (DateTime)datos.Lector["FechaVencimientoReserva"];
                    aux.MontoSeña = (decimal)datos.Lector["MontoSeña"];
                    aux.EstadoReserva = (bool)datos.Lector["EstadoReserva"];

                    lista.Add(aux);
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

        public int AgregarReserva(Reserva nueva)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.SetearConsulta("INSERT INTO RESERVAS (IDUsuario, FechaReserva, FechaVencimientoReserva, MontoSeña, EstadoReserva) " +
                                     "VALUES (@IDUsuario, @FechaReserva, @FechaVencimientoReserva, @MontoSeña, @EstadoReserva); SELECT SCOPE_IDENTITY();");
                datos.SetearParametro("@IDUsuario", nueva.IdUsuario.IdUsuario);
                datos.SetearParametro("@FechaReserva", nueva.FechaReserva);
                datos.SetearParametro("@FechaVencimientoReserva", nueva.FechaVencimiento);
                datos.SetearParametro("@MontoSeña", nueva.MontoSeña);
                datos.SetearParametro("@EstadoReserva", nueva.EstadoReserva);

                object result = datos.EjecutarAccionScalar();
                return Convert.ToInt32(result);
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
        public void ActualizarEstado(int idReserva, bool estado)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.SetearConsulta("UPDATE RESERVAS SET EstadoReserva = @Estado WHERE IDReserva = @IDReserva");
                datos.SetearParametro("@Estado", estado);
                datos.SetearParametro("@IDReserva", idReserva);
                datos.EjecutarAccion();
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
        public void ModificarReserva(Reserva reserva)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.SetearConsulta("UPDATE RESERVAS SET IDUsuario=@IDUsuario, FechaReserva=@FechaReserva, FechaVencimientoReserva=@FechaVencimientoReserva, " +
                                     "MontoSeña=@MontoSeña, EstadoReserva=@EstadoReserva WHERE IDReserva=@IDReserva");
                datos.SetearParametro("@IDReserva", reserva.IdReserva);
                datos.SetearParametro("@IDUsuario", reserva.IdUsuario.IdUsuario);
                datos.SetearParametro("@FechaReserva", reserva.FechaReserva);
                datos.SetearParametro("@FechaVencimientoReserva", reserva.FechaVencimiento);
                datos.SetearParametro("@MontoSeña", reserva.MontoSeña);
                datos.SetearParametro("@EstadoReserva", reserva.EstadoReserva);

                datos.EjecutarAccion();
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

        public void EliminarReserva(int id)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.SetearConsulta("DELETE FROM RESERVAS WHERE IDReserva=@IDReserva");
                datos.SetearParametro("@IDReserva", id);
                datos.EjecutarAccion();
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